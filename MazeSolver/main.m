function main()
    % MAIN - Main simulation runner with single window update
    
    clear all; close all; clc;
    
    fprintf('====================================\n');
    fprintf('   MAZE SOLVER HACKATHON - IIT Ropar\n');
    fprintf('====================================\n\n');
    
    % Add all folders to path
    addpath(genpath(pwd));
    
    % Get participant name
    fprintf('Enter participant name: ');
    participant_name = input('', 's');
    
    % Get level
    fprintf('\nSelect maze level (1-5): ');
    level = input('');
    
    if level < 1 || level > 5
        error('Level must be between 1 and 5');
    end
    
    % Generate maze
    fprintf('\nGenerating maze level %d...\n', level);
    [maze, start_pos, goal_pos] = maze_def(level);
    
    % Initialize robot (start facing East)
    robot = init_robot(start_pos, 2);
    
    % ============================================
    % # SETUP SINGLE WINDOW VISUALIZATION
    % # ============================================
    
    % Close any existing maze solver windows
    close(findobj('Type', 'Figure', 'Name', 'Maze Solver'));
    
    % Create/update single figure
    draw_maze(maze, start_pos, goal_pos);
    robot = draw_robot(robot, maze);
    
    % Simulation parameters
    max_actions = size(maze, 1) * size(maze, 2) * 4;
    current_action = 0;
    solved = false;
    crashed = false;
    
    fprintf('\n=== SIMULATION START ===\n');
    fprintf('Maze: %dx%d cells\n', size(maze,1), size(maze,2));
    fprintf('Start: [%d,%d], Goal: [%d,%d]\n', ...
        start_pos(1), start_pos(2), goal_pos(1), goal_pos(2));
    fprintf('Max actions: %d\n\n', max_actions);
    fprintf('Robot is moving in the SAME WINDOW...\n\n');
    
    % ============================================
    % # MAIN SIMULATION LOOP - SINGLE WINDOW UPDATE
    % # ============================================
    
    while current_action < max_actions && ~solved && ~crashed
        current_action = current_action + 1;
        
        % Get sensor data
        sensors = sense_robot(robot, maze);
        
        % Call participant's controller
        action = your_controller(sensors, robot.position, robot.direction, maze);
        
        % Update robot
        robot = update_robot(robot, action, maze);
        
        % ========================================
        % # UPDATE SAME WINDOW - NO NEW FIGURE
        % # ========================================
        
        % Update robot in existing window
        robot = draw_robot(robot, maze);
        
        % Pause based on action type
        switch action
            case 1  % Move
                pause(0.2);
            case {2, 3}  % Turn
                pause(0.15);
            case 4  % Stay
                pause(0.1);
        end
        
        % Check if goal reached
        if isequal(robot.position, goal_pos)
            solved = true;
            fprintf('\n🎉 CONGRATULATIONS! MAZE SOLVED!\n');
            robot.score = robot.score + 500;  % Bonus
            
            % Final update with celebration text
            ax = gca;
            text(size(maze,2)/2, -1, '🎉 MAZE SOLVED! 🎉', ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 16, 'FontWeight', 'bold', ...
                'Color', [0.2 0.6 0.2], ...
                'BackgroundColor', [1 1 1 0.8]);
            drawnow;
        end
        
        % Check for too many collisions
        if robot.collisions > 20
            crashed = true;
            fprintf('\n❌ ROBOT CRASHED - Too many collisions!\n');
            
            % Add crash indicator
            ax = gca;
            text(size(maze,2)/2, -1, '❌ ROBOT CRASHED ❌', ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 16, 'FontWeight', 'bold', ...
                'Color', [0.8 0.2 0.2], ...
                'BackgroundColor', [1 1 1 0.8]);
            drawnow;
        end
        
        % Display progress in console (not in figure)
        if mod(current_action, 20) == 0
            fprintf('Action %d: %s at [%d,%d] | Score: %.0f\n', ...
                current_action, robot.last_action_type, ...
                robot.position(1), robot.position(2), robot.score);
        end
    end
    
    % ============================================
    % # FINAL RESULTS - SAME WINDOW
    % # ============================================
    
    % Add final status to existing window
    ax = gca;
    if solved
        status_text = sprintf('SOLVED in %d actions!', current_action);
        status_color = [0.2 0.6 0.2];
    elseif crashed
        status_text = sprintf('CRASHED after %d actions', current_action);
        status_color = [0.8 0.2 0.2];
    else
        status_text = sprintf('TIMEOUT after %d actions', current_action);
        status_color = [0.8 0.5 0.2];
    end
    
    text(size(maze,2)/2, -2, status_text, ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 14, 'FontWeight', 'bold', ...
        'Color', status_color, ...
        'BackgroundColor', [1 1 1 0.8]);
    
    % Final results in console
    fprintf('\n====================================\n');
    fprintf('           FINAL RESULTS\n');
    fprintf('====================================\n');
    fprintf('Participant: %s\n', participant_name);
    fprintf('Level: %d\n', level);
    fprintf('Status: %s\n', status_text);
    fprintf('Total actions: %d\n', current_action);
    fprintf('  • Moves: %d\n', robot.move_count);
    fprintf('  • Turns: %d (L:%d, R:%d)\n', ...
        robot.turn_count, robot.turn_left_count, robot.turn_right_count);
    fprintf('  • Stays: %d\n', robot.stay_count);
    fprintf('  • Collisions: %d\n', robot.collisions);
    fprintf('Final position: [%d,%d]\n', robot.position(1), robot.position(2));
    fprintf('Final score: %.0f\n', robot.score);
    
    % Efficiency metrics
    if robot.turn_count > 0
        move_turn_ratio = robot.move_count / robot.turn_count;
        fprintf('Move/Turn ratio: %.2f\n', move_turn_ratio);
    end
    
    visited_percent = 100 * size(robot.memory.visited, 1) / sum(maze(:)==1);
    fprintf('Exploraation: %.1f%% of maze\n', visited_percent);
    
    % Save results
    results_file = sprintf('results_%s_level%d.mat', ...
        strrep(participant_name, ' ', '_'), level);
    save(results_file, 'robot', 'maze', 'level', 'solved');
    fprintf('\nResults saved to: %s\n', results_file);
    
    % Keep figure open
    fprintf('\nFigure remains open. Close it when done.\n');
end
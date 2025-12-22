% RUN THE FILE FROM HERE :)
% ALSO the bot_speed At 10th line can be changed to simulate fast or slow

function main()
    clear all; close all; clc;


    % ADDED: Initialize bot_speed (1.0 = normal speed)
    % Range = 0.1 to 10
    bot_speed = 1;    

   
    fprintf(' MAZE SOLVER HACKATHON - IIT Ropar\n');
    fprintf('-----------------------------------\n');
    
    % Add all folders to path
    addpath(genpath(pwd));
    
    % Get participant's entry number
    fprintf('Enter Entry Number: ');
    participant_entry = input('', 's');
    

    % Get level (Worked on some eg. matrixes way.. will add alogrithms soon
    fprintf('\nSelect maze level (1-5) or 6 for final(randomized): ');
    level = input('');
    
    if level < 1 || level > 6
        error('Level must be between 1 and 6');
    end
    

    % Generate maze
    fprintf('\nGenerating maze level %d...\n', level);
    [maze, start_pos, goal_pos] = maze_def(level);
    
    % Initializing robot (start facing East), By default sun facing...
    robot = init_robot(start_pos, 2);
    
    % Close any existing maze solver windows
    close(findobj('Type', 'Figure', 'Name', 'Maze Solver'));
    
    % ADDED: Initialize saved_path for participant to use
    saved_path = [];

    % Create/update single figure
    draw_maze(maze, start_pos, goal_pos);
    robot = draw_robot(robot, maze, saved_path);
    
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
    
   

    % MAIN SIMULATION LOOP 
    while current_action < max_actions && ~solved && ~crashed
        current_action = current_action + 1;
        
        % Get sensor data
        sensors = sense_robot(robot, maze);
        
        % Call participant's controller, ** THE STUFF TO BE WORKED UPON
        % MODIFIED: Pass saved_path and get updated version back
        [action, saved_path] = your_controller(sensors, robot.position, robot.direction, maze, saved_path);
        
        % Update robot
        robot = update_robot(robot, action, maze);
                
      
        % Update robot in existing window
        robot = draw_robot(robot, maze, saved_path);
        
        bot_speed = max(0.1, min(bot_speed, 10.0));  % Clamp between 0.1x and 10x speed
        
        % Calculate pause duration based on action and bot_speed
        switch action
            case 1  % Move
                pause_duration = 0.05 / bot_speed;
            case {2, 3}  % Turn
                pause_duration = 0.025 / bot_speed;
            case 4  % Stay
                pause_duration = 0.00375 / bot_speed;
        end        

        pause(pause_duration);
        
        % Check if goal reached
        if isequal(robot.position, goal_pos)
            solved = true;
            fprintf('\n CONGRATS! MAZE SOLVED!\n');
            
            % Final update with celebration text
            ax = gca;
            text(size(maze,2)/2, -1, 'MAZE SOLVED! ', ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 16, 'FontWeight', 'bold', ...
                'Color', [0.2 0.6 0.2], ...
                'BackgroundColor', [1 1 1 0.8]);
            drawnow;
        end
        
        % Check for too many collisions
        if robot.collisions > 10
            crashed = true;
            fprintf('\n ROBOT CRASHED - Too many collisions!\n');
            
            % Add crash indicator
            ax = gca;
            text(size(maze,2)/2, -1, 'ROBOT CRASHED! ', ...
                'HorizontalAlignment', 'center', ...
                'FontSize', 16, 'FontWeight', 'bold', ...
                'Color', [0.8 0.2 0.2], ...
                'BackgroundColor', [1 1 1 0.8]);
            drawnow;
        end
        
        % Display progress in terminal (Whole purpose being debugging)
        if mod(current_action, 20) == 0
            fprintf('Action %d: %s at [%d,%d] | Score: %.0f\n', ...
                current_action, robot.last_action_type, ...
                robot.position(1), robot.position(2), robot.score);
        end
    end
    

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
    fprintf('\n--------------------------------\n');
    fprintf('         FINAL RESULTS\n');
    fprintf('Participant: %s\n', participant_entry);
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


    % ADDED: Display participant's saved_path
    fprintf('\n--- PARTICIPANT SAVED PATH ---\n');
    if ~isempty(saved_path)
        fprintf('Saved path has %d positions\n', size(saved_path, 1));
        for i = 1:size(saved_path, 1)
            fprintf('  [%d, %d]', saved_path(i, 1), saved_path(i, 2));
            if i == 1
                fprintf('  (START)');
            elseif i == size(saved_path, 1) && solved
                fprintf('  (GOAL)');
            end
            fprintf('\n');
        end
    else
        fprintf('No path saved by participant\n');
    end


    % TEXT FILE EXACT SAME AS CONSOLE
        txt_file = sprintf('results_%s_level%d.txt', ...
        strrep(participant_entry, ' ', '_'), level);
    
    fid = fopen(txt_file, 'w');
    
    % Write exactly what was printed to console
    fprintf(fid, '         FINAL RESULTS:\n');
    fprintf(fid, 'Participant: %s\n', participant_entry);
    fprintf(fid, 'Level: %d\n', level);
    fprintf(fid, 'Status: %s\n', status_text);
    fprintf(fid, 'Total actions: %d\n', current_action);
    fprintf(fid, '  • Moves: %d\n', robot.move_count);
    fprintf(fid, '  • Turns: %d (L:%d, R:%d)\n', ...
        robot.turn_count, robot.turn_left_count, robot.turn_right_count);
    fprintf(fid, '  • Stays: %d\n', robot.stay_count);
    fprintf(fid, '  • Collisions: %d\n', robot.collisions);
    fprintf(fid, 'Final position: [%d,%d]\n', robot.position(1), robot.position(2));
    fprintf(fid, 'Final score: %.0f\n', robot.score);
    
    % ADDED: Save the saved_path to file
    fprintf(fid, '\n--- PARTICIPANT SAVED PATH ---\n');
    if ~isempty(saved_path)
        fprintf(fid, 'Saved path has %d positions\n', size(saved_path, 1));
        for i = 1:size(saved_path, 1)
            fprintf(fid, '  [%d, %d]\n', saved_path(i, 1), saved_path(i, 2));
        end
    else
        fprintf(fid, 'No path saved by participant\n');
    end
    
    fclose(fid);
    
    fprintf('\nResults saved to: %s\n', txt_file);

    
    % Keep figure open
    fprintf('\nFigure remains open. Close it when done.\n');
end
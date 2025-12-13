function main()
    % MAIN - Entry point for Maze Solver simulation
    % Runs the complete simulation with visualization
    
    % Clear workspace and close figures
    clear; close all; clc;
    
    fprintf('=== Winter Hackathon: Maze Solving Robot ===\n\n');
    
    % Get participant information
    participant_name = input('Enter participant name: ', 's');
    fprintf('Welcome, %s!\n\n', participant_name);
    
    % Select level
    fprintf('Select maze level (1-5): ');
    level = input('');
    
    if level < 1 || level > 5
        error('Level must be between 1 and 5');
    end
    
    % Generate maze
    fprintf('Generating maze level %d...\n', level);
    [maze, start_pos, goal_pos] = maze_def(level);
    
    % Initialize robot
    robot = init_robot(start_pos, 2);  % Start facing East
    
    % Draw initial state
    draw_maze(maze, start_pos, goal_pos);
    draw_robot(robot, maze);
    
    % Simulation parameters
    max_steps = size(maze, 1) * size(maze, 2) * 3;  % Reasonable step limit
    step = 0;
    solved = false;
    crashed = false;
    
    fprintf('\n=== Simulation Started ===\n');
    fprintf('Maze size: %d x %d\n', size(maze, 1), size(maze, 2));
    fprintf('Step limit: %d\n', max_steps);
    fprintf('Press Ctrl+C to stop early\n\n');
    
    % Main simulation loop
    while step < max_steps && ~solved && ~crashed
        step = step + 1;
        
        % Get sensor data
        sensors = sense_robot(robot, maze);
        
        % Call participant's controller
        action = your_controller(sensors, robot.position, robot.direction, maze);
        
        % Update robot state
        robot = update_robot(robot, action, maze);
        
        % Update visualization every N steps or when action changes
        if mod(step, 5) == 0 || action ~= 1
            draw_maze(maze, start_pos, goal_pos);
            draw_robot(robot, maze);
            pause(0.05);  % Small pause for animation
        end
        
        % Check if goal reached
        if isequal(robot.position, goal_pos)
            solved = true;
            fprintf('🎉 GOAL REACHED at step %d!\n', step);
            robot.score = robot.score + 500;  % Bonus for solving
        end
        
        % Check for too many collisions
        if robot.collisions > 20
            crashed = true;
            fprintf('❌ Robot disabled - too many collisions (%d)\n', robot.collisions);
        end
        
        % Display progress every 50 steps
        if mod(step, 50) == 0
            fprintf('Step %d: Position [%d,%d], Score: %.0f\n', ...
                step, robot.position(1), robot.position(2), robot.score);
        end
    end
    
    % Final display
    draw_maze(maze, start_pos, goal_pos);
    draw_robot(robot, maze);
    
    % Results summary
    fprintf('\n=== Simulation Results ===\n');
    fprintf('Participant: %s\n', participant_name);
    fprintf('Level: %d\n', level);
    fprintf('Steps taken: %d\n', step);
    fprintf('Collisions: %d\n', robot.collisions);
    fprintf('Final score: %.0f\n', robot.score);
    
    if solved
        fprintf('Status: ✅ SUCCESS - Maze solved!\n');
    elseif crashed
        fprintf('Status: ❌ FAILED - Robot crashed\n');
    else
        fprintf('Status: ⏱️ TIMEOUT - Step limit reached\n');
    end
    
    % Save results
    results_file = sprintf('results_%s_level%d.mat', participant_name, level);
    save(results_file, 'robot', 'maze', 'start_pos', 'goal_pos', 'step', 'solved');
    fprintf('Results saved to %s\n', results_file);
end
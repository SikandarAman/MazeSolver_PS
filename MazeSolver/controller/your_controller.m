function [action, saved_path] = your_controller(sensor_data, current_pos, current_dir, maze, saved_path)
    % YOUR_CONTROLLER, This is YOUR maze-solving algorithm!
    % Write your code here to control the robot through the maze.
    
    % ====================================================
    % PART 1: UNDERSTANDING THE INPUTS (What you're given)
    
    % sensor_data - Tells you what's around the robot:
    % [front_sensor, left_sensor, right_sensor]
    % 1 = open path (no wall), 0 = wall (blocked)
    
    % Example: If sensor_data = [1, 0, 1]
    %          Means: Front is OPEN, Left is WALL, Right is OPEN
    
    front_open = sensor_data(1);  % Check front sensor
    left_open  = sensor_data(2);  % Check left sensor  
    right_open = sensor_data(3);  % Check right sensor
    
    
    % current_pos - Robot's current position in the maze
    % [row, column] - Like coordinates on a map
    % Example: [3, 5] means row 3, column 5
    
    current_row = current_pos(1);  % Get row number
    current_col = current_pos(2);  % Get column number
    
    % REMEMBER: Goal is always at [maze_rows-1, maze_cols-1]
    % You can calculate it:
    goal_row = size(maze, 1) - 1;  % Last row - 1
    goal_col = size(maze, 2) - 1;  % Last column - 1

    % current_dir - Which way the robot is facing:
    % 1 = North (facing UP)
    % 2 = East  (facing RIGHT)
    % 3 = South (facing DOWN)
    % 4 = West  (facing LEFT)
    
    % These variables help convert numbers to direction names:
    dir_names = {'North', 'East', 'South', 'West'};
    current_direction_name = dir_names{current_dir};
    

    % saved_path - The final path tracker
    % You can see this array as small red dots in the simulation path
    % Start empty: saved_path = []

    % Ex: Add all positions
    % Add positions: saved_path = [saved_path; current_pos] 
    

    % ===================================================
    % PART 2: DECISION MAKING (What should the robot do?
    
    % You need to decide which action to take based on sensors
    
    % AVAILABLE ACTIONS (choose ONE):
    % action = 1  --> Move FORWARD one step
    % action = 2  --> TURN LEFT (rotate 90° counter-clockwise)
    % action = 3  --> TURN RIGHT (rotate 90° clockwise)
    % action = 4  --> STAY (don't move - rarely used)


    


    % WORK BELOW (Replace the example)
    % ------------------------------------------------------------------
    % PART 3: EXAMPLE ALGORITHM - Right-Hand Rule (Wall Follower)

    % This algorithm follows the right wall:
    % 1. If front is open, go forward
    % 2. If front is blocked, try turning right
    % 3. If right is blocked, try turning left
    % 4. If all blocked, turn around (dead end) ,i.e, (U-Turn)
    
    if front_open == 1
        % Path ahead is clear - GO FORWARD
        action = 1;
        
    elseif right_open == 1
        % Right side is clear - TURN RIGHT
        action = 3;
        
    elseif left_open == 1
        % Left side is clear - TURN LEFT
        action = 2;
        
    else
        % Dead end! All sides blocked - TURN AROUND
        % We'll turn left twice to face opposite direction
        action = 2;
    end
    
    saved_path = [saved_path; current_pos];    

    % Simple tracking: Save every position you visit

    %--------------------------------------------------------------





    % ===========================================
    % PART 4: DISPLAY INFORMATION (For debugging)
    
    % This shows what's happening in the command window
    fprintf('\n--- Robot Status ---\n');
    fprintf('Position: [%d, %d]\n', current_row, current_col);
    fprintf('Facing: %s\n', current_direction_name);
    fprintf('Sensors: Front=%d, Left=%d, Right=%d\n', ...
            front_open, left_open, right_open);
    fprintf('Path saved: %d positions\n\n', size(saved_path, 1));
    
    
end
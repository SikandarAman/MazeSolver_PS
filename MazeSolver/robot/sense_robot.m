function sensor_readings = sense_robot(robot_state, maze)
    % SENSE_ROBOT - Simulate robot's distance sensors
    % Inputs: robot_state structure, maze matrix
    % Output: [front_dist, left_dist, right_dist] to nearest walls
    
    % Get current position and direction
    pos = robot_state.position;
    dir = robot_state.direction;
    [rows, cols] = size(maze);
    
    % Initialize sensor readings
    sensor_readings = zeros(1, 3);
    
    % Define direction vectors: [row_change, col_change]
    % Order: N, E, S, W
    dir_vectors = [-1, 0;  % North
                    0, 1;  % East
                    1, 0;  % South
                    0, -1]; % West
    
    % Check front direction
    front_dir = dir;
    sensor_readings(1) = measure_distance(pos, dir_vectors(front_dir, :), maze);
    
    % Check left direction (rotate counter-clockwise)
    left_dir = mod(dir - 2, 4) + 1;
    sensor_readings(2) = measure_distance(pos, dir_vectors(left_dir, :), maze);
    
    % Check right direction (rotate clockwise)
    right_dir = mod(dir, 4) + 1;
    sensor_readings(3) = measure_distance(pos, dir_vectors(right_dir, :), maze);
end

function dist = measure_distance(start_pos, dir_vector, maze)
    % MEASURE_DISTANCE - Helper function to measure distance to wall
    % Moves in given direction until hitting a wall or boundary
    
    dist = 0;
    current_pos = start_pos;
    [rows, cols] = size(maze);
    
    while true
        % Calculate next position
        next_pos = current_pos + dir_vector;
        
        % Check boundaries
        if next_pos(1) < 1 || next_pos(1) > rows || ...
           next_pos(2) < 1 || next_pos(2) > cols
            break;  % Hit boundary (outer wall)
        end
        
        % Check if next cell is a wall
        if maze(next_pos(1), next_pos(2)) == 0
            break;  % Hit a wall
        end
        
        % Valid move, increment distance and continue
        dist = dist + 1;
        current_pos = next_pos;
    end
end
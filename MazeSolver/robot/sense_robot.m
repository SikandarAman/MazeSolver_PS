function sensor_readings = sense_robot(robot_state, maze)
    % SENSE_ROBOT - Binary sensors (1=open, 0=wall)
    % Returns [front_open, left_open, right_open]
    
    pos = robot_state.position;
    dir = robot_state.direction;
    [rows, cols] = size(maze);
    
    % Initialize sensor readings
    sensor_readings = zeros(1, 3);
    
    % Direction vectors: [row_change, col_change]
    % N, E, S, W
    dir_vectors = [-1, 0;  % North
                    0, 1;  % East
                    1, 0;  % South
                    0, -1]; % West
    
    % Check front cell
    front_dir = dir;
    front_pos = pos + dir_vectors(front_dir, :);
    sensor_readings(1) = is_cell_open(front_pos, maze);
    
    % Check left cell
    left_dir = mod(dir - 2, 4) + 1;  % Rotate CCW
    left_pos = pos + dir_vectors(left_dir, :);
    sensor_readings(2) = is_cell_open(left_pos, maze);
    
    % Check right cell
    right_dir = mod(dir, 4) + 1;  % Rotate CW
    right_pos = pos + dir_vectors(right_dir, :);
    sensor_readings(3) = is_cell_open(right_pos, maze);
end

function open = is_cell_open(pos, maze)
    % IS_CELL_OPEN - Check if cell is open and within bounds
    [rows, cols] = size(maze);
    
    % Check boundaries
    if pos(1) < 1 || pos(1) > rows || pos(2) < 1 || pos(2) > cols
        open = 0;
        return;
    end
    
    % Check if cell is path (1) not wall (0)
    open = (maze(pos(1), pos(2)) == 1);
end
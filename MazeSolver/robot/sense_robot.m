function sensor_readings = sense_robot(robot_state, maze)
    % SENSE_ROBOT - Binary sensors (1=open, 0=wall)
    % Returns [front_open, left_open, right_open]
    
    % Get current position and direction
    pos = robot_state.position;
    dir = robot_state.direction;
    [rows, cols] = size(maze);
    
    % Initialize sensor readings (1=open, 0=wall)
    sensor_readings = zeros(1, 3);
    
    % Direction vectors: [row_change, col_change]
    % Order: N, E, S, W
    dir_vectors = [-1, 0;  % North
                    0, 1;  % East
                    1, 0;  % South
                    0, -1]; % West
    
    % Check front cell
    front_dir = dir;
    front_pos = pos + dir_vectors(front_dir, :);
    sensor_readings(1) = is_cell_open(front_pos, maze);
    
    % Check left cell (rotate counter-clockwise)
    left_dir = mod(dir - 2, 4) + 1;
    left_pos = pos + dir_vectors(left_dir, :);
    sensor_readings(2) = is_cell_open(left_pos, maze);
    
    % Check right cell (rotate clockwise)
    right_dir = mod(dir, 4) + 1;
    right_pos = pos + dir_vectors(right_dir, :);
    sensor_readings(3) = is_cell_open(right_pos, maze);
end

function open = is_cell_open(pos, maze)
    % IS_CELL_OPEN - Check if a cell is open (path) and within bounds
    [rows, cols] = size(maze);
    
    % Check boundaries
    if pos(1) < 1 || pos(1) > rows || pos(2) < 1 || pos(2) > cols
        open = 0;  % Out of bounds = wall
        return;
    end
    
    % Check if cell is a path (1) not wall (0)
    open = (maze(pos(1), pos(2)) == 1);
end
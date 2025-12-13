function robot_state = init_robot(start_pos, start_dir)
    % INIT_ROBOT - Initialize robot state structure
    % Inputs: start_pos [row,col], start_dir (1=N,2=E,3=S,4=W)
    % Output: robot_state structure with all robot properties
    
    % Create robot state structure
    robot_state = struct();
    
    % Position and orientation
    robot_state.position = start_pos;      % Current [row, col]
    robot_state.direction = start_dir;     % 1=N, 2=E, 3=S, 4=W
    robot_state.start_pos = start_pos;     % For reference
    robot_state.start_dir = start_dir;     % For reference
    
    % Movement history
    robot_state.path = start_pos;          % Store all positions visited
    robot_state.actions = [];              % Store all actions taken
    robot_state.step_count = 0;            % Number of steps taken
    robot_state.collisions = 0;           % Number of wall collisions
    
    % Sensor readings (will be updated)
    robot_state.sensors = [0, 0, 0];       % [front, left, right]
    
    % Performance metrics
    robot_state.score = 1000;              % Starting score
    robot_state.is_active = true;          % Robot can still move
    
    % Graphics handles (will be set later)
    robot_state.graphics.body = [];
    robot_state.graphics.front = [];
    robot_state.graphics.trail = [];
    
    % Memory for algorithms (optional)
    robot_state.memory.visited = [];       % Cells already visited
    robot_state.memory.map = [];           % Internal map representation
end
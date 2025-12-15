function robot_state = init_robot(start_pos, start_dir)
    % INIT_ROBOT - Initialize robot state with separate counters
    
    robot_state = struct();
    
    % Position and orientation
    robot_state.position = start_pos;
    robot_state.direction = start_dir;
    robot_state.start_pos = start_pos;
    robot_state.start_dir = start_dir;
    
    % SEPARATE ACTION COUNTERS
    robot_state.move_count = 0;        % Number of forward moves
    robot_state.turn_count = 0;        % Total turns (left + right)
    
    % For debugging and direction sense
    robot_state.turn_left_count = 0;   % Only left turns
    robot_state.turn_right_count = 0;  % Only right turns

    % Stay nobody really uses but still if someone wants to give bot break
    robot_state.stay_count = 0;        % Number of stays

    robot_state.total_actions = 0;     % All actions

    % Real bad thing to be avoided, but always welcome to do so
    robot_state.collisions = 0;        % Wall collisions
    
    % Action tracking
    robot_state.actions = [];          % History of actions (for debugging)
    robot_state.path = start_pos;      % History of position
    robot_state.last_action_type = 'none';
    
    % Sensors
    robot_state.sensors = [0, 0, 0];   % [front, left, right] or F L R
    
    % Performance metrics
    robot_state.score = 1000;         % Starting score (score looks fun)
    robot_state.is_active = true;
    
    % Memory for algorithms
    robot_state.memory = struct();
    robot_state.memory.visited = start_pos;
    robot_state.memory.dead_ends = [];
    
    % Graphics handles
    robot_state.graphics = struct();
    robot_state.graphics.body = [];
    robot_state.graphics.front = [];
    robot_state.graphics.trail = [];
    robot_state.graphics.stats_text = [];

    % Initialize turning points array
    robot_state.turning_points = [];  % Stores [row, col] positions where robot turned (Useful for algorithm implementation)
    
end
function robot_state = update_robot(robot_state, action, maze)

    % Increment total actions
    robot_state.total_actions = robot_state.total_actions + 1;
    robot_state.actions = [robot_state.actions; action];
    
    % Store previous position before any action
    % The whole purpose of previous was to mark turns with orange dots "/
    previous_position = robot_state.position;
    
    % Direction vectors
    dir_vectors = [-1, 0; 0, 1; 1, 0; 0, -1];  % N, E, S, W
    
    switch action
        case 1  % MOVE FORWARD
            robot_state.move_count = robot_state.move_count + 1;
            
            % Calculate new position
            new_pos = robot_state.position + dir_vectors(robot_state.direction, :);
            
            % Check if move is valid
            if is_valid_move(new_pos, maze)
                robot_state.position = new_pos;
                robot_state.path = [robot_state.path; new_pos];
                
                % Update score: -2 for moving
                robot_state.score = robot_state.score - 2;
                robot_state.last_action_type = 'move';
                
            else
                % Invalid move (into wall)
                robot_state.collisions = robot_state.collisions + 1;
                robot_state.score = robot_state.score - 10; % Bcz whyy
                robot_state.last_action_type = 'collision';
            end
            
        case 2  % TURN LEFT
            robot_state.turn_count = robot_state.turn_count + 1;
            robot_state.turn_left_count = robot_state.turn_left_count + 1;
            
            % Update direction (N->W->S->E->N) [Like a State Machine]
            robot_state.direction = mod(robot_state.direction - 2, 4) + 1;
            
            % Record turn position "/
            robot_state.turning_points = [robot_state.turning_points; previous_position];
            
            % Update score: -1 for turning
            robot_state.score = robot_state.score - 1;
            robot_state.last_action_type = 'turn_left';
            
        case 3  % TURN RIGHT
            robot_state.turn_count = robot_state.turn_count + 1;
            robot_state.turn_right_count = robot_state.turn_right_count + 1;
            
            % Update direction (N->E->S->W->N)
            robot_state.direction = mod(robot_state.direction, 4) + 1;
            
            % Record turn position
            robot_state.turning_points = [robot_state.turning_points; previous_position];
            
            % Update score: -1 for turning
            robot_state.score = robot_state.score - 1;
            robot_state.last_action_type = 'turn_right';
            
        % In case it comes handy (Will penalize though)
        case 4  % STAY
            robot_state.stay_count = robot_state.stay_count + 1;
            robot_state.score = robot_state.score - 1;
            robot_state.last_action_type = 'stay';
            
        otherwise
            error('Invalid action. Must be 1-4.');
    end
    
    % Update sensor readings
    robot_state.sensors = sense_robot(robot_state, maze);
    
    % Update visited cells
    if ~ismember(robot_state.position, robot_state.memory.visited, 'rows')
        robot_state.memory.visited = [robot_state.memory.visited; robot_state.position];
    end
end



% LOCAL HELPER FUNCTION
function valid = is_valid_move(pos, maze)
    % IS_VALID_MOVE - Check if position is valid and within bounds
    [rows, cols] = size(maze);
    
    % Check boundaries
    if pos(1) < 1 || pos(1) > rows || pos(2) < 1 || pos(2) > cols
        valid = false;
        return;
    end
    
    % Check if cell is a path (not a wall)
    valid = (maze(pos(1), pos(2)) == 1);
end
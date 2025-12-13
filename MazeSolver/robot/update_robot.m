function robot_state = update_robot(robot_state, action, maze)
    % UPDATE_ROBOT - Update robot state based on action
    % Inputs: robot_state, action (1-4), maze matrix
    % Output: Updated robot_state
    
    % Store the action taken
    robot_state.actions = [robot_state.actions; action];
    robot_state.step_count = robot_state.step_count + 1;
    
    % Define direction vectors
    dir_vectors = [-1, 0; 0, 1; 1, 0; 0, -1];  % N, E, S, W
    
    switch action
        case 1  % Move forward
            % Calculate new position
            new_pos = robot_state.position + dir_vectors(robot_state.direction, :);
            
            % Check if move is valid (not into wall or out of bounds)
            if is_valid_move(new_pos, maze)
                robot_state.position = new_pos;
                robot_state.path = [robot_state.path; new_pos];
                
                % Update score (penalty for each step)
                robot_state.score = robot_state.score - 1;
            else
                % Invalid move (into wall) - penalize
                robot_state.collisions = robot_state.collisions + 1;
                robot_state.score = robot_state.score - 10;
                disp('Collision with wall!');
            end
            
        case 2  % Turn left
            % Update direction (N->W->S->E->N)
            robot_state.direction = mod(robot_state.direction - 2, 4) + 1;
            
        case 3  % Turn right
            % Update direction (N->E->S->W->N)
            robot_state.direction = mod(robot_state.direction, 4) + 1;
            
        case 4  % Stay (do nothing)
            % Still penalize for wasting time
            robot_state.score = robot_state.score - 2;
            
        otherwise
            error('Invalid action. Must be 1-4.');
    end
    
    % Update sensor readings
    robot_state.sensors = sense_robot(robot_state, maze);
    
    % Update memory of visited cells
    robot_state.memory.visited = [robot_state.memory.visited; robot_state.position];
end

function valid = is_valid_move(pos, maze)
    % IS_VALID_MOVE - Check if position is within maze and not a wall
    [rows, cols] = size(maze);
    
    % Check boundaries
    if pos(1) < 1 || pos(1) > rows || pos(2) < 1 || pos(2) > cols
        valid = false;
        return;
    end
    
    % Check if cell is a path (1) not wall (0)
    valid = (maze(pos(1), pos(2)) == 1);
end
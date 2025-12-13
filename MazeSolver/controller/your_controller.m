function action = your_controller(sensor_data, current_pos, current_dir, maze)
    % YOUR_CONTROLLER - Simplified for binary sensors
    % Inputs:
    %   sensor_data: [front_open, left_open, right_open] (1=open, 0=wall)
    %   current_pos: [row, column] current position
    %   current_dir: current facing direction (1=N, 2=E, 3=S, 4=W)
    %   maze: complete maze matrix
    % Output:
    %   action: 1=move forward, 2=turn left, 3=turn right, 4=stay
    
    % Extract binary sensor readings
    front_open = sensor_data(1);
    left_open = sensor_data(2);
    right_open = sensor_data(3);
    
    % ==============================================
    % PARTICIPANTS: IMPLEMENT YOUR ALGORITHM HERE
    % ==============================================
    
    % EXAMPLE 1: Right-hand wall follower (simplified)
    if front_open == 1
        % Path ahead is clear, move forward
        action = 1;
    elseif right_open == 1
        % Wall on right, path on right, turn right
        action = 3;
    elseif left_open == 1
        % Wall on right and front, path on left, turn left
        action = 2;
    else
        % Dead end, turn around (left twice or right twice)
        action = 2;  % Turn left (will need to turn twice)
    end
    
    % EXAMPLE 2: Random explorer (for testing)
    % possible_actions = [];
    % if front_open == 1
    %     possible_actions = [possible_actions, 1];
    % end
    % if left_open == 1
    %     possible_actions = [possible_actions, 2];
    % end
    % if right_open == 1
    %     possible_actions = [possible_actions, 3];
    % end
    % if isempty(possible_actions)
    %     action = 2;  % Turn left (dead end)
    % else
    %     action = possible_actions(randi(length(possible_actions)));
    % end
end
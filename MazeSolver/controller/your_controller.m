function action = your_controller(sensor_data, current_pos, current_dir, maze)

    % YOUR_CONTROLLER 

  %INPUTS:
    %   sensor_data: [front, left, right] (1=open, 0=wall)
    %   current_pos: [row, col] current position
    %   current_dir: current direction (1=N, 2=E, 3=S, 4=W)
    %   maze: complete maze matrix (for advanced algorithms)

  % Output:
    %   action: 1 = move forward,
    %           2 = turn left, 
    %           3 = turn right,
    %           4=stay    

    % Note: U-Turn take 2 lefts or 2 rights
    
    % Extract sensor readings
    front_open = sensor_data(1);
    left_open = sensor_data(2);
    right_open = sensor_data(3);

    dir_str = {'N','E','S','W'};
    goal = [size(maze,1)-1, size(maze,2)-1];
    
    fprintf('Pos:[%d,%d] Dir:%s(%d) | Sensors:F%d L%d R%d | ', ...
        current_pos(1), current_pos(2), dir_str{current_dir}, current_dir, ...
        front_open, left_open, right_open);
    fprintf('Goal:[%d,%d]\n', goal(1), goal(2));



    % ==============================================
    % PARTICIPANTS: IMPLEMENT YOUR ALGORITHM HERE
    % ==============================================
    


    %  EXAMPLE: Simple wall follower (right-hand rule)
    if front_open == 1
        % Path ahead is clear, move forward
        action = 1;
    elseif right_open == 1
        % Right is clear, turn right
        action = 3;
    elseif left_open == 1
        % Left is clear, turn left
        action = 2;
    else
        % Dead end, turn around (turn left twice)
        action = 2;  % First turn left
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
    
    % EXAMPLE 3: Left-hand rule (mirror of right-hand)
    % if front_open == 1
    %     action = 1;
    % elseif left_open == 1
    %     action = 2;
    % elseif right_open == 1
    %     action = 3;
    % else
    %     action = 3;  % Turn right to turn around
    % end
end
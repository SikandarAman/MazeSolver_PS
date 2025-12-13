function action = your_controller(sensor_data, current_pos, current_dir, maze)
    % YOUR_CONTROLLER - Template for participant's maze-solving algorithm
    % Inputs:
    %   sensor_data: [front_distance, left_distance, right_distance]
    %   current_pos: [row, column] current position in maze
    %   current_dir: current facing direction (1=N, 2=E, 3=S, 4=W)
    %   maze: complete maze matrix (optional for advanced algorithms)
    % Output:
    %   action: 1=move forward, 2=turn left, 3=turn right, 4=stay
    
    % Extract sensor readings
    front_dist = sensor_data(1);
    left_dist = sensor_data(2);
    right_dist = sensor_data(3);
    
    % ==============================================
    % PARTICIPANTS: IMPLEMENT YOUR ALGORITHM HERE
    % ==============================================
    
    % EXAMPLE 1: Simple wall follower (right-hand rule)
    % Always keep your right hand on the wall
    
    if front_dist > 0
        % If path ahead is clear, move forward
        action = 1;
    elseif right_dist > 0
        % If right is clear, turn right
        action = 3;
    elseif left_dist > 0
        % If left is clear, turn left
        action = 2;
    else
        % Dead end, turn around (turn left twice)
        action = 2;  % First turn left
    end
    
    % EXAMPLE 2: Random walk (for testing)
    % Uncomment to try random movement
    % action = randi([1, 4]);
    
    % EXAMPLE 3: Left-hand rule (mirror of right-hand)
    % if front_dist > 0
    %     action = 1;
    % elseif left_dist > 0
    %     action = 2;
    % elseif right_dist > 0
    %     action = 3;
    % else
    %     action = 2;  % Turn around
    % end
end
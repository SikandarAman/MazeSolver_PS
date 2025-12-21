function [action, saved_path] = your_controller(sensor_data, current_pos, current_dir, maze, saved_path)
    % YOUR_CONTROLLER - Participant's maze-solving algorithm
    
    % INPUTS:
    %   sensor_data: [front, left, right] (1=open, 0=wall)
    %   current_pos: [row, col] current position
    %   current_dir: current direction (1=N, 2=E, 3=S, 4=W)
    %   maze: complete maze matrix
    %   saved_path: array where participant can store their shortest path
    %               Each row is [row, col] position
    
    % OUTPUTS:
    %   action: 1 = move forward, 2 = turn left, 3 = turn right, 4 = stay
    %   saved_path: updated path array (participant can append positions)
    
    % Extract sensor readings
    front_open = sensor_data(1);
    left_open = sensor_data(2);
    right_open = sensor_data(3);
    
    % ==============================================
    % PARTICIPANTS: IMPLEMENT YOUR ALGORITHM HERE
    % ==============================================
    

    % EXAMPLE: Simple wall follower (right-hand rule)
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

    % You can add positions to saved_path as you discover what you think
    % is the shortest path. For example: (here I am for now saving wherever traversed)
    %YOU CAN SEE IT AS VERY SMALL RED DOTS IN YOUR PATH TO VISUALIZE
    
     saved_path = [saved_path; current_pos];

    % IMPORTANT: Don't add every position or array will be too large!
    % Only add key positions that form your shortest path.

end
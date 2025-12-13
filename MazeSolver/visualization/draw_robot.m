function draw_robot(robot_state, maze)
    % DRAW_ROBOT - Draw robot at current position with direction
    % Inputs: robot_state structure, maze matrix
    
    % Get maze dimensions for coordinate conversion
    [rows, cols] = size(maze);
    pos = robot_state.position;
    dir = robot_state.direction;
    
    % Convert matrix coordinates to plot coordinates
    % In maze matrix: (row, col) where row increases downward
    % In plot: (x, y) where y increases upward, so we invert rows
    plot_x = pos(2) - 0.5;      % Column becomes x
    plot_y = rows - pos(1) + 0.5;  % Invert row to get y
    
    % ===========================================================
    % FIXED SECTION: Proper handle checking and deletion
    % ===========================================================
    
    % Check and delete robot body if it exists
    if isfield(robot_state.graphics, 'body') 
        if ~isempty(robot_state.graphics.body)
            % Check if handle is still valid
            if ishandle(robot_state.graphics.body)
                delete(robot_state.graphics.body);
            end
        end
    end
    
    % Check and delete front indicator if it exists
    if isfield(robot_state.graphics, 'front') 
        if ~isempty(robot_state.graphics.front)
            if ishandle(robot_state.graphics.front)
                delete(robot_state.graphics.front);
            end
        end
    end
    
    % Check and delete trail if it exists
    if isfield(robot_state.graphics, 'trail') 
        if ~isempty(robot_state.graphics.trail)
            if ishandle(robot_state.graphics.trail)
                delete(robot_state.graphics.trail);
            end
        end
    end
    
    % Alternative: More concise way (if you prefer)
    % delete_if_exists(robot_state.graphics, 'body');
    % delete_if_exists(robot_state.graphics, 'front');
    % delete_if_exists(robot_state.graphics, 'trail');
    
    hold on;
    
    % Draw robot body (square)
    robot_state.graphics.body = rectangle('Position', ...
        [plot_x-0.4, plot_y-0.4, 0.8, 0.8], ...
        'FaceColor', [0.2 0.6 1.0], ...  % Blue
        'EdgeColor', 'k', ...
        'LineWidth', 2, ...
        'Curvature', 0.2);  % Slightly rounded corners
    
    % Draw direction indicator (triangle pointing forward)
    switch dir
        case 1  % North (up)
            tri_x = [plot_x, plot_x-0.3, plot_x+0.3];
            tri_y = [plot_y+0.3, plot_y-0.2, plot_y-0.2];
        case 2  % East (right)
            tri_x = [plot_x+0.3, plot_x-0.2, plot_x-0.2];
            tri_y = [plot_y, plot_y-0.3, plot_y+0.3];
        case 3  % South (down)
            tri_x = [plot_x, plot_x-0.3, plot_x+0.3];
            tri_y = [plot_y-0.3, plot_y+0.2, plot_y+0.2];
        case 4  % West (left)
            tri_x = [plot_x-0.3, plot_x+0.2, plot_x+0.2];
            tri_y = [plot_y, plot_y-0.3, plot_y+0.3];
    end
    
    robot_state.graphics.front = patch(tri_x, tri_y, 'y', ...
        'EdgeColor', 'k', 'LineWidth', 1, 'FaceAlpha', 0.8);
    
    % Draw path trail if there is history
    if size(robot_state.path, 1) > 1
        % Convert path to plot coordinates
        path_x = robot_state.path(:, 2) - 0.5;
        path_y = rows - robot_state.path(:, 1) + 0.5;
        
        robot_state.graphics.trail = plot(path_x, path_y, 'b-', ...
            'LineWidth', 1.5, 'Color', [0 0 0.7 0.5]);
    end
    
    % Display robot info
    info_str = sprintf('Pos: [%d,%d]\nDir: %s\nSteps: %d\nScore: %d', ...
        pos(1), pos(2), ...
        get_direction_name(dir), ...
        robot_state.step_count, ...
        round(robot_state.score));
    
    text(0.5, rows+0.5, info_str, ...
        'BackgroundColor', 'w', ...
        'EdgeColor', 'k', ...
        'FontSize', 10, ...
        'VerticalAlignment', 'bottom');
    
    hold off;
    drawnow;
end

function dir_name = get_direction_name(dir_num)
    % Helper function to convert direction number to name
    switch dir_num
        case 1, dir_name = 'North';
        case 2, dir_name = 'East';
        case 3, dir_name = 'South';
        case 4, dir_name = 'West';
        otherwise, dir_name = 'Unknown';
    end
end

% Optional helper function (uncomment if you want to use it)
% function delete_if_exists(graphics_struct, field_name)
%     % Helper to delete graphic objects safely
%     if isfield(graphics_struct, field_name)
%         if ~isempty(graphics_struct.(field_name))
%             if ishandle(graphics_struct.(field_name))
%                 delete(graphics_struct.(field_name));
%             end
%         end
%     end
% end
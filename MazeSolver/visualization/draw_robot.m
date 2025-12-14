function robot_state = draw_robot(robot_state, maze)
    % DRAW_ROBOT - Draw robot with action-based coloring
    % Updates existing figure instead of creating new one
    
    % Find the main figure
    fig = findobj('Type', 'Figure', 'Name', 'Maze Solver');
    if isempty(fig)
        % If figure doesn't exist, create it
        draw_maze(maze, [2,2], [size(maze,1)-1, size(maze,2)-1]);
        fig = gcf;
    else
        figure(fig);  % Make it current
    end
    
    % Get maze dimensions
    [rows, cols] = size(maze);
    pos = robot_state.position;
    dir = robot_state.direction;
    
    % Convert to plot coordinates
    plot_x = pos(2) - 0.5;
    plot_y = rows - pos(1) + 0.5;
    
    % ============================================
    % # CLEAR PREVIOUS ROBOT GRAPHICS ONLY
    % # ============================================
    
    % We need to clear only robot-related graphics, not the maze
    % Get all children of current axes
    ax = gca;
    children = get(ax, 'Children');
    
    % Delete only robot-related objects (identified by tags or types)
    % We'll use UserData to tag robot graphics
    for i = length(children):-1:1
        obj = children(i);
        if isprop(obj, 'UserData') && ~isempty(obj.UserData)
            if strcmp(obj.UserData, 'robot_graphics')
                delete(obj);
            end
        end
        
        % Also delete by type if no UserData (for backward compatibility)
        if isa(obj, 'matlab.graphics.primitive.Text')
            % Check if it's statistics text (contains numbers)
           if isvalid(obj) && ~isempty(obj.String)
                str = obj.String;
                if contains(str, 'Pos:') || contains(str, 'Moves:') || ...
                   contains(str, 'Turns:') || contains(str, 'Score:')
                    delete(obj);
                end
            end
        end
    end
    
    % Also delete any remaining trail (lines)
    lines = findobj(ax, 'Type', 'line');
    for i = 1:length(lines)
        if ~isempty(lines(i).Color)
            % Check if it's a trail line (blue with transparency)
            if all(lines(i).Color(1:3) == [0 0 0.7]) || ...
               (length(lines(i).Color) > 3 && lines(i).Color(4) == 0.5)
                delete(lines(i));
            end
        end
    end
    
    hold on;
    
    % ============================================
    % # COLOR CODE BASED ON LAST ACTION
    % # ============================================
    
    switch robot_state.last_action_type
        case 'move'
            body_color = [0.2 0.6 1.0];    % Blue
            action_text = 'MOVED';
        case 'turn_left'
            body_color = [1.0 0.8 0.2];    % Yellow
            action_text = 'TURNED LEFT';
        case 'turn_right'
            body_color = [1.0 0.5 0.2];    % Orange
            action_text = 'TURNED RIGHT';
        case 'collision'
            body_color = [1.0 0.2 0.2];    % Red
            action_text = 'COLLISION!';
        case 'stay'
            body_color = [0.6 0.6 0.6];    % Gray
            action_text = 'STAYED';
        otherwise
            body_color = [0.2 0.6 1.0];    % Default blue
            action_text = '';
    end
    
    % ============================================
    % # DRAW ROBOT BODY
    % # ============================================
    
    robot_body = rectangle('Position', ...
        [plot_x-0.4, plot_y-0.4, 0.8, 0.8], ...
        'FaceColor', body_color, ...
        'EdgeColor', 'k', ...
        'LineWidth', 2, ...
        'Curvature', 0.2);
    robot_body.UserData = 'robot_graphics';  % Tag it for deletion
    
    % ============================================
    % # DRAW DIRECTION INDICATOR
    % # ============================================
    
    switch dir
        case 1  % North
            tri_x = [plot_x, plot_x-0.3, plot_x+0.3];
            tri_y = [plot_y+0.3, plot_y-0.2, plot_y-0.2];
        case 2  % East
            tri_x = [plot_x+0.3, plot_x-0.2, plot_x-0.2];
            tri_y = [plot_y, plot_y-0.3, plot_y+0.3];
        case 3  % South
            tri_x = [plot_x, plot_x-0.3, plot_x+0.3];
            tri_y = [plot_y-0.3, plot_y+0.2, plot_y+0.2];
        case 4  % West
            tri_x = [plot_x-0.3, plot_x+0.2, plot_x+0.2];
            tri_y = [plot_y, plot_y-0.3, plot_y+0.3];
    end
    
    robot_front = patch(tri_x, tri_y, 'y', ...
        'EdgeColor', 'k', 'LineWidth', 1, 'FaceAlpha', 0.8);
    robot_front.UserData = 'robot_graphics';  % Tag it
    
    % ============================================
    % # DRAW PATH TRAIL
    % # ============================================
    
    if size(robot_state.path, 1) > 1
        % Convert path to plot coordinates
        path_x = robot_state.path(:, 2) - 0.5;
        path_y = rows - robot_state.path(:, 1) + 0.5;
        
        robot_trail = plot(path_x, path_y, 'b-', ...
            'LineWidth', 1.5, 'Color', [0 0 0.7 0.5]);
        robot_trail.UserData = 'robot_graphics';  % Tag it
        
        % ============================================
        % # MARK TURNING POINTS (CORRECTED)
        % # ============================================
        
        if ~isempty(robot_state.turning_points)
            % Get unique turning points to avoid duplicate markers
            [unique_turns, ~] = unique(robot_state.turning_points, 'rows', 'stable');
            
            % Convert turning points to plot coordinates
            turn_x = unique_turns(:, 2) - 0.5;
            turn_y = rows - unique_turns(:, 1) + 0.5;
            
            % Plot each turning point
            for i = 1:size(unique_turns, 1)
                % Skip if this is the current position (unless we want to mark it)
                if isequal(unique_turns(i, :), robot_state.position)
                    continue;
                end
                
                turn_marker = plot(turn_x(i), turn_y(i), 'o', ...
                    'MarkerSize', 8, ...
                    'MarkerFaceColor', [1 0.5 0], ...  % Orange
                    'MarkerEdgeColor', 'k', ...
                    'LineWidth', 1);
                turn_marker.UserData = 'robot_graphics';  % Tag it
            end
            
            % If current action was a turn, mark current position too
            if strcmp(robot_state.last_action_type, 'turn_left') || ...
               strcmp(robot_state.last_action_type, 'turn_right')
                turn_marker = plot(plot_x, plot_y, 's', ...  % Square for current turn
                    'MarkerSize', 10, ...
                    'MarkerFaceColor', [1 0.8 0], ...  % Bright yellow
                    'MarkerEdgeColor', 'r', ...
                    'LineWidth', 2);
                turn_marker.UserData = 'robot_graphics';  % Tag it
            end
        end
    end
    % ============================================
    % # DISPLAY STATISTICS
    % # ============================================
    
    % Convert direction to name
    dir_str = get_direction_name(dir);
    
    stats_str = sprintf(['ROBOT STATISTICS\n' ...
                         'Pos: [%d,%d] | Dir: %s\n' ...
                         'Moves: %d | Turns: %d (L:%d, R:%d)\n' ...
                         'Stays: %d | Collisions: %d\n' ...
                         'Actions: %d | Score: %.0f\n' ...
                         'Visited: %d cells'], ...
        pos(1), pos(2), ...
        dir_str, ...
        robot_state.move_count, ...
        robot_state.turn_count, ...
        robot_state.turn_left_count, ...
        robot_state.turn_right_count, ...
        robot_state.stay_count, ...
        robot_state.collisions, ...
        robot_state.total_actions, ...
        round(robot_state.score), ...
        size(robot_state.memory.visited, 1));
    
    stats_text = text(0.5, rows+1.5, stats_str, ...
        'BackgroundColor', 'w', ...
        'EdgeColor', 'k', ...
        'FontSize', 9, ...
        'VerticalAlignment', 'top', ...
        'HorizontalAlignment', 'left', ...
        'Margin', 3);
    stats_text.UserData = 'robot_graphics';  % Tag it
    
    % ============================================
    % # ACTION INDICATOR TEXT
    % # ============================================
    
    if ~isempty(action_text)
        action_text_obj = text(plot_x, plot_y+0.6, action_text, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'FontWeight', 'bold', ...
            'FontSize', 10, ...
            'Color', 'k', ...
            'BackgroundColor', [1 1 1 0.7]);
        action_text_obj.UserData = 'robot_graphics';  % Tag it
    end
    
    hold off;
    drawnow;
    
    % Update graphics handles in robot_state (optional)
    robot_state.graphics.body = robot_body;
    robot_state.graphics.front = robot_front;
    robot_state.graphics.stats_text = stats_text;
end

% ============================================
% # HELPER FUNCTION FOR DIRECTION NAME
% # ============================================

function dir_name = get_direction_name(dir_num)
    % GET_DIRECTION_NAME - Convert direction number to name
    switch dir_num
        case 1
            dir_name = 'North';
        case 2
            dir_name = 'East';
        case 3
            dir_name = 'South';
        case 4
            dir_name = 'West';
        otherwise
            dir_name = 'Unknown';
    end
end
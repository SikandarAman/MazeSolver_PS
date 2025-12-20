function robot_state = draw_robot(robot_state, maze)
    % DRAW_ROBOT, Draw robot with action-based coloring
    % Updates existing figure instead of creating new one
    
    % Find the main figure
    fig = findobj('Type', 'Figure', 'Name', 'Maze Solver');
    if isempty(fig)
        % If figure doesn't exist, create it
        draw_maze(maze, [2,2], [size(maze,1)-1, size(maze,2)-1]);
        fig = gcf;
    else
        figure(fig);
    end
    
    % Get maze dimensions
    [rows, cols] = size(maze);
    pos = robot_state.position;
    dir = robot_state.direction;
    
    % Convert to plot coordinates
    plot_x = pos(2) - 0.5; 
    plot_y = rows - pos(1) + 0.5;
    
    % Clear ALL text objects in statistics area (above the maze)
    ax = gca;
    all_objs = findobj(ax);
    
    for i = length(all_objs):-1:1
        obj = all_objs(i);
        
        % Check if it's a text object
        if isa(obj, 'matlab.graphics.primitive.Text')
            if isvalid(obj)
                % Get text position
                txt_pos = obj.Position;
                if length(txt_pos) >= 2 && txt_pos(2) > rows
                    % Delete any text in statistics area (above maze)
                    delete(obj);
                end
            end
        end
    end
    
    % Also clear robot graphics (body, front, trail)
    for i = length(all_objs):-1:1
        obj = all_objs(i);
        if isprop(obj, 'UserData') && ~isempty(obj.UserData)
            if strcmp(obj.UserData, 'robot_graphics')
                delete(obj);
            end
        end
    end
    
    hold on;
    
    % COLOR CODE BASED ON LAST ACTION    
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
    
    % DRAW ROBOT BODY
    robot_body = rectangle('Position', ...
        [plot_x-0.4, plot_y-0.4, 0.8, 0.8], ...
        'FaceColor', body_color, ...
        'EdgeColor', 'k', ...
        'LineWidth', 2, ...
        'Curvature', 0.2);
    robot_body.UserData = 'robot_graphics';
    
    % DRAW DIRECTION INDICATOR  
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
    robot_front.UserData = 'robot_graphics';
    
    % DRAW PATH TRAIL    
    if size(robot_state.path, 1) > 1
        % Convert path to plot coordinates
        path_x = robot_state.path(:, 2) - 0.5;
        path_y = rows - robot_state.path(:, 1) + 0.5;
        
        robot_trail = plot(path_x, path_y, 'b-', ...
            'LineWidth', 1.5, 'Color', [0 0 0.7 0.5]);
        robot_trail.UserData = 'robot_graphics';
        
        % MARK TURNING POINTS
        if ~isempty(robot_state.turning_points)
            % Get unique turning points
            [unique_turns, ~] = unique(robot_state.turning_points, 'rows', 'stable');
            
            % Convert turning points to plot coordinates
            turn_x = unique_turns(:, 2) - 0.5;
            turn_y = rows - unique_turns(:, 1) + 0.5;
            
            % Plot each turning point
            for i = 1:size(unique_turns, 1)
                % Skip if this is the current position
                if isequal(unique_turns(i, :), robot_state.position)
                    continue;
                end
                
                turn_marker = plot(turn_x(i), turn_y(i), 'o', ...
                    'MarkerSize', 8, ...
                    'MarkerFaceColor', [1 0.5 0], ...
                    'MarkerEdgeColor', 'k', ...
                    'LineWidth', 1);
                turn_marker.UserData = 'robot_graphics';
            end
            
            % If current action was a turn, mark current position too
            if strcmp(robot_state.last_action_type, 'turn_left') || ...
               strcmp(robot_state.last_action_type, 'turn_right')
                turn_marker = plot(plot_x, plot_y, 's', ...
                    'MarkerSize', 10, ...
                    'MarkerFaceColor', [1 0.8 0], ...
                    'MarkerEdgeColor', 'r', ...
                    'LineWidth', 2);
                turn_marker.UserData = 'robot_graphics';
            end
        end
    end
    
    % ACTION INDICATOR TEXT (on maze)
    if ~isempty(action_text)
        action_text_obj = text(plot_x, plot_y+0.6, action_text, ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'bottom', ...
            'FontWeight', 'bold', ...
            'FontSize', 10, ...
            'Color', 'k', ...
            'BackgroundColor', [1 1 1 0.7]);
        action_text_obj.UserData = 'robot_graphics';
    end
    
    % DISPLAY STATISTICS IN SEPARATE AREA (above maze)
    % Convert direction to name
    dir_str = get_direction_name(dir);
    
    % Calculate statistics values
    total_path_cells = sum(maze(:) == 1);
    visited_cells = size(robot_state.memory.visited, 1);
    visited_percent = 100 * visited_cells / total_path_cells;
    goal_pos = [size(maze,1)-1, size(maze,2)-1];
    dist = sum(abs(pos - goal_pos));
    
    % Create a formatted statistics display
    stats_y = rows + 4.5;  % Position above maze
    
        % Main title
        title_text = text(0.5, stats_y, 'ROBOT STATISTICS', ...
            'FontSize', 11, 'FontWeight', 'bold', ...
            'Color', 'b', 'HorizontalAlignment', 'left', ...
            'Interpreter', 'none'); 
        
        % Position and direction
        pos_text = sprintf('Position: [%d, %d] | Direction: %s', ...
            pos(1), pos(2), dir_str);
        text(0.5, stats_y - 0.8, pos_text, ...
            'FontSize', 9, 'HorizontalAlignment', 'left', ...
            'Interpreter', 'none'); 
            
    % Action counts
    actions_text = sprintf('Moves: %d | Turns: %d (L:%d, R:%d) | Stays: %d', ...
        robot_state.move_count, ...
        robot_state.turn_count, ...
        robot_state.turn_left_count, ...
        robot_state.turn_right_count, ...
        robot_state.stay_count);
    text(0.5, stats_y - 1.6, actions_text, ...
        'FontSize', 9, 'HorizontalAlignment', 'left');
    
    % Performance metrics
    perf_text = sprintf('Collisions: %d | Actions: %d | Score: %.0f', ...
        robot_state.collisions, ...
        robot_state.total_actions, ...
        round(robot_state.score));
    text(0.5, stats_y - 2.4, perf_text, ...
        'FontSize', 9, 'HorizontalAlignment', 'left');
    
    % Exploration info
    explored_text = sprintf('Visited: %d cells (%.1f%% of maze)', ...
        visited_cells, visited_percent);
    text(0.5, stats_y - 3.2, explored_text, ...
        'FontSize', 9, 'HorizontalAlignment', 'left');
    
    % Right side statistics
    sensor_y = rows + 4.5;
    
    % Sensor readings
    sensor_text = sprintf('SENSORS [F L R]: [%d %d %d]', ...
        robot_state.sensors(1), robot_state.sensors(2), robot_state.sensors(3));
    text(cols - 1, sensor_y, sensor_text, ...
        'FontSize', 9, 'FontWeight', 'bold', ...
        'Color', [0.2 0.5 0.2], 'HorizontalAlignment', 'right');
    
    % Current action
    action_text_display = sprintf('Last Action: %s', robot_state.last_action_type);
    text(cols - 1, sensor_y - 0.8, action_text_display, ...
            'FontSize', 9, 'HorizontalAlignment', 'right', ...
            'Interpreter', 'none'); 
    
    % Goal distance
    dist_text = sprintf('Goal Distance: %d cells', dist);
    text(cols - 1, sensor_y - 1.6, dist_text, ...
        'FontSize', 9, 'HorizontalAlignment', 'right');
    
    % Turn ratio if applicable
    if robot_state.turn_count > 0
        ratio = robot_state.move_count / robot_state.turn_count;
        ratio_text = sprintf('Move/Turn Ratio: %.2f', ratio);
        text(cols - 1, sensor_y - 2.4, ratio_text, ...
            'FontSize', 9, 'HorizontalAlignment', 'right');
    end
    
    hold off;
    drawnow;
    
    % Update graphics handles in robot_state
    robot_state.graphics.body = robot_body;
    robot_state.graphics.front = robot_front;
end


% HELPER FUNCTION FOR DIRECTION NAME
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
            dir_name = 'Unknown'; %Shouldn't exist but good to put else case
    end
end
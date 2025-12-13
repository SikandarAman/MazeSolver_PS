function draw_maze(maze, start_pos, goal_pos)
    % DRAW_MAZE - Visualize the maze with start and goal markers
    % Inputs: maze matrix, start_pos, goal_pos
    
    % Get maze dimensions
    [rows, cols] = size(maze);
    
    % Create figure if it doesn't exist
    if isempty(findobj('Type', 'Figure', 'Name', 'Maze Solver'))
        figure('Name', 'Maze Solver', 'Position', [100 100 800 600]);
    else
        clf;  % Clear current figure
    end
    
    hold on;
    axis equal;
    axis([0 cols 0 rows]);
    grid on;
    set(gca, 'YDir', 'reverse');  % So row 1 is at top
    title('Maze Solver Hackathon');
    
    % Draw each cell
    for r = 1:rows
        for c = 1:cols
            if maze(r, c) == 0  % Wall
                rectangle('Position', [c-1, rows-r, 1, 1], ...
                         'FaceColor', [0.4 0.4 0.4], ...
                         'EdgeColor', [0.2 0.2 0.2], ...
                         'LineWidth', 1);
            else  % Path
                rectangle('Position', [c-1, rows-r, 1, 1], ...
                         'FaceColor', [0.95 0.95 0.95], ...
                         'EdgeColor', [0.8 0.8 0.8], ...
                         'LineWidth', 0.5);
            end
        end
    end
    
    % Draw start position (green)
    start_x = start_pos(2) - 0.5;
    start_y = rows - start_pos(1) + 0.5;
    plot(start_x, start_y, 'gs', ...
         'MarkerSize', 20, 'MarkerFaceColor', 'g', ...
         'MarkerEdgeColor', 'k', 'LineWidth', 2);
    
    % Draw goal position (red)
    goal_x = goal_pos(2) - 0.5;
    goal_y = rows - goal_pos(1) + 0.5;
    plot(goal_x, goal_y, 'ro', ...
         'MarkerSize', 25, 'MarkerFaceColor', 'r', ...
         'MarkerEdgeColor', 'k', 'LineWidth', 2);
    
    % Add text labels
    text(start_x, start_y-0.1, 'START', ...
         'HorizontalAlignment', 'center', ...
         'FontWeight', 'bold', 'Color', 'k');
    text(goal_x, goal_y-0.1, 'GOAL', ...
         'HorizontalAlignment', 'center', ...
         'FontWeight', 'bold', 'Color', 'k');
    
    hold off;
    drawnow;
end
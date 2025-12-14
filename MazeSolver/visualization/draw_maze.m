function draw_maze(maze, start_pos, goal_pos)
    % DRAW_MAZE - Draw maze with grid lines as walls
    % Updates existing figure instead of creating new one
    
    % Get maze dimensions
    [rows, cols] = size(maze);
    
    % Check if figure exists
    fig = findobj('Type', 'Figure', 'Name', 'Maze Solver');
    
    if isempty(fig)
        % Create new figure
        fig = figure('Name', 'Maze Solver', 'Position', [100 100 900 700], ...
                    'NumberTitle', 'off', 'IntegerHandle', 'off');
        set(fig, 'Tag', 'MazeSolverFigure');  % Set tag for easy finding
    else
        % Use existing figure
        figure(fig);
        clf;  % Clear the figure for redrawing
    end
    
    hold on;
    axis equal;
    axis([0 cols 0 rows]);
    grid off;
    
    % Set background to light gray
    set(gca, 'Color', [0.95 0.95 0.95]);
    
    % ============================================
    % # DRAW ALL CELLS WITH COLORS
    % # ============================================
    
    % Draw each cell
    for r = 1:rows
        for c = 1:cols
            if maze(r, c) == 0  % Wall cell
                % Light gray for walls
                rectangle('Position', [c-1, rows-r, 1, 1], ...
                         'FaceColor', [0.85 0.85 0.85], ...
                         'EdgeColor', 'none');
            else  % Path cell
                % White for paths
                rectangle('Position', [c-1, rows-r, 1, 1], ...
                         'FaceColor', [1 1 1], ...
                         'EdgeColor', 'none');
            end
        end
    end
    
    % ============================================
    % # DRAW GRID LINES (WALLS)
    % # ============================================
    
    % Draw thin gray grid lines for all cells
    for x = 0:cols
        plot([x x], [0 rows], '-', 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    end
    for y = 0:rows
        plot([0 cols], [y y], '-', 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    end
    
    % Draw thick black lines for actual walls
    % Horizontal walls
    for r = 1:rows-1
        for c = 1:cols
            % Wall between cell (r,c) and (r+1,c)
            if maze(r, c) == 0 || maze(r+1, c) == 0
                plot([c-1, c], [rows-r, rows-r], 'k-', 'LineWidth', 3);
            end
        end
    end
    
    % Vertical walls
    for r = 1:rows
        for c = 1:cols-1
            % Wall between cell (r,c) and (r,c+1)
            if maze(r, c) == 0 || maze(r, c+1) == 0
                plot([c, c], [rows-r, rows-r+1], 'k-', 'LineWidth', 3);
            end
        end
    end
    
    % Outer borders (always walls)
    plot([0 cols], [0 0], 'k-', 'LineWidth', 4);      % Top
    plot([0 cols], [rows rows], 'k-', 'LineWidth', 4); % Bottom
    plot([0 0], [0 rows], 'k-', 'LineWidth', 4);      % Left
    plot([cols cols], [0 rows], 'k-', 'LineWidth', 4); % Right
    
    % ============================================
    % # MARK START AND GOAL
    % # ============================================
    
    % Start position (green)
    start_x = start_pos(2) - 0.5;
    start_y = rows - start_pos(1) + 0.5;
    
    rectangle('Position', [start_x-0.3, start_y-0.3, 0.6, 0.6], ...
             'FaceColor', 'g', 'EdgeColor', 'k', ...
             'LineWidth', 2, 'Curvature', 0.3);
    text(start_x, start_y-0.5, 'START', ...
         'HorizontalAlignment', 'center', ...
         'FontWeight', 'bold', 'FontSize', 10);
    
    % Goal position (red)
    goal_x = goal_pos(2) - 0.5;
    goal_y = rows - goal_pos(1) + 0.5;
    
    rectangle('Position', [goal_x-0.3, goal_y-0.3, 0.6, 0.6], ...
             'FaceColor', 'r', 'EdgeColor', 'k', ...
             'LineWidth', 2, 'Curvature', 0.3);
    text(goal_x, goal_y-0.5, 'GOAL', ...
         'HorizontalAlignment', 'center', ...
         'FontWeight', 'bold', 'FontSize', 10);
    
    % Set Y direction to match matrix indexing
    set(gca, 'YDir', 'reverse');
    
    % Add title with maze info
    title(sprintf('Maze Solver - Level: %dx%d', rows, cols), 'FontSize', 14);
    
    hold off;
    drawnow;
end
function maze = generate_random_maze(rows, cols)
    % GENERATE_RANDOM_MAZE, will create a random maze using Randomized Prim's algorithm
    % Input: rows, cols, dimensions of maze
    % Output: maze, binary matrix (0=wall, 1=path)
    
    % Initialize with all walls
    maze = zeros(rows, cols);
    
    % Create borders
    maze(1, :) = 0;   % Top border
    maze(end, :) = 0; % Bottom border
    maze(:, 1) = 0;   % Left border
    maze(:, end) = 0; % Right border
    
    % Start cell (always open, ensure it's not on border)
    start_row = 2;
    start_col = 2;
    
    % Mark start as path
    maze(start_row, start_col) = 1;
    
    % List of frontier cells
    frontiers = [];
    
    % Add initial frontiers (cells 2 steps away from start)
    if start_row > 2
        frontiers = [frontiers; start_row-2, start_col];
    end
    if start_row < rows-1
        frontiers = [frontiers; start_row+2, start_col];
    end
    if start_col > 2
        frontiers = [frontiers; start_row, start_col-2];
    end
    if start_col < cols-1
        frontiers = [frontiers; start_row, start_col+2];
    end
    
    % Mark frontiers in maze (temporary marking for algorithm)
    for i = 1:size(frontiers, 1)
        maze(frontiers(i,1), frontiers(i,2)) = 2;
    end
    
    % Main algorithm loop
    while ~isempty(frontiers)
        % Pick a random frontier cell
        idx = randi(size(frontiers, 1));
        current = frontiers(idx, :);
        
        % Remove from frontiers
        frontiers(idx, :) = [];
        
        % List of neighbors that are already paths
        neighbors = [];
        
        % Check all 4 directions
        dirs = [-2, 0; 2, 0; 0, -2; 0, 2];
        for d = 1:4
            neighbor = current + dirs(d, :);
            if neighbor(1) >= 1 && neighbor(1) <= rows && ...
               neighbor(2) >= 1 && neighbor(2) <= cols
                if maze(neighbor(1), neighbor(2)) == 1  % Already a path
                    neighbors = [neighbors; neighbor];
                end
            end
        end
        
        if ~isempty(neighbors)
            % Pick a random neighbor to connect to
            neighbor = neighbors(randi(size(neighbors, 1)), :); %Trusting on random function to be random :)
            
            % Carve path between current and neighbor
            wall_row = floor((current(1) + neighbor(1)) / 2);
            wall_col = floor((current(2) + neighbor(2)) / 2);
            
            maze(current(1), current(2)) = 1;  % Make current a path
            maze(wall_row, wall_col) = 1;      % Remove wall between them
            
            % Add new frontiers from current cell
            new_dirs = [-2, 0; 2, 0; 0, -2; 0, 2];
            for d = 1:4
                new_frontier = current + new_dirs(d, :);
                if new_frontier(1) >= 2 && new_frontier(1) <= rows-1 && ...
                   new_frontier(2) >= 2 && new_frontier(2) <= cols-1
                    if maze(new_frontier(1), new_frontier(2)) == 0  % Unvisited
                        frontiers = [frontiers; new_frontier];
                        maze(new_frontier(1), new_frontier(2)) = 2;  % Mark as frontier
                    end
                end
            end
        end
    end
    
    % Clean up: remove frontier markers (2) and set to walls (0)
    maze(maze == 2) = 0;
    
    % Ensure start and goal are accessible
    maze(2, 2) = 1;  % Start position
    maze(rows-1, cols-1) = 1;  % Goal position
    
    % Connect goal if isolated
    if maze(rows-2, cols-1) == 0 && maze(rows-1, cols-2) == 0
        % Carve a path to goal
        maze(rows-2, cols-1) = 1;
        maze(rows-3, cols-1) = 1;
    end
    
    % Ensure maze is solvable by running a simple BFS
    if ~is_maze_solvable(maze, [2,2], [rows-1, cols-1])
        fprintf('Warning: Generated maze may not be solvable. Regenerating...\n');
        % Try one more time recursively
        maze = generate_random_maze(rows, cols);
    end
end

function solvable = is_maze_solvable(maze, start, goal)
    % Simple BFS to check if maze is solvable
    [rows, cols] = size(maze);
    visited = false(rows, cols);
    queue = start;
    visited(start(1), start(2)) = true;
    
    dirs = [-1, 0; 1, 0; 0, -1; 0, 1];
    
    while ~isempty(queue)
        current = queue(1, :);
        queue(1, :) = [];
        
        if isequal(current, goal)
            solvable = true;
            return;
        end
        
        for d = 1:4
            next = current + dirs(d, :);
            if next(1) >= 1 && next(1) <= rows && ...
               next(2) >= 1 && next(2) <= cols
                if maze(next(1), next(2)) == 1 && ~visited(next(1), next(2))
                    visited(next(1), next(2)) = true;
                    queue = [queue; next];
                end
            end
        end
    end
    
    solvable = false;
end
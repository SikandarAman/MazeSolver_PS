function [maze, start_pos, goal_pos] = maze_def(level)
    % MAZE_DEF - Returns predefined mazes for 5 levels
    % 0 = wall, 1 = path (btw Binary maze, others with line walls became complex)
    
    switch level
        case 1  % Level 1: 10x10
            maze = [0 0 0 0 0 0 0 0 0 0;
                    0 1 1 1 0 1 1 1 1 0;
                    0 1 0 1 0 1 0 0 1 0;
                    0 1 0 1 1 1 0 1 1 0;
                    0 1 0 0 0 0 0 1 0 0;
                    0 1 1 1 1 1 1 1 0 0;
                    0 0 0 1 0 0 0 1 0 0;
                    0 1 1 1 0 1 1 1 1 0;
                    0 1 0 0 0 1 0 0 1 0;
                    0 0 0 0 0 0 0 0 0 0];
                    
        case 2  % Level 2: 15x15
            maze = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                    0 1 1 1 1 1 0 1 1 1 1 1 0 1 0;
                    0 1 0 0 0 1 0 1 0 0 0 1 0 1 0;
                    0 1 1 1 0 1 1 1 0 1 1 1 0 1 0;
                    0 0 0 1 0 0 0 0 0 1 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 1 1 0;
                    0 1 0 0 0 0 0 1 0 0 0 0 0 0 0;
                    0 1 1 1 1 1 0 1 1 1 1 1 1 1 0;
                    0 0 0 0 0 1 0 0 0 1 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 0 1 0;
                    0 1 0 0 0 0 0 1 0 0 0 1 0 1 0;
                    0 1 0 1 1 1 1 1 1 1 0 1 1 1 0;
                    0 1 0 1 0 0 0 0 0 1 0 0 0 0 0;
                    0 1 1 1 0 1 1 1 1 1 1 1 1 1 0;
                    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                    
        case 3  % Level 3: 20x20
            maze = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                    0 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 0;
                    0 1 0 1 0 1 0 0 0 1 0 1 0 0 0 1 0 0 1 0;
                    0 1 0 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 0;
                    0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 0 1 0;
                    0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 1 0 1 0;
                    0 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 1 0 1 0;
                    0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 1 0;
                    0 1 0 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 1 0;
                    0 1 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0;
                    0 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 1 0 0;
                    0 0 0 1 0 1 0 0 0 1 0 1 0 0 0 0 0 1 0 0;
                    0 1 1 1 0 1 0 1 1 1 1 1 0 1 1 1 0 1 1 0;
                    0 1 0 0 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 0;
                    0 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 0;
                    0 1 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 0;
                    0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0;
                    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                    
        case 4  % Level 4: 25x25
            maze = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                    0 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0;
                    0 1 0 0 0 1 0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 0;
                    0 1 0 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 0;
                    0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 1 0;
                    0 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 0;
                    0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 0;
                    0 1 0 0 0 0 0 1 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 1 0;
                    0 1 1 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 1 1 0;
                    0 0 0 0 0 1 0 0 0 1 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0;
                    0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 0;
                    0 1 0 1 0 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0;
                    0 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 0;
                    0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 1 0 0 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 1 1 0 1 0;
                    0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 1 0;
                    0 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 0;
                    0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0;
                    0 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 0;
                    0 0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 1 0 1 0;
                    0 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 0 1 0 1 1 1 0 1 0;
                    0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0 1 0 1 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0;
                    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                    
        case 5  % Level 5: 30x30
            maze = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 0;
                    0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 1 0;
                    0 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 0 1 1 1 1 1 1 0 1 0;
                    0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 0 1 0 1 0;
                    0 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 0 1 0;
                    0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 0;
                    0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 0;
                    0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 0 1 1 0;
                    0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 1 0 0;
                    0 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 0;
                    0 1 0 1 0 0 0 1 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0;
                    0 1 0 1 1 1 1 1 0 1 1 1 1 1 0 1 0 1 1 1 1 1 0 1 1 1 1 1 1 0;
                    0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 1 0 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0;
                    0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 1 0;
                    0 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 0;
                    0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0;
                    0 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 0;
                    0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0;
                    0 1 1 1 0 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 0 1 0;
                    0 1 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 1 0;
                    0 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 0 1 0;
                    0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0;
                    0 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0;
                    0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
                    0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0;
                    0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0;
                    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                    
        otherwise
            error('Level must be between 1 and 5');
    end
    
    % Set start and goal positions
    % Basically starting at above the first black box 
    % ending in a similar way to get the longest the alterante vertices
    start_pos = [2, 2];
    goal_pos = [size(maze, 1) - 1, size(maze, 2) - 1];
end


% function [maze, start_pos, goal_pos] = maze_def(level, algorithm)
%     % MAZE_DEF - Improved maze generator with multiple algorithms
%     % Input: level (1-5), algorithm ('recursive', 'prim', 'kruskal')
%     % Output: maze (matrix), start_pos [row,col], goal_pos [row,col]
% 
%     if nargin < 2
%         algorithm = 'recursive';  % Default algorithm
%     end
% 
%     % Set maze sizes based on level
%     maze_sizes = [10, 15, 20, 25, 30];
%     n = maze_sizes(level);
% 
%     % Generate maze using selected algorithm
%     switch lower(algorithm)
%         case 'recursive'
%             maze = generate_recursive_maze(n);
%         case 'prim'
%             maze = generate_prim_maze(n);
%         case 'kruskal'
%             maze = generate_kruskal_maze(n);
%         case 'simple'
%             maze = generate_simple_maze(n);
%         otherwise
%             maze = generate_recursive_maze(n);
%     end
% 
%     % Set start and goal positions
%     start_pos = [2, 2];
%     goal_pos = [n-1, n-1];
% 
%     % Ensure start and goal are paths
%     maze(start_pos(1), start_pos(2)) = 1;
%     maze(goal_pos(1), goal_pos(2)) = 1;
% end
% 
% %% =====================================================
% %% ALGORITHM 1: Recursive Backtracking (Standard)
% %% =====================================================
% function maze = generate_recursive_maze(n)
%     % Initialize with all walls (0 = wall, 1 = path)
%     maze = zeros(n, n);
% 
%     % Mark grid cells (every other cell is a potential path)
%     for i = 2:2:n-1
%         for j = 2:2:n-1
%             maze(i, j) = 1;  % Potential path cell
%         end
%     end
% 
%     % Start from (2,2)
%     stack = [2, 2];
%     visited = false(n, n);
%     visited(2, 2) = true;
% 
%     % Directions: [dx, dy] for up, right, down, left
%     directions = [-2, 0; 0, 2; 2, 0; 0, -2];
% 
%     while ~isempty(stack)
%         current = stack(end, :);
%         x = current(1);
%         y = current(2);
% 
%         % Get unvisited neighbors (2 steps away)
%         neighbors = [];
%         for d = 1:4
%             nx = x + directions(d, 1);
%             ny = y + directions(d, 2);
% 
%             % Check bounds and if unvisited
%             if nx >= 2 && nx <= n-1 && ny >= 2 && ny <= n-1
%                 if ~visited(nx, ny) && maze(nx, ny) == 1
%                     neighbors = [neighbors; nx, ny];
%                 end
%             end
%         end
% 
%         if ~isempty(neighbors)
%             % Choose random neighbor
%             idx = randi(size(neighbors, 1));
%             next = neighbors(idx, :);
% 
%             % Remove wall between current and next
%             wall_x = (x + next(1)) / 2;
%             wall_y = (y + next(2)) / 2;
%             maze(wall_x, wall_y) = 1;
% 
%             % Mark as visited and push to stack
%             visited(next(1), next(2)) = true;
%             stack = [stack; next];
%         else
%             % Backtrack
%             stack(end, :) = [];
%         end
%     end
% 
%     % Add outer walls
%     maze(1, :) = 0;
%     maze(end, :) = 0;
%     maze(:, 1) = 0;
%     maze(:, end) = 0;
% end
% 
% %% =====================================================
% %% ALGORITHM 2: Prim's Algorithm (Better maze variety)
% %% =====================================================
% function maze = generate_prim_maze(n)
%     % Initialize with all walls
%     maze = zeros(n, n);
% 
%     % Start cell
%     start = [2, 2];
%     maze(start(1), start(2)) = 1;
% 
%     % List of frontier cells
%     frontiers = get_frontiers(start, n, maze);
% 
%     while ~isempty(fronters)
%         % Pick random frontier
%         idx = randi(size(frontiers, 1));
%         cell = frontiers(idx, :);
%         frontiers(idx, :) = [];
% 
%         % Get neighbors that are already paths
%         neighbors = get_neighbors(cell, n, maze);
%         if ~isempty(neighbors)
%             % Connect to random neighbor
%             nidx = randi(size(neighbors, 1));
%             neighbor = neighbors(nidx, :);
% 
%             % Carve path between cell and neighbor
%             wall_x = (cell(1) + neighbor(1)) / 2;
%             wall_y = (cell(2) + neighbor(2)) / 2;
%             maze(wall_x, wall_y) = 1;
%             maze(cell(1), cell(2)) = 1;
% 
%             % Add new frontiers
%             new_frontiers = get_frontiers(cell, n, maze);
%             frontiers = [frontiers; new_frontiers];
%         end
%     end
% 
%     % Add outer walls
%     maze(1, :) = 0;
%     maze(end, :) = 0;
%     maze(:, 1) = 0;
%     maze(:, end) = 0;
% end
% 
% function frontiers = get_frontiers(cell, n, maze)
%     % Get frontier cells (2 cells away)
%     x = cell(1);
%     y = cell(2);
%     frontiers = [];
% 
%     directions = [-2, 0; 0, 2; 2, 0; 0, -2];
% 
%     for d = 1:4
%         nx = x + directions(d, 1);
%         ny = y + directions(d, 2);
% 
%         if nx >= 2 && nx <= n-1 && ny >= 2 && ny <= n-1
%             if maze(nx, ny) == 0  % Cell is wall
%                 frontiers = [frontiers; nx, ny];
%             end
%         end
%     end
% end
% 
% function neighbors = get_neighbors(cell, n, maze)
%     % Get neighbor cells that are already paths
%     x = cell(1);
%     y = cell(2);
%     neighbors = [];
% 
%     directions = [-2, 0; 0, 2; 2, 0; 0, -2];
% 
%     for d = 1:4
%         nx = x + directions(d, 1);
%         ny = y + directions(d, 2);
% 
%         if nx >= 2 && nx <= n-1 && ny >= 2 && ny <= n-1
%             if maze(nx, ny) == 1  % Cell is already a path
%                 neighbors = [neighbors; nx, ny];
%             end
%         end
%     end
% end
% 
% %% =====================================================
% %% ALGORITHM 3: Simple Maze (Guaranteed good results)
% %% =====================================================
% function maze = generate_simple_maze(n)
%     % Create a simple but guaranteed good maze
% 
%     % Initialize with all walls
%     maze = zeros(n, n);
% 
%     % Create a spiral or simple pattern
%     for i = 2:n-1
%         for j = 2:n-1
%             % Create horizontal and vertical paths
%             if mod(i, 2) == 0 || mod(j, 2) == 0
%                 maze(i, j) = 1;
%             end
% 
%             % Add some randomness
%             if rand() > 0.3
%                 maze(i, j) = 1;
%             end
%         end
%     end
% 
%     % Ensure start and end are connected
%     % Create a guaranteed path from start to end
%     x = 2;
%     y = 2;
% 
%     while x < n-1 || y < n-1
%         maze(x, y) = 1;
% 
%         % Move toward goal
%         if x < n-1 && rand() > 0.5
%             x = x + 1;
%         elseif y < n-1
%             y = y + 1;
%         else
%             x = x + 1;
%         end
%     end
%     maze(n-1, n-1) = 1;
% 
%     % Add outer walls
%     maze(1, :) = 0;
%     maze(end, :) = 0;
%     maze(:, 1) = 0;
%     maze(:, end) = 0;
% 
%     % Make sure there are enough walls
%     for i = 2:n-1
%         for j = 2:n-1
%             if rand() > 0.7 && ~((i==2 && j==2) || (i==n-1 && j==n-1))
%                 maze(i, j) = 0;
%             end
%         end
%     end
% end
% 
% %% =====================================================
% %% ALGORITHM 4: Kruskal's Algorithm
% %% =====================================================
% function maze = generate_kruskal_maze(n)
%     % Initialize with all walls
%     maze = zeros(n, n);
% 
%     % Create list of all walls between cells
%     walls = [];
% 
%     for i = 2:2:n-1
%         for j = 2:2:n-1
%             maze(i, j) = 1;  % Cell
% 
%             % Add walls to right and down
%             if j < n-1
%                 walls = [walls; i, j, i, j+2, i, j+1];  % Right wall
%             end
%             if i < n-1
%                 walls = [walls; i, j, i+2, j, i+1, j];  % Down wall
%             end
%         end
%     end
% 
%     % Initialize disjoint set for each cell
%     parent = 1:n*n;
% 
%     % Randomize walls
%     walls = walls(randperm(size(walls, 1)), :);
% 
%     for w = 1:size(walls, 1)
%         cell1 = (walls(w,1)-1)*n + walls(w,2);
%         cell2 = (walls(w,3)-1)*n + walls(w,4);
%         wall_x = walls(w,5);
%         wall_y = walls(w,6);
% 
%         if find(parent, cell1) ~= find(parent, cell2)
%             % Remove wall
%             maze(wall_x, wall_y) = 1;
%             union(parent, cell1, cell2);
%         end
%     end
% 
%     % Add outer walls
%     maze(1, :) = 0;
%     maze(end, :) = 0;
%     maze(:, 1) = 0;
%     maze(:, end) = 0;
% end
% 
% function root = find(parent, x)
%     while parent(x) ~= x
%         parent(x) = parent(parent(x));
%         x = parent(x);
%     end
%     root = x;
% end
% 
% function union(parent, x, y)
%     rootX = find(parent, x);
%     rootY = find(parent, y);
%     if rootX ~= rootY
%         parent(rootY) = rootX;
%     end
% end
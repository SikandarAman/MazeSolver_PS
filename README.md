# Maze Solver Challenge - IIT Ropar Robotics Club

## Overview
Maze solving is the art and science of finding a path from start to finish through complex pathways. It's not just a puzzle—it's a fundamental challenge in robotics, artificial intelligence, and algorithm design that simulates real-world navigation problems.

Maze solving bridges theory with practice in the most engaging way possible. While you learn algorithms in lectures, here you implement them in action!

This project gives you hands-on experience with two critical engineering skills:

### 🛠️ **MATLAB Programming** - The industry-standard tool for:
- Numerical computation
- Algorithm development  
- Data visualization
- Engineering simulations

### 🧠 **Algorithm Design** - Learn by doing:
- Pathfinding algorithms (DFS, BFS, A*)
- Optimization techniques
- Real-time decision making
- Problem-solving strategies

Every maze presents unique challenges that teach you:
- **Spatial reasoning** - Understanding 2D navigation
- **Sensor interpretation** - Making decisions with limited information
- **Efficiency optimization** - Finding the shortest/fastest path
- **Debugging skills** - When your algorithm gets stuck

## 🚀 Getting Started

### Installation Options:

**Option A: Download ZIP (Recommended for Beginners)**
1. Click the green "Code" button above
2. Select "Download ZIP"
3. Extract the files locally in any folder of your choice

![Download ZIP](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/DonwloadZip.png)


**Option B: Clone the GitHub Repository**
```bash
git clone https://github.com/[your-username]/MazeSolver.git
```


## 📁 Project Structure

```
MazeSolver/
├── config/
│   ├── generate_random_maze.m
│   └── maze_def.m
├── controller/
│   └── your_controller.m     <-- YOUR ALGORITHM GOES HERE (your_controller.m)
├── robot/
│   ├── init_robot.m
│   ├── sense_robot.m
│   └── update_robot.m
├── visualization/
│   ├── draw_maze.m
│   └── draw_robot.m
└── main.m                    <-- RUN SIMULATION FROM HERE (main.m)
```

## 🎯 Quick Start Guide

1. **Open MATLAB**

2. **Navigate to the MazeSolver folder**
   - Use the "Current Folder" browser to navigate to your extracted/cloned folder

![Add Folder Location](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/MatlabLocn.png)

3. **Run the main file**
   - Double-click on `main.m` in the file browser

![Double Click Main](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/LocatingMain.png)

4. **Run the simulation**
   - Click the "Run" button or press F5

![Run Code](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/Run.png)

5. **Add to Path (First time only)**
   - If prompted, select "Add to Path" to allow MATLAB to access all files

6. **Start the simulation**
   - Enter your entry number and select a level (1-6)
   - Level 1-5 are predefined fixed examples
   - Levl 6 is the main level (random everytime) for final run

![Terminal Input](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/TerminalView.png)

## 🤖 Default Algorithm

The project comes with a basic right-wall follower algorithm implemented by default:
(Note for level 1 this algorithm works well, the final stats file are saved in .txt file on successful completion)

![Default Wall Follower](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/Bot.png)

## ✨ Your Task: The Controller

**Important:** The only file you need to modify is `your_controller.m`. This is where you implement your maze-solving algorithm.

![Your Controller File](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/YourController.png)

### Running Your Simulation:
1. Always run from `main.m`
2. Use full screen for better statistics readability
3. Adjust speed by modifying `bot_speed` in line 10 of main.m (no other changes needed in main)

## 📊 Maze Levels & Scoring

### Available Levels:
- **Levels 1-5**: Predefined example mazes for practice
- **Level 6**: Random maze generator (main challenge level)

### Maze Structure:
- Represented as matrices (0 = wall, 1 = path)
- Starting position: (2,2)
- Goal position: Bottom-right corner
![Maze Matrix](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/Matrix.png)

### Scoring Criteria:
- *your_controller code is expected for submission, as well as screenshots as you progress and justifications for methods used*
- *TRY BEST 2-3 ALGORITHMS FOR SUBMISSIONS, stating the pros and cons among them.*

- **Reference Score**: Scoring system inbuilt, just for reference for the participant themselves
- **Main Evaluation** (for competition):
  - Random maze solving capabilities (on average performance, will be checked on multiple mazes)
  - Code quality and structure
  - Algorithm creativity and novelty
  - Shortest path finding achievement, save final locations on array
  - Time to complete

## 📝 Result Files

When your simulation completes successfully, a statistics file will be saved automatically. Save this file along with your code for submission.

![Result File](https://github.com/SikandarAman/MazeSolver_PS/blob/main/Images/Results.png)

## 🎓 Learning Phases

### **Phase 1: The Explorer**
- Understand the basics
- Learn how sensors work (simulating real IR/ultrasonic sensors)
- Master basic movement commands (forward, turn, stop)
- Implement simple decision-making (if-else logic)

### **Phase 2: The Strategist**
- Implement classic algorithms
- Master wall-following techniques (right-hand/left-hand rule)
- Implement memory-based navigation (avoiding loops)
- Develop goal-seeking behavior

### **Phase 3: The Optimizer**
- Enhance performance metrics
- Minimize steps and turns
- Reduce collisions
- Find shortest paths
- *(Think: "If I had to go again, which path should I follow to reach fastest, considering I already did dry runs?")*

### **Phase 4: The Innovator**
- Create something new and original
- Combine multiple algorithms
- Implement adaptive strategies
- Push the boundaries of what's possible

## 🛠️ Technical Details

### Sensor Information:
The robot has three binary sensors (1=open, 0=wall):
- **Front**: Cell directly ahead
- **Left**: Cell to the left
- **Right**: Cell to the right

### Available Actions:
- **1**: Move forward
- **2**: Turn left
- **3**: Turn right
- **4**: Stay (penalized in scoring)

## Special Note
1. Every participant is requested to go through all the files and understand the coding part, will be helpful for your intution for designing the controller
2. There can be minor updates still required in repo, in case you feel some improvements contact us
3. Use LLM's for your benefit, though plagiarism will be strictly checked, but support can be taken from LLM's in case of difficulty of putting your thoughts to code
4. This is special, Consider you instead of bot, and you are solving a maze what will you be doing, from the given information.

## 🤝 Contributing
Feel free to fork this repository, experiment with different algorithms, and submit pull requests with improvements!

## 📞 Support

For questions or issues, please:
1. Check the code comments in each file
2. Review the example algorithms provided
3. Contact the Robotics Club, IIT Ropar robotics@iitrpr.ac.in
   or          Aman Mittal, 2023eeb1182@iitrpr.ac.in

---

**Happy Coding and Happy Maze Solving! 🎯**

*"The only way to learn a new programming language is by writing programs in it." - Dennis Ritchie*

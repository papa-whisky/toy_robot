# Toy Robot Simulator
A toy robot simulator, a small command-line app to place a robot on a 5x5 table and move it around. Refer to `PROBLEM.md` for the original app specification.

## Dependencies
- Ruby ~>2.5
- RSpec ~>3.7 (optional)

## Usage
Run the program with the executable `$ bin/toy_robot` then enter commands one at a time to control the robot. The following commands are valid:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

All commands will be ignored until the robot is placed. Any invalid input will be ignored. Any movement that would cause the robot to move off the 5x5 table will be ignored.

Note that no error is raised, nor message printed, when invalid commands are entered, as such output was not required by the specification. There was also no `EXIT` command or similar specified, so you'll need to use `Ctrl+c` to kill the app.

## Tests
Ensure you have the RSpec gem installed, then run the test suite with `$ rspec`.

## Design Notes
There are three main classes; `ToyRobot::Input` parses and validates the user input, `ToyRobot::Simulator` controls the robot and ensures it won't move off the table, and `ToyRobot::Robot` tracks x/y position and bearing.

The number of 'and's in that last sentence would indicate that these classes don't strictly follow the single responsibility principle. I found that splitting, for example, the `Input` class into further `Input::Parser` and `Input::Validator` classes made the code more difficult to navigate and to test cleanly. At present I don't believe any of these classes are overly complex or difficult to understand, and I prefer to avoid further abstraction until it actually provides a practical benefit.

require_relative 'robot'

module ToyRobot
  class Simulator
    VALID_COORD_RANGE = 0..4

    def initialize
      @robot = Robot.new
    end

    def execute(command:, params: nil)
      if command == 'PLACE'
        place_robot_at(params)
      elsif robot.placed?
        send_command_to_robot(command)
      end
    end

    private

    attr_reader :robot

    def place_robot_at(position)
      return unless position_valid?(position)
      robot.place(position: position)
    end

    def position_valid?(position)
      VALID_COORD_RANGE.include?(position[:x]) &&
        VALID_COORD_RANGE.include?(position[:y])
    end

    def send_command_to_robot(command)
      if command == 'MOVE'
        robot.move if position_valid?(robot.position_after_move)
      else
        robot.public_send(command.downcase.to_sym)
      end
    end
  end
end

require_relative 'toy_robot/input'

module ToyRobot
  def self.run
    loop do
      input = Input.new(gets.chomp)
      # ...pass input to a simulator that can execute the command
    end
  end
end

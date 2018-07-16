require_relative 'toy_robot/simulator'
require_relative 'toy_robot/input'

module ToyRobot
  def self.run
    simulator = Simulator.new

    loop do
      input = Input.new(gets.chomp)
      next unless input.valid?

      simulator.execute(command: input.command, params: input.params)
    end
  end
end

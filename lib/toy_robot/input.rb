module ToyRobot
  class Input
    attr_reader :command
    attr_reader :params

    def initialize(input)
      args = input.split(' ')

      @command = args[0]
      @params = parse_params_from(args[1])
    end

    private

    def parse_params_from(input)
      return unless input

      params = input.split(',')
      { x: params[0].to_i, y: params[1].to_i, bearing: params[2] }
    end
  end
end

module ToyRobot
  class Input
    VALID_COMMANDS = %w[PLACE MOVE LEFT RIGHT REPORT].freeze
    VALID_BEARINGS = %w[NORTH EAST SOUTH WEST].freeze

    attr_reader :command

    def initialize(input)
      args = input.split(' ')

      @command = args[0]
      @raw_params = args[1]&.split(',')
    end

    def params
      return unless raw_params
      { x: raw_params[0].to_i, y: raw_params[1].to_i, bearing: raw_params[2] }
    end

    def valid?
      command_valid? && params_valid?
    end

    private

    attr_reader :raw_params

    def command_valid?
      VALID_COMMANDS.include? command
    end

    def params_valid?
      if command == 'PLACE'
        !params.nil? && coordinates_valid? && bearing_valid?
      else
        params.nil?
      end
    end

    def coordinates_valid?
      # Ensure coordinates consist of digits only
      [raw_params[0], raw_params[1]].all? { |value| /^\d+$/ =~ value }
    end

    def bearing_valid?
      VALID_BEARINGS.include? raw_params[2]
    end
  end
end

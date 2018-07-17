module ToyRobot
  class Robot
    MOVEMENTS = {
      'NORTH' => { x: 0, y: 1 },
      'EAST' => { x: 1, y: 0 },
      'SOUTH' => { x: 0, y: -1 },
      'WEST' => { x: -1, y: 0 }
    }.freeze
    BEARINGS = MOVEMENTS.keys.freeze

    def place(position:)
      @x_pos = position[:x]
      @y_pos = position[:y]
      @bearing = position[:bearing]
    end

    def move
      @x_pos += movement[:x]
      @y_pos += movement[:y]
    end

    def left
      bearing_index = BEARINGS.index(bearing)
      @bearing = BEARINGS.rotate(-1)[bearing_index]
    end

    def right
      bearing_index = BEARINGS.index(bearing)
      @bearing = BEARINGS.rotate[bearing_index]
    end

    def report
      puts "#{x_pos},#{y_pos},#{bearing}"
    end

    def placed?
      !x_pos.nil? && !y_pos.nil? && !bearing.nil?
    end

    def position_after_move
      { x: x_pos + movement[:x], y: y_pos + movement[:y] }
    end

    private

    attr_reader :x_pos
    attr_reader :y_pos
    attr_reader :bearing

    def movement
      MOVEMENTS[bearing]
    end
  end
end

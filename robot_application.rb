class Table
    attr_reader :width, :height

    def initialize(width = 5, height = 5)
        @width = width
        @height = height
    end

    def valid_position?(x, y)
        x >= 0 && x < @width && y >= 0 && y < @height
    end
end

class Robot
    attr_accessor :x, :y, :facing

    def initialize(table)
        @table = table
        @x = nil
        @y = nil
        @facing = nil
    end

    def place(x, y, facing)
        if @table.valid_position?(x, y) && ['NORTH', 'SOUTH', 'EAST', 'WEST'].include?(facing)
            @x = x
            @y = y
            @facing = facing
        else
            puts "Placement is invalid. Please provide valid coordinates and direction."
        end
    end

    def move
        case @facing
        when 'NORTH'
        @y += 1 if @table.valid_position?(@x, @y + 1)
        when 'SOUTH'
        @y -= 1 if @table.valid_position?(@x, @y - 1)
        when 'EAST'
        @x += 1 if @table.valid_position?(@x + 1, @y)
        when 'WEST'
        @x -= 1 if @table.valid_position?(@x - 1, @y)
      end
    end

    def left
        case @facing
        when 'NORTH'
            @facing = 'WEST'
        when 'WEST'
            @facing = 'SOUTH'
        when 'SOUTH'
            @facing = 'EAST'
        when 'EAST'
            @facing = 'NORTH'
        end
    end

    def right
        case @facing
        when 'NORTH'
          @facing = 'EAST'
        when 'EAST'
          @facing = 'SOUTH'
        when 'SOUTH'
          @facing = 'WEST'
        when 'WEST'
          @facing = 'NORTH'
        end
    end

    def report
        if @x && @y && @facing
        puts "Output: #{@x}, #{@y}, #{@facing}"
        else
        puts "Robot is not placed on the table yet."
        end
    end
end


class CommandParser
    def initialize(robot)
      @robot = robot
    end
  
    def parse(command)
      parts = command.strip.split(' ')
      case parts[0]
      when 'PLACE'
        place_params = parts[1].split(',')
        if place_params.length == 3
          x, y, facing = place_params.map(&:strip)
          @robot.place(x.to_i, y.to_i, facing)
        else
            puts "Invalid PLACE command format. Please use 'PLACE X,Y,FACING'."
        end
      when 'MOVE'
        @robot.move
      when 'LEFT'
        @robot.left
      when 'RIGHT'
        @robot.right
      when 'REPORT'
        @robot.report
      else
        puts "Command not recognized. Please provide a valid command."
      end  
    end
end


# Sample test data
table = Table.new
robot = Robot.new(table)
command_parser = CommandParser.new(robot)

commands = [
  'PLACE 1,1,SOUTH',
  'MOVE',
  'REPORT'
]

commands.each { |command| command_parser.parse(command) }
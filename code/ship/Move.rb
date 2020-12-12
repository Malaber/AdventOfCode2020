require_relative '../Exceptions'

class Move
  attr_accessor :cmd, :value

  def initialize(line)
    @cmd = line[/[NSEWLRF]/]
    @value = line[/\d+/].to_i

    if @cmd.match /[LR]/
      raise ShipMoveInitializationError unless @value % 90 == 0
    end
  end

  def move(n, e, dir, cmd_override = nil)
    if cmd_override.nil?
      puts "#{@cmd}, #{@value}"
      print "N: #{n}, E: #{e}, DIR: #{dir} -> "
    end
    new_n = n.dup
    new_e = e.dup
    new_dir = dir.dup

    if cmd_override.nil?
      cmd = @cmd
    else
      cmd = cmd_override
    end

    case cmd
    when "N"
      new_n += @value
    when "S"
      new_n -= @value
    when "E"
      new_e += @value
    when "W"
      new_e -= @value
    when "L"
      new_dir -= @value
      new_dir += 360 until new_dir >= 0
    when "R"
      new_dir += @value
      new_dir -= 360 until new_dir < 360
    when "F"
      new_n, new_e, new_dir = move(n, e, dir, $lookup[dir/90])
    end

    puts "N: #{new_n}, E: #{new_e}, DIR: #{new_dir}" if cmd_override.nil?
    return new_n, new_e, new_dir
  end
end

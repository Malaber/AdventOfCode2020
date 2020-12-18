require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

lines.map!(&:strip)

def solve(line)
  p line
  subline_regex = /\(([^()]+?)\)/
  until line.count("(").zero?
    subline = line.match(subline_regex).captures.first
    subline_result = solve(subline)
    line.sub!(subline_regex, subline_result.to_s)
  end
  p line

  result = nil
  operator = nil
  line.split(/\s+/).each do |ins|
    if result.nil?
      result = ins.to_i
      next
    end

    if ins == "*"
      operator = "*"
      next
    end

    if ins == "+"
      operator = "+"
      next
    end

    if operator == "*"
      result *= ins.to_i
    end

    if operator == "+"
      result += ins.to_i
    end

  end

  result
end

sum = 0
lines.each_with_index do |line, index|
  p index
  result = solve(line)
  sum += result
end

p sum

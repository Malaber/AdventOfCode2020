require_relative '../input'
lines = get_lines $PROGRAM_NAME

lines.map!(&:to_i)

def first(lines)
  lines.each do |line|
    lines.each do |line2|
      if line + line2 == 2020
        return line * line2
      end
    end
  end
end

puts first(lines)


def second(lines)
  lines.each do |line|
    lines.each do |line2|
      lines.each do |line3|
        if line + line2 + line3 == 2020
          return line * line2 * line3
        end
      end
    end
  end
end

puts second(lines)

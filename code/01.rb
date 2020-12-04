require_relative '../input'
lines = get_lines $PROGRAM_NAME

lines.map!(&:to_i)

lines.each do |line|
  lines.each do |line2|
    if line + line2 == 2020
      puts line * line2
    end
  end
end
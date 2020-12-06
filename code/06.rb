require_relative '../input'
lines = get_lines $PROGRAM_NAME

groups = []
group = ""

lines.each do |line|
  line.strip!

  line.split('').each do |char|
    group = "#{group}#{char}" unless group.include?(char)
  end
  if line == ""
    groups << group
    group = ""
  end
end

counter = 0
groups.each do |group|
  counter += group.length
end

p counter

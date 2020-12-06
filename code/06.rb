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

part_2_group = nil
part_2_groups = []

lines.each do |line|
  if line == ""
    part_2_groups << part_2_group
    part_2_group = nil
    next
  end

  if part_2_group.nil?
    part_2_group = line
  else
    line_array = line.split("")
    part_2_group_array = part_2_group.split("")

    part_2_group = (line_array & part_2_group_array).join("")
  end
end

p part_2_groups
counter_2 = 0
part_2_groups.each do |group|
  counter_2 += group.length
end

p counter_2

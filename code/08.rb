require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

computer = Computer.new(lines, "Original Instructions")

begin
  exit_code = computer.run!
rescue ComputerError => e
  print e
end

exit 0 unless exit_code.nil?

puts "got ahead"

new_instruction_sets = [{set: lines.dup.map(&:dup), name: "Original set but duped"}]

lines.each_with_index do |line, index|
  new_lines = lines.dup.map(&:dup)
  if new_lines[index].match /nop/
    new_lines[index].gsub!("nop", "jmp")
    change = "Changed index #{index} from nop to jmp"
  elsif new_lines[index].match /jmp/
    new_lines[index].gsub!("jmp", "nop")
    change = "Changed index #{index} from jmp to nop"
  end

  new_instruction_sets << {set: new_lines, name: change} if change
end

new_instruction_sets.each do |set|
  computer = Computer.new(set[:set], set[:name])
  begin
    exit_code = computer.run!
    puts computer.name if exit_code.zero?
  rescue ComputerError => e
    print e
  end
end


exit 0



original_instructions.each_with_index do |instruction, index|
  new_instruction_set = original_instructions.dup.map(&:dup)
  case new_instruction_set[index].cmd
  when "nop"
    new_instruction_set[index] = Instruction.new("jmp", new_instruction_set[index].value, new_instruction_set[index].run_times)
    new_instruction_sets << {set: new_instruction_set, name: "Index #{index} changed from nop to jmp"}
  when "jmp"
    new_instruction_set[index] = Instruction.new("nop", new_instruction_set[index].value, new_instruction_set[index].run_times)
    new_instruction_sets << {set: new_instruction_set, name: "Index #{index} changed from jmp to nop"}
  end
end

new_instruction_sets.each do |instruction_set|
  computer = Computer.new(instruction_set[:set], instruction_set[:name])
  begin
    exit_code = computer.run!
    puts computer.name if exit_code.zero?
  rescue ComputerError => e
    print e
  end
end

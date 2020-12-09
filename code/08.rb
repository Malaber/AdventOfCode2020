require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

computer = Computer.new(lines.dup.map(&:dup), "Original Instructions")

begin
  exit_code = computer.run!
rescue ComputerError => e
  print e
end

exit 0 unless exit_code.nil?

new_instruction_sets = []

lines.each_with_index do |line, index|
  new_lines = lines.dup.map(&:dup)
  if line.match /nop/
    new_lines[index].gsub!("nop", "jmp")
    change = "Changed index #{index} from nop to jmp"
  elsif line.match /jmp/
    new_lines[index].gsub!("jmp", "nop")
    change = "Changed index #{index} from jmp to nop"
  end

  new_instruction_sets << {set: new_lines, name: change} if change
end

new_instruction_sets.each do |set|
  computer = Computer.new(set[:set], set[:name])
  begin
    exit_code, acc, pointer = computer.run!
    puts "#{computer.name}; acc: #{acc}; pointer: #{pointer}" if exit_code.zero?
  rescue ComputerError => e
    # print e
  end
end

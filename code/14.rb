require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

@bitmask = ""
mem = {}

def apply_bitmask(value)
  new_value = value.dup
  @bitmask.split("").each_with_index do |char, index|
    next if char == "X"
    new_value[index] = char
  end
  new_value.gsub("X", "0")
end

lines.each do |line|
  if line.match(/mask/)
    @bitmask = line.gsub("mask = ", "").strip
    next
  end
  address_string, value = line.strip.split(" = ")
  address = address_string.gsub!("mem[", "").gsub!("]", "").to_i
  value_bin = value.to_i.to_s(2)
  until value_bin.size == @bitmask.size
    value_bin = "X#{value_bin}"
  end

  mem[address] = apply_bitmask(value_bin).to_i(2)
end

p mem.values.inject(0){|sum,x| sum + x }

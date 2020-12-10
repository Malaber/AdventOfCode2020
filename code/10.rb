require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

CHARGING_OUTLET_VOLTAGE = 0
dif = [0,0,0,0]

lines.map!(&:to_i).sort!

device_built_in_joltage = lines.max + 3

def get_difference_to_next(voltages, index)
  voltage = voltages[index]
  next_voltage = voltages[index + 1]
  return 3  if next_voltage.nil?

  next_voltage - voltage
end

voltages = lines.dup.unshift(CHARGING_OUTLET_VOLTAGE)

voltages.each_with_index do |voltage, index|
  difference = get_difference_to_next(voltages, index)
  dif[difference] += 1
end

p dif[1] * dif[3]
require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

lines.map!(&:to_i).sort!

CHARGING_OUTLET_VOLTAGE = 0
@device_joltage = lines.max + 3

def get_difference_to_next(voltages, index)
  voltage = voltages[index]
  next_voltage = voltages[index + 1]
  return 0 if next_voltage.nil?

  next_voltage - voltage
end

def get_difference_array_for_lines(lines)
  dif = [0, 0, 0, 0]

  voltages = lines.dup.unshift(CHARGING_OUTLET_VOLTAGE)
  voltages.append(@device_joltage)

  voltages.each_with_index do |voltage, index|
    difference = get_difference_to_next(voltages, index)
    dif[difference] += 1
  end
  dif
end

dif = get_difference_array_for_lines(lines)

p dif[1] * dif[3]
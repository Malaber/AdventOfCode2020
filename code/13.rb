require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

bus_hashes_with_delay = {}

arrival_time = lines.first.to_i
buses = lines.last.split(",").map{|bus| bus == "x" ? "x" : bus.to_i }
buses.each_with_index do |bus, index| bus
  next if bus == "x"

  bus_hashes_with_delay[index] = bus
end

departures = {}

buses.each do |bus|
  next if bus == "x"

  earliest_departure = 0
  until arrival_time <= earliest_departure
    earliest_departure += bus
  end

  departures[bus] = earliest_departure
end

bus_id, departure_time = departures.min_by{|k,v| v}

puts bus_id * (departure_time - arrival_time)

def check_timestamp(t, bus_hashes_with_delay)
  bus_hashes_with_delay.each do |index, bus|
    return false unless ((t+index)%bus).zero?
  end
  return true
end

def get_t(bus_hashes_with_delay)
  max_bus = bus_hashes_with_delay.max_by{|k,v| v}.last
  t_at_max = max_bus
  loop do
    first_bus = t_at_max-bus_hashes_with_delay.key(max_bus)
    return first_bus if check_timestamp(first_bus, bus_hashes_with_delay)
    t_at_max += max_bus
  end
end

t = get_t(bus_hashes_with_delay)
p t

require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

arrival_time = lines.first.to_i
buses = lines.last.split(",").map{|bus| bus == "x" ? "x" : bus.to_i }

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

def check_timestamp(t, buses)
  buses.each_with_index do |bus, index|
    next if bus == "x"

    return false unless ((t+index)%bus).zero?
  end
  return true
end

def get_t(buses)
  max_bus = buses.max_by{|x| x=="x" ? 0 : x}
  t_at_max = max_bus
  loop do
    return t_at_max if check_timestamp(t_at_max-buses.index(max_bus), buses)
    t_at_max += max_bus
  end
end

t = get_t(buses)
p t

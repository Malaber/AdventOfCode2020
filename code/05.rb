require_relative '../input'
lines = get_lines $PROGRAM_NAME

ids = []

lines.each do |line|
  row = line[0..6]
  line[0..6] = ""
  seat = line

  row.gsub!("B", "1")
  row.gsub!("F", "0")
  seat.gsub!("R", "1")
  seat.gsub!("L", "0")

  row_bin = row.to_i(2)
  seat_bin = seat.to_i(2)

  ids << row_bin * 8 + seat_bin
end

p ids.max

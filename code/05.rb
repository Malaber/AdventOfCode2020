require_relative '../input'
lines = get_lines $PROGRAM_NAME

ids = []
passes = []

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

  id = row_bin * 8 + seat_bin

  ids << id
  passes << {id: id,
          seat: seat_bin,
          row: row_bin}
end

p passes.sort_by! { |pass | pass[:id] }.last

a = passes.first[:id]
b = passes.last[:id]

possible_ids = (a..b).to_a

p missing_ids = (possible_ids-ids)

script_number = ARGV[0]

exit 1 if File.exists?("inputs/#{script_number}.txt")
exit 1 if File.exists?("code/#{script_number}.txt")

File.open("inputs/#{script_number}.txt", "w"){|f| f.write("")}
File.open("code/#{script_number}.rb", "w"){|f| f.write(
"require_relative '../input'
lines = get_lines $PROGRAM_NAME
")}

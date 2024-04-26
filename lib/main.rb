
# TODO: Add option to receive from input
filename = "./resources/quake_logs.txt"

File.open(filename, 'r') do |f|
  f.each_line do |log_line|
    pp log_line.split
  end
end

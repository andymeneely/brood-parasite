require 'tty-reader'

reader = TTY::Reader.new

reader.on(:keyescape) do
  puts "Exiting!"
  exit
end

reader.on(:keyf8) do
  puts "Rebuilding..."
  cards_rb = File.join(__dir__, "cards.rb")
  load(cards_rb)
end

loop do
  reader.read_line("=> ")
end

parser = Parsers::CsvParser.new

Dir.glob("data/*.csv") do |file|
  parser.parse(file)
end

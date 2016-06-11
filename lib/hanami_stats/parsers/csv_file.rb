module Parsers
  class CsvFile
    attr_reader :file
    attr_reader :parsed
    attr_reader :data

    def initialize(file)
      @file = file
    end
  end
end

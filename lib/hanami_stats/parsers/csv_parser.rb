require "csv"

module Parsers
  class CsvParser
    SEPARATOR = ";"
    HAS_HEADERS = true
    RETURN_HEADERS = false

    attr_reader :results

    def load(file)
      files.push CsvFile.new(file)
      true
    end

    def parse_all
      files.each do |file|
        parse(file.file)
      end
    end

    def parse(file)
      rows = read_csv(file)
      process(rows)
    end

    def process(rows)
      result_count = 0
      rows.each do |row|
        version = PlatformVersion.new(version: row[0], count: row[1], platform: @platform)
        PlatformVersionRepository.create(version)
        result_count += 1
      end
      results[:count] = result_count
      true
    end

    def results
      @results ||= { count: 0 }
    end

    def read_csv(file)
      rows = CSV.read(file, col_sep: SEPARATOR, headers: HAS_HEADERS, return_headers: RETURN_HEADERS)
      determine_platform_from_file_name(file)
      rows
    end

    private

    def determine_platform_from_file_name(file)
      case File.basename(file)
      when /android/
        @platform = "android"
      when /ios/
        @platform = "ios"
      when /windows-phone/
        @platform = "windows-phone"
      else
        @platform = "other"
      end
    end

    def files
      @files ||= []
    end
  end
end

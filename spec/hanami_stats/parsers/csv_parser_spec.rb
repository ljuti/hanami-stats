require "spec_helper"

RSpec.describe Parsers::CsvParser do
  describe "Loading files" do
    context "Single file" do
      let(:file) { File.open("data/stats-android.csv") }

      subject { described_class.new }

      it "loads a file" do
        expect(subject.load(file)).to eq true
      end
    end
  end

  describe "Parsing a CSV file" do
    let(:file) { File.open("data/stats-android.csv") }

    subject { described_class.new }

    it "parses the file" do
      expect(subject.parse(file)).to eq true
      expect(subject.results[:count]).to eq 75
    end
  end

  describe "Identifying platforms" do
    context "Android" do
      let(:android) { double("stats-android.csv") }

      it "determines Android as a platform from CSV file name" do
        allow(File).to receive(:basename).with(android).and_return("android")
        expect(described_class.new.send(:determine_platform_from_file_name, android)).to eq "android"
      end
    end

    context "iOS" do
      let(:ios) { double("stats-ios.csv") }

      it "determines iOS as a platform from CSV file name" do
        allow(File).to receive(:basename).with(ios).and_return("ios")
        expect(described_class.new.send(:determine_platform_from_file_name, ios)).to eq "ios"
      end
    end

    context "Windows Phone" do
      let(:windows) { double("stats-windows-phone.csv") }

      it "determines Windows Phone as a platform from CSV file name" do
        allow(File).to receive(:basename).with(windows).and_return("windows-phone")
        expect(described_class.new.send(:determine_platform_from_file_name, windows)).to eq "windows-phone"
      end
    end

    context "Other" do
      let(:linux) { double("stats-linux.csv") }

      it "determines Android as a platform from CSV file name" do
        allow(File).to receive(:basename).with(linux).and_return("linux")
        expect(described_class.new.send(:determine_platform_from_file_name, linux)).to eq "other"
      end
    end
  end

  describe "Storing objects to repository" do
    let(:file) { File.open("data/stats-android.csv") }

    before do
      @parser = described_class.new
      @rows = @parser.read_csv(file)
    end

    subject { @parser.process(@rows) }

    it "stores all valid entries to the database" do
      expect(@parser.results[:count]).to eq 0
      expect(subject).to eq true
      expect(PlatformVersionRepository.all.count).to eq @parser.results[:count]
      expect(PlatformVersionRepository.first.platform).to eq "android"
    end
  end

  after do
    PlatformVersionRepository.clear
  end
end

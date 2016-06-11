require "spec_helper"

RSpec.describe PlatformVersionRepository do
  describe "Scopes" do
    describe ".android" do
      subject { PlatformVersionRepository.android }

      it "returns versions for Android platform" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "android"
        end
      end
    end

    describe ".ios" do
      subject { PlatformVersionRepository.ios }

      it "returns versions for iOS platform" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "ios"
        end
      end
    end

    describe ".ios" do
      subject { PlatformVersionRepository.windows }

      it "returns versions for Windows Phone platform" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "windows-phone"
        end
      end
    end

    describe ".other" do
      subject { PlatformVersionRepository.other }

      it "returns all other platform versions" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "other"
        end
      end
    end
  end
end

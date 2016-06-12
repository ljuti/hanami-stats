require "spec_helper"

RSpec.describe PlatformVersionRepository do
  describe "Scopes" do
    describe ".android" do
      subject { described_class.android }

      it "returns versions for Android platform" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "android"
        end
      end
    end

    describe ".ios" do
      subject { described_class.ios }

      it "returns versions for iOS platform" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "ios"
        end
      end
    end

    describe ".ios" do
      subject { described_class.windows }

      it "returns versions for Windows Phone platform" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "windows-phone"
        end
      end
    end

    describe ".other" do
      subject { described_class.other }

      it "returns all other platform versions" do
        expect(subject.all).to be_instance_of Array
        subject.all.each do |result|
          expect(result.platform).to eq "other"
        end
      end
    end

    describe ".platform(platform)" do
      context "Known platform" do
        subject { described_class.platform("ios") }

        it "returns versions for given platform" do
          expect(subject.all).to be_instance_of Array
          subject.all.each do |result|
            expect(result.platform).to eq "ios"
          end
        end
      end

      context "Unknown platform" do
        subject { described_class.platform("foo") }

        it "returns no results for platforms that don't exist in the Repository" do
          expect(subject.all).to be_instance_of Array
          expect(subject.all).to be_empty
        end
      end
    end
  end

  describe ".totals" do
    subject { described_class.totals }

    it "returns a hash of results" do
      expect(subject).to be_instance_of Hash
      expect(subject).to have_key(:android)
      expect(subject).to have_key(:ios)
      expect(subject).to have_key(:"windows-phone")
    end

    describe "Results" do
      before do
        versions = [
          FactoryGirl.build_list(:platform_version, 10, :android),
          FactoryGirl.build_list(:platform_version, 20, :ios),
          FactoryGirl.build_list(:platform_version, 30, :windows)
        ]
        versions.flatten.each { |version| described_class.create(version) }
      end

      it "returns the totals for each platform" do
        expect(subject[:android]).to be_a Integer
        expect(subject[:ios]).to be_a Integer
        expect(subject[:"windows-phone"]).to be_a Integer
      end
    end
  end
end

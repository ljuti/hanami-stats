require "spec_helper"

RSpec.describe PlatformVersion do
  describe "Initializing a new object" do
    context "No attributes given" do
      subject { described_class.new }

      it "instantiates a new object" do
        expect(subject).to be_instance_of described_class
      end
    end

    context "Attributes given" do
      subject { described_class.new(version: "1.2.3", count: "1,234,567", platform: "ios") }

      it "instantiates a new object" do
        expect(subject).to be_instance_of described_class
      end
    end
  end

  describe "Attributes" do
    subject { described_class.new }

    it "has a version string" do
      expect(subject).to respond_to(:version)
    end

    it "has a count" do
      expect(subject).to respond_to(:count)
    end

    it "has a type" do
      expect(subject).to respond_to(:type)
    end

    it "has a platform" do
      expect(subject).to respond_to(:platform)
    end

    describe "#version" do
      context "Valid SemVer" do
        context "Without a patch" do
          subject { described_class.new(version: "1.2.3").version }

          it "returns a semantic version for given semver string" do
            expect(subject).to eq Semantic::Version.new("1.2.3")
            expect(subject.major).to eq 1
            expect(subject.minor).to eq 2
            expect(subject.patch).to eq 3
          end
        end

        context "With a patch" do
          subject { described_class.new(version: "1.2.3-patch").version }

          it "returns a semantic version for given semver string" do
            expect(subject).to eq Semantic::Version.new("1.2.3-patch")
            expect(subject.major).to eq 1
            expect(subject.minor).to eq 2
            expect(subject.patch).to eq 3
            expect(subject.pre).to eq "patch"
          end
        end
      end

      context "Non-SemVer" do
        let(:version) { described_class.new(version: "1,2,3") }

        it "returns a semantic version for given semver string" do
          expect(version.version).to eq "1,2,3"
        end
      end
    end

    describe "#count" do
      context "Integer" do
        subject { described_class.new(version: "1.2.3", count: "1,234,567").count }

        it "returns count if the string can be parsed into integer from '0,000,000' format" do
          expect(subject).to be_a Integer
          expect(subject).to eq 1234567
        end
      end

      context "Non-integer" do
        subject { described_class.new(version: "1.2.3", count: "asdf").count }

        it "returns 0 if the string is something else than a number in '0,000,000' format" do
          expect(subject).to be_a Integer
          expect(subject).to eq 0
        end
      end

      context "Nil" do
        subject { described_class.new(version: "1.2.3", count: nil).count }

        it "returns 0 as count if no count given" do
          expect(subject).to be_a Integer
          expect(subject).to eq 0
        end
      end
    end

    describe "#type" do
      context "SemVer" do
        subject { described_class.new(version: "1.2.3").type }

        it "returns :semver as the type if given version string conforms to SemVer 2" do
          expect(subject).to eq :semver
        end
      end

      context "Non-SemVer" do
        subject { described_class.new(version: "asdf").type }

        it "returns :other as the type if given version string does not conform to SemVer 2" do
          expect(subject).to eq :other
        end
      end
    end

    describe "#platform" do
      context "Known platform" do
        context "Android" do
          subject { described_class.new(version: "1.2.3", platform: "android").platform }

          it "returns Android as the platform" do
            expect(subject).to eq "android"
          end
        end

        context "iOS" do
          subject { described_class.new(version: "1.2.3", platform: "ios").platform }

          it "returns ios as the platform" do
            expect(subject).to eq "ios"
          end
        end

        context "Windows" do
          subject { described_class.new(version: "1.2.3", platform: "windows-phone").platform }

          it "returns Windows Phone as the platform" do
            expect(subject).to eq "windows-phone"
          end
        end
      end

      context "Unknown platform" do
        subject { described_class.new(version: "1.2.3", platform: "linux").platform }

        it "returns 'other' as platform" do
          expect(subject).to eq "other"
        end
      end
    end
  end

  describe "#semver?" do
    context "Valid SemVer" do
      subject { described_class.new(version: "1.2.3", platform: "linux") }

      it "returns true for valid semvers" do
        expect(subject).to be_semver
      end
    end

    context "Invalid SemVer" do
      subject { described_class.new(version: "1.2", platform: "linux") }

      it "returns true for valid semvers" do
        expect(subject).not_to be_semver
      end
    end
  end
end

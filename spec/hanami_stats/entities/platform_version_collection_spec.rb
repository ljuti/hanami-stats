require "spec_helper"

RSpec.describe PlatformVersionCollection do
  describe "Initialization" do
    context "No attributes" do
      subject { described_class.new }

      it "can be instantiated" do
        expect(subject).to be_instance_of described_class
        expect(subject.versions).to eq []
        expect(subject.platform).to eq nil
      end
    end

    context "Empty attributes hash" do
      subject { described_class.new({}) }

      it "can be instantiated" do
        expect(subject).to be_instance_of described_class
        expect(subject.versions).to eq []
        expect(subject.platform).to eq nil
      end
    end

    context "With versions" do
      let(:versions) { FactoryGirl.build_list(:platform_version, 10) }

      subject { described_class.new({ versions: versions }) }

      it "can be instantiated" do
        expect(subject).to be_instance_of described_class
        expect(subject.versions).to eq versions
        expect(subject.platform).to eq nil
      end
    end

    context "With platform" do
      subject { described_class.new({ versions: nil, platform: "linux" }) }

      it "can be instantiated" do
        expect(subject).to be_instance_of described_class
        expect(subject.versions).to eq []
        expect(subject.platform).to eq "linux"
      end
    end

    context "With versions and platform" do
      let(:versions) { FactoryGirl.build_list(:platform_version, 10) }

      subject { described_class.new({ versions: versions, platform: "ios" }) }

      it "can be instantiated" do
        expect(subject).to be_instance_of described_class
        expect(subject.versions).to eq versions
        expect(subject.platform).to eq "ios"
      end
    end
  end

  let(:collection) do
    FactoryGirl.build_list(:platform_version, 10)
  end

  subject { PlatformVersionCollection.new(versions: collection) }
  it "holds a collection of PlatformVersion objects" do
    expect(subject.all).to be_instance_of Array
    expect(subject.count).to eq 10
  end

  describe "Semvers" do
    let(:collection) do
      semver = FactoryGirl.build_list(:platform_version, 5)
      others = FactoryGirl.build_list(:platform_version, 5, version: "1.2")
      semver + others
    end

    subject { described_class.new(versions: collection) }

    it "returns semver versions" do
      expect(subject.semvers).to be_instance_of Array
      expect(subject.semvers.count).to eq 5
    end
  end

  describe "#total_count" do
    let(:collection) { FactoryGirl.build_list(:platform_version, 10) }

    subject { described_class.new(versions: collection).total_count }

    it "returns total count of versions in the collection" do
      expect(subject).to eq 1230
    end
  end

  describe "#major_versions" do
    before do
      @collection = []
      @collection.push(FactoryGirl.build(:platform_version, version: "2.3.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "2.5.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "1.3.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "3.3.4"))
    end

    subject { described_class.new(versions: @collection).major_versions }

    it "returns major versions for the collection" do
      expect(subject).to eq [1,2,3]
    end
  end

  describe "#counts_per_major_version" do
    before do
      @collection = []
      @collection.push(FactoryGirl.build(:platform_version, version: "2.3.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "2.5.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "1.3.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "3.3.4"))
    end

    subject { described_class.new(versions: @collection).counts_per_major_version }

    it "returns an array of counts per major version" do
      expect(subject).to eq [[1,123], [2,246], [3,123]]
    end
  end

  describe "#counts_for_other" do
    before do
      @collection = []
      @collection.push(FactoryGirl.build(:platform_version, version: "1.2.3"))
      @collection.push(FactoryGirl.build(:platform_version, version: "9.0"))
      @collection.push(FactoryGirl.build(:platform_version, version: "foo"))
    end

    subject { described_class.new(versions: @collection).counts_for_other }

    it "returns total count for 'other' in the collection" do
      expect(subject).to eq 246
    end
  end

  describe "#to_json" do
    before do
      @collection = []
      @collection.push(FactoryGirl.build(:platform_version, version: "1.2.3"))
      @collection.push(FactoryGirl.build(:platform_version, version: "2.2.3"))
      @collection.push(FactoryGirl.build(:platform_version, version: "2.2.4"))
      @collection.push(FactoryGirl.build(:platform_version, version: "9.0"))
    end

    subject { described_class.new(versions: @collection).to_json }

    it "returns the collection as JSON" do
      json = JSON.parse(subject)
      expect(json).to have_key("total")
      expect(json["total"]).to eq 492
      expect(json).to have_key("1")
      expect(json["1"]).to eq 123
      expect(json).to have_key("2")
      expect(json["2"]).to eq 246
      expect(json).to have_key("other")
      expect(json["other"]).to eq 123
    end
  end
end

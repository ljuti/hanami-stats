require "spec_helper"

RSpec.describe PlatformVersionCollection do
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

  describe "#to_json", skip: "Pending" do
    let(:collection) { FactoryGirl.build_list(:platform_version, 10) }

    subject { described_class.new(versions: collection).to_json }

    it "returns the collection as JSON" do
    end
  end
end

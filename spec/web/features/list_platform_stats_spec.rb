require "features_helper"

describe "Platform specific statistics" do
  context "Android" do
    it "returns statistics for Android" do
      visit "/api/stats/android"

      json = JSON.parse(page.body)

      expect(json).to have_key("total")
      expect(json).to have_key("other")
      [2,3,4,5,6].each do |major|
        expect(json).to have_key(major.to_s)
      end
      expect(json["total"]).to eq 35065928
      expect(json["other"]).to eq 5467447
    end
  end

  context "iOS" do
    it "returns statistics for iOS" do
      visit "/api/stats/ios"

      json = JSON.parse(page.body)
      expect(json).to have_key("total")
      expect(json).to have_key("other")
      [2,3,4,5,6,7,8,9,10].each do |major|
        expect(json).to have_key(major.to_s)
      end
      expect(json["total"]).to eq 21287488
      expect(json["other"]).to eq 3993815
    end
  end

  context "Windows Phone" do
    it "returns statistics for Windows Phone" do
      visit "/api/stats/windows-phone"

      json = JSON.parse(page.body)
      expect(json).to have_key("total")
      expect(json).to have_key("other")
      expect(json["total"]).to eq 4503628
      expect(json["other"]).to eq 4503628
    end
  end

  context "Unknown platform" do
    it "returns no results for unknown platforms" do
      visit "/api/stats/linux"

      json = JSON.parse(page.body)

      expect(json).to have_key("message")
      expect(json["message"]).to match /No results/
    end
  end
end

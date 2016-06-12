require "features_helper"

describe "All statistics" do
  it "should return total count by each platform" do
    visit "/api/stats"

    json = JSON.parse(page.body)

    expect(json).to have_key("android")
    expect(json).to have_key("ios")
    expect(json).to have_key("windows-phone")

    expect(json["android"]).to be_a Integer
    expect(json["ios"]).to be_a Integer
    expect(json["windows-phone"]).to be_a Integer

    expect(json["android"]).to eq 35065928
    expect(json["ios"]).to eq 21287488
    expect(json["windows-phone"]).to eq 4503628
  end
end

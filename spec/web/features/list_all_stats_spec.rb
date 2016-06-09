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
  end
end

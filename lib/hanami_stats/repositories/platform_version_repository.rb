class PlatformVersionRepository
  include Hanami::Repository

  def self.android
    query do
      where(platform: "android")
    end
  end

  def self.ios
    query do
      where(platform: "ios")
    end
  end

  def self.windows
    query do
      where(platform: "windows-phone")
    end
  end

  def self.other
    query do
      where(platform: "other")
    end
  end
end

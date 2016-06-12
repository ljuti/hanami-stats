class PlatformVersionRepository
  include Hanami::Repository

  def self.platform(platform)
    query do
      where(platform: platform)
    end
  end

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

  def self.totals
    {
      android: PlatformVersionCollection.new(versions: self.android).total_count,
      ios: PlatformVersionCollection.new(versions: self.ios).total_count,
      "windows-phone": PlatformVersionCollection.new(versions: self.windows).total_count
    }
  end
end

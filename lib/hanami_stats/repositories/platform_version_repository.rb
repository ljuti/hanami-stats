class PlatformVersionRepository
  include Hanami::Repository

  class << self
    def platform(platform)
      query do
        where(platform: platform)
      end
    end

    def android
      query do
        where(platform: "android")
      end
    end

    def ios
      query do
        where(platform: "ios")
      end
    end

    def windows
      query do
        where(platform: "windows-phone")
      end
    end

    def other
      query do
        where(platform: "other")
      end
    end

    def totals
      {
        android: collection_for(android).total_count,
        ios: collection_for(ios).total_count,
        "windows-phone": collection_for(windows).total_count
      }
    end

    def collection_for(versions)
      PlatformVersionCollection.new(versions: versions)
    end
  end
end

module Web::Controllers::Stats
  class Show
    include Web::Action

    params do
      param :platform, inclusion: %w( android ios windows-phone )
    end

    def call(params)
      if params.valid?
        self.body = platform_collection(params[:platform]).to_json
      else
        self.body = { message: "No results for given platform." }.to_json
      end
    end

    def platform_collection(platform)
      PlatformVersionCollection.new(
        versions: PlatformVersionRepository.platform(platform).all,
        platform: platform
      )
    end
  end
end

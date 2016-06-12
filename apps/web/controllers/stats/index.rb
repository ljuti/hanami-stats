module Web::Controllers::Stats
  class Index
    include Web::Action

    def call(params)
      self.body = PlatformVersionRepository.totals.to_json
    end
  end
end

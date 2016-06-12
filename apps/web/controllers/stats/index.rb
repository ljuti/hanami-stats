module Web::Controllers::Stats
  class Index
    include Web::Action

    def call(*)
      self.body = PlatformVersionRepository.totals.to_json
    end
  end
end

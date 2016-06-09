module Web::Views::Stats
  class Index
    include Web::View
    format :json

    def render
      raw collection.to_json
    end

    def collection
      {
        "android": 123,
        "ios": 234,
        "windows-phone": 345
      }
    end
  end
end

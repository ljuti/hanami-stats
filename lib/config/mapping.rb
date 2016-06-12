collection :platform_versions do
  entity      PlatformVersion
  repository  PlatformVersionRepository

  attribute :count, String
  attribute :platform, String
  attribute :version, String
end

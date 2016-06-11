# collection :users do
#   entity     User
#   repository UserRepository
#
#   attribute :id,   Integer
#   attribute :name, String
# end

collection :platform_versions do
  entity      PlatformVersion
  repository  PlatformVersionRepository

  attribute :count, String
  attribute :platform, String
  attribute :version, String
end

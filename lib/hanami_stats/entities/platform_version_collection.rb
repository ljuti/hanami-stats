class PlatformVersionCollection
  include Hanami::Entity
  attributes :versions, :platform

  def initialize(attributes = {})
    @platform = attributes[:platform]
    @versions = attributes[:versions] || []
  end

  def all
    versions
  end

  def count
    versions.count
  end

  def total_count
    versions.map(&:count).inject(&:+)
  end

  def semvers
    versions.select(&:semver?)
  end

  def major_versions
    semvers.map(&:major).uniq.sort
  end

  def counts_per_major_version
    counts = []
    major_versions.reverse.each do |major|
      counts.push([major, semvers.select do |version|
        version.major.equal?(major)
      end.map(&:count).inject(&:+)])
    end
    counts
  end

  def to_json
    {
      "total": total_count,
      "results": counts_per_major_version
    }.to_json
  end
end

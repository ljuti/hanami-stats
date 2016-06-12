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

  def non_semvers
    versions.reject(&:semver?)
  end

  def major_versions
    semvers.map(&:major).uniq.sort
  end

  def counts_per_major_version
    counts = []
    major_versions.each do |major|
      counts.push([major, semvers.select do |version|
        version.major.equal?(major)
      end.map(&:count).inject(&:+)])
    end
    counts
  end

  def counts_for_other
    non_semvers.map(&:count).inject(&:+)
  end

  def to_json
    {
      other: counts_for_other,
      total: total_count,
    }.merge(counts_per_major_version.to_h).to_json
  end
end

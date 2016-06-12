class PlatformVersion
  include Hanami::Entity
  extend Forwardable

  attributes :version, :count, :type, :platform

  def_delegators :version, :major, :major

  def version=(version_string)
    @version = begin
      Semantic::Version.new(version_string)
    rescue ArgumentError
      version_string
    end
    version_type
  end

  def count=(count)
    @count = count.to_s.delete(",").to_i
  end

  def platform=(platform_string)
    @platform = %w( android ios windows-phone ).include?(platform_string) ? platform_string : "other"
  end

  def semver?
    version_type.equal?(:semver)
  end

  private

  def version_type
    @type = version.instance_of?(Semantic::Version) ? :semver : :other
  end
end

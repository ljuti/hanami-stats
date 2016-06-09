class Version
  include Hanami::Entity
  attributes :version, :count, :type, :platform

  def version=(version_string)
    @version = begin
      Semantic::Version.new(version_string)
    rescue ArgumentError
      version_string
    end
    version_type
  end

  def count=(count)
    @count = count.to_s.gsub(",","").to_i
  end

  def platform=(platform_string)
    @platform = %w( android ios windows-phone ).include?(platform_string) ? platform_string : "other"
  end

  private

  def version_type
    @type = version.instance_of?(Semantic::Version) ? :semver : :other
  end
end

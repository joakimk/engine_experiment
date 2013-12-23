class EngineDeps
  def self.for(engine)
    gemfile_path = File.join(File.dirname(__FILE__), "../engines/#{engine}/Gemfile")
    gemfile_path = File.expand_path(gemfile_path)

    unless File.exists?(gemfile_path)
      raise "Could not find #{gemfile_path}"
    end

    File.readlines(gemfile_path).map(&:chomp).map { |line| line.match(/gem "(.+?)", path: "\.\.\//); $1 }.compact
  end
end

require "jstdutil/formatter"
require "jstdutil/redgreen"
require "jstdutil/colorful_html"
#require "jstdutil/autotest"

module Jstdutil
  def self.install_dir
    File.expand_path(File.dirname(__FILE__))
  end

  #
  # Locate Jar file from a given path. Default classpath is $JSTDUTIL_HOME
  # Finds and returns the first file matching jstest*.jar (case insensitive).
  # Also checks current working directory
  #
  def self.jar(classpath = ENV["JSTESTDRIVER_HOME"] || Dir.pwd)
    files = Dir.glob(File.join(classpath, 'jstest*.jar'), File::FNM_CASEFOLD)
    files.sort! { |f1, f2| f1.downcase <=> f2.downcase }

    if !files || !files.first
      msg = "Unable to load jar file from #{classpath}\n" <<
            "Check that $JSTESTDRIVER_HOME is set correctly"
      raise FileNotFoundError.new(msg)
    end

    files[-1]
  end

  #
  # Run the jar through the java command
  #
  def self.run(args, jar)
    begin
      `java -jar #{jar} #{args}`
    rescue Exception => err
    end
  end
end

class FileNotFoundError < StandardError
end

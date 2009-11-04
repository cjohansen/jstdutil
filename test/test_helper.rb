require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'fileutils'
require 'redgreen' if RUBY_VERSION < "1.9"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'jstdutil'

class Test::Unit::TestCase
  def capture_stdout
    ios = StringIO.new
    stdout = $stdout
    $stdout = ios

    begin
      yield
    ensure
      $stdout = stdout
      ios
    end
  end

  def capture_stderr
    ios = StringIO.new
    stderr = $stderr
    $stderr = ios

    begin
      yield
    ensure
      $stderr = stderr
      ios
    end
  end

  def with_jars(jars = "JsTestDriver-1.0b.jar", dir = "data")
    FileUtils.rm_rf(dir)
    Dir.mkdir(dir)

    [jars].flatten.each do |lib|
      File.open(File.join(dir, lib), "w") { |f| f.puts "" }
    end

    begin
      yield dir
    ensure
      FileUtils.rm_rf(dir)
    end
  end

  def with_env(name, value)
    env = ENV[name]
    ENV[name] = value

    begin
      yield
    ensure
      ENV[name] = value
    end
  end
end

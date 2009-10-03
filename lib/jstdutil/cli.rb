module Jstdutil
  #
  # <tt>Jstdutil::Cli</tt> is a tiny wrapper to the JsTestDriver
  # jar, simply allowing you to avoid the clunkiness of <tt>`java -jar FILE [ARGS]`</tt>
  #
  # The wrapper also formats output with <tt>JsRedGreen</tt>, yielding
  # beautiful test reports.
  #
  # In addition to the JsTestDriver arguments you can specify the path
  # to the jar file by --jar. This kinda defeats the purpose, though,
  # so a better solution is to set the environment variable
  # $JSTESTDRIVER_HOME to where the jar file lives (see <tt>JsTestDriver.jar</tt>).
  #
  class Cli
    def self.run(args = [])
      args = args.join(" ")
      jar = (args.match(/--jar\s+([^\s]+)/) || [])[1] || Jstdutil.jar
      Jstdutil::RedGreen.format(Jstdutil.run("#{args.sub(/--jar\s+[^\s]+/, '')}", jar))
    end
  end
end

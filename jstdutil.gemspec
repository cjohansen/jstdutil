# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jstdutil}
  s.version = "0.3.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christian Johansen"]
  s.date = %q{2011-07-10}
  s.description = %q{Thin wrapper over Google's JsTestDriver that adds colors and autotest}
  s.email = %q{christian@cjohansen.no}
  s.executables = ["jstestdriver", "jsautotest"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "Changelog",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "TODO.org",
    "VERSION",
    "bin/jsautotest",
    "bin/jstestdriver",
    "lib/jstdutil.rb",
    "lib/jstdutil/autotest.rb",
    "lib/jstdutil/cli.rb",
    "lib/jstdutil/colorful_html.rb",
    "lib/jstdutil/formatter.rb",
    "lib/jstdutil/hooks.rb",
    "lib/jstdutil/jstestdriver/config.rb",
    "lib/jstdutil/redgreen.rb",
    "lib/jstdutil/test_file.rb",
    "lib/jstdutil/test_runner.rb",
    "lib/watchr_script",
    "test/cli_test.rb",
    "test/colorful_html_test.rb",
    "test/formatter_test.rb",
    "test/jstdutil_test.rb",
    "test/jstestdriver_config_test.rb",
    "test/jstestdriver_test.rb",
    "test/redgreen_test.rb",
    "test/test_file_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/cjohansen/jstdutil}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{jstdutil}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Thin wrapper over Google's JsTestDriver that adds colors and autotest}
  s.test_files = [
    "test/cli_test.rb",
    "test/colorful_html_test.rb",
    "test/formatter_test.rb",
    "test/jstdutil_test.rb",
    "test/jstestdriver_config_test.rb",
    "test/jstestdriver_test.rb",
    "test/redgreen_test.rb",
    "test/test_file_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<watchr>, [">= 0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<watchr>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<watchr>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end

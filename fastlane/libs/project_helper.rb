require 'fastlane'

module ProjectHelper
  extend self

  def xcpretty_formatter_path
    gem_path = sh("bundle show xcpretty-json-formatter").chomp
    return "#{gem_path}/lib/json_formatter.rb"
  end

  def xcbeautify_formatter_path
    return "swift run -c release --package-path tools-package xcbeautify"
  end

end

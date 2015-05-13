require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

def main_menu
  "1. Add a course to your Wish List\n2. View your course Wish List\n3. Remove a course from your Wish List\n4. View your played courses\n5. Review a played course\n6. Import Data\n7. Exit\n"
end
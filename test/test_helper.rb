ENV["TEST"] = "true"
require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'highline/import'
require 'active_record'
require_relative "../lib/environment"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

def main_menu
  "\n* Welcome to Disc Golf Course Tracker *\n\n1. Add a course to your Wish List\n2. View your course Wish List\n3. View your played courses\n4. See your stats\n5. Exit\n"
end

def view_courses_submenu
  "\nWould you like to...\n1. Update a course\n2. Delete a course\n3. Mark a course as complete\n4. Return to main menu\n"
end

class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM courses;")
    Database.execute("DELETE FROM reviews;")
  end
end

def create_course(name, city, state, address, zip, holes, paid)
  Database.execute("INSERT INTO courses (name, city, state, address, zip, holes, paid) VALUES (?, ?, ?, ?, ?, ?, ?)", name, city, state, address, zip, holes, paid)
end
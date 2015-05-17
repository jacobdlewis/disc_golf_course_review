require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'highline/import'

Dir["./app/**/*.rb"].each { |file| require file }
Dir["./lib/*.rb"].each { |file| require file }
ENV["TEST"] = "true"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

def main_menu
  "\n1. Add a course to your Wish List\n2. View your course Wish List\n3. Remove a course from your Wish List\n4. View your played courses\n5. Review a played course\n6. Exit\n"
end

def view_courses_submenu
  "\nWould you like to...\n1. Update a course\n2. Delete a course\n3. Mark a course as complete\n4. Return to main menu\n"
end

class Minitest::Test
  def setup
    Database.execute <<-SQL
  CREATE TABLE IF NOT EXISTS courses (
    id integer PRIMARY KEY AUTOINCREMENT,
    name varchar(100) NOT NULL,
    city varchar(100),
    state varchar(25),
    address varchar(100),
    zip varchar(20),
    holes varchar(10),
    paid varchar(10)
    );
  SQL
    Database.execute("DELETE FROM courses;")
  end
end

def create_course(name, city, state, address, zip, holes, paid)
  Database.execute("INSERT INTO courses (name, city, state, address, zip, holes, paid) VALUES (?, ?, ?, ?, ?, ?, ?)", name, city, state, address, zip, holes, paid)
end
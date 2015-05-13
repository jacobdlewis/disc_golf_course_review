require 'sqlite3'

class Database
  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    @@db = SQLite3::Database.new("db/disc_golf_course_tracker_test.sqlite")
  end
end
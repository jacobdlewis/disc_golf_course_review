require 'sqlite3'
require 'active_record'

class Database

  def self.load_structure
    Database.execute <<-SQL
CREATE TABLE IF NOT EXISTS courses (
  id integer PRIMARY KEY AUTOINCREMENT,
  name varchar(100) NOT NULL,
  city varchar(100),
  state varchar(25)
  );
SQL
    Database.execute <<-SQL
CREATE TABLE IF NOT EXISTS reviews (
  id integer PRIMARY KEY AUTOINCREMENT,
  name varchar(100) NOT NULL,
  city varchar(100),
  state varchar(25),
  course_id integer NOT NULL,
  comment varchar(500),
  completion_date datetime DEFAULT CURRENT_TIMESTAMP
  );
SQL
  end

  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = Environment.current
    database = "db/disc_golf_course_tracker_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
  end
end
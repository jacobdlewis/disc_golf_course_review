###create database

    sqlite3 disc_golf_course_review.db

###create courses table
    CREATE TABLE courses
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR NOT NULL,
      city VARCHAR NOT NULL,
      state VARCHAR NOT NULL,
      street_address VARCHAR NULL,
      zip_code VARCHAR NULL,
      holes INTEGER NULL,
      paid INTEGER NULL
    );

###create wish_list table
    CREATE TABLE wish_list
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      course_id INTEGER NOT NULL,
      date_added TEXT NOT NULL,
      FOREIGN KEY(course_id) REFERENCES courses(id)
    );

###create completed_courses table
    CREATE TABLE completed_courses
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      course_id INTEGER NOT NULL,
      date_completed TEXT NOT NULL,
      FOREIGN KEY(course_id) REFERENCES courses(id)
    );

###create reviews table
    CREATE TABLE reviews
    (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      course_id INTEGER NOT NULL,
      review_date TEXT NOT NULL,
      score INTEGER NULL,
      recommend INTEGER,
      FOREIGN KEY(course_id) REFERENCES completed_courses(course_id)
    );

### add course
    INSERT INTO courses
    ( name,  city, state, street_address, zip_code, holes, paid )
    VALUES ( "Seven Oaks Park", "Nashville", "TN", "School Lane", "37076", 18, 0);

# disc golf course review
A command line application for planning and tracking games of disc golf at various courses.

##Usage

* Run 'rake bootstrap_database' to setup your local database
* Then, `./disc_golf_course_tracker` to start the program

##Project Vision
This app will be a small command-line program that tracks disc golf courses the user has played and wants to play.

Users will be able to add courses to their wish list and to mark played courses as completed. They can also track review courses that they've completed and view their stored reviews of those courses.

##Features

* Add courses to Wish List
* View Wish List
* Mark Wish List courses as played
* Add reviews for completed courses
* View Played Courses

##Main menu
In order to move throughout the program and accomplish various tasks, the user should receive clear guidance from a written menu.

###Usage Example
>./disc_golf_course_tracker
>
>1. Add a course to your Wish List
>2. View your course Wish List
>3. View your played courses
>4. Exit

###Acceptance Criteria:

 * The menu clearly lists user options.

## Add course to Wish List
In order to keep track of courses that the user wants to play in the future, the user should be able to add disc golf courses to a course wish list.

###Usage Example:
>./disc_golf_course_tracker
>
>1. Add a course to your Wish List
>2. View your course Wish List
>3. View your played courses
>4. Exit
>
>1
>
>What is the name of the course?
>Seven Oaks Park
>In what city is the course located?
>Nashville
>In what state is the course located?
>TN
>Thank you. Seven Oaks Park has been added to your course Wish List.

###Acceptance Criteria:

* Adding a course creates a new course listing in the database's courses table
* Adding a course creates a new listing in the wish_list table

## Mark a Course as Played
In order to achieve a sense of progress, the user should be able to mark courses they've played as completed, moving the course from Wish List to Completed Courses. When the user marks the course as complete, they should be prompted for their score and whether they'd recommend the course to a friend.

###Usage Example:
>./disc_golf_course_tracker
>
>1. Add a course to your Wish List
>2. View your course Wish List
>3. View your played courses
>4. Exit
>
>2
>
>Your Wish List Courses are:
>1. Monticello Oaks (Monticello, FL)
>2. Walter Creek (Raleigh, NC)
>
>Would you like to...
>1. Update a course
>2. Delete a course
>3. Mark a course as complete
>4. Return to main menu
>
>3
>
>Which course would you like to mark as complete?
>Monticello Oaks
>Please enter a quick review of the course.
>Full of short tees, this course is birdie friendly.
>Monticello Oaks was successfully marked as completed.


###Acceptance Criteria:
 * Marking a course as completed adds the course ID to the completed_courses table in the database
 * The course is removed from the Wish List table
 * The user's review is added to a reviews table in the database.

## Deleting a course
In order to remove courses that have been closed or that the user no longer wishes to play, the user should be able to delete a wish list course.

###Usage Example:
>./disc_golf_course_tracker
>
>1. Add a course to your Wish List
>2. View your course Wish List
>3. View your played courses
>4. Exit
>
>2
>
>Your Wish List Courses are:
>1. Best Course Ever (Nowhere, FL)
>2. Seven Oaks Park (Nashville, TN)
>
>Would you like to...
>1. Update a course
>2. Delete a course
>3. Mark a course as complete
>4. Return to main menu
>
>2
>
>What is the name of the course you'd like to delete?
>Best Course Ever
>Best Course Ever was deleted successfully

###Acceptance Criteria:
  * Deleting a course removes it from the courses table in the database
  * Deleting a course shows user visual confirmation of the deletion

##View played courses/reviews
In order to keep track of the courses they've played, the user should be able to view their played courses and their reviews of those courses.

###Usage Example:
>./disc_golf_course_tracker
>
>1. Add a course to your Wish List
>2. View your course Wish List
>3. View your played courses
>4. Exit
>
>3
>
>Completed Courses:
>
>1. Elver Park (Madison, WI) Reviews: 2
>
>2. Heistand park (Madison, WI) Reviews: 3
>
>3. Monticello Oaks (Monticello, FL) Reviews: 1
>
>Would you like to...
>1. See all reviews for a course
>2. Add a review to a course
>3. Return to main menu
>
>1
>
>What is the name of the course for which you want to see reviews?
>Heistand park
>
>Reviews for Heistand park:
>
>May 19, 2015 - It's wooded and difficult but right next to Glide, the best disc golf store in town.
>
>May 19, 2015 - It's great!
>
>May 19, 2015 - Lots of opportunities for lefties to stretch their arm.

###Acceptance Criteria

* A list of completed courses appears when the user selects "View your played courses"
* The user can see instances/games of that course by entering its name

##View User Stats
In order to get a sense of how they're using the program, the user can see high level stats about their stored data.

###Usage Example
>./disc_golf_course_tracker
>
>1. Add a course to your Wish List
>2. View your course Wish List
>3. View your played courses
>4. See your stats
>5. Exit
>
>4
>
>User Stats:
>
> \* You have written 6 reviews
>
> \* You have 5 Wish List courses
>
> \* Most of your completed courses are in WI (2 courses)
>
> \* Most of your Wish List courses are in TN (3 courses)

###Acceptance Criterea

* A list of stats about program usage appears when the user selects "See your stats" from the main menu
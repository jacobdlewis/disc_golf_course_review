# disc golf course review
A command line application for planning and tracking games of disc golf at various courses. 

##Project Vision
This app will be a small command-line program that tracks disc golf courses the user has played and wants to play. 

Users will be able to add courses to their "wish list," mark played courses as "completed," and track things like scores, conditions, and overall experience for each instance of playing a course. Wish list course entries will be comprised of course name, course location, number of holes, and paid/free. Played courses will be displayed in list form, showing the course that was "completed" as well as the number of times it's been played. Users will be able to drill down into their list of courses played to see scores, conditions, and a "# of stars rating" for overall experience for each course visit. 

##Features 

* Add courses to Wish List
* Mark Wish List courses as played & add course review
* View Wish List
* View Played Courses
* Initial Data Import

### Add course to Wish List
In order to keep track of courses that the user wants to play in the future, the user should be able to add disc golf courses to a course wish list. 

Usage Example:
> ./disc_golf_course_tracker
> 
> 1. Add a Course Name
> 2. Add course attributes (street address, holes, paid/free)
> 3. "[course title] has been added successfully" prints on the screen

Acceptance Criteria: 
 * Adding a course creates a new course listing in the database's courses table
 * 

### Mark a Course as Played
In order to achieve a sense of progress, the user should be able to mark courses they've played as completed. When the user marks the course as complete, they should be prompted for their score, their assessment of course conditions, and whether they'd recommend the course to a friend.

Usage Example: 
> ./disc_golf_course_tracker
> 
> 1. View Wish List courses
> 2. Mark course as completed
> 3. Enter their course score
> 4. Enter their assessment of course conditions
> 5. Enter y/n for whether they'd recommend the course to a friend
> 6. "[course title] has been marked as played. You have [number] courses remaining on your Wish List. You've played [number] courses." prints to the screen

###Acceptance Criteria: 
  * Marking a course as completed adds the course ID to the played courses table in the database
  * The user's review is added to a reviews table in the database.
  * The course that was completed is removed from the wish list table. 
 
## Deleting a course
In order to remove courses that have been closed or that the user no longer wishes to play, the user should be able to delete a wish list course. 

###Usage Example:
> ./disc_golf_course_tracker
> 
> 1. Select "Delete Wish List course"
> 2. See "Are you sure you'd like to remove [course name] from your Wish List? (y/n)"?
>   - If 'y,' see "[course name] has been removed from you Wish List."
>   - If 'n,' see "What would you like to do?" menu prompt.

###Acceptance Criteria: 
  * Deleting a course removes it from the courses table in the database
  * Deleting a course shows user visual confirmation of the deletion

##View played courses/reviews
In order to determine whether the user enjoyed their experience playing a course, the user should be able to view their played courses and their reviews of those courses. 

###Usage Example:
> ./disc_golf_course_tracker

> "What would you like to do?" prints to the screen.

> 1. Add a course to you Wish List
> 2. View your course Wish List
> 3. Remove a course from your Wish List
> 4. View your played courses
> 5. Import Data

> user selects "4. View your played courses"

> A list of completed courses prints to the screen.

> "View your course review by typing the course's number" prints to the screen.

> User types 2

> Their review comments for the course print to the screen

> * "Holes: 18 Score: 72 Date: 4/22/2015 Recommend? Yes
> * "Holes: 18 Score: 68 Date: 5/06/2015 Recommend? Yes

###Acceptance Criteria

* A list of completed courses appears when the user selects "View your played courses"
* The user can see instances/games of that course by selecting its number from the displayed list
* 
##Initial Data Import
In order to avoid manual data entry, the user should be able to import course data via a CSV file. The initial import should allow users to populate the courses table.

###Usage Example:
> ./disc_golf_course_tracker

> "What would you like to do?" prints to the screen.

> 1. Add a course to you Wish List
> 2. View your course Wish List
> 3. Remove a course from your Wish List
> 4. View your played courses
> 5. Import Data
> 
> User selects 'Import Data'
> 
>'What is the file path to the .CSV file you'd like to import? Import must be in the format of
(id, name, city, state, zip code, street address, holes, paid?).
>
> User inputs 'users/Desktop/course_list.csv'
>
> "Your course information has been uploaded successfully" prints to the screen

###Acceptance Criteria
* The user is able to populate the database's courses table by importing a csv file. 


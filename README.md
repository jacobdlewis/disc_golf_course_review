# disc golf course review
A command line application for planning and tracking games of disc golf at various courses. 

##Project Vision
This app will be a small command-line program that tracks disc golf courses the user has played and wants to play. 

Users will be able to add courses to their "wish list," mark played courses as "completed," and track things like scores and whether they'd recommend the course for each instance of playing a course. Wish list course entries will be comprised of course name, course location, number of holes, and paid/free. Played courses will be displayed in list form, showing the course that was "completed" as well as the number of times it's been played. 

##Features 

* Add courses to Wish List
* View Wish List
* Mark Wish List courses as played
* Add reviews for completed courses
* View Played Courses
* Initial Data Import from CSV

##Main menu
In order to move throughout the program and accomplish various tasks, the user should receive clear guidance from a written menu.

> "What would you like to do?" prints to the screen.

> 1. Add a course to you Wish List
> 2. View your course Wish List
> 3. Remove a course from your Wish List
> 4. View your played courses
> 5. Review a played course
> 6. Import Data

###Acceptance Criteria:

 * The menu clearly lists user options.

## Add course to Wish List
In order to keep track of courses that the user wants to play in the future, the user should be able to add disc golf courses to a course wish list. 

###Usage Example:
> ./disc_golf_course_tracker
> 
> 1. Add a Course Name
>
> "What is the name of the course"
>
>  - "Seven Oaks Park"
>
> "In what city is the course located?"
>
> - "Nashville"
>
> "In what state is the course located?"
>
> - "TN"
>
> "What is the street address for the course? (optional)"
>
> - "3474 McGavock Pike"
> 
> "What is the ZIP code for the course? (optional)"
>
> - "37217"
>
> "How many holes does the course have? (optional)"
> 
> - "18"
>
> "Is the course paid or free? (optional)"
>
> - "paid"
> 
> "Thank you. Seven Oaks Park has been added to your course Wish List"

###Acceptance Criteria: 

* Adding a course creates a new course listing in the database's courses table
* Adding a course creates a new listing in the wish_list table

## Mark a Course as Played
In order to achieve a sense of progress, the user should be able to mark courses they've played as completed, moving the course from Wish List to Completed Courses. When the user marks the course as complete, they should be prompted for their score and whether they'd recommend the course to a friend.

###Usage Example: 
> ./disc_golf_course_tracker
> 
> user selects "View your course Wish List" from the main menu
> 
> 1. Seven Oaks Park
> 2. Cedar Hill Park
> 3. Crockett Park
> 4. Rollin Ridge Disc Golf
>
> "Would you like to:"
>
> a) Return to main menu
>
> b) Mark a course as complete
>
> user selects: "b) Mark a course as complete"
> 
> "Which course would you like to complete?"
>
> user enters: 1
>
> "Thank you. Seven Oaks Park has been marked as complete"

###Acceptance Criteria: 
 * Marking a course as completed adds the course ID to the completed_courses table in the database
 * The course is removed from the Wish List table
 * The user's review is added to a reviews table in the database.

## Deleting a course
In order to remove courses that have been closed or that the user no longer wishes to play, the user should be able to delete a wish list course. 

###Usage Example:
> ./disc_golf_course_tracker
> 
> user selects "Remove a course from your Wish List" from the main menu
> 
> 1. Cedar Hill Park
> 2. Crockett Park
> 3. Rollin Ridge Disc Golf
> 
> "Which course would you like to remove?"
> 
> user enters: 2
> 
> "Are you sure you'd like to remove Crockett Park from your Wish List? (y/n)"
>
>  user enters: "y"
>
> "Thank you. Crockett Park has been removed from your Wish List."

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
> 5. Review a played course
> 6. Import Data

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

##Initial Data Import
In order to avoid manual data entry, the user should be able to import course data via a CSV file. The initial import should allow users to populate the courses table.

###Usage Example:
> ./disc_golf_course_tracker

> "What would you like to do?" prints to the screen.

> 1. Add a course to you Wish List
> 2. View your course Wish List
> 3. Remove a course from your Wish List
> 4. View your played courses
> 5. Review a played course
> 6. Import Data
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

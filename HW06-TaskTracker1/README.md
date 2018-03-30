# TasksTracker1

TaskTracker1 is a task tracking application where users can register themselves, login, view tasks assigned to them and also assign tasks to other users.
* The Homepage of Application has a textbox to log in and besides it is two buttons, for login and registration respectively.
* So user can enter the website using their Email, and if they haven't registered it before, they can go and register themselves.
* After Successful Registration or login, users are redirected to Dashboard, where the top of the page displays the welcome heading tag, followed by user account details,  followed by cards -which displays all the information of the task. Edit user details and delete user details are kept at the bottom of the page. The decision for this design choice was made by me because the order of information was necessary. Showing the user details first makes user sure that they logged into the right account, and below it is the cards of tasks which are assigned to him, that makes workflow better. And Edit and Delete User at the bottom makes sense because they'll be used rarely or almost never.
* On the top of the page below user details, there is the option to create a new task, which opens on new page redirect, making UI less cluttered and navigation clean.
* New task has a dropdown where the user can select from the list of users, to assign the particular task. And the user is assigning the task, so it text and it is hardcoded because it makes perfect sense and makes the form look clean. The user can fill in task details and task description, and select from the select group about time interval. Time Interval will be validated in chunks of 15 mins, and it can be 0, because initially when the task is assigned, time spent would be zero. There is a checkbox to mark the task as completed or incomplete, which is convenient!
* When the user click submits button, time validation is done, and if details are okay, he is redirected back to the dashboard, which makes UI cleaned and navigation easy. Also when the task is deleted user is redirected back to Dashboard.
* each card has the option for delete task, edit the task, which when clicked return to dashboard upon success. This way navigation of the entire website is flawless for user experience. 
* on logout and deletion the user is throwed away from system back to homepage of the website.
* The application leverages on storing id of the users in session because, id's are the best representation of the current state of user in database, and also it occupies lesser amount of memory buffer. Credits for this design choice: http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html

# Deployment Instructions: 

 * Install dependencies with `mix deps.get`
 * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
 * Install Node.js dependencies with `cd assets && npm install`
 * Start Phoenix endpoint with 

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

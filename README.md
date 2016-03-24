# ClassPortal
Created by 
- Harsha Kunapareddy( skunapa)
- Harini Reddy Kumbum (hkumbum)
- Yuvraj Singh Rathore (yrathor)

<b>Pre-configured Admin and User Details:</b>
<table border=1>
	<th> Role </th>
	<th> Name </th>
	<th> Email ID </th>
	<th> Password </th>
	<tr> <td> Super Admin <td> Harsha <td>skunapa@ncsu.edu <td> 1234</tr>
	<tr> <td> Admin <td> Harini <td>hkumbam@ncsu.edu <td> 1234</tr>
	<tr> <td> Admin <td> Yuvraj <td>yrathor@ncsu.edu <td> 1234</tr>
	<tr> <td> Student <td> Jaithrik <td>jbollab@ncsu.edu <td> 1234</tr>
	<tr> <td> Instructor <td> Dr. Edward Gehringer <td>edg@ncsu.edu <td> 1234</tr>
	<tr> <td> Instructor <td> Dr. Steffen Heber <td>heber@ncsu.edu <td> 1234</tr>
	<tr> <td> Student <td> Anush <td>abonam@ncsu.edu <td> 1234</tr>
	<tr> <td> Student <td> Dheeraj <td>rnagaru@ncsu.edu <td> 1234</tr>

</table>

There are three types of users in the system: Admin, Instructor and Student.

Below are the tasks that can be performed by each user type

<b> Admin </b>
- Edit profile
	* Click on Edit Profile tab, change the details and click on Update User
- Manage Users
	* Click on Search users tab. You can view, edit and delete the users
	* Click on Add User tab to add users
- Manage Courses
	* Click on Search Courses tab. Below actions can be performed
		* Show - Details of the course can be seen.
		* Enroll Requests - List of students who have requested for enrollement can be seen
		* View Students - List of students enrolled for the course can be seen.
		* Edit - To edit the course details
		* Delete - To delete the course
	* Click on Add Course tab to create new courses. Instructor has to be selected while creating a course.
	
<b> Instructor </b>
- Edit profile
	* Click on Edit Profile tab, change the details and click on Update User
- Approve Enrollement Request
	* Click on My Courses tab. Click on Enroll Requests corresponding to the course and Accept/Reject the request.
- Add Material
	* Click on My Courses tab. Click on Announcements corresponding to the course and Add a new Announcement.
	
<b> Student </b>
- Edit profile
	* Click on Edit Profile tab, change the details and click on Update User
- Search Courses
	* Click on Search courses. Search using any of the fields. Click on Show to view the details of the course.
- Request Enrollement
	* Click on Search courses. Click on Enroll corresponding to the required course. Requested courses can be viewed in My courses tab with Status "Requested"
- Course history
	* Click on My courses tab to view the current and past courses. Student can drop a current course by clicking on "Drop" corresponding to the course.

<b> Edge Case Handling </b>
- When Admin tries to delete a user who is currently enrolled in a course or taking a course

If Admin deletes a Student, student will be removed from the database.

If Admin tries to delete an Instructor, he has to first update the course with some other instructor and then delete the instructor ( Admin cannot delete an instructor who is taking an active course)
- What will happen if a student request to join a course multiple times? will there be multiple requests created?

Student cannot join the course multiple times. If the student tries to enroll again, he will be shown a notice saying he cannot enroll multiple times
- What will happen if admin tries to delete an active course? Will student lose their grades? Will the user history also be deleted?

If admin tries to delete an active course, he will be shown a pop-up saying All the students and grades will be deleted from the course. If he says yes, course will be deleted and all the students will lose their grades. History will aslo be deleted.
- What will happen if admin tried to delete an instructor who is currently teaching a course?

Admin has to first select an other instructor. Instrutors with active courses cannot be deleted.

<b> Extra Credit </b>
- Students and Instructors can exchange private messages. Go to messages tab and new messages.
- Instructor of the course can request to make a course “Inactive” by clicking on Inactive Request. The request can be viewed by the admins in Inactive Requests tab.
- Student can register to receive a notification email when an inactive course becomes Active. Go to search courses tab and search for inactive courses, then click on Notify when active button corresponding to the course.

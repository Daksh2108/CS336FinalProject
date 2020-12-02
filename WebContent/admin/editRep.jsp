<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete</title>
</head>
<body>
<h1>Enter Customer Representative Details</h1>
    <form action="editDetails.jsp" method="POST">
    SSN Of Customer Rep To Be Changed: <input type="text" name="old_ssn"/> <br/>
	New SSN: <input type="text" name="new_ssn"/> <br/>
	New Username:<input type="text" name="new_username"/> <br/>
	New Password:<input type="password" name="new_password"/> <br/>
	Confirm Password:<input type="password" name="confirm_password"/> <br/>
	First Name:<input type="text" name="first_name"/> <br/>
	Last Name:<input type="text" name="last_name"/> <br/>
	Train Id:<input type="text" name="train_id"/> <br/>
	<input type="submit" value="Edit"/> <br/> 
	</form> <br/>
	<a href="adminpage.jsp">Go Back</a>
</body>
</html>
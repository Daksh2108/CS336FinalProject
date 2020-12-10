<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADD</title>
</head>
<body>
   <h1>Enter Customer Representative Details</h1>
   <form action="addRepLoginDetails.jsp" method="POST">
    SSN: <input type="text" name="SSN"/> <br/>
	Username:<input type="text" name="username"/> <br/>
	Password:<input type="password" name="password"/> <br/>
	Confirm Password:<input type="password" name="confirm_password"/> <br/>
	First Name:<input type="text" name="first_name"/> <br/>
	Last Name:<input type="text" name="last_name"/> <br/>
	<input type="submit" value="Add"/> <br/> 
	 </form> <br/>
	<a href="adminpage.jsp">Go Back</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>New User</title>
   </head>
   <body>
      <h1>CREATE USER</h1>
      <form action="createUser.jsp" method="POST">
	       Username: <input type="text" name="username"/> <br/>
	       Password:<input type="password" name="password"/> <br/>
	       Confirm Password:<input type="password" name="Confirm Password"/> <br/>
	       email:<input type="text" name="email"/> <br/>
	       First Name:<input type="text" name="first_name"/> <br/>
	       Last Name:<input type="text" name="last_name"/> <br/>
	       <input type="submit" value="Create"/> <br/>
       </form>
       <a href="login.jsp">Already have an account?</a>
	</body>
</html>
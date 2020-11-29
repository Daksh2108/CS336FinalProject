<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Login Form</title>
</head>
<body>
<h1>EMPLOYEE LOGIN</h1>
     <form action="displayLoginDetails.jsp" method="POST">
       Employee Username: <input type="text" name="username"/> <br/>
       Employee Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Login"/> <br/>
       <a href="../login.jsp">Go Back</a> <br/>
     </form> <br/>
</body>
</html>
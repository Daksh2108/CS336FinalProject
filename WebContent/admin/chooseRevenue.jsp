<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	
<meta charset="ISO-8859-1">
<title>Login Page</title>
</head>
<body>
 <h1>Choose Display of Reservations Type </h1>
      <form action="transitLineRevDisplay.jsp" method="POST">
        <input type="submit" value="Display By Transit Line"/>
     </form> <br/>
     <form action="customerRevDisplay.jsp" method="POST">
        <input type="submit" value="Display By Customers"/>
     </form> <br/>    
     <a href="adminpage.jsp">Go Back</a> <br/>
</body>
</html>
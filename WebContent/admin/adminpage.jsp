<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page</title>
</head>
<body>
<h1>Welcome Admin</h1>

<form action="addRep.jsp" method="POST">
	<input type="submit" value="Add Customer Representative"/>
</form> </br>

<form action="editRep.jsp" method="POST">
	<input type="submit" value="Edit Customer Representative"/>
</form> </br>

<form action="deleteRep.jsp" method="POST">
	<input type="submit" value="Delete Customer Representative"/>
</form> </br>

<form action="salesDetails.jsp" method="POST">
	<input type="submit" value="Find Sales Report"/>
</form> <br/>
  
<form action="chooseReservation.jsp" method="POST">
	<input type="submit" value="Reservations"/>
</form> <br/>
  
<form action="revenue.jsp" method="POST">
	<input type="submit" value="Revenue"/>
</form> <br/>
  
<p>Best Customer:</p>
 <!-- Find a way to display best customer here -->
 <p>5 Most Active Transit Lines:</p>
 <!-- Find a way to display Most Active Transit Lines here -->
<a href="../login.jsp">Sign Out</a>


</body>
</html>
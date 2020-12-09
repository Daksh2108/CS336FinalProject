<% if ((session.getAttribute("user") == null)) { %>
    You are not logged in <br/>
    <a href="../login.jsp">Please Login</a>
<% } %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Customer Representative<br/> Page</title>
</head>
<body>
<h1>Welcome <%=session.getAttribute("fullname")%> <br/></h1>

<form action="deleteSchedule.jsp" method="POST">
	<input type="submit" value="Delete Reservation"/>
</form> </br>
 
 <form action="answerQuestion.jsp" method="POST">
	<input type="submit" value="Answer Customer Question"/>
</form> </br>

 <form action="trainList.jsp" method="POST">
	<input type="submit" value="List of Train Schedules"/>
</form> </br>

 <form action="customerList.jsp" method="POST">
	<input type="submit" value="List of Customers with Reservations"/>
</form> </br>

<a href="../login.jsp">Sign Out</a>


</body>
</html>
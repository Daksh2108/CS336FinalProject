<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login Page</title>
   </head>
   <body>
       <h1>Choose Display of Reservations Type </h1>
      <form action="transitLineDisplay.jsp" method="POST">
        <input type="submit" value="Display By Transit Line"/>
     </form> <br/>
     <form action="customerNameDisplay.jsp" method="POST">
        <input type="submit" value="Display By Customers"/>
     </form> <br/>    
     <a href="adminpage.jsp">Go Back</a> <br/>
   </body>
</html>
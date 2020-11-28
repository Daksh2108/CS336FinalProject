<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
   <h1>LOGIN</h1>
     <form action="displayLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Submit"/>
        
     </form>
      <h1>CREATE USER</h1>
      <form action="createUser.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       Confirm Password:<input type="password" name="Confirm Password"/> <br/>
       <input type="submit" value="Create"/>
       </form>
       
     
   </body>
</html>
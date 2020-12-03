<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login Page</title>
   </head>
   <body>
   <h1>LOGIN</h1>
     <form action="displayLoginDetails.jsp" method="POST">
       Username: <input type="text" name="username"/> <br/>
       Password:<input type="password" name="password"/> <br/>
       <input type="submit" value="Login"/>
     </form> <br/>
     <a href="register.jsp">Don't have an account?</a> <br/>
     
     <a href="customerRep/customerRepLogin.jsp">Employees Login Here</a> <br/><br/>
     
     
       <form action="displayLoginDetails.jsp" method="POST">
       <input type="submit" value="Check FAQ"/>
     </form> <br/>
     
   </body>
</html>
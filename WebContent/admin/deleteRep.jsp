<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
      	<title>Delete Page </title>
      	<h1>Delete Customer Representative</h1>
      <a href="adminpage.jsp">Go Back</a></br>
      <form action="deleteRepDetails.jsp" method="POST">
       Enter SSN of representative to be deleted: <input type="text" name="SSN"/> <br/>
       <input type="submit" value="Delete Representative"/> <br/>
     </form> <br/>
    </head>
   	<body>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("SELECT * from Employee_Data");
	   	%>
	   	
		<table id="schedule_table" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>SSN</th>
			      <th>UserName</th>
			      <th>Password</th>
			      <th>First Name</th>
			      <th>Last Name</th>
			     
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("SSN"));
					out.print("</td>");
					
					
					out.print("<td>");
					out.print(rs.getString("username"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("password"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("first_name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("last_name"));
					out.print("</td>");
					

					out.print("</tr>");
				}
	   		} catch(Exception e){
	   			e.printStackTrace();
	   		}
	   
	   	%> 	
	  
  	</script> 
  		<body>
  	</body>
</html>
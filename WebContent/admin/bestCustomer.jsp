<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
   	    <title>Best Customer</title>
   		<h1>Best Customer:</h1></br></br>
		<a href="adminpage.jsp">Go back</a> </br> </br>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	int i = st.executeUpdate("CREATE TEMPORARY TABLE temp select c.username,c.first_name, c.last_name,(sum(r.total_fare)) as totalfare  from Customer c, Reservation r where r.username = c.username group by(c.username)");
	   	         rs=st.executeQuery("select t.username, t.first_name,t.last_name,max(totalfare) as revenue from temp t");
	   	%>
	   	
		<table id="bestCustomer" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Username</th>
			  	  <th>First Name</th>
			      <th>Last Name</th>
			      <th>Revenue</th>
			      
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("t.username"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("t.first_name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("t.last_name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("revenue"));
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
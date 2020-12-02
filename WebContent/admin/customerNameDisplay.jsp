<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
   		<h1>Reservations By Customer Name: </h1>
		<a href="adminpage.jsp">Home</a> </br> </br>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("select c.first_name,c.last_name,r.reservation_number,r.Date,r.total_fare,r.username ,r.TrainId from Reservation r , Customer as c where c.username=r.username");
	   	%>
	   	
		<table id="transitLineTable" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>First Name</th>
			  	  <th>Last Name</th>
			      <th>Reservation Number</th>
			      <th>Date</th>
			      <th>Total Fare</th>
			      <th>Username</th>
			      <th>TrainId</th>
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("c.first_name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("c.last_name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("r.reservation_number"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("r.Date"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("r.total_fare"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("r.username"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("r.TrainId"));
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
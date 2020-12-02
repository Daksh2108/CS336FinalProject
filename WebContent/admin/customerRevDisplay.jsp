<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
   		<h1>Revenue By Customer Name: </h1>
		<a href="chooseRevenue.jsp">Go back</a> </br> </br>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("select c.first_name,c.last_name,sum(r.total_fare) as revenue from Reservation r , Customer as c where c.username=r.username group by c.first_name,c.last_name");		 	
	   	%>
	   	
		<table id="customerTable" style="width:100%" border='1'>
		<thead>
			  <tr>
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
					out.print(rs.getString("c.first_name"));
					out.print("</td>");
					
					
					out.print("<td>");
					out.print(rs.getString("c.last_name"));
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
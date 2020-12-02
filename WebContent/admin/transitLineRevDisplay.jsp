<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
   		<h1>Revenue By Transit Lines: </h1>
		<a href="chooseRevenue.jsp">Go back</a> </br> </br>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("select t.TransitLine,sum(r.total_fare) as revenue from Reservation r , Train_Schedule_Data as t where t.TrainId=r.TrainId group by t.transitLine");		 	
	   	%>
	   	
		<table id="transitLineTable" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>TransitLine</th>
			      <th>Revenue</th>
			     
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("t.TransitLine"));
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
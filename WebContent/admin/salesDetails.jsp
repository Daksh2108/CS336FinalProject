<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
   	    <title>Sales Report</title>
   		<h1>Sales Report:</h1></br></br>
		<a href="adminpage.jsp">Go back</a> </br> </br>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs=st.executeQuery("select (extract(YEAR_MONTH FROM r.Date)) as Month , sum(r.total_fare) as Revenue from Reservation r where extract(YEAR_MONTH FROM r.Date) in (select extract(YEAR_MONTH FROM Date) from Reservation where extract(YEAR_MONTH FROM r.Date) = extract(YEAR_MONTH FROM Date)) group by(Month)");
	           
	   		 	%>
	   	
		<table id="salesReport" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Year-Month</th>
			  	  <th>Revenue</th>
			      
			  </tr>
		  </thead>
		  <tbody>
		<%
		         
				while (rs.next()) {
					 float total = 0;
					 
				    String date = "";
				   	date=rs.getString("Month");
					total = rs.getFloat("Revenue");
					String year=date.substring(0,4);
					String month=date.substring(4);
	                String combinedDate = year+ "-"+month;
	                
					out.print("<tr>");
					
					out.print("<td>");
					out.print(combinedDate);
					out.print("</td>");
					
					out.print("<td>");
					out.print(total);
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
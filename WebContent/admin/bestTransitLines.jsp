<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
   	    <title>Best Transit Lines</title>
   		<h1>Best Transit Lines By Reservation:</h1></br></br>
		<a href="adminpage.jsp">Go back</a> </br> </br>
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	int i = st.executeUpdate("CREATE TEMPORARY TABLE temp select(extract(YEAR_MONTH FROM r.Date)) as Month, count(r.TrainId) as count, t.TransitLine from Reservation r, Train_Schedule_Data t where t.TrainId=r.TrainId and extract(YEAR_MONTH FROM r.Date) in (select extract(YEAR_MONTH FROM Date) from Reservation where extract(YEAR_MONTH FROM r.Date) = extract(YEAR_MONTH FROM Date))group by (t.TransitLine),month");
	   	         rs=st.executeQuery("select Month,TransitLine,dense_rank() over ( partition by Month order by count desc ) as 'Top5 Rank Per Month' from temp");
	   	%>
	   	
		<table id="bestTransitLines" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Year-Month</th>
			  	  <th>Transit Line</th>
			      <th>Top5 Rank Per Month</th>      
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					    String date = "";
					   	date=rs.getString("Month");
						String year=date.substring(0,4);
						String month=date.substring(4);
		                String combinedDate = year+ "-"+month;
					out.print("<tr>");
					
					out.print("<td>");
					out.print(combinedDate);
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("TransitLine"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Top5 Rank Per Month"));
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
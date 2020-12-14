<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<% if ((session.getAttribute("user") == null)) { %>
    You are not logged in <br/>
    <a href="login.jsp">Please Login</a>
<% } else{ %>
    Welcome <%=session.getAttribute("user")%> <br/> <!-- this will display the username that is stored in the session. -->
    <br/> <a href="searches/scheduleSearch.jsp">Find Schedules</a> <br/>
    <br/> <a href="FAQ.jsp">Find Frequently Asked Questions</a> <br/><br/>
    
    <h1>Your Reservations</h1>
    
    <%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("SELECT reservation_number, total_fare, TrainId, DepartureDateTime, DepartingStationId, ArrivingStationId, ArrivalDateTime FROM Reservation WHERE username LIKE '%"+session.getAttribute("user")+"%'");
	   	%>
    
    <table id="reservations" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Reservation #</th>
			      <th>Fare</th>
			      <th>Train #</th> 
			      <th>Departure Date</th>
			      <th>Departure Station</th>
			      <th>Arrival Date</th>
			      <th>Arrival Station</th>
			  </tr>
		  </thead>
		  <tbody>
	
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("reservation_number"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("total_fare"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("TrainId"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("DepartureDateTime"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("DepartingStationId"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("ArrivingStationId"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("ArrivalDateTime"));
					out.print("</td>");

					out.print("</tr>");
					
				}
	   		} catch(Exception e){
	   			e.printStackTrace();
	   		}
	   	%> 
      
    <a href='logout.jsp'>Log out</a>
<% } %>
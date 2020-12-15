<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html>
   	<head>
   	<title>Reservation Created!</title>
    </head>
   	<body>
   	
   		<%
   			DecimalFormat df = new DecimalFormat("0.00");
   		
   			String outTrainId = request.getParameter("outbound_train_id");
   			String outDeptTime = request.getParameter("outbound_departure_time");
   			String outArrTime = request.getParameter("outbound_arrival_time");
   			String outDepSid = request.getParameter("outbound_departure_station");
   			String outArrSid = request.getParameter("outbound_arrival_station");
   			
   			String inTrainId = request.getParameter("inbound_train_id");
   			String inDeptTime = request.getParameter("inbound_departure_time");
   			String inArrTime = request.getParameter("inbound_arrival_time");
   			String inDepSid = request.getParameter("inbound_departure_station");
   			String inArrSid = request.getParameter("inbound_arrival_station");
   			
   			String user = (String)session.getAttribute("user");
   			
   			double fare = Double.parseDouble(request.getParameter("trip_fare"));
   			
	   		try{
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   		 	PreparedStatement rs = con.prepareStatement("insert into Reservation(total_fare,username,TrainId, DepartureDateTime, DepartingStationId, ArrivingStationId, ArrivalDateTime) values(?,?,?,?,?,?,?)");
	   		 	
	   		 	if(!inTrainId.equals("ONE WAY")){
	   		 		rs.setString(1, ""+fare/2);
	   		 	}
	   		 	else{
	   		 		rs.setString(1, ""+fare);
	   		 	}
	   		 	rs.setString(2, user);
	   		 	rs.setString(3, outTrainId);
	   		 	rs.setString(4, outDeptTime);
	   		 	rs.setString(5, outDepSid);
	   		 	rs.setString(6, outArrSid);
	   		 	rs.setString(7, outArrTime);
	   		 	
	   		 	rs.executeUpdate();
	   		 	
	   		 	if(!inTrainId.equals("ONE WAY")){
	   		 		PreparedStatement rs2 = con.prepareStatement("insert into Reservation(total_fare,username,TrainId, DepartureDateTime, DepartingStationId, ArrivingStationId, ArrivalDateTime) values(?,?,?,?,?,?,?)");
		   		 	rs2.setString(1,""+fare/2);
	   		 		rs2.setString(2, user);
		   		 	rs2.setString(3, inTrainId);
		   		 	rs2.setString(4, inDeptTime);
		   		 	rs2.setString(5, inDepSid);
		   		 	rs2.setString(6, inArrSid);
		   		 	rs2.setString(7, inArrTime);
		   		 	rs2.executeUpdate();
	   		 	}
	   		 	
	   		 	
	   		 	
	   		} catch(Exception e){
	   			e.printStackTrace();
	   		}
	   	%>
		
 		<h1> <%=session.getAttribute("user")%>'s Reservation Details: </h1>
 		
 		<h3>Outbound Trip</h3>
 		
	 		<%
	 			out.print("<p>Train ID: " + outTrainId + "</p>");
	 			out.print("<p>Outbound Departure Date/Time: " + outDeptTime + "</p>");
	 			out.print("<p>Outbound Departure Station #: " + outDepSid + "</p>");
	 			out.print("<p>Outbound Arrival Date/Time: " + outArrTime + "</p>");
	 			out.print("<p>Outbound Arrival Station #: " + outArrSid + "</p>");
	 		%>
	 		
 		<h3>Return Trip</h3>
 		
 			<%
	 			out.print("<p>Train ID: " + inTrainId + "</p>");
	 			out.print("<p>Return Departure Date/Time: " + inDeptTime + "</p>");
	 			out.print("<p>Return Departure Station #: " + inDepSid + "</p>");
	 			out.print("<p>Return Arrival Date/Time: " + inArrTime + "</p>");
	 			out.print("<p>Return Departure Station #: " + inArrSid + "</p>");
	 		%>
 		
 		
		<%
			out.print("<h4>Total Fare: $" + df.format(fare) + "</h4>");
		%>
 		
 		<a href="../success.jsp">Go to account home</a> </br> </br>
 		
 	</body>
 </html>
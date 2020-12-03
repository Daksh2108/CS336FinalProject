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
    <a href='logout.jsp'>Log out</a>

<!DOCTYPE html>
<html>
   	<head>
      	<title>Calculate Fares</title>
    </head>
   	<body>
	   	<h1>Calculate Fares</h1>
	   	<p id="enter_train_id"></p>
	   	<p id="enter_fare"></p>
	   	<p id="enter_travel_time"></p>
	   	<p id="enter_departure"></p>
	   	<p id="enter_departure_station"></p>
	   	<p id="enter_arrival"></p>
	   	<p id="enter_arrival_station"></p>
	   	<p id="enter_transit_line"></p>
	   	
	   	<h1>Special Conditions</h1>
	</body>
	<script>
		document.getElementById("enter_train_id").innerText = "Train Number: "+sessionStorage.getItem("train_id");
		document.getElementById("enter_fare").innerText = "Standard Fare: "+sessionStorage.getItem("fare");
		document.getElementById("enter_travel_time").innerText = "One-Way Total Travel Time: "+sessionStorage.getItem("travel_time");
		document.getElementById("enter_departure").innerText = "Departs At: "+sessionStorage.getItem("departure");
		document.getElementById("enter_departure_station").innerText = "Departs From: "+sessionStorage.getItem("departure_station");
		document.getElementById("enter_arrival").innerText = "Arrives At: "+sessionStorage.getItem("arrival");
		document.getElementById("enter_arrival_station").innerText = "Destination: "+sessionStorage.getItem("arrival_station");
		document.getElementById("enter_transit_line").innerText = "Transit Line: "+sessionStorage.getItem("transit_line");
	</script>
</html>


<% } %>
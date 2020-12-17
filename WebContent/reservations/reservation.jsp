<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<% if ((session.getAttribute("user") == null)) { %>
    You are not logged in <br/>
    <a href="../login.jsp">Please Login</a>
<% } else{ %>
    Welcome <%=session.getAttribute("user")%> <br/> <!-- this will display the username that is stored in the session. -->
    <br/> <a href="../searches/scheduleSearch.jsp">Find Schedules</a> <br/>
    <a href='../logout.jsp'>Log out</a>

<!DOCTYPE html>
<html>
   	<head>
      	<title>Calculate Fares</title>
    </head>
   	<body>
	   	<h1>Calculate Fares</h1>
	   	<p id="enter_train_id"></p>
	   	<p id="enter_travel_time"></p>
	   	<p id="enter_departure"></p>
	   	<p id="enter_departure_station"></p>
	   	<p id="enter_arrival"></p>
	   	<p id="enter_arrival_station"></p>
	   	<p id="enter_transit_line"></p>
	   	<h3 id="enter_fare"></h3>
	   	
	   	<h1>Special Conditions</h1>
	   	<h4>Select the conditions that apply:</h4>
	   	
	   	<input type="radio" id="adult" name="age" checked>
	   	<label for="adult">Adult (12-65)</label>
	   	<br/>
	   	
	   	<input type="radio" id="child" name="age">
	   	<label for="child">Child (Under 12)</label>
	   	<br/>
	   	
	   	<input type="radio" id="senior" name="age">
	   	<label for="senior">Senior (Over 65)</label>
	   	<br/>
	   	
	   	<input type="checkbox" id="disabled">
	   	<label for="disabled">Disabled</label>
	   	<br/>
	   	
	   	<h1>Round Trip Options</h1>
	   	
	   	<table id="round_trips" style="width:100%" border='1'>
			<thead>
				  <tr>
				  	  <th>Reserve</th>
				      <th>Train ID</th>
				      <th>Fare ($)</th> 
				      <th>Total Travel Time</th>
				      <th>Departure Date</th>
				      <th>Departure Station</th>
				      <th>Dep. Station #</th>
				      <th>Arrival Date</th>
				      <th>Arrival Station</th>
				      <th>Arr. Station #</th>
				      <th>Transit Line</th>
				  </tr>
			  </thead>
			  <tbody>
			  </tbody>
		  </table>
		  <br/>
		<form action="newRes.jsp" method="POST">
		
			<input id="oti" name="outbound_train_id" value="" hidden>
			<input id="odt" name="outbound_departure_time" value="" hidden>
			<input id="oat" name="outbound_arrival_time" value="" hidden>
			<input id="ods" name="outbound_departure_station" value="" hidden>
			<input id="oas" name="outbound_arrival_station" value="" hidden>
			
			<input id="iti" name="inbound_train_id" value="" hidden>
			<input id="idt" name="inbound_departure_time" value="" hidden>
			<input id="iat" name="inbound_arrival_time" value="" hidden>
			<input id="ids" name="inbound_departure_station" value="" hidden>
			<input id="ias" name="inbound_arrival_station" value="" hidden>
			
			<input id="total_trip_fare" name="trip_fare" value="" hidden>
			
		  	<input type="submit" value="Reserve My Trip!"/>
	   	</form>
	</body>
	<script type="text/javascript">
	
		//retrieving variables from session storage
		const train_id = sessionStorage.getItem("train_id");
		const travel_time = sessionStorage.getItem("travel_time");
		const departure = sessionStorage.getItem("departure");
		const departure_station = sessionStorage.getItem("departure_station");
		const arrival = sessionStorage.getItem("arrival");
		const arrival_station = sessionStorage.getItem("arrival_station");
		const transit_line = sessionStorage.getItem("transit_line");
		const out_departing_sid = sessionStorage.getItem("out_departing_sid");
		const out_arriving_sid = sessionStorage.getItem("out_arriving_sid");
		const schedule = JSON.parse(sessionStorage.getItem("sched"));
		const curr_table = document.getElementById('round_trips');
		const fare = parseFloat(sessionStorage.getItem("fare"));
		
		//set the input values for the form
		document.getElementById("oti").value = train_id;
		document.getElementById("odt").value = departure;
		document.getElementById("oat").value = arrival;
		document.getElementById("ods").value = out_departing_sid;
		document.getElementById("oas").value = out_arriving_sid;
		
		document.getElementById("iti").value = "ONE WAY";
		document.getElementById("idt").value = "ONE WAY";
		document.getElementById("iat").value = "ONE WAY";
		document.getElementById("ids").value = "ONE WAY";
		document.getElementById("ias").value = "ONE WAY";
		document.getElementById("total_trip_fare").value = fare;
		
		//age radio button element
		const child_button = document.getElementById('child');
		const senior_button = document.getElementById('senior');
		const adult_button = document.getElementById('adult');
		const disabled_button = document.getElementById('disabled');
		
		//fare calculation stuff
		var disabled = false;
		var total_fare = fare;
		var discounted_fare = fare;
		var age = "adult";
		
		//round trip radio buttons
		var round_trip_button = document.getElementsByName("trip");
		
		const col_names = ["reserve", "train_id", "fare", "travel_time", "departure", "departure_station", "departure_sid", "arrival", "arrival_station", "arrival_sid", "transit_line"];
		var round_trips = schedule.filter(route => route.arrival_station === departure_station && route.departure_station === arrival_station && route.departure.localeCompare(arrival) >= 0);
		
		window.onload = () => {
	
			//setting reservation info on page load
			document.getElementById("enter_train_id").innerText = "Train Number: " + train_id;
			document.getElementById("enter_fare").innerText = "Total Fare: $" + fare;
			document.getElementById("enter_travel_time").innerText = "One-Way Total Travel Time: " + travel_time;
			document.getElementById("enter_departure").innerText = "Departs At: " + departure;
			document.getElementById("enter_departure_station").innerText = "Departs From: " + departure_station;
			document.getElementById("enter_arrival").innerText = "Arrives At: " + arrival;
			document.getElementById("enter_arrival_station").innerText = "Destination: " + arrival_station;
			document.getElementById("enter_transit_line").innerText = "Transit Line: " + transit_line;
			
			//setting up round trip info
			var no_round_trip = {};
	        for (var j = 0; j < col_names.length; j++) {
	        	no_round_trip[col_names[j]] = "One Way";
	        }
			round_trips.unshift(no_round_trip);
			
			var new_rows = document.createElement('tbody');
			round_trips.forEach((e, i) => {
	            var tr = new_rows.insertRow(i);
	            var radio_button = i === 0 ? "<input type='radio' id="+i+" name='trip' onclick='addTrip(this.id)' checked>" : "<input type='radio' id="+i+" name='trip' onclick='addTrip(this.id)'>";
	            //go through our object and insert accordingly
	            Object.keys(e).forEach((k, j) => {
	              var cell = tr.insertCell(j);
	              cell.innerHTML = j === 0 ? radio_button : e[k];
	            });
	          });
	        curr_table.replaceChild(new_rows, curr_table.childNodes[3]);
		}
		
		//function to add a return trip
		function addTrip(position){
			total_fare = parseInt(position) === 0 ? fare * 1 : fare + parseFloat(round_trips[position]["fare"]);
			if(age === "child"){
				discounted_fare =  disabled ? total_fare * 0.75 * 0.5 : total_fare * 0.75;
			} else if(age === "senior"){
				discounted_fare = disabled ? total_fare * 0.65 * 0.5 : total_fare * 0.65;
			} else{
				discounted_fare = disabled ? total_fare * 0.5 : total_fare * 1;
			}
			document.getElementById("enter_fare").innerText = "Total Fare: $" + discounted_fare.toFixed(2);
			document.getElementById("total_trip_fare").value = discounted_fare;
			document.getElementById("iti").value = round_trips[position]["train_id"];
			document.getElementById("idt").value = round_trips[position]["departure"];
			document.getElementById("iat").value = round_trips[position]["arrival"];
			document.getElementById("ids").value = round_trips[position]["departure_sid"];
			document.getElementById("ias").value = round_trips[position]["arrival_sid"];
		}
        
        //on click listeners
        child_button.addEventListener('click', (e) => {
        	age = "child";
        	discounted_fare =  disabled ? total_fare * 0.75 * 0.5 : total_fare * 0.75;
        	document.getElementById("total_trip_fare").value = discounted_fare;
        	document.getElementById("enter_fare").innerText = "Total Fare: $" + discounted_fare.toFixed(2);
        });
        
        senior_button.addEventListener('click', (e) => {
        	age = "senior";
        	discounted_fare = disabled ? total_fare * 0.65 * 0.5 : total_fare * 0.65;
        	document.getElementById("total_trip_fare").value = discounted_fare;
        	document.getElementById("enter_fare").innerText = "Total Fare: $" + discounted_fare.toFixed(2);
        });
        
        adult_button.addEventListener('click', (e) => {
        	age = "adult";
        	discounted_fare = disabled ? total_fare * 0.5 : total_fare * 1;
        	document.getElementById("total_trip_fare").value = discounted_fare;
        	document.getElementById("enter_fare").innerText = "Total Fare: $" + discounted_fare.toFixed(2);
        });
        
        disabled_button.addEventListener('click', (e) => {
        	disabled = !disabled;
   			discounted_fare = disabled ? discounted_fare * 0.5 : discounted_fare * 2;
   			document.getElementById("total_trip_fare").value = discounted_fare;
   			document.getElementById("enter_fare").innerText = "Total Fare: $" + discounted_fare.toFixed(2);
        });
	</script>
</html>


<% } %>
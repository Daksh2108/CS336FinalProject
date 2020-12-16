<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
   	<head>
      	<title>Train Schedules</title>
    </head>
   	<body>
	   	<h1>Find Train Schedules</h1>
	   	<a href='../success.jsp'>Home</a> <br/> <br/>
	   	
	   	<h3>Search</h3> (Leave empty if you don't want to filter a category)<br/>
	   	Departure Station: <input type="text" placeholder="MetroPark" id="or_search"/> <br/>
	   	Arrival Station: <input type="text" placeholder="Rahway" id="dest_search"/> <br/>
	   	Date & Time: <input type="text" placeholder="2020-11-27 08:45:00.0" id="datetime_search"/> <br/>
	   	<button id="search">Search</button> <br/><br/>
	   	
	   	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("SELECT sd.TrainId, sd.Fare, sd.Travel_time, sd.NumOfStops, sd.TransitLine, df.DepartureDateTime, aa.ArrivalDateTime, df.StopNumber as deptStop, aa.StopNumber as arrStop, aa.Sid as arrSid, df.Sid as dfSid, "+ 
	   		 		"(SELECT Name "+
	   		 		     "FROM Train_Station_Data as tsd "+
	   		 		     "WHERE tsd.StationId = aa.Sid) as arrival_station, "+
	   		 		"(SELECT Name "+
	   		 		     "FROM Train_Station_Data as tsd "+
	   		 			 "WHERE tsd.StationId = df.Sid) as departure_station "+
	   		 		 "FROM Train_Schedule_Data as sd "+
	   		 		 "INNER JOIN Departs_From as df "+
	   		 		 "ON sd.TrainId = df.Tid "+
	   		 		 "INNER JOIN Arrives_At as aa "+
	   		 		 "ON sd.TrainId = aa.Tid");
	   	%>
	   	
		<table id="schedule_table" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Reserve</th>
			      <th>Train ID</th>
			      <th id="fareColumn" style="cursor:pointer">Fare ($)</th> 
			      <th>Total Travel Time</th>
			      <th id="departColumn" style="cursor:pointer">Departure Date</th>
			      <th>Departure Station</th>
			      <th id="arriveColumn" style="cursor:pointer">Arrival Date</th>
			      <th>Arrival Station</th>
			      <th>Transit Line</th>
			  </tr>
		  </thead>
		  <tbody>
		<%
				int count = 0;
				while (rs.next()) {
					
					String arrivalStation = rs.getString("arrival_station");
					String departureStation = rs.getString("departure_station");
					
					int arrStop = Integer.parseInt(rs.getString("arrStop"));
					int deptStop = Integer.parseInt(rs.getString("deptStop"));
					
					if(arrStop <= deptStop){
						continue;
					} else if(arrivalStation.equals(departureStation)){
						continue;
					}
					
					double tripFare = Double.parseDouble(rs.getString("Fare"));
					int totalStops = Integer.parseInt(rs.getString("NumOfStops"));
					double fare = (tripFare/(double)totalStops) * (arrStop - deptStop);
					
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print("<button id="+count+" onclick=\"makeReserve(this.id)\">Reserve This Trip</button>");
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("TrainId"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(fare);
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Travel_time"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("DepartureDateTime"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(departureStation);
					out.print("</td>");
					
					out.print("<td style='display:none;'>");
					out.print(rs.getString("dfSid"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("ArrivalDateTime"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(arrivalStation);
					out.print("</td>");
					
					out.print("<td style='display:none;'>");
					out.print(rs.getString("arrSid"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("TransitLine"));
					out.print("</td>");

					out.print("</tr>");
					count++;
				}
	   		} catch(Exception e){
	   			e.printStackTrace();
	   		}
	   	%>
	   		</tbody>
	   	</table>
	</body>
	
	
	<script>
	    
		const fare_click = document.getElementById('fareColumn');
		const depart_click = document.getElementById('departColumn');
		const arrive_click = document.getElementById('arriveColumn');
		
		const orgsearch = document.getElementById('or_search');
		const destsearch = document.getElementById('dest_search');
		const datsearch = document.getElementById('datetime_search');
		const search_button = document.getElementById('search');
		
		const col_names = ["reserve", "train_id", "fare", "travel_time", "departure", "departure_station", "departure_sid", "arrival", "arrival_station", "arrival_sid", "transit_line"];
		let schedule_obj = [];
		let filtered_obj = [];
		const curr_table = document.getElementById('schedule_table');
		
		const table_rows = curr_table.rows;
		
		window.onload = () => {
			for (var i = 1; i < table_rows.length; i++) {
	               cols = table_rows[i].children;
	               var sched_entry = {};
	               for (var j = 0; j < cols.length; j++) {
	               	if(j === 0){
	               		sched_entry[col_names[j]] = cols[j].innerHTML;    		
	               	} else{
	               		sched_entry[col_names[j]] = cols[j].innerText;
	               	}
	               }
	               schedule_obj.push(sched_entry);
	       	}
			console.log(schedule_obj);
		}
		
		function rePopTable(toDisplay){
			console.log(toDisplay);
			var new_rows = document.createElement('tbody');
			toDisplay.forEach((e, i) => {
	            var tr = new_rows.insertRow(i);
	            //go through our object and insert accordingly
	            Object.keys(e).forEach((k, j) => {
	              var cell = tr.insertCell(j);
	              cell.innerHTML = e[k];
	              if(j === 6 || j === 9){
	            	  cell.hidden = true;
	              }
	            });
	          });
	        curr_table.replaceChild(new_rows, curr_table.childNodes[3]);
		}
		
		function makeReserve(e){
			sessionStorage.setItem("train_id", schedule_obj[e]["train_id"]);
			sessionStorage.setItem("fare", schedule_obj[e]["fare"]);
			sessionStorage.setItem("travel_time", schedule_obj[e]["travel_time"]);
			sessionStorage.setItem("departure", schedule_obj[e]["departure"]);
			sessionStorage.setItem("departure_station", schedule_obj[e]["departure_station"]);
			sessionStorage.setItem("arrival", schedule_obj[e]["arrival"]);
			sessionStorage.setItem("arrival_station", schedule_obj[e]["arrival_station"]);
			sessionStorage.setItem("transit_line", schedule_obj[e]["transit_line"]);
			sessionStorage.setItem("out_departing_sid", schedule_obj[e]["departure_sid"]);
			sessionStorage.setItem("out_arriving_sid", schedule_obj[e]["arrival_sid"]);
			sessionStorage.setItem("sched", JSON.stringify(schedule_obj));
			window.location.href = "../reservations/reservation.jsp";
		}
		
		fare_click.addEventListener('click', (e) => {
			filtered_obj = schedule_obj.slice();
			filtered_obj.sort((a,b) => {
	        	return a.fare - b.fare;
	        });
	        rePopTable(filtered_obj);
		});
		depart_click.addEventListener('click', (e) => {
			filtered_obj = schedule_obj.slice();
			filtered_obj.sort((a,b) => {
	        	return a.departure.localeCompare(b.departure);
	        });
	        rePopTable(filtered_obj);
		});
		arrive_click.addEventListener('click', (e) => {
			filtered_obj = schedule_obj.slice();
			filtered_obj.sort((a,b) => {
	        	return a.arrival.localeCompare(b.arrival);
	        });
	        rePopTable(filtered_obj);
		});
		search_button.addEventListener('click', (e) => {
			filtered_obj = schedule_obj.slice();
			if(orgsearch.value !== ''){
				filtered_obj = filtered_obj.filter(route => route.departure_station.indexOf(orgsearch.value) > -1);
			}
			
			if(destsearch.value !== ''){
				filtered_obj = filtered_obj.filter(route => route.arrival_station.indexOf(destsearch.value) > -1);
			}
			
			if(datsearch.value !== ''){
				filtered_obj = filtered_obj.filter(route => route.departure.indexOf(datsearch.value) > -1);
			}
			
			rePopTable(filtered_obj);
		});
  	</script>
	
</html>
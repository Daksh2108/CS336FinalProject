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
	   	
	   	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("select * from Train_Schedule_Data " +
	   		    "inner join Departs_From on Train_Schedule_Data.TrainId = Departs_From.Tid and " + 
	   		 	"Train_Schedule_Data.DepartureDateTime = Departs_From.DepartureDateTime and "+
	   		    "Train_Schedule_Data.ArrivalDateTime = Departs_From.ArrivalDateTime "+
	   		    "inner join Train_Station_Data on Departs_From.Sid = Train_Station_Data.StationId");
	   	%>
	   	
		<table id="schedule_table" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Reserve</th>
			      <th>Train ID</th>
			      <th id="fareColumn" style="cursor:pointer">Fare</th> 
			      <th>Travel Time</th>
			      <th id="departColumn" style="cursor:pointer">Departure Date</th>
			      <th id="arriveColumn" style="cursor:pointer">Arrival Date</th>
			      <th>Station Name</th>
			  </tr>
		  </thead>
		  <tbody>
		  <!-- FOR TESTING PURPOSES ONLY -->
		  	  <!-- <tr>
			  	  <td><a href='../success.jsp'>Reserve This Trip</a></td>
			      <td>2</td>
			      <td>15</td> 
			      <td>01:00:00</td>
			      <td>2020-11-27 07:45:00.0</td>
			      <td>2020-11-27 08:45:00.0</td>
			      <td>Huntington</td>
			  </tr> -->
		  <!-- FOR TESTING PURPOSES ONLY -->
		<%
				while (rs.next()) {

					out.print("<tr>");
					
					out.print("<td>");
					out.print("<a href='../success.jsp'>Reserve This Trip</a>");
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("TrainId"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Fare"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Travel_time"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("DepartureDateTime"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("ArrivalDateTime"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Name"));
					out.print("</td>");
					
					out.print("</tr>");
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
		const col_names = ["reserve", "train_id", "fare", "travel_time", "departure", "arrival", "station_name"];
		var schedule_obj = [];
		fare_click.addEventListener('click', (e) => {
			schedule_obj = [];
	        const table_rows = document.getElementById('schedule_table').rows;
	        const curr_table = document.getElementById('schedule_table');
	        for (var i = 1; i < table_rows.length; i++) {
	                cols = table_rows[i].children;
	                var sched_entry = {};
	                for (var j = 0; j < cols.length; j++) {
	                	if(j === 0){
	                		sched_entry[col_names[j]] = "<a href='../success.jsp'>Reserve This Trip</a>";
	                	} else{
	                		sched_entry[col_names[j]] = cols[j].innerText;
	                	}
	                }
	                schedule_obj.push(sched_entry);
	        }
	        schedule_obj.sort((a,b) => {
	        	return a.fare - b.fare;
	        });
	        var new_rows = document.createElement('tbody');
	        schedule_obj.forEach((e, i) => {
	            var tr = new_rows.insertRow(i);
	            //go through our object and insert accordingly
	            Object.keys(e).forEach((k, j) => {
	              var cell = tr.insertCell(j);
	              cell.innerHTML = e[k];
	            });
	          });
	        curr_table.replaceChild(new_rows, curr_table.childNodes[3]);
		});
		depart_click.addEventListener('click', (e) => {
			schedule_obj = [];
	        const table_rows = document.getElementById('schedule_table').rows;
	        const curr_table = document.getElementById('schedule_table');
	        for (var i = 1; i < table_rows.length; i++) {
	                cols = table_rows[i].children;
	                var sched_entry = {};
	                for (var j = 0; j < cols.length; j++) {
	                	if(j === 0){
	                		sched_entry[col_names[j]] = "<a href='../success.jsp'>Reserve This Trip</a>";
	                	} else{
	                		sched_entry[col_names[j]] = cols[j].innerText;
	                	}
	                }
	                schedule_obj.push(sched_entry);
	        }
	        //localeCompare()

	        schedule_obj.sort((a,b) => {
	        	return a.departure.localeCompare(b.departure);
	        });
	        var new_rows = document.createElement('tbody');
	        schedule_obj.forEach((e, i) => {
	            var tr = new_rows.insertRow(i);
	            //go through our object and insert accordingly
	            Object.keys(e).forEach((k, j) => {
	              var cell = tr.insertCell(j);
	              cell.innerHTML = e[k];
	            });
	          });
	        curr_table.replaceChild(new_rows, curr_table.childNodes[3]);
		});
		arrive_click.addEventListener('click', (e) => {
			schedule_obj = [];
	        const table_rows = document.getElementById('schedule_table').rows;
	        const curr_table = document.getElementById('schedule_table');
	        for (var i = 1; i < table_rows.length; i++) {
	                cols = table_rows[i].children;
	                var sched_entry = {};
	                for (var j = 0; j < cols.length; j++) {
	                	if(j === 0){
	                		sched_entry[col_names[j]] = "<a href='../success.jsp'>Reserve This Trip</a>";
	                	} else{
	                		sched_entry[col_names[j]] = cols[j].innerText;
	                	}
	                }
	                schedule_obj.push(sched_entry);
	        }
	        schedule_obj.sort((a,b) => {
	        	return a.arrival.localeCompare(b.arrival);
	        });
	        var new_rows = document.createElement('tbody');
	        schedule_obj.forEach((e, i) => {
	            var tr = new_rows.insertRow(i);
	            //go through our object and insert accordingly
	            Object.keys(e).forEach((k, j) => {
	              var cell = tr.insertCell(j);
	              cell.innerHTML = e[k];
	            });
	          });
	        curr_table.replaceChild(new_rows, curr_table.childNodes[3]);
		});
		console.log(schedule_obj);
  	</script>
	
</html>
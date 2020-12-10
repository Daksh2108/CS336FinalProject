<%@page import="com.sun.org.apache.xpath.internal.compiler.Keywords"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<% 
String TrainId=request.getParameter("train_id");
String departureDate=request.getParameter("departure_date");
String oldDepartureDate=request.getParameter("oldDeparture_date");
String stationId=request.getParameter("station_id");
String stopNo=request.getParameter("stop_no");


Class.forName("com.mysql.jdbc.Driver");
Connection con= DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
Statement st= con.createStatement();

ResultSet rs2;

String oldDepartureDateTime="";

String month="";
String day="";
String hours="";
rs2 = st.executeQuery("select TIMESTAMPDIFF(month,'" + oldDepartureDate + "','" + departureDate + "') as Month");	 
     while(rs2.next()){
    	 month=rs2.getString("Month");
     }
	 
 rs2 = st.executeQuery("select TIMESTAMPDIFF(day,'" + oldDepartureDate + "','" + departureDate + "') as Day");	 
 	while(rs2.next()){
    	 day=rs2.getString("Day");
     }
 	
 rs2 = st.executeQuery("select TIMESTAMPDIFF(Hour,'" + oldDepartureDate + "','" + departureDate + "') as Hours");	 
 	while(rs2.next()){
     	 hours=rs2.getString("Hours");
	 }
  	 
	out.println("MONTHHHHHHHHHH" + month);
	out.println("DAYYYYYYYYYYYYYY" + day);
	out.println("DAYYYYYYYYYYYYYY" + hours);
	int intHours=Integer.parseInt(hours);
	int noOfDays=Integer.parseInt(day);
	int noOfMonth=Integer.parseInt(month);
	if(intHours>24){
		intHours=intHours-noOfDays*24;	
	}
	
	//fix hours
	
	 





%>


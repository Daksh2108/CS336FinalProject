<%@page import="com.sun.org.apache.xpath.internal.compiler.Keywords"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<%! boolean exists(Connection con, String s,String dateTime) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"select * from Arrives_At WHERE " + s + "=?");
	stmt.setString(1, dateTime);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}
boolean trainExists(Connection con, String s,String dateTime) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"select * from Arrives_At WHERE " + s + "=?");
	stmt.setString(1, dateTime);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}

boolean departureDateExists(Connection con, String s,String dateTime) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"select * from Arrives_At WHERE " + s + "=?");
	stmt.setString(1, dateTime);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}
boolean stationIdExists(Connection con, String s,String dateTime) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"select * from Arrives_At WHERE " + s + "=?");
	stmt.setString(1, dateTime);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}
boolean stopNoExists(Connection con, String s,String dateTime) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"select * from Arrives_At WHERE " + s + "=?");
	stmt.setString(1, dateTime);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}

%>
<% 

String TrainId=request.getParameter("train_id2");
String departureDate=request.getParameter("arrival_date");
String oldDepartureDate=request.getParameter("oldArrival_date");
String stationId=request.getParameter("station_id2");
String stopNo=request.getParameter("stop_no2");

if(TrainId.equals("") || departureDate.equals("") || oldDepartureDate.equals("")  || stationId.equals("") || stopNo.equals("")){	
	
	out.println("Make sure all fields are not blank  <a href='editSchedule.jsp'>try again</a>");
     return;
}

if(departureDate.length()!=19){
	out.println("Make sure date is valid <a href='editSchedule.jsp'>try again</a>");
    return;
}


Class.forName("com.mysql.jdbc.Driver");
Connection con= DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
Statement st= con.createStatement();

boolean exists=exists(con, "ArrivalDateTime", oldDepartureDate);
boolean trainExists= trainExists(con, "Tid", TrainId);
boolean departureDateExists= departureDateExists(con, "ArrivalDateTime", oldDepartureDate);
boolean stationIdExists= stationIdExists(con, "Sid", stationId);
boolean stopNoExists= stopNoExists(con, "StopNumber", stopNo);

	if(exists==false && trainExists==false && departureDateExists==false && stationIdExists==false && stopNoExists==false){
		int i =st.executeUpdate("Update Arrives_At set ArrivalDateTime = '"+ departureDate + "' where ArrivalDateTime='"+oldDepartureDate+"' and Sid='" + stationId +"' and StopNumber='"+stopNo+"'");
		session.setAttribute("confirmation", "pass");
 	    response.sendRedirect("editSuccess.jsp"); 
	}else{
		 session.setAttribute("confirmation", "fails");
		 response.sendRedirect("editSuccess.jsp");

	}
		
	
	 
con.close();

%>


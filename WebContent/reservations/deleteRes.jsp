<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.text.DecimalFormat" %>


<!DOCTYPE html>
<html>
   	<head>
   	<title>Reservation Deleted!</title>
    </head>
   	<body>
   	
   	<%
   		String resNum = request.getParameter("reservation");
   	
   		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
		 	PreparedStatement rs = con.prepareStatement("DELETE FROM Reservation WHERE reservation_number = ?;");
		 	
		 	rs.setString(1, resNum);
		 	rs.executeUpdate();
   		} catch(Exception e){
   			e.printStackTrace();
   		}
   	%>
   	
   	<h4>Reservation #<% out.print(resNum); %> deleted!</h4><br/>
   	
   	<a href="../success.jsp">Go to account home</a>
   	</body>
   	</html>
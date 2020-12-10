<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete</title>
</head>
<body>
<h1>Enter Customer Representative Details</h1></br>
    <a href="adminpage.jsp">Go Back</a></br>
    <form action="editDetails.jsp" method="POST">
    SSN Of Customer Rep To Be Changed: <input type="text" name="old_ssn"/> <br/>
	New SSN: <input type="text" name="new_ssn"/> <br/>
	New Username:<input type="text" name="new_username"/> <br/>
	New Password:<input type="password" name="new_password"/> <br/>
	Confirm Password:<input type="password" name="confirm_password"/> <br/>
	First Name:<input type="text" name="first_name"/> <br/>
	Last Name:<input type="text" name="last_name"/> <br/>
	<input type="submit" value="Edit"/> <br/> 
	</form> <br/>
</body>
	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		    ResultSet rs;
	   		 	rs = st.executeQuery("SELECT * from Employee_Data");
	   	%>
	   	
		<table id="schedule_table" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>SSN</th>
			      <th>UserName</th>
			      <th>Password</th>
			      <th>First Name</th>
			      <th>Last Name</th>
			      
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("SSN"));
					out.print("</td>");
					
					
					out.print("<td>");
					out.print(rs.getString("username"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("password"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("first_name"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("last_name"));
					out.print("</td>");
					

					out.print("</tr>");
				}
	   		} catch(Exception e){
	   			e.printStackTrace();
	   		}
	   
	   	%> 	
	  
</html>
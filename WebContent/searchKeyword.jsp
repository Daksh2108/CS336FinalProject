<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>

<!DOCTYPE html>
<html>
   	<head>
    </head>
   	<body>
		
 		<h1>Filtered By Keyword: </h1>
 		<a href="FAQ.jsp">Go back</a> </br> </br>
 		
   		
		
      	<!-- Retrieve train schedules from data base -->
	   	<%
	   		try{
	   			
	   			Class.forName("com.mysql.jdbc.Driver");
	   			Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	   			Statement st = con.createStatement();
	   		 	ResultSet rs;
	            rs = st.executeQuery("select question,answer from FAQ where question LIKE '%"+request.getParameter("keyword").trim()+"%'");	 	
	   	%>
	   	
		<table id="FAQ" style="width:100%" border='1'>
		<thead>
			  <tr>
			  	  <th>Questions</th>
			      <th>Answers</th>
			  </tr>
		  </thead>
		  <tbody>
		<%
				while (rs.next()) {
					
					out.print("<tr>");
					
					out.print("<td>");
					out.print(rs.getString("question"));
					out.print("</td>");
					
					
					out.print("<td>");
					out.print(rs.getString("answer"));
					out.print("</td>");

					out.print("</tr>");
					
				}
	   		} catch(Exception e){
	   			e.printStackTrace();
	   		}
	   	%> 	
	  
  	</script> 
  		<body>
  		
  	</body>
</html>
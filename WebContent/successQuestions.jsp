<%@page import="com.sun.org.apache.xpath.internal.compiler.Keywords"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import ="java.sql.*" %>
<%! boolean checkDuplicateQuestions(Connection con, String question,String questionAsked) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM FAQ WHERE " + question + "=?");

	stmt.setString(1, questionAsked);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<%
String question=request.getParameter("customerQuestion");
String error = "";
if(question.equals("")){
	session.setAttribute("customerQuestion","failed");
	response.sendRedirect("successQueAdded.jsp");
	return;
}
Class.forName("com.mysql.jdbc.Driver");
Connection con2 = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
Statement st2 = con2.createStatement();
if (checkDuplicateQuestions(con2, "question", request.getParameter("customerQuestion"))==false) {
	error = "Question " + question + " is already asked.";
	out.println("Question already exists <a href='FAQ.jsp'>try again</a>");
    con2.close();
	st2.close();

	return;
}

try{
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
Statement st = con.createStatement();

PreparedStatement rs = con.prepareStatement(
		"INSERT INTO FAQ(question,answer) " + "VALUES(?,null)");
rs.setString(1, question);
rs.executeUpdate();
session.setAttribute("customerQuestion","passed");
response.sendRedirect("successQueAdded.jsp");
}catch (Exception e){
	session.setAttribute("customerQuestion","failed");
	response.sendRedirect("successQueAdded.jsp");
}

%>
</head>
<body>
</body>
</html>

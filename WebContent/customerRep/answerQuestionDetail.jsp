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
String question=request.getParameter("question");
String answer=request.getParameter("answer");
if(question.equals("")){
	session.setAttribute("answer","emptyQuestion");
	response.sendRedirect("answerQuestionSuccess.jsp");
	return;
}
if(answer.equals("")){
	session.setAttribute("answer","emptyAnswer");
	response.sendRedirect("answerQuestionSuccess.jsp");
	return;
}
Class.forName("com.mysql.jdbc.Driver");
Connection con2 = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
Statement st2 = con2.createStatement();
if (checkDuplicateQuestions(con2, "question", request.getParameter("customerQuestion"))==true) {

//int i=st2.executeUpdate("UPDATE FAQ SET answer = ? WHERE  question =?");

PreparedStatement rs = con2.prepareStatement(
		"UPDATE FAQ SET answer = ? WHERE  question =?");
rs.setString(1, answer);
rs.setString(2, question);
rs.executeUpdate();
session.setAttribute("answer","pass");
response.sendRedirect("answerQuestionSuccess.jsp");
return;

}
session.setAttribute("answer","failed");
response.sendRedirect("answerQuestionSuccess.jsp");
%>
</head>
<body>
</body>
</html>

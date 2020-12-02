<%@ page import ="java.sql.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
	Statement st = con.createStatement();
   	ResultSet rs;
	rs = st.executeQuery("SELECT sum(total_fare)  FROM Reservation where Date between '2020-11-01' and '2020-11-30'");
	float total = 0;
	while(rs.next()){
		total = rs.getFloat("sum(total_fare)");
	}
		
		
	
	
	out.println("Total fare for November " + total);
	session.setAttribute("fare", total);
    out.println("<a href='adminpage.jsp'>Go back</a>");
    response.sendRedirect("salesReport.jsp");

rs.close();
con.close();
	
%>
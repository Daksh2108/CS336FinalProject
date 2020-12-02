<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="java.sql.*" %>
<%! 
// Validate if the value of the specified field (e.g. email, username) in customer table is unique.

boolean ssnExists(Connection con, String s,String ssn) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM Employee_Data WHERE " + s + "=?");
	stmt.setString(1, ssn);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}
%>
	<%   
   	String SSN = request.getParameter("SSN").trim();  
	
	
	
	if(SSN.length()!=11 ){
     	out.println("Make sure ssn is valid  <a href='deleteRep.jsp'>try again</a>");
         return;
    }
	
	
	    
		 	try
		 	{
		 		Class.forName("com.mysql.jdbc.Driver");
		 		Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
		 	Statement st=con.createStatement();
		 
		 	
		 	if(ssnExists(con, "SSN",SSN)==true){
		 		out.println("SSN does not exists <a href='deleteRep.jsp'>try again</a>");
		 	}else{
		 	 	session.setAttribute("SSN", SSN);
			 	int i=st.executeUpdate("DELETE FROM Employee_Data WHERE SSN ='" + SSN + "'");
			 	
			 	//   rs2 = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
			 	out.println("Data Deleted Successfully!");
			 	response.sendRedirect("successDel.jsp");
			 
			 	}
			con.close();
		 	}catch(Exception e)
		 	{
		 	System.out.print(e);
		 	e.printStackTrace();
		 	}
		 	
		
	 
   	%>
   
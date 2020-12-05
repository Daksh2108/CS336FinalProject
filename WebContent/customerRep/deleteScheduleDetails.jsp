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
   	String train_Id = request.getParameter("train_Id").trim();  
	    
		 	try
		 	{
		 		Class.forName("com.mysql.jdbc.Driver");
		 		Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
		 	Statement st=con.createStatement();
		 	
		 	 	session.setAttribute("confirmation", train_Id);
			 	//int i=st.executeUpdate("DELETE FROM Employee_Data WHERE SSN ='" + SSN + "'");
			 	
			     int a=st.executeUpdate("DELETE FROM  Reservation where TrainId='" + train_Id + "'");
			     int b=st.executeUpdate("DELETE FROM  Arrives_At where Tid='" + train_Id + "'"); 
			     int c=st.executeUpdate("Delete FROM Departs_From where Tid='" + train_Id + "'");
			     int d=st.executeUpdate("Delete FROM Train_Schedule_Data where TrainId='" + train_Id + "'");
			     int e=st.executeUpdate("Delete FROM Employee_Data where TrainId='" + train_Id + "'");
			     int f=st.executeUpdate("Delete FROM Train_Data where TrainId='" + train_Id + "'");
			     
			 	//   rs2 = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
			 	out.println("Train Information Deleted Successfully!");
			 	response.sendRedirect("successDelSchedule.jsp");
			con.close();
		 	}catch(Exception e)
		 	{
		 	System.out.print(e);
		 	e.printStackTrace();
		 	}
		 	
		
	 
   	%>
   
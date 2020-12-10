<%@ page import ="java.sql.*" %>
<%! 
// Validate if the value of the specified field (e.g. email, username) in customer table is unique.
boolean checkDuplicateUsers(Connection con, String username, String userid) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM Customer WHERE " + username + "=?");

	stmt.setString(1, userid);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}
%>
<%
    String error = "";
    String userid = request.getParameter("username").trim();   
    String pwd = request.getParameter("password").trim();
    String confirmPwd = request.getParameter("Confirm Password").trim();
    String email = request.getParameter("email").trim();
    String first_Name = request.getParameter("first_name").trim();
    String last_Name = request.getParameter("last_name").trim();
    
    //checking for null values if entered by user 
    
    if(userid.equals("") ){
    	out.println("Make sure username is not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    
    if(pwd.equals("") || confirmPwd.equals("")){
    	
    	out.println("Make sure password and confirmed password are not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    
    if(!pwd.equals(confirmPwd)){
    	out.println("Make sure password and confirmed password match <a href='login.jsp'>try again</a>");
    	return;
    }
    
    if(email.equals("") ){
    	out.println("Make sure email id is not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    
    if(first_Name.equals("") ){
    	out.println("Make sure First Name is not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    
    if(last_Name.equals("") ){
    	out.println("Make sure Last Name is not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
    Statement st = con.createStatement();
    
    ResultSet rs3=st.executeQuery("select * from Customer where username='" + userid + "' and password='" + pwd + "'"); 
    			
    if (checkDuplicateUsers(con, "username", userid)==false) {
		error = "Username " + userid + " is already taken.";
		out.println("Username already exists <a href='login.jsp'>try again</a>");
    
		return;
    }
    PreparedStatement rs = con.prepareStatement(
					"INSERT INTO Customer(username, password,email,first_name,last_name) " + "VALUES(?, ?,?,?,?)");
   
   rs.setString(1, userid);
   rs.setString(2, pwd);
   rs.setString(3, email);
   rs.setString(4, first_Name);
   rs.setString(5, last_Name);
   rs.executeUpdate();
    			
   ResultSet rs2;
   rs2 = st.executeQuery("select * from Customer where username='" + userid + "' and password='" + pwd + "'");
   if (rs2.next()) {
       session.setAttribute("user", userid); // the username will be stored in the session
       out.println("welcome " + userid);
       out.println("<a href='logout.jsp'>Log out</a>");
       response.sendRedirect("success.jsp");
   }
   
   
   rs.close();
   con.close();

%>
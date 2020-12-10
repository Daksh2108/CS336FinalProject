<%@ page import ="java.sql.*" %>
<%! 
// Validate if the value of the specified field (e.g. email, username) in customer table is unique.
boolean checkDuplicateUsers(Connection con, String username, String userid) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM Employee_Data WHERE " + username + "=?");

	stmt.setString(1, userid);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}

boolean checkDuplicateSSN(Connection con, String ssn, String userid) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM Employee_Data WHERE " + ssn + "=?");
	

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
    String SSN = request.getParameter("SSN").trim();   
    String userid = request.getParameter("username").trim();   
    String pwd = request.getParameter("password").trim();
    String confirmPwd = request.getParameter("confirm_password").trim();
    String firstname = request.getParameter("first_name").trim();
    String lastname = request.getParameter("last_name").trim();
    
    //checking for null values if entered by user 
    
     if(SSN.length()!=11 ){
     	out.println("Make sure ssn is valid  <a href='addRep.jsp'>try again</a>");
         return;
     }
     if(userid.equals("") ){
    	out.println("Make sure username is not blank  <a href='addRep.jsp'>try again</a>");
        return;
     }
    
     if(pwd.equals("") || confirmPwd.equals("")){
    	
    	out.println("Make sure password and confirmed password are not blank  <a href='addRep.jsp'>try again</a>");
        return;
     }
    
     if(!pwd.equals(confirmPwd)){
    	out.println("Make sure password and confirmed password match <a href='addRep.jsp'>try again</a>");
    	return;
     }
     
     if(firstname.equals("")){
      	out.println("Please fill firstname in  <a href='addRep.jsp'>try again</a>");
          return;
      }
      if(lastname.equals("")){
       	out.println("Please fill lastname in  <a href='addRep.jsp'>try again</a>");
           return;
       }
      
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
    Statement st = con.createStatement();
    
    ResultSet rs3=st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'"); 
    			
    if (checkDuplicateUsers(con, "username", userid)==false) {
		error = "Username " + userid + " is already taken.";
		out.println("Username already exists <a href='addRep.jsp'>try again</a>");
    
		return;
    }
    if (checkDuplicateSSN(con, "SSN", SSN)==false) {
		error = "SSN " + SSN + " is already taken.";
		out.println("SSN already exists <a href='addRep.jsp'>try again</a>");
    
		return;
    }
    PreparedStatement rs = con.prepareStatement(
					"INSERT INTO Employee_Data(SSN, username,password,first_name,last_name) " + "VALUES(?, ?, ?, ?, ?)");
   
   
   
	rs.setString(1, SSN);
    rs.setString(2, pwd);
    rs.setString(3, userid);
    rs.setString(4, firstname);
    rs.setString(5, lastname);
    
    rs.executeUpdate();
    session.setAttribute("userid",userid);
    			
    out.println("CUSTOMER REP ACCOUNT SUCCESSFULLY CREATED");
    response.sendRedirect("successAdd.jsp");
   
   
   
    rs.close();
    con.close();
%>
<%@ page import ="java.sql.*" %>
<%! 
// Validate if the value of the specified field (e.g. email, username) in customer table is unique.
boolean checkDuplicateUsers(Connection con, String userid) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM Employee_Data WHERE username<> " + userid + "and username= ?");
	
	//SELECT * FROM Employee_Data WHERE ssn<>'111-11-1111' and + ssn + "=?"

	stmt.setString(1, userid);
	result= stmt.executeQuery();
	//resultset returns boolean type
	boolean indicate = !result.next();
	
	result.close();
	stmt.close();
	
	return indicate;
}

boolean checkDuplicateSSN(Connection con, String userid,String oldSSN) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM Employee_Data WHERE SSN<>'" + oldSSN + "and SSN =?");
	      
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
    String oldSSN = request.getParameter("old_ssn").trim(); 
    String newSSN = request.getParameter("new_ssn").trim(); 
    String userid = request.getParameter("new_username").trim();   
    String pwd = request.getParameter("new_password").trim();
    String confirmPwd = request.getParameter("confirm_password").trim();
    String firstname = request.getParameter("first_name").trim();
    String lastname = request.getParameter("last_name").trim();
    String trainId = request.getParameter("train_id").trim();
    
    //checking for null values if entered by user 
    
     if(oldSSN.length()!=11 && newSSN.length()!=11 ){
     	out.println("Make sure old ssn and new ssn are valid  <a href='editRep.jsp'>try again</a>");
         return;
     }
     if(userid.equals("") ){
    	out.println("Make sure username is not blank  <a href='editRep.jsp'>try again</a>");
        return;
     }
    
     if(pwd.equals("") || confirmPwd.equals("")){
    	
    	out.println("Make sure password and confirmed password are not blank  <a href='editRep.jsp'>try again</a>");
        return;
     }
    
     if(!pwd.equals(confirmPwd)){
    	out.println("Make sure password and confirmed password match <a href='editRep.jsp'>try again</a>");
    	return;
     }
     
     if(firstname.equals("")){
      	out.println("Please fill firstname in  <a href='editRep.jsp'>try again</a>");
          return;
      }
      if(lastname.equals("")){
       	out.println("Please fill lastname in  <a href='editRep.jsp'>try again</a>");
           return;
       }
      if(!trainId.equals("1") && !trainId.equals("2") && !trainId.equals("3") && !trainId.equals("4") && !trainId.equals("5")){
       	out.println("Please enter a valid trainId 1 - 5  <a href='editRep.jsp'>try again</a>");
           return;
       }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
    Statement st = con.createStatement();
    
    ResultSet rs3=st.executeQuery("select * from Employee_Data where username='" + userid + "'"); 
    			
    if (checkDuplicateUsers(con, userid)==false) {
		error = "Username " + userid + " is already taken.";
		out.println("Username already exists <a href='editRep.jsp'>try again</a>");
    
		return;
    }
    
    
    
    
    if (checkDuplicateSSN(con, newSSN, userid)==false) {
		error = "SSN " + newSSN + " is already taken.";
		out.println("SSN already exists <a href='editRep.jsp'>try again</a>");
    
		return;
    }
    
    int i=st.executeUpdate("DELETE FROM Employee_Data WHERE SSN ='" + oldSSN + "'");
    
    
    
    PreparedStatement rs = con.prepareStatement(
					"INSERT INTO Employee_Data(SSN, username,password,first_name,last_name,TrainId) " + "VALUES(?, ?, ?, ?, ?, ?)");
   
   
   
	rs.setString(1, newSSN);
    rs.setString(2, pwd);
    rs.setString(3, userid);
    rs.setString(4, firstname);
    rs.setString(5, lastname);
    rs.setString(6, trainId);
    rs.executeUpdate();
    session.setAttribute("userid",userid);
    			
    out.println("CUSTOMER REP ACCOUNT SUCCESSFULLY CREATED");
    response.sendRedirect("adminPage.jsp");
   
   
   
    rs.close();
    con.close();
%>
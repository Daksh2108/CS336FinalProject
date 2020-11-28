<%@ page import ="java.sql.*" %>
<%! 
// Validate if the value of the specified field (e.g. email, username) in customer table is unique.
boolean checkDuplicateUsers(Connection con, String username, String userid) throws SQLException {
	ResultSet result;
	
	PreparedStatement stmt = con.prepareStatement(
			"SELECT * FROM users WHERE " + username + "=?");

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
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
    Statement st = con.createStatement();
    
    ResultSet rs3=st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'"); 
    			
    if (checkDuplicateUsers(con, "username", userid)==false) {
		error = "Username " + userid + " is already taken.";
		out.println("Username already exists <a href='login.jsp'>try again</a>");
    
		return;
    }
    PreparedStatement rs = con.prepareStatement(
					"INSERT INTO users(username, password) " + "VALUES(?, ?)");
   
   
   
   rs.setString(1, userid);
   rs.setString(2, pwd);
   rs.executeUpdate();
    			
   ResultSet rs2;
   rs2 = st.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
   if (rs2.next()) {
       session.setAttribute("user", userid); // the username will be stored in the session
       out.println("welcome " + userid);
       out.println("<a href='logout.jsp'>Log out</a>");
       response.sendRedirect("success.jsp");
   }
   
   
   rs.close();
   con.close();
//    int result=0;
//     //result=Integer.parseInt(rs.getObject(1).toString());
//     //Integer.parseInt(rs.getObject(1).toString());
//      st.executeUpdate("insert into users(username,password) values(username='" + userid + "' and password='" + pwd + "'");
//     if (rs.next()) {
//         session.setAttribute("user", userid); // the username will be stored in the session
//         out.println("welcome " + userid);
//         out.println("<a href='logout.jsp'>Log out</a>");
//         response.sendRedirect("success.jsp");
//     } else {
//         out.println("Invalid password <a href='login.jsp'>try again</a>");
//     }
%>
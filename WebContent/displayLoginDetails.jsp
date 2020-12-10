<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username").trim();   
    String pwd = request.getParameter("password").trim();
    
    if(userid.equals("admin") && pwd.equals("admin") ){
    	//open a page 
    	
    	 response.sendRedirect("admin/adminpage.jsp");
    	return;
    	
    }
    
    if(userid.equals("") ){
    	out.println("Make sure username is not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    
    if(pwd.equals("")){
    	
    	out.println("Make sure password is not blank  <a href='login.jsp'>try again</a>");
        return;
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from Customer where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("welcome " + userid);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid username/password <a href='login.jsp'>try again</a>");
    }
%>
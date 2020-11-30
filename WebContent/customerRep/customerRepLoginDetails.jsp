<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username").trim();   
    String pwd = request.getParameter("password").trim();
    String first_name="";
    String last_name="";

    
    if(userid.equals("") ){
    	out.println("Make sure username is not blank  <a href='customerRepLogin.jsp'>try again</a>");
        return;
    }
    
    if(pwd.equals("")){
    	
    	out.println("Make sure password is not blank  <a href='customerRepLogin.jsp'>try again</a>");
        return;
    }
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj","admin", "password");
    Statement st = con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select first_name,last_name from Employee_Data  where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid);// the username will be stored in the session
        first_name=rs.getString("first_name");
        last_name=rs.getString("last_name");
        String fullname=first_name+" "+last_name;
        session.setAttribute("fullname", fullname);
        response.sendRedirect("customerRepHome.jsp");
    } else {
        out.println("Invalid username/password <a href='customerRepLogin.jsp'>try again</a>");
    }
%>
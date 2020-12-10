<%@ page import ="java.sql.*" %>

<%
    String error = "";
    String trainId = request.getParameter("train_id").trim();
    String transitLine = request.getParameter("transit_line").trim();
    
    
    //checking for null values if entered by user 
    
    
     if(trainId.equals("") ){
    	out.println("Make sure Train Id field is not blank  <a href='editSchedule.jsp'>try again</a>");
        return;
     }
    
     
     if(transitLine.equals("")){
    	 out.println("Make sure TransitLine field is not blank  <a href='editSchedule.jsp'>try again</a>");
         return;
      }
     
     if(!trainId.equals("1") && !trainId.equals("2") && !trainId.equals("3") && !trainId.equals("4") && !trainId.equals("5")){
        	out.println("Please enter a valid trainId 1 - 5  <a href='editSchedule.jsp'>try again</a>");
            return;
        }
     try{
    	    Class.forName("com.mysql.jdbc.Driver");
    	    Connection con = DriverManager.getConnection("jdbc:mysql://cs336.cl2bmz1pwrvy.us-east-2.rds.amazonaws.com:3306/proj?useSSL=false","admin", "password");
    	    Statement st = con.createStatement();
    	   // update Train_Schedule_Data set TransitLine=? where TrainId=?;
    	        			
    	    int i=st.executeUpdate("update Train_Schedule_Data set TransitLine='" + transitLine + "'" + "where TrainId= '" + trainId + "'");
    	    session.setAttribute("confirmation", "pass");
    	    response.sendRedirect("editSuccess.jsp");
    	    
    	    con.close();
    	    
     }catch (Exception e){
    	 session.setAttribute("confirmation", "failed");
    	 response.sendRedirect("editSuccess.jsp");
     }
  
  
   
%>
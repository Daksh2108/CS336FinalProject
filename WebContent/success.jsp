<% if ((session.getAttribute("user") == null)) { %>
    You are not logged in <br/>
    <a href="login.jsp">Please Login</a>
<% } else{ %>
    Welcome <%=session.getAttribute("user")%> <br/> <!-- this will display the username that is stored in the session. -->
    <br/> <a href="searches/scheduleSearch.jsp">Find Schedules</a> <br/>
    <br/> <a href="FAQ.jsp">Find Frequently Asked Questions</a> <br/><br/>
      
    <a href='logout.jsp'>Log out</a>
<% } %>
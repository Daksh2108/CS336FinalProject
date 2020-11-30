<% if ((session.getAttribute("user") == null)) { %>
    You are not logged in <br/>
    <a href="../login.jsp">Please Login</a>
<% } else{ %>
   
    Welcome <%=session.getAttribute("fullname")%> <br/> <!-- this will display the username that is stored in the session. -->
    <a href='../logout.jsp'>Log out</a>
<% } %>
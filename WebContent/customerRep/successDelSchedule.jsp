<% if ((session.getAttribute("confirmation") == null)) { %>
    Train Schedule not deleted <br/>
    <a href='customerRepHome.jsp'>Go Back</a>
<% } else{ %>
     Train Schedule deleted <br/> <!-- this will display the username that is stored in the session. -->
    <a href='customerRepHome.jsp'>Go Back</a>
<% } %>
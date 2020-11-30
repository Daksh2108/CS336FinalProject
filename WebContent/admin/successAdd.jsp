<% if ((session.getAttribute("userid") == null)) { %>
    customer rep not added <br/>
    <a href='adminpage.jsp'>Go Back</a>
<% } else{ %>
     customer rep added <br/> <!-- this will display the username that is stored in the session. -->
    <a href='adminpage.jsp'>Go Back</a>
<% } %>
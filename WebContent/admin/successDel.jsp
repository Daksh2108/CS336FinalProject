<% if ((session.getAttribute("SSN") == null)) { %>
    customer rep not deleted <br/>
    <a href='adminpage.jsp'>Go Back</a>
<% } else{ %>
     customer rep deleted <br/> <!-- this will display the username that is stored in the session. -->
    <a href='adminpage.jsp'>Go Back</a>
<% } %>
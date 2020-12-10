<% if ((session.getAttribute("confirmation").equals("fails"))) { %>
    Train Schedule not edited <br/>
    <a href='editSchedule.jsp'>Go Back</a>
<% } else{ %>
     Train Schedule edited <br/> <!-- this will display the username that is stored in the session. -->
    <a href='editSchedule.jsp'>Go Back</a>
<% } %>
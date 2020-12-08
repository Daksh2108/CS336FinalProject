<% if ((session.getAttribute("answer").equals("failed"))) { %>
    Question Does Not Exist<br/>
    <a href='answerQuestion.jsp'>Go Back</a>
<% } else if((session.getAttribute("answer").equals("emptyAnswer"))){ %>
     Answer Field is Empty <br/> <!-- this will display the username that is stored in the session. -->
    <a href='answerQuestion.jsp'>Go Back</a>
<% } else if((session.getAttribute("answer").equals("emptyQuestion"))){ %>
Question Field is Empty <br/> <!-- this will display the username that is stored in the session. -->
<a href='answerQuestion.jsp'>Go Back</a>
<% } else if((session.getAttribute("answer").equals("pass"))){ %>
Answered Successfully <br/> <!-- this will display the username that is stored in the session. -->
<a href='answerQuestion.jsp'>Go Back</a>
<% }else{ %>
Not Answered Successfully <br/> <!-- this will display the username that is stored in the session. -->
<a href='answerQuestion.jsp'>Go Back</a>
<% }
%>
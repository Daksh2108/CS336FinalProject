<% if ((session.getAttribute("customerQuestion").equals("passed"))) { %>
    Question  added <br/>
    <a href="FAQ.jsp">Go Back </a>
<% }else if((session.getAttribute("customerQuestion").equals("keywordFailed"))){%>
	 Keyword not found <br/>
	  <a href='FAQ.jsp'>Go Back </a>
<%}else{ %>
    Question not added <br/>
      
    <a href='FAQ.jsp'>Go Back </a>
<% } %>
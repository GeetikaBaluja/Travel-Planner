<%
    
session.removeAttribute("uname");
request.getSession().invalidate();
response.sendRedirect("index.jsp");
    
    
%>
<%@page import="java.sql.*"%>
<%@include file="appvars.jsp" %>
<%

if(request.getParameter("id")!=null)
    {
        String a,b;
	a=request.getParameter("id");
       
	try
       { 
                  Class.forName(MYSQL_DRIVER_NAME);
                  Connection myconnection;
                  myconnection=DriverManager.getConnection(path+place,uname,pass);
                  
                  try
                  {
                    String q="delete from tours where eventid=?";
                           
                    PreparedStatement mystatement=myconnection.prepareStatement(q);
                    mystatement.setString(1, a);
                    mystatement.executeUpdate();
                     response.sendRedirect("listoftours.jsp");
                 
                    
                    }
                      catch(Exception e)
                    {
                        out.println("Error in Query " + e.getMessage());
                    }
                  finally
                  {
                      myconnection.close();
                  }
              }
              catch(Exception e)
              {
                  out.println("Error in Connection " + e.getMessage());
              }
    }

%>
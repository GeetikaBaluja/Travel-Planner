<%@page import="java.sql.*"%>
<%@include file="appvars.jsp" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">

	<!-- START head -->
	<head>
		<!-- Site meta charset -->
		<meta charset="UTF-8">
		
		<!-- title -->
		<title>Add State</title>
		
		<!-- meta description -->
		<meta name="description" content="YOUR META DESCRIPTION GOES HERE" />
		
		<!-- meta keywords -->
		<meta name="keywords" content="YOUR META KEYWORDS GOES HERE" />
		
		<!-- meta viewport -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		
		<!-- favicon -->
		<link rel="icon" href="favicon.html" type="image/x-icon" />
		<link rel="shortcut icon" href="favicon.html" type="image/x-icon" />
		
		<!-- bootstrap 3 stylesheets -->
		<link rel="stylesheet" type="text/css" href="bs3/css/bootstrap.css" media="all" />
		<!-- template stylesheet -->
		<link rel="stylesheet" type="text/css" href="css/styles.css" media="all" />
		<!-- responsive stylesheet -->
		<link rel="stylesheet" type="text/css" href="css/responsive.css" media="all" />
		<!-- Load Fonts via Google Fonts API -->
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Karla:400,700,400italic,700italic" />
		<!-- color scheme -->
		<link rel="stylesheet" type="text/css" href="css/colors/color1.css" title="color1" />
		<link rel="alternate stylesheet" type="text/css" href="css/colors/color2.css" title="color2" />
		<link rel="alternate stylesheet" type="text/css" href="css/colors/color3.css" title="color3" />
		<link rel="alternate stylesheet" type="text/css" href="css/colors/color4.css" title="color4" />
	</head>
	<!-- END head -->

	<!-- START body -->
	<body>
		<!-- START #wrapper -->
		<div id="wrapper">
			<!-- START header -->
			<%@include file="header1.jsp" %>
			
			<!-- START #page-header -->
			<div id="header-banner">
				<div class="banner-overlay">
					<div class="container">
						<div class="row">
							<section class="col-sm-6">
								<h1 class="text-upper">Add State</h1>
							</section>
							
							<!-- breadcrumbs -->
							<section class="col-sm-6">
								<ol class="breadcrumb">
                                                                    <li class="home"><a href="index.jsp">Home</a></li>
									<li><a href="adminpanel.jsp">Admin Panel</a></li>
									<li class="active">Add State</li>
								</ol>
							</section>
						</div>
					</div>
				</div>
			</div>
			<!-- END #page-header -->
			
			<!-- START .main-contents -->
			<div class="main-contents">
				<div class="container">
					<!-- START #page -->
					<div id="page">
						
						<!-- START #contactForm -->
						<section id="signup-form">
							<h2 class="ft-heading text-upper">Add State</h2>
							<form action="" method="post">
								<fieldset>
									<ul class="formFields list-unstyled">
                                                                             <li class="row">
											<div class="col-md-6">
												<%
                      
        if(request.getParameter("submit")!=null)        
        {
        Connection myconnection=null;
        
        Class.forName(MYSQL_DRIVER_NAME);
        try
        {
            myconnection=DriverManager.getConnection(path+place, uname, pass);
            try
            {
                String query="insert into statetable(statename) values(?)";
            PreparedStatement mystatement=myconnection.prepareStatement(query);
            mystatement.setString(1, request.getParameter("statename"));
           
            int a=mystatement.executeUpdate();
            if(a==1)
            {
                 out.println("State Added Successfully");
            }
            }
            catch(Exception e)
            {
                out.println("error in query " + e.getMessage());
            }
            finally            
        {
            myconnection.close();
        }
            
        }
        catch(Exception e)
        {
            out.println("<font color='red'>Error in connection " + e.getMessage() + "</font>");
           
        }
        finally            
        {
            myconnection.close();
        }
        }




                     %>
											</div>
										</li>
										<li class="row">
											<div class="col-md-6">
												<label>State Name <span class="required small">(Required)</span></label>
												<input type="text" class="form-control" name="statename" value="" required/>
											</div>
											
										</li>
										
										
										
										<li class="row">
											<div class="col-md-12">
												<input type="submit" class="btn btn-primary btn-lg text-upper" name="submit" value="Add State" />
												
											</div>
										</li>
                                                                               
									</ul>
								</fieldset>
							</form>
						</section>
						<!-- END #contactForm -->
                                                <h3>Already Added States</h3>
                                                 <div class="table-responsive"> 
												<% 
                                                                                                   Connection myconnection=null;
             try{

        Class.forName(MYSQL_DRIVER_NAME);
      myconnection=DriverManager.getConnection(path+place,uname,pass);
     try
                  {
                    String q1="select * from statetable";
                    PreparedStatement mystatement=myconnection.prepareStatement(q1);
                 
                    ResultSet myresult=mystatement.executeQuery();

                    if(myresult.next())
                    {
                        out.println("<table align='center' border='1px' cellspacing='0' cellpadding='5' class='.table-hover'>");
                        out.println("<tr bgcolor='yellow'><td>State ID</td><td>State Name</td></tr>");
                        do
                        {
                           
                                out.println("<tr>");
                            
                            out.println("<td>" + myresult.getString("stateid") + "</td>");
                           out.println("<td>" + myresult.getString("statename") + "</td>");
                            out.println("</tr>");                            
                        }
                        while(myresult.next());
                        out.println("</table>");
                    }
                    else
                    {
                         out.println("<h3 align='center'>No States added yet</h3>");
                    }
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

                                                                                                


%>
                      
       
											</div>
					</div>
					<!-- END #page -->
				</div>
			</div>
			<!-- END .main-contents -->
			
			<!-- START footer -->
			<%@include file="footer.jsp" %>
			<!-- END footer -->
		</div>
		<!-- END #wrapper -->

	
		<!-- javascripts -->
		<script type="text/javascript" src="js/modernizr.custom.17475.js"></script>

		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="bs3/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/script.js"></script>
		<script src="js/styleswitcher.js"></script>
		<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->

		<!-- Analytics -->
		<script>
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','../../../www.google-analytics.com/analytics.js','ga');
		
		  ga('create', 'UA-42761673-1', 'extracoding.com');
		  ga('send', 'pageview');
		</script>

	</body>
</html>
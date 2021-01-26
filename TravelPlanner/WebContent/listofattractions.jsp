<%@page import="java.sql.*"%>
<%@include file="appvars.jsp" %>


<!DOCTYPE html>
<html lang="en" dir="ltr">

	<!-- START head -->
	<head>
		<!-- Site meta charset -->
		<meta charset="UTF-8">
		
		<!-- title -->
		<title>Delete Attractions</title>
		
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
                <script type="text/javascript" src="js/jquery.min.js"></script>
              
		<script src="js/styleswitcher.js"></script>
               
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
								<h1 class="text-upper">Delete Attraction</h1>
							</section>
							
							<!-- breadcrumbs -->
							<section class="col-sm-6">
								<ol class="breadcrumb">
                                                                    <li class="home"><a href="index.jsp">Home</a></li>
									<li><a href="adminpanel.jsp">Admin Panel</a></li>
									<li class="active">Delete Attraction</li>
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
							<h2 class="ft-heading text-upper">Delete Attraction</h2>
                                                        <form action="" method="post">
								<fieldset>
									<ul class="formFields list-unstyled">
                                                                             <li class="row">
											
                                                                                            <div class="table-responsive"> 
												<% 
                                                                                                   Connection myconnection=null;
             try{

        Class.forName(MYSQL_DRIVER_NAME);
      myconnection=DriverManager.getConnection(path+place,uname,pass);
     try
                  {
                    String q1="select * from attractions";
                    PreparedStatement mystatement=myconnection.prepareStatement(q1);
                 
                    ResultSet myresult=mystatement.executeQuery();

                    if(myresult.next())
                    {
                        out.println("<table align='center' border='1px' cellspacing='0' cellpadding='5' class='.table-hover'>");
                        out.println("<tr bgcolor='yellow'><td width=150px>Name of Attraction</td><td>Description</td><td>Category</td><td>Delete</td></tr>");
                        do
                        {
                           
                                out.println("<tr>");
                            
                            out.println("<td>" + myresult.getString("name") + "</td>");
                           out.println("<td>" + myresult.getString("description") + "</td>");
                             
                            
                            out.println("<td>" + myresult.getString("category") + "</td>");
                           
 
                            out.println("<td><a href='deleteattraction.jsp?id=" + myresult.getString("id") + "'>Delete</a></td>");
                            out.println("</tr>");                            
                        }
                        while(myresult.next());
                        out.println("</table>");
                    }
                    else
                    {
                         out.println("<h3 align='center'>No Events added yet</h3>");
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
										</li>
										
                                                                               
                                                                               
									</ul>
								</fieldset>
							</form>
						</section>
						<!-- END #contactForm -->
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

		
		<script type="text/javascript" src="bs3/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/script.js"></script>


		<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->

		
	</body>
</html>
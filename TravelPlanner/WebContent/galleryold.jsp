<%@page import="java.sql.*"%>
<%@include file="appvars.jsp" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">

	<!-- START head -->
	<head>
		<!-- Site meta charset -->
		<meta charset="UTF-8">
		
		<!-- title -->
		<title>Sign Up</title>
		
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
                	<link rel="stylesheet" type="text/css" href="css/fancybox/jquery.fancybox.css" media="all" />
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
			<%@include file="header.jsp" %>
			
			<!-- START #page-header -->
			<div id="header-banner">
				<div class="banner-overlay">
					<div class="container">
						<div class="row">
							<section class="col-sm-6">
								<h1 class="text-upper">GALLERY</h1>
							</section>
							
							<!-- breadcrumbs -->
							<section class="col-sm-6">
								<ol class="breadcrumb">
									<li class="home"><a href="index.jsp">Home</a></li>
									<li class="active">Destinations</li>
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
				<div class="row">
<h2 class="ft-heading text-upper">Gallery</h2>

					<ul class="gallery-list list-unstyled">
						
							
									<%
	Connection myconnection=null;

        Class.forName(MYSQL_DRIVER_NAME);
        try
        {
             myconnection=DriverManager.getConnection(path+place, uname, pass);
            try
            {
            String q="select * from tours";
            PreparedStatement mystatement=myconnection.prepareStatement(q);
            
            ResultSet myresult=mystatement.executeQuery();
			
            if(myresult.next())            
            {
                
              
               
				do
				{
                                      
					 if(myresult.getString("image1")!="")
                      {
                     
                      
                      out.println("<li class='col-md-4'><div class='gal-item'><img class='img-responsive2' src='uploads/" + myresult.getString("image1") + "' width='200px' height='200px'><a class='item-overlay' href='uploads/" + myresult.getString("image1") + "'><img src='img/icons/gal-zoom-icon.png' /><span class='item-text text-center'>" + myresult.getString("name") + "</span></a></div></li>");
                      }
                       if(!myresult.getString("image2").equals(""))
                       {
                      out.println("<li class='col-md-4'><div class='gal-item'><img class='img-responsive2' src='uploads/" + myresult.getString("image2") + "' width='200px' height='200px'><a class='item-overlay' href='uploads/" + myresult.getString("image2") + "'><img src='img/icons/gal-zoom-icon.png' /><span class='item-text text-center'>" + myresult.getString("name") + "</span></a></div></li>");
                       }
                        if(!myresult.getString("image3").equals(""))
                        {
                      out.println("<li class='col-md-4'><div class='gal-item'><img class='img-responsive2' src='uploads/" + myresult.getString("image3") + "' width='200px' height='200px'><a class='item-overlay' href='uploads/" + myresult.getString("image3") + "'><img src='img/icons/gal-zoom-icon.png' /><span class='item-text text-center'>" + myresult.getString("name") + "</span></a></div></li>");
                        }
					
									
                                }
                                while(myresult.next());
                 out.println("</ul>");
            }
            else
            {
                 out.println("<h3>No Destinations available yet</h3>");
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
            out.println("error in connection " + e.getMessage());
            out.println("<script type='text/javascript'>alert('Error in Connection')</script>");
        }
        
									%>
								</div>
							
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
		<script type="text/javascript" src="js/jquery.easing.js"></script>
		<script type="text/javascript" src="js/jquery.fancybox.js"></script>
		<script type="text/javascript" src="js/script.js"></script>
                <!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->

                <script type="text/javascript">
		$(document).ready(function() {
			
			// initilize fancybox
			$(".item-overlay").fancybox({
				overlayShow: true,
				overlayOpacity: .7,
				overlayColor: "#000000", // background overlay color
				transitionIn: "fade", // transition type 'elastic', 'fade' or 'none'
				transitionOut: "fade",
				easingIn: "easeInCubic", // Easing used for elastic animations
				easingOut: "easeOutCubic",
				cyclic: true
			});
		});
		</script>
		
		
	</body>
</html>
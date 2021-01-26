<%@page import="java.sql.*"%>
<%@include file="appvars.jsp"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>View Bookings</title>

<!-- meta description -->
<meta name="description" content="YOUR META DESCRIPTION GOES HERE" />

<!-- meta keywords -->
<meta name="keywords" content="YOUR META KEYWORDS GOES HERE" />

<!-- meta viewport -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />

<!-- favicon -->
<link rel="icon" href="favicon.html" type="image/x-icon" />
<link rel="shortcut icon" href="favicon.html" type="image/x-icon" />

<!-- bootstrap 3 stylesheets -->
<link rel="stylesheet" type="text/css" href="bs3/css/bootstrap.css"
	media="all" />
<!-- template stylesheet -->
<link rel="stylesheet" type="text/css" href="css/styles.css" media="all" />
<!-- responsive stylesheet -->
<link rel="stylesheet" type="text/css" href="css/responsive.css"
	media="all" />
<!-- Load Fonts via Google Fonts API -->
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Karla:400,700,400italic,700italic" />
<!-- color scheme -->
<link rel="stylesheet" type="text/css" href="css/colors/color1.css"
	title="color1" />
<link rel="alternate stylesheet" type="text/css"
	href="css/colors/color2.css" title="color2" />
<link rel="alternate stylesheet" type="text/css"
	href="css/colors/color3.css" title="color3" />
<link rel="alternate stylesheet" type="text/css"
	href="css/colors/color4.css" title="color4" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>

<script src="js/styleswitcher.js"></script>

</head>
<!-- END head -->

<!-- START body -->
<body>
	<!-- START #wrapper -->
	<div id="wrapper">
		<!-- START header -->
		<%@include file="header2.jsp"%>

		<!-- START #page-header -->
		<div id="header-banner">
			<div class="banner-overlay">
				<div class="container">
					<div class="row">
						<section class="col-sm-6">
							<h1>
								<label style="color: white"> Welcome to Travel Planner</label>
							</h1>
							<label style="font-size: 24px; color: white"> Hi, <%=session.getAttribute("uname")%></label>

							<%=request.getAttribute("box1Response")%>
						</section>
						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<div style="float: right; color: white; text-align: left;">
								<p>Mailing-Address</p>
								<%=request.getAttribute("box2Response")%>
							</div>
						</section>
					</div>
				</div>
			</div>
		</div>
		<!-- END #page-header -->

		<!-- START .main-contents -->
		<div class="main-contents">
			<div style="width: 100%;" class="container">
				<!-- START #page -->
				<div id="page">



					<!-- START #contactForm -->
					<section id="signup-form"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 20px;"
						class="col-md-2">

						<h4 class="ft-heading text-upper">Summary</h4>
						<%
							if (null != request.getAttribute("midbox1Response")) {
								out.println(request.getAttribute("midbox1Response"));
							}
						%>


						<!-- 						<div class="table-responsive" -->
						<!-- 							style="display: block; position: relative; height: 250px; overflow: auto;"> -->

						<!-- 						</div> -->
					</section>
					<section id="signup-form"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px;"
						class="col-md-7">
						<h4 class="ft-heading text-upper">Bookings</h4>

						<div class="table-responsive"
							style="display: block; position: relative; height: 250px; overflow: auto;">

							<%
								if (null != request.getAttribute("pageResponse")) {
									out.println(request.getAttribute("pageResponse"));
									out.println(request.getAttribute("pageResponse1"));
								}
							%>
						</div>
					</section>
					<section id="signup-form"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 20px;"
						class="col-md-2">
						<div>
							<h4 class="ft-heading text-upper">Feedback</h4>
							<%
								if (null != request.getAttribute("midbox3Response")) {
									out.println(request.getAttribute("midbox3Response"));
								}
							%>
						</div>
						<!-- 						<div class="table-responsive" -->
						<!-- 							style="display: block; position: relative; height: 250px; overflow: auto;"> -->
						<!-- 				</div> -->
					</section>
					<!-- END #contactForm -->
				</div>
				<!-- END #page -->
			</div>
		</div>
		<!-- END .main-contents -->
		<div class="contact_us-popup" id="contactUsPage">
			<%@include file="contact_us.jsp"%>
		</div>
		<div onclick="openContactUsPage()" id="contactUsDiv" class="btn"
			style="margin-right: 50px; margin-bottom: 10px; margin-left: 10px; background-color: dodgerblue; color: white; padding: 11px 15px 10px; border-radius: 15px; box-shadow: black 5px 8px 10px -1px; position: fixed; bottom: 0px; right: 0px; display: block;">
			Have a Query?</label>
			<p style="text-align: center; margin: 0;">Ask Us</p>
		</div>
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
<!DOCTYPE html>
<html lang="en" dir="ltr">

<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Admin Panel</title>

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
</head>
<!-- END head -->

<!-- START body -->
<body>
	<%
		response.addHeader("Cache-Control",
				"no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
		response.addHeader("Pragma", "no-cache");
		response.addDateHeader("Expires", 0);
	%>
	<!-- START #wrapper -->
	<div id="wrapper">
		<!-- START header -->
		<%@include file="header1.jsp"%>

		<!-- START #page-header -->
		<div id="header-banner">
			<div class="banner-overlay">
				<div class="container">
					<div class="row">
						<section class="col-sm-6">
							<h1 class="text-upper">Admin Panel</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="index.jsp">Home</a></li>
								<li class="active">Admin Panel</li>
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
					<div>
						<h2>Admin Panel</h2>
						<div style="text-align: center;">
							<div class="row">
								<div class="col-md-3">
									<a href="addtour.jsp"><img src="images/add_tour.png" width="120"
										height="120" /></a>
									<div>
										<a href="addtour.jsp">Add Tour</a>
									</div>
								</div>
								<div class="col-md-3">
									<a href="fetchAllTours"><img src="images/update_tour.png"
										width="106" height="111"></a>
									<div>
										<a href="fetchAllTours">View / Update Tours</a>
									</div>
								</div>
								<div class="col-md-3">
									<a href="fetchBookingRecords"><img src="images/view_booking.jpg"
										width="120" height="120" /></a>
									<div>
										<a href="fetchBookingRecords">View Booking Requests</a>
									</div>
								</div>
								<div class="col-md-3">
									<a href="viewCustomerQueries"><img src="images/query_image.jpg"
										width="120" height="120" /></a>
									<div>
										<a href="viewfeedback.jsp">Customer Query Box </a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END #page -->
				</div>
				<input type="hidden" id="success_msg"
					value="<%=request.getAttribute("successMsg")%>"> <input
					type="hidden" id="err_msg"
					value="<%=request.getAttribute("errMsg")%>">
			</div>
			<!-- END .main-contents -->

			<!-- START footer -->
			<%-- 		<%@include file="footer.jsp"%> --%>
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
</body>
<script>
	window.onload = function() {
		checkForAlertMsgs();
	};

	function checkForAlertMsgs() {
		var successMsg = document.getElementById('success_msg');
		var errMsg = document.getElementById('err_msg');
		if (successMsg.value != "null") {
			alert(successMsg.value);
		} else if (errMsg.value != "null") {
			alert(errMsg.value);
		}
	}
</script>
</html>
<%@page import="java.sql.*"%>
<%@include file="appvars.jsp"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<%
	// 	if (session.getAttribute("tourid") == "") {
	// 		response.sendRedirect("index.jsp");
	// 	}
%>
<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Booking Details</title>

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
<!-- favicon -->
<link rel="icon" href="favicon.html" type="image/x-icon" />
<link rel="shortcut icon" href="favicon.html" type="image/x-icon" />

<!-- bootstrap 3 stylesheets -->
<link rel="stylesheet" type="text/css" href="bs3/css/bootstrap.css"
	media="all" />
<link rel="stylesheet" type="text/css"
	href="css/fancybox/jquery.fancybox.css" media="all" />
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
	<!-- START #wrapper -->
	<div id="wrapper">
		<!-- START header -->
		<%@include file="header2.jsp"%>

		<!-- START #page-header -->
		<div id="header-banner">
			<div class="banner-overlay">
				<div class="container">
					<div class="row" style="color: white;">
						<section class="col-sm-8">
							<h1>
								<label>Hi&nbsp;</label><label><%=session.getAttribute("uname")%>,
								</label>
							</h1>
							<h5>Your Booking Details for</h5>
							<h4>
								<%=request.getAttribute("tourName")%>
							</h4>
						</section>
						<section class="col-sm-4">
							<div style="text-align: center;">
								<label>To Cancel this Booking, please confirm by
									clicking </label> <a class="btn btn-primary" style="float: right;"
									href="completeBookingController">Cancel Booking</a>
							</div>
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
				<div id="page" class="col-md-6 col-md-offset-3"
					style="box-shadow: 10px 10px 10px 10px; border-radius: 15px; padding: 10px;">

					<div class="tour-plans">
						<form id="completeBookingProcess"
							action="completeBookingController" method="post">
							<input type="hidden" name="adults"
								value='<%=request.getAttribute("adults")%>'> <input
								type="hidden" name="children"
								value='<%=request.getAttribute("children")%>'> <input
								type="hidden" name="travelDate"
								value='<%=request.getAttribute("travelDate")%>'> <input
								type="hidden" name="travelReturnDate"
								value='<%=request.getAttribute("travelReturnDate")%>'> <input
								type="hidden" name="customercity"
								value='<%=request.getAttribute("customercity")%>'> <input
								type="hidden" name="touringDaysCount"
								value='<%=request.getAttribute("touringDaysCount")%>'> <input
								type="hidden" name="totalTourCost"
								value='<%=request.getAttribute("totalTourCost")%>'> <input
								type="hidden" name="roomsBooked"
								value='<%=request.getAttribute("roomsBooked")%>'>

							<h3>Your Trip Details</h3>
							<table
								style="margin: 0 auto; border-spacing: 10px; border-collapse: separate; padding: 5px">
								<%=request.getAttribute("hotelResponse")%>
							</table>
							<table style="margin: 0 auto;">
								<tr>
									<td colspan="2" style="text-align: center;"><label>Person
											Traveling:</label></td>
								</tr>
								<tr>
									<td><p>
											Adults:
											<%=request.getAttribute("adults")%></p></td>
									<td><p>
											Children:
											<%=request.getAttribute("children")%></p></td>
								</tr>
								<tr>
									<td><span>Duration:</span></td>
									<td><label><%=request.getAttribute("touringDaysCount")%>
											days </label></td>
								</tr>
								<tr>
									<td><span>Traveling Date:</span></td>
									<td><label><%=request.getParameter("sdate1")%></label></td>
								</tr>
								<tr>
									<td><span>Return Date:</span></td>
									<td><label><%=request.getAttribute("travelReturnDate")%></label></td>
								</tr>
							</table>
							<div>
								<h2 class="text-upper" style="text-align: center;">
									tour package cost:
									<%=request.getAttribute("totalTourCost")%>
								</h2>
								<div style="margin: 20px; text-align: center;">
									<label>To Confirm this Booking, please click </label> <a
										class="btn btn-primary text-upper" href="javascript:;"
										onclick="document.getElementById('completeBookingProcess').submit();">Confirm
										Booking</a>
								</div>
							</div>
						</form>
						<h5 style="text-align: center;">Thanks for using the
							TravelPlanner.</h5>
					</div>

				</div>
			</div>
		</div>
		<!-- END .main-contents -->

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



	<script type="text/javascript" src="js/jquery.easing.js"></script>
	<script type="text/javascript" src="js/jquery.fancybox.js"></script>

	<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->

	<script type="text/javascript">
		$(document).ready(function() {

			// initilize fancybox
			$(".item-overlay2").fancybox({
				overlayShow : true,
				overlayOpacity : .7,
				overlayColor : "#000000", // background overlay color
				transitionIn : "fade", // transition type 'elastic', 'fade' or 'none'
				transitionOut : "fade",
				easingIn : "easeInCubic", // Easing used for elastic animations
				easingOut : "easeOutCubic",
				cyclic : true
			});
		});
	</script>


</body>
</html>
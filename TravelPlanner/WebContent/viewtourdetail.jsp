<%@page import="java.sql.*"%>
<%@include file="appvars.jsp"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<%
	if (request.getParameter("id") != null) {
		session.setAttribute("tourid", request.getParameter("id"));
	}
%>
<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Tour Detail</title>

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
		<%@include file="header.jsp"%>

		<!-- START #page-header -->
		<div id="header-banner">
			<div class="banner-overlay">
				<div class="container">
					<div class="row">
						<section class="col-sm-6">
							<h1 class="text-upper">
								<%=request.getAttribute("tourDescription")%>
							</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<div class="sidebar-widget"
								style="width: 55%; float: right; color: white;">
								<h3 class="text-upper">Price</h3>
								<h6>
									For an Adult
									<%=request.getAttribute("adultPrice")%>
								</h6>
								<h6>
									For Child
									<%=request.getAttribute("childPrice")%>
								</h6>

								<p>
									<a id="booking_btn" class="btn btn-primary btn-md text-upper"
										href="tourBookingController">Book Now</a>
								</p>
							</div>
						</section>
					</div>
				</div>
				<div id="contactUsDiv"
					style="margin-right: 50px; margin-bottom: 10px; margin-left: 10px; background-color: dodgerblue; color: white; padding: 11px 15px 10px; border-radius: 15px; box-shadow: black 5px 8px 10px -1px; position: fixed; bottom: 0px; right: 0px; display: block;">
					Have a Query?</label>
					<p style="text-align: center; margin: 0;">
						<button onclick="openContactUsPage()"
							style="color: white; border: none; background-color: dodgerblue;">Ask
							Us</button>
					</p>
				</div>
			</div>

		</div>
		<!-- END #page-header -->

		<!-- START .main-contents -->
		<div class="main-contents">
			<div class="container">
				<!-- START #page -->
				<div id="page" class="col-md-8">

					<div class="tour-plans">
						<%=request.getAttribute("pageResponse")%>
					</div>

				</div>
				<!-- END #page -->
				<aside class="col-md-4" id="sidebar" name="sidebar">
					<%=request.getAttribute("pageResponse2")%>
					<div style="margin: 10px;">
						<h2>Customer Reviews</h2>
						<div>
							<%=request.getAttribute("feedbackResponse")%>
						</div>
						<div>
							<button
								style="background-color: transparent; border: none; float: right;"
								onclick="openReviewsPage()">Click to read more Reviews</button>
						</div>
					</div>
				</aside>
			</div>
		</div>
		<!-- END .main-contents -->

	</div>
	<!-- END #wrapper -->
	<!-- Contact US -->

	<div class="contact_us-popup" id="contactUsPage">
		<%@include file="contact_us.jsp"%>
	</div>
	<div class="reviews-popup" id="reviewsPage">
		<input type="hidden" id="tourId" name="tourId"
			value=<%=request.getParameter("id")%>>
		<%@include file="viewreviews.jsp"%>
	</div>

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
		// 		$(document).ready(function() {
		// 			alert("Hello");
		// 			// initilize fancybox
		// 			$(".item-overlay2").fancybox({
		// 				overlayShow : true,
		// 				overlayOpacity : .7,
		// 				overlayColor : "#000000", // background overlay color
		// 				transitionIn : "fade", // transition type 'elastic', 'fade' or 'none'
		// 				transitionOut : "fade",
		// 				easingIn : "easeInCubic", // Easing used for elastic animations
		// 				easingOut : "easeOutCubic",
		// 				cyclic : true
		// 			});
		// 		});

		window.onload = function() {
			var bookingBtn = document.getElementById('booking_btn');
			if (document.getElementById('tour_status').value == 0) {
				bookingBtn.removeAttribute('href');
				bookingBtn.innerText='Booking Not allowed';
				;
			}
		};
		var myIndex = 0;
		carousel();

		function carousel() {
			var i;
			var x = document.getElementsByClassName("tripPhotos");
			for (i = 0; i < x.length; i++) {
				x[i].style.display = "none";
			}
			myIndex++;
			if (myIndex > x.length) {
				myIndex = 1
			}
			x[myIndex - 1].style.display = "block";
			setTimeout(carousel, 2000); // Change image every 2 seconds
		}

		function openReviewsPage() {
			fetchReviewsAjax();
			document.getElementById("reviewsPage").style.display = "block";
			document.getElementById("contactUsPage").style.display = "none";
		}

		function closeReviewsPage() {
			document.getElementById("reviewsPage").style.display = "none";
			var reviewList = document.getElementById("review-list");
			var listOfReviews = reviewList.childNodes.length;
			for (var i = 0; i < listOfReviews; i++) {
				reviewList.removeChild(reviewList.firstChild);
			}
		}
	</script>


</body>
</html>
<%@page import="java.sql.*"%>
<%@include file="appvars.jsp"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Home | Travel Hub</title>


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

<link rel="stylesheet" href="css/flexslider.css" type="text/css"
	media="screen" />
<!-- SLIDER REVOLUTION 4.x CSS SETTINGS -->
<link rel="stylesheet" type="text/css"
	href="js/rs-plugin/css/settings.css" media="all" />
<!-- responsive stylesheet -->
<link rel="stylesheet" type="text/css" href="css/responsive.css"
	media="all" />

<!-- color scheme -->
<link rel="stylesheet" type="text/css" href="css/colors/color1.css"
	title="color1" />
<link rel="alternate stylesheet" type="text/css"
	href="css/colors/color2.css" title="color2" />
<link rel="alternate stylesheet" type="text/css"
	href="css/colors/color3.css" title="color3" />
<link rel="alternate stylesheet" type="text/css"
	href="css/colors/color4.css" title="color4" />

<!-- Load Fonts via Google Fonts API -->
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Karla:400,700,400italic,700italic" />

</head>
<!-- END head -->

<!-- START body -->
<body>
	<!-- START #wrapper -->
	<div id="wrapper">
		<%@include file="header.jsp"%>
		<!-- END header -->

		<!-- START #main-slider -->
		<div id="main-slider">
			<div id="content-slider" style="background-color: black;">
				<!-- START Slide 1 -->
				<div class="tripPhotos" style="position: fixed;">
					<img src="img/Index_1.jpg" style="display: block; width: 100%;"
						alt="Slider Image 1" data-bgfit="cover"
						data-bgposition="center center" data-bgrepeat="no-repeat" />
				</div>
				<!-- LAYER NR. 1 -->

				<!-- END Slide 1 -->

				<!-- START Slide 2 -->
				<div class="tripPhotos" style="position: fixed;">
					<img src="img/Index_2.jpg" style="display: block; width: 100%;"
						alt="Slider Image 2" data-bgfit="cover"
						data-bgposition="center center" data-bgrepeat="no-repeat" />
					<!-- LAYER NR. 1 -->
				</div>

				<!-- START Slide 3 -->
				<div class="tripPhotos" style="position: fixed;">
					<img src="img/Index_3.jpg" style="display: block; width: 100%;"
						alt="Slider Image 3" data-bgfit="cover"
						data-bgposition="center center" data-bgrepeat="no-repeat" />
					<!-- LAYER NR. 1 -->
				</div>
				<!-- END Slide 3 -->
			</div>
			<!-- 			<div id="slider-overlay"></div> -->
		</div>
		<!-- END #main-slider -->


		<!-- START .main-contents -->
		<div class="main-contents">
			<div class="container" id="home-page">


				<!-- START .tour-plan -->
				<form class="plan-tour" action="lookForPlacesController"
					method="POST">
					<div>
						<h2 class="text-center text-upper">TRAVEL ACROSS INDIA</h2>
					</div>
					<div class="plan-banner">
						<span>Plan Your</span>
						<h4>
							<span>Trip</span>
						</h4>
					</div>
					<div class="top-fields">
						<%
							if (null != request.getAttribute("pageResponse")) {
								out.println(request.getAttribute("pageResponse"));
							}
						%>
						Search your Destination Trip
						<div class="input-field col-md-12">
							<input type="text" placeholder="Location" name="place" autocomplete="off" />
						</div>

					</div>
					<div class="bottom-fields">

						<div class="submit-btn col-md-4">
							<input type="submit" value="Search" />
						</div>
					</div>
				</form>
			</div>
			<!-- START .main-contents .bom-contents -->
			<div class="main-contents bom-contents">
				<div class="container">

					<div class="row">
						<!-- START featured destination  -->
						<section class="col-md-3 fd-column">
							<div class="featured-dest">
								<span class="fd-image"> <a
									href="lookForPlacesController?cat=1"><img
										class="img-circle" src="img/index_hillstation.jpg" width="150"
										height="150" alt="Featured Destination" /></a>
								</span>
								<h3 class="text-center text-upper">Hill Stations</h3>
								<p class="text-center">Experience the stunning countryside,
									lush green meadows, rich flora and fauna, unexplored areas,
									unique cultural heritage, chaotic bazaars and a score of
									adventure activities. </p>
								<span class="btn-center"><a
									class="btn btn-primary text-upper"
									href="lookForPlacesController?cat=1">Search</a></span>
							</div>
						</section>
						<!-- END featured destination  -->

						<!-- START featured destination 2 -->
						<section class="col-md-3 fd-column">
							<div class="featured-dest">
								<span class="fd-image"> <a
									href="lookForPlacesController?cat=2"><img
										class="img-circle" src="img/index_city1.jpg"
										alt="Featured Destination" width="150" height="150" /></a>
								</span>
								<h3 class="text-center text-upper">City Tour</h3>
								<p class="text-center">Explore the metropolitan cities, an
									amalgamation of traditional in cultures and heritage and modern
									in terms of its shopping, sight-seeing and local as well as
									national eateries.</p>
								<span class="btn-center"><a
									class="btn btn-primary text-upper"
									href="lookForPlacesController?cat=2">Search</a></span>
							</div>
						</section>
						<!-- END featured destination 2 -->
						<!-- START featured destination 1 -->
						<section class="col-md-3 fd-column">
							<div class="featured-dest">
								<span class="fd-image"> <a
									href="lookForPlacesController?cat=3"><img
										class="img-circle" src="img/featured-image-1.jpg"
										alt="Featured Destination" /></a>
								</span>
								<h3 class="text-center text-upper">Beaches</h3>
								<p class="text-center">Head towards the exotic beach
									destinations in India. Sun kissed silvery beaches, coconut and
									palm trees swaying rhythmically to the cool breeze, and
									turquoise waters caressing your souls.</p>
								<span class="btn-center"><a
									class="btn btn-primary text-upper"
									href="lookForPlacesController?cat=3">Search</a></span>
							</div>
						</section>
						<!-- END featured destination 1 -->

						<!-- START featured destination 3 -->
						<section class="col-md-3 fd-column">
							<div class="featured-dest">
								<span class="fd-image"> <a
									href="lookForPlacesController?cat=4"><img
										class="img-circle" src="img/Index_wildlife.jpg"
										alt="Featured Destination" width="150" height="150" /></a>
								</span>
								<h3 class="text-center text-upper">Wildlife Spots</h3>
								<p class="text-center">Calling all wildlife enthusiasts to
									come experience the wildlife, bird sanctuaries, national
									parks, bio-sphere reserves present at opportune locations
									throughout India.</p>
								<span class="btn-center"><a
									class="btn btn-primary text-upper"
									href="lookForPlacesController?cat=4">Search</a></span>
							</div>
						</section>
						<!-- END featured destination 3 -->




					</div>
				</div>
			</div>
			<input type="hidden" id="success_msg" name="success_msg"
				value="<%=request.getAttribute("successMsg")%>"> <input
				type="hidden" id="err_msg" name="err_msg"
				value="<%=request.getAttribute("errMsg")%>" autocomplete="off">
		</div>
		<!-- END .main-contents .bom-contents -->

		<%-- 				<%@include file="footer.jsp"%> --%>
		<!-- END footer -->
	</div>
	<!-- END #wrapper -->




	<!-- javascripts -->
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/modernizr.custom.17475.js"></script>


	<script type="text/javascript" src="bs3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
	<script src="js/jquery.flexslider-min.js"></script>
	<script src="js/script.js"></script>
	<script src="js/jquery.minimalect.min.js" type="text/javascript"></script>

	<script src="js/styleswitcher.js"></script>

	<!-- SLIDER REVOLUTION 4.x SCRIPTS  -->
	<script type="text/javascript"
		src="js/rs-plugin/js/jquery.plugins.min.js"></script>
	<script type="text/javascript"
		src="js/rs-plugin/js/jquery.revolution.min.js"></script>

	<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->


	<script type="text/javascript">
		var myIndex = 0;
		window.onload = function() {
			carousel();
			checkForAlertMsgs();
		};
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
			setTimeout(carousel, 5000); // Change image every 2 seconds
		}

		function checkForAlertMsgs() {
			var successMsg = document.getElementById('success_msg');
			var errMsg = document.getElementById('err_msg');
			if (successMsg.value != "null") {
				alert(successMsg.value);
				window.location.href = "index.jsp";
			} else if (errMsg.value != "null") {
				alert(errMsg.value);
				window.location.href = "index.jsp";
			}
		}
	</script>
</body>
</html>
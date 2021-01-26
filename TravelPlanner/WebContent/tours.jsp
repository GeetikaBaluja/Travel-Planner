<%@page import="java.sql.*"%>
<%@include file="appvars.jsp"%>
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
							<h1 class="text-upper">DESTINATIONS</h1>
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
				<h2 class="text-center text-upper">TRAVEL ACROSS INDIA</h2>
				<p class="headline text-center">Visit Amazing India this year and discover the hidden places of India</p>
				<div class="row">
					<!-- START featured destination 1 -->
					<section class="col-md-3 fd-column">
						<div class="featured-dest">
							<span class="fd-image"> <a
								href="showattractions.jsp?cat=Beaches" title="Search"><img
									class="img-circle" src="img/featured-image-1.jpg"
									alt="Featured Destination" /></a>
							</span>
							<h3 class="text-center text-upper">Beaches</h3>
							<p class="text-center">Visit the exotic beaches popular
								across the world for their beauty. Surf or swim or take sun bath
								in Indian Beaches.</p>
							<span class="btn-center"><a
								class="btn btn-primary text-upper"
								href="showattractions.jsp?cat=Beaches" title="Search">Search</a></span>
						</div>
					</section>
					<!-- END featured destination 1 -->
					<!-- START featured destination 2 -->
					<section class="col-md-3 fd-column">
						<div class="featured-dest">
							<span class="fd-image"> <a
								href="showattractions.jsp?cat=Religious Places" title="Search"><img
									class="img-circle" src="img/featured-image-2.jpg"
									alt="Featured Destination" /></a>
							</span>
							<h3 class="text-center text-upper">Religious Places</h3>
							<p class="text-center">Visit the Religious places of India to
								get bliss in life. You will feel peace, calmness and
								satisfaction by visiting these places.</p>
							<span class="btn-center"><a
								class="btn btn-primary text-upper"
								href="showattractions.jsp?cat=Religious Places" title="Search">Search</a></span>
						</div>
					</section>
					<!-- END featured destination 2 -->
					<!-- START featured destination 3 -->
					<section class="col-md-3 fd-column">
						<div class="featured-dest">
							<span class="fd-image"> <a
								href="showattractions.jsp?cat=Tourist Spots" title="Search"><img
									class="img-circle" src="img/featured-image-3.jpg"
									alt="Featured Destination" /></a>
							</span>
							<h3 class="text-center text-upper">Tourist Spots</h3>
							<p class="text-center">Visit the popular Indian Tourist Spots
								with your family, friends. You will enjoy the stay with the
								tourist friendly atmosphere</p>
							<span class="btn-center"><a
								class="btn btn-primary text-upper"
								href="showattractions.jsp?cat=Tourist Spots" title="Search">Search</a></span>
						</div>
					</section>
					<!-- END featured destination 3 -->
					<!-- START featured destination 4 -->
					<section class="col-md-3 fd-column">
						<div class="featured-dest">
							<span class="fd-image"> <a
								href="showattractions.jsp?cat=Hill Stations" title="Search"><img
									class="img-circle" src="img/featured-image-4.jpg"
									alt="Featured Destination" /></a>
							</span>
							<h3 class="text-center text-upper">Hill Stations</h3>
							<p class="text-center">Enjoy the coolness of Indian Hill
								Stations with breathtaking views of Hills of India. You will
								enjoy natural beauty of India.</p>
							<span class="btn-center"><a
								class="btn btn-primary text-upper"
								href="showattractions.jsp?cat=Hill Stations" title="Search">Search</a></span>
						</div>
					</section>
					<!-- END featured destination 4 -->
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


</body>
</html>
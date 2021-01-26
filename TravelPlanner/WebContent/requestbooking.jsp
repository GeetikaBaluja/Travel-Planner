<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@include file="appvars.jsp"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Request Tour Booking</title>

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
<link rel="stylesheet" href="css/jquery-ui.css" />
<script src="js/jquery.js"></script>
<script src="js/jquery-ui.js"></script>

<script>
	$(function() {
		$("#sdate1").datepicker(
				{
					minDate : 30,
					maxDate : 90,
					dateFormat : 'yy-mm-dd',
					onSelect : function(selectedDate) {
						var d = new Date(selectedDate);
						d.setDate(d.getDate()
								+ parseInt($("#touringDaysCount").val()));
						$("#enddate1").datepicker("setDate", d);
					}
				});
	});
	$(function() {
		$("#enddate1").datepicker({
			dateFormat : 'yy-mm-dd',
			beforeShowDay : function(date) {
				return [ false, '' ];
			}
		});
	});
</script>
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
							<h1 class="text-upper">Request Tour Booking</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="index.jsp">Home</a></li>
								<li class="active">Request Tour Booking</li>
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
				<div id="page" class="col-md-8">
					<%
						if (null != request.getAttribute("pageResponse")) {
							out.println(request.getAttribute("pageResponse"));
						}
					%>
					<!-- START #contactForm -->
					<section id="signup-form">
						<h2 class="ft-heading text-upper">Please provide details for
							your booking</h2>
						<span>Bookings allowed for next 3 months only</span>
						<form action="tourBookingController" method="post">
							<fieldset>
								<ul class="formFields list-unstyled">
									<li class="row">
										<div class="col-md-6"></div>
									</li>

									<li class="row">
										<div class="col-md-6">
											<label>Departure Date</label> <input type="text"
												class="form-control" name="sdate1" id="sdate1" value=""
												required autocomplete="off" />
										</div>
										<div class="col-md-6">
											<label>Return Date</label> <input type="text"
												class="form-control" name="enddate1" id="enddate1" value=""
												readonly required autocomplete="off" />
										</div>
									</li>
									<li class="row">
										<div class="col-md-3">
											<label>No. of Adults <span class="required small">(Required)</span></label>
											<input type="number" class="form-control" name="adults"
												id="adults" value="1" required min="1" max="10" />
										</div>
										<div class="col-md-3">
											<label>No. of Children <span class="required small">(<12
													Years)</span></label> <input type="number" class="form-control"
												name="children" id="children" value="0" required min="0"
												max="10" />
										</div>
										<div class="col-md-6">
											<label>Departure City <span class="required small"></span></label>
											<select name="dcity" id="dcity" class="form-control">
												<option disabled="disabled">Choose City</option>
												<option selected="selected">New Delhi</option>
												<option>Mumbai</option>
												<option>Kolkata</option>
												<option>Bangalore</option>

											</select>
										</div>
									</li>

									<li class="row"></li>


									<li class="row">
										<div class="col-md-12 col-md-offset-4">
											<input type="submit" class="btn btn-primary btn-lg"
												name="submit" value="Calculate Tour Expenses" />

										</div>
									</li>

								</ul>
							</fieldset>
							<input id="touringDaysCount" name="touringDaysCount"
								type="hidden"
								value=<%=request.getAttribute("touringDaysCount")%>>
						</form>
					</section>
					<!-- END #contactForm -->
				</div>
				<!-- END #page -->
				<aside class="col-md-4"
					style="box-shadow: 8px 2px 15px 0px; border-radius: 10px;"
					id="sidebar" name="sidebar">

					<h1 class="text-upper" style="text-align: center;">Tour
						Selected</h1>

					<%
						if (null != request.getAttribute("pageResponse1")) {
							out.println(request.getAttribute("pageResponse1"));
						}
					%>
				</aside>
			</div>
		</div>
		<!-- END .main-contents -->

		<!-- 		<!-- START footer -->

		<%-- 		<%@include file="footer.jsp"%> --%>
		<!-- 		<!-- END footer -->
	</div>
	<!-- END #wrapper -->


	<!-- javascripts -->
	<script type="text/javascript" src="js/modernizr.custom.17475.js"></script>
	<script type="text/javascript" src="bs3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/script.js"></script>
	<script src="js/styleswitcher.js"></script>
	<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->


</body>
</html>
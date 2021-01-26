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
							<h1 class="text-upper">Sign Up</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="index.jsp">Home</a></li>
								<li class="active">Sign up</li>
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
				<div id="page" class="col-md-10 col-md-offset-1">

					<!-- START #contactForm -->
					<section id="signup-form"
						style="box-shadow: 10px 10px 10px 10px; padding: 10px; border-radius: 15px;">
						<h2 class="ft-heading text-upper" style="text-align: center;">
							<p>Register Yourself</p>
						</h2>
						<form action="signup" method="post">
							<fieldset>
								<ul class="formFields list-unstyled">
									<li class="row">
										<div class="col-md-6">
											<%
												if (null != request.getAttribute("pageResponse")) {
													out.println(request.getAttribute("pageResponse"));
												}
											%>
										</div>
									</li>
									<li class="row">
										<div class="col-md-5 col-md-offset-1">
											<label>Name <span class="required small">(Required)</span></label>
											<input type="text" autocomplete="off" class="form-control"
												name="name" value="" required />
										</div>
										<div class="col-md-5 col-md-offset-0">
											<label>Email <span class="required small">(Required)</span></label>
											<input type="email" class="form-control" autocomplete="off"
												name="emailid" value="" required />
										</div>
									</li>

									<li class="row">
										<div class="col-md-5 col-md-offset-1">
											<label>Password <span class="required small">(Required)</span></label>
											<input type="password" class="form-control" name="password1"
												value="" required />
										</div>
										<div class="col-md-5 col-md-offset-0">
											<label>Confirm Password <span class="required small">(Required)</span></label>
											<input type="password" class="form-control" name="password2"
												value="" />
										</div>
									</li>
									<li class="row">
										<div class="col-md-5 col-md-offset-1">
											<label>Phone </label> <input type="text" autocomplete="off"
												class="form-control" name="phone" value="" />
										</div>
										<div class="col-md-2 col-md-offset-0">
											<label>House No.</label><input name="house_no"
												autocomplete="off" id="house_no" class="form-control">

										</div>
										<div class="col-md-3 col-md-offset-0">
											<label>Street Name</label> <input name="street_name"
												id="street_name" class="form-control" autocomplete="off">
										</div>
									</li>
									<li class="row">

										<div class="col-md-3 col-md-offset-1">
											<label>City</label> <input name="city" id="city"
												class="form-control" autocomplete="off">
										</div>
										<div class="col-md-3 col-md-offset-0">
											<label>State</label> <input name="state" id="state"
												class="form-control" autocomplete="off">
										</div>
										<div class="col-md-3 col-md-offset-0">
											<label>Pincode</label> <input name="pincode" id="pincode"
												class="form-control" autocomplete="off">
										</div>
									</li>







									<li class="row">
										<div class="col-md-5 col-md-offset-5">
											<input type="submit"
												class="btn btn-primary btn-lg text-upper" name="submit"
												value="Sign up" />

										</div>
									</li>

								</ul>
							</fieldset>
						</form>
					</section>
					<!-- END #contactForm -->
				</div>
				<input type="hidden" id="success_msg" name="success_msg"
					value="<%=request.getAttribute("successMsg")%>"> <input
					type="hidden" id="err_msg" name="err_msg"
					value="<%=request.getAttribute("errMsg")%>">
				<!-- END #page -->
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
<script type="text/javascript">
	var myIndex = 0;
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
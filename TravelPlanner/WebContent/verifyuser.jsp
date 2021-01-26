<!DOCTYPE html>
<html lang="en" dir="ltr">

<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Verify One-Time Password</title>

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
		<%-- 		<%@include file="header.jsp"%> --%>


		<!-- breadcrumbs -->

		<!-- START #page-header -->
		<div id="header-banner">
			<div class="banner-overlay">
				<div class="container">
					<div class="row">
						<section class="col-sm-6">
							<h1 class="text-upper">Verify One-Time Password</h1>
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
				<div id="page" class="col-md-6 col-md-offset-3">

					<!-- START #contactForm -->
					<section id="signup-form"
						style="box-shadow: 10px 12px 20px 5px; padding: 20px; border-radius: 15px;">
						<h2 class="ft-heading text-upper" style="text-align: center;">Verify
							OTP</h2>
						<form action="verifyOtp" method="post">
							<fieldset>
								<ul class="formFields list-unstyled">
									<li class="row">
										<div class="col-md-6"></div>
									</li>
									<li class="row">
										<div class="col-md-8 col-md-offset-2">
											<label>Enter OTP <span class="required small">(Required)</span></label>
											<input type="text" autocomplete="off" class="form-control" name="otp" value=""
												required /> <input type="hidden" id="phone" name="phone"
												value=<%=request.getAttribute("phone")%>>
										</div>

									</li>
									<li class="row">
										<div class="col-md-8 col-md-offset-2">
											<input type="submit"
												class="btn btn-primary btn-lg text-upper" name="submit"
												value="Verify" />

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
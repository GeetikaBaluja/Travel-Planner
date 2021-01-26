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
<title>Booking Status</title>

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
							<h2 class="text-upper" style="text-align: center;">
								tour package cost:
								<%=request.getAttribute("totalTourCost")%>
							</h2>
							<div style="text-align: center;">
								<label>If you want to Cancel Booking, please confirm by
									clicking the button</label>
								<button class="btn btn-primary" disabled id="cancelBookingBtn"
									onclick="document.getElementById('changeCustomerBookingStatus').submit();">Cancel
									Booking</button>
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
						<form id="changeCustomerBookingStatus"
							action="changeCustomerBookingStatus" method="post">
							<input type="hidden" name="bookingId" id="bookingId"
								value=<%=request.getAttribute("bookingId")%>> <input
								type="hidden" name="tourName"
								value='<%=request.getAttribute("tourName")%>'> <input
								type="hidden" name="travelDate" id="travelDate"
								value=<%=request.getAttribute("travelDate")%>> <input
								type="hidden" name="bookingStatus" id="bookingStatus"
								value=<%=request.getAttribute("tourStatus")%>> <input
								type="hidden" name="tourId" id="tourId"
								value=<%=request.getAttribute("tourId")%>>

							<h3>Booking Details</h3>
							<table style="margin: 10px;">
								<tr>
									<td colspan="2">Booking Id: <label><%=request.getAttribute("bookingId")%></label></td>
								</tr>
								<tr>
									<td colspan="2">Booked On: <label> <%=request.getAttribute("requestDate")%></label></td>
								</tr>
							</table>
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
									<td><label>Tour Duration: </label></td>
									<td><label><%=request.getAttribute("touringDaysCount")%>
											days </label></td>
								</tr>
								<tr>
									<td><label> Travel Date:</label></td>
									<td><label><%=request.getAttribute("travelDate")%></label></td>
								</tr>
								<tr>
									<td><label> Return Date:</label></td>
									<td><label><%=request.getAttribute("returnDate")%></label></td>
								</tr>
								<tr>
									<td><label> Booking Status: </label></td>
									<td><label><%=request.getAttribute("tourStatus")%></label></td>
								</tr>
							</table>
						</form>
						<div style="text-align: center;">
							<label>Tell Us about your Trip.</label>
							<button class="btn btn-primary" id="feedbackBtn"
								onclick="openFeedbackPage(false)" disabled>Share
								Feedback</button>
							<h5 style="text-align: center;">Thanks for using the
								TravelPlanner.</h5>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- END .main-contents -->
		<div class="feedback-popup" id="feedbackPage">
			<input type="hidden" name="user_rating_hidden"
				id="user_rating_hidden"
				value=<%=request.getAttribute("user_rating")%>> <input
				type="hidden" name="highlights_hidden" id="highlights_hidden"
				value=<%=request.getAttribute("highlights")%>> <input
				type="hidden" name="experience_hidden" id="experience_hidden"
				value=<%=request.getAttribute("experience")%>> <input
				type="hidden" name="feedback_submission_date_hidden"
				id="feedback_submission_date_hidden"
				value=<%=request.getAttribute("feedbackSubmissionDate")%>> <input
				type="hidden" name="feedback_submission_hidden"
				id="feedback_submission_hidden"
				value=<%=request.getAttribute("feedbackSubmitted")%>>


			<%@include file="sharefeedback.jsp"%>
		</div>

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
		window.onload = function() {
			document.getElementById("cancelBookingBtn").disabled =
	<%=request.getAttribute("cancelBtnDisable")%>
		;
		checkCancelAction();
			performActionOnFeedbackBtn();
		}
		function performActionOnFeedbackBtn() {
			var today = new Date();
			var travelDate = new Date(
					document.getElementById("travelDate").value);
			var tourStatus = document.getElementById("bookingStatus").value;
			var feedbackSubmitted = document
					.getElementById("feedback_submission_hidden").value;
			if ((today >= travelDate) && (tourStatus == 'Confirmed')) {
				document.getElementById("feedbackBtn").disabled = false;
			}
			if (feedbackSubmitted == "true") {
				document.getElementById("feedbackBtn").setAttribute('onclick',
						'fetchAndOpenFeedbackPage(false)');
				var feedbackSubmissionDate = document.getElementById("feedback_submission_date_hidden").value;
				 feedbackSubmissionDate = new Date(feedbackSubmissionDate);
				feedbackSubmissionDate.setDate(feedbackSubmissionDate.getDate() + 15);
				if (today > feedbackSubmissionDate) {
					document.getElementById("feedbackBtn").setAttribute(
							'onclick', 'fetchAndOpenFeedbackPage(true)');
				}
				document.getElementById("feedbackBtn").textContent = "View Feedback";
				document.getElementById("feedbackBtn").disabled = false;
			}

		}
		function openFeedbackPage(isDisabled) {
			document.getElementById("feedbackPage").style.display = "block";
			document.getElementById("user_rating").disabled = Boolean(isDisabled);
			document.getElementById("highlights").disabled = Boolean(isDisabled);
			document.getElementById("experience").disabled = Boolean(isDisabled);
			document.getElementById("submit_feedback_btn").disabled = Boolean(isDisabled);
		}

		function closeFeedbackPage() {
			document.getElementById("feedbackPage").style.display = "none";
			document.getElementById("highlights").value = "";
			document.getElementById("experience").value = "";
		}
		function fetchAndOpenFeedbackPage(isDisabled) {
			fetchFeedbackAjax();
			fillFeedbackBox();
			openFeedbackPage(isDisabled);

		}
		function checkCancelAction(){
			var today = new Date();
			var travelDate = new Date(
					document.getElementById("travelDate").value);
			if (today >= travelDate){
			document.getElementById("cancelBookingBtn").disabled = true;
			}
		}

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
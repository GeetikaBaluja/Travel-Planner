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
<title>View Booking Requests</title>

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
<script type="text/javascript" src="js/jquery.min.js"></script>

<script src="js/styleswitcher.js"></script>

</head>
<!-- END head -->

<!-- START body -->
<body>
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
							<h1 class="text-upper">View Booking Requests</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="adminpanel.jsp">Admin Panel</a></li>
								<li class="active">View Booking Request</li>
							</ol>
						</section>
					</div>
				</div>
			</div>
		</div>
		<!-- END #page-header -->

		<!-- START .main-contents -->
		<div class="main-contents">
			<div class="">
				<!-- START #page -->
				<div id="page">

					<!-- START #contactForm -->
					<section id=""
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 20px;"
						class="col-md-3">
						<div style="font-size: 22px;">
							<label>Search Booking</label>
						</div>
						<div>
							<div class="row" style="margin: 5px;">
								<div class="col-md-4">
									<label style="margin-top: 10px;">Booking Id.</label>
								</div>
								<div class="col-md-8">
									<input type="text" id="booking_id" class="form-control">
								</div>
							</div>
							<div class="row" style="margin: 5px;">
								<div class="col-md-3" style="float: right; margin: 5px;">
									<button type="button" class="btn btn-primary"
										onclick="fetchRecordByBookingId()">Find</button>
								</div>
							</div>
							<div
								style="text-align: center; border-top: 1px solid; margin: 15px;">
								<label style="position: absolute; margin-top: -10px;">OR</label>
							</div>
							<div>
								<div class="row" style="margin: 5px;">
									<div class="col-md-4">
										<label>Email</label>
									</div>
									<div class="col-md-8">
										<input type="email" class="form-control" id="email_id"
											name="email_id">
									</div>
								</div>
								<div class="row" style="margin: 5px;">
									<div class="col-md-4">
										<label>Contact No</label>
									</div>
									<div class="col-md-8">
										<input type="text" id="contact_no" class="form-control"
											name="contact_no">
									</div>
								</div>
								<div class="row" style="margin: 5px;">
									<div class="col-md-4">
										<label>Travel-Date</label>
									</div>
									<div class="col-md-8">
										<input type="date" class="form-control" id="travel_date"
											name="travel_date">
									</div>
								</div>
								<div class="row" style="margin: 5px;">
									<div class="col-md-3" style="float: right; margin: 5px;">

										<button type="button" class="btn btn-primary"
											onclick="fetchRecordByMultipleFields()">Find</button>
									</div>
								</div>
							</div>
						</div>
					</section>
					<section id="confirm_section"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 20px; display: none;"
						class="col-md-8">
						<div class="row">
							<div class="col-md-7">
								<label class="ft-heading text-upper" style="font-size: 24px;">Bookings</label><label
									class="value">Confirmed</label>
								<%=request.getAttribute("confirmedBookingCount")%></div>
							<div class="col-md-5" style="margin-top: 5px;">
								<button id="pending_btn" class="btn btn-secondary"
									style="margin: 5px;" onClick='viewPending()'>Pending
									Bookings</button>
								<button id="cancel_btn" class="btn btn-secondary"
									style="margin: 5px;" onClick='viewCancel()'>Cancelled
									Bookings</button>
							</div>
						</div>
						<div class="table-responsive"
							style="display: block; position: relative; height: 250px; overflow: auto;">
							<table id='pending' class='table' align='center'>
								<tr style='color: white; background: black'>
									<th class="col-md-1">Booking Id</th>
									<th class="col-md-1">Name</th>
									<th class="col-md-2">Tour Name</th>
									<th class="col-md-1">Travel Date</th>
								</tr>
								<%=request.getAttribute("confirmRequestResponse")%>
							</table>
						</div>
					</section>
					<section id="pending_section"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 20px;"
						class="col-md-8">
						<div class="row">
							<div class="col-md-7">
								<label class="ft-heading text-upper" style="font-size: 24px;">Bookings</label><label
									class="value">Pending</label>
								<%=request.getAttribute("pendingBookingCount")%></div>
							<div class="col-md-5" style="margin-top: 5px;">
								<button class="btn btn-secondary" id="confirm_btn"
									style="margin: 5px;" onClick="viewConfirm()">Confirmed
									Bookings</button>
								<button class="btn btn-secondary" style="margin: 5px;"
									id="cancel_btn" onClick='viewCancel()'>Cancelled
									Bookings</button>
							</div>
						</div>
						<div class="table-responsive"
							style="display: block; position: relative; height: 250px; overflow: auto;">

							<table id='pending' class='table' align='center'>
								<tr style='color: white; background: black'>
									<th class="col-md-1">Booking Id</th>
									<th class="col-md-1">Name</th>
									<th class="col-md-2">Tour Name</th>
									<th class="col-md-1">Travel Date</th>
								</tr>
								<%=request.getAttribute("pendingRequestResponse")%>
							</table>
						</div>
					</section>
					<section id="cancel_section"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 20px; display: none;"
						class="col-md-8">
						<div class="row">
							<div class="col-md-7">
								<label class="ft-heading text-upper" style="font-size: 24px;">Bookings</label><label
									class="value">Cancelled</label>
								<%=request.getAttribute("cancelledBookingCount")%></div>
							<div class="col-md-5" style="margin-top: 5px;">
								<button id="confirm_btn" class="btn btn-secondary"
									style="margin: 5px;" onClick="viewConfirm()">Confirmed
									Bookings</button>
								<button id="pending_btn" class="btn btn-secondary"
									style="margin: 5px;" onClick='viewPending()'>Pending
									Bookings</button>
							</div>
						</div>
						<div class="table-responsive"
							style="display: block; position: relative; height: 250px; overflow: auto;">
							<table id='pending' class='table' align='center'>
								<tr style='color: white; background: black'>
									<th class="col-md-1">Booking Id</th>
									<th class="col-md-1">Name</th>
									<th class="col-md-2">Tour Name</th>
									<th class="col-md-1">Travel Date</th>
								</tr>
								<%=request.getAttribute("cancelledRequestResponse")%>
							</table>
						</div>
					</section>
					<!-- END #contactForm -->
				</div>
				<%=request.getAttribute("confirmRequestForm")%>
				<%=request.getAttribute("pendingRequestForm")%>
				<%=request.getAttribute("cancelledRequestForm")%>

				<div id="contact_us-container" class="modal"></div>


				<!-- END #page -->
			</div>
		</div>
		<!-- END .main-contents -->

		<!-- START footer -->
		<%-- 		<%@include file="footer.jsp"%> --%>
		<!-- END footer -->
	</div>
	<!-- END #wrapper -->


	<!-- javascripts -->
	<script type="text/javascript" src="js/modernizr.custom.17475.js"></script>


	<script type="text/javascript" src="bs3/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/script.js"></script>

	<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->

	<script>
		function viewConfirm() {
			document.getElementById('pending_section').style.display = 'none';
			document.getElementById('cancel_section').style.display = 'none';
			document.getElementById('confirm_section').style.display = 'block';
		}
		function viewPending() {
			document.getElementById('pending_section').style.display = 'block';
			document.getElementById('cancel_section').style.display = 'none';
			document.getElementById('confirm_section').style.display = 'none';
		}
		function viewCancel() {
			document.getElementById('pending_section').style.display = 'none';
			document.getElementById('cancel_section').style.display = 'block';
			document.getElementById('confirm_section').style.display = 'none';
		}
		function fetchRecordByBookingId() {
			var bookingId = document.getElementById('booking_id').value;
			if (bookingId == "") {
				alert("Booking Id is Empty");
			} else {
				fetchRecordByBookingIdAjax(bookingId);
			}
		}
		function fetchRecordByMultipleFields() {
			var emailId = document.getElementById('email_id').value;
			var contactNo = document.getElementById('contact_no').value;
			var travelDate = document.getElementById('travel_date').value;
			if ((emailId == "") || (contactNo == "") || (travelDate == "")) {
				alert("Details Missing");
			} else {
				fetchRecordByMultipleFieldsAjax(emailId, contactNo, travelDate);
			}
		}

		function fetchRecordByBookingIdAjax(bookingIdValue) {
			var prepareDataSet = {
				bookingId : bookingIdValue,
			}
			$
					.ajax({
						type : "POST",
						json : true, // added this
						url : 'fetchRecordByBookingId',
						'Content-Type' : 'application/x-www-form-urlencoded',
						data : prepareDataSet,
						async : false,
						success : function(json) {
							if (json['errMsg'] == "") {
								createBookingDetailsPopUp(json);
								for (var hotelCounter = 0; hotelCounter < json['hotelInfoArr'].length; hotelCounter++) {
									var hotelDiv = document
											.createElement('div');
									hotelDiv.setAttribute("class", "col-md-3");
									var hotelSpan = document
											.createElement('span');
									hotelSpan.setAttribute("class", "box");
									var hotelSpanTextNode = document
											.createTextNode('Hotel:');
									hotelSpan.appendChild(hotelSpanTextNode);
									var hotelInfoLabel = document
											.createElement('label');
									hotelInfoLabel.setAttribute("class",
											"value");
									var hotelInfoLabelTextNode = document
											.createTextNode(json['hotelInfoArr'][hotelCounter]['hotelName']
													+ ','
													+ json['hotelInfoArr'][hotelCounter]['hotelAddress']);
									hotelInfoLabel
											.appendChild(hotelInfoLabelTextNode);
									hotelDiv.appendChild(hotelSpan);
									hotelDiv.appendChild(hotelInfoLabel);

									document.getElementById('hotel-info-div')
											.appendChild(hotelDiv);

								}

							} else {
								alert(json['errMsg']);
							}

						},
						error : function(e) {
							console.log("jQuery error message = " + e.message);
						}

					});
		}

		function fetchRecordByMultipleFieldsAjax(emailIdValue, contactNoValue,
				travelDateValue) {
			var prepareDataSet = {
				emailId : emailIdValue,
				contactNo : contactNoValue,
				travelDate : travelDateValue

			}
			$
					.ajax({
						type : "POST",
						json : true, // added this
						url : 'fetchRecordByBookingWithMVs',
						'Content-Type' : 'application/x-www-form-urlencoded',
						data : prepareDataSet,
						async : false,
						success : function(json) {
							if (json['errMsg'] != "") {
								displayBookingListBasedOnMVs(json['bookingListResponse']);
								//createBookingDetailsPopUp(json);
							}

							else {
								alert(json['errMsg']);
							}

						},
						error : function(e) {
							console.log("jQuery error message = " + e.message);
						}

					});
		}
		function displayBookingListBasedOnMVs(bookingListResponse) {
			var bookingListDiv = "<div class='modal-content'><div class='modal-header'><span onclick='closePopUp()'class='close'>&times;</span><h3>Booking Details</h3></div><div class='table-responsive modal-body' style='display: block; position: relative; height: 250px; overflow: auto;'>"
					+ "<table id='pending' class='table' align='center'><tr style='color: white; background: black'>"
					+ "<th class='col-md-1'>Booking_Id</th><th class='col-md-1'>Name</th><th class='col-md-2'>Tour_Name</th><th class='col-md-1'>Travel_Date</th></tr>"
					+ bookingListResponse + "</table></div></div>";
			var bookingPageContainer = document
					.getElementById('contact_us-container');
			bookingPageContainer.innerHTML = bookingListDiv;
			bookingPageContainer.style.display = "block";

		}
		function createBookingDetailsPopUp(bookingObj) {

			var bookingPopUp = "<div class='modal-content col-md-12'><div class='modal-header'><span onclick='closePopUp()'class='close'>&times;</span><h3>Booking Details</h3><div><span class='box'>Booking Id: <label class='value'>"
					+ bookingObj['bookingId']
					+ "</label></span><span class='box'>Booking Status:<label class='value'>"
					+ bookingObj['tourStatus']
					+ "</label></span></div><p><span class='box'>Booked On: <label class='value'> "
					+ bookingObj['requestDate']
					+ "</label></span></p></div>"
					+ "<div class='modal-body'><div class='row' style='padding: 10px;'><div><label>Personal Details</label></div><div class='col-md-3'><span class='box'>Booking For:<label class='value'>"
					+ bookingObj['name']
					+ "</label></span></div><div class='col-md-3'><span class='box'>ContactNo.<label class='value'>"
					+ bookingObj['phone']
					+ "</label></span></div><div class='col-md-3'><span class='box'>Email:<label class='value'>"
					+ bookingObj['email']
					+ "</label></span></div></div><div class='row' style='padding: 10px;'><div><label>Tour Details</label></div><div class='col-md-5'><span class='box'>TourName:<label class='value'>"
					+ bookingObj['tourName']
					+ "<label></span></div><div class='col-md-3'><span class='box'>Tour Duration:<label class='value'>"
					+ bookingObj['touringDaysCount']
					+ "</label></span></div></div><div class='row' style='padding: 10px;'><div><label>Booking Info</label></div><div class='col-md-4'><span class='box'><label>Person Traveling:</label><span class='box'>Adults:<label class='value'>"
					+ bookingObj['adults']
					+ "</label></span><span class='box' >Children:<label class='value'>"
					+ bookingObj['children']
					+ "</label></span></div><div class='col-md-3'><span class='box'>Rooms Booked:<label class='value'>"
					+ bookingObj['roomsbooked']
					+ "</label></span></div><div class='col-md-3'><span class='box'> Travel Date:<label class='value'>"
					+ bookingObj['travelDate']
					+ "</label></span></div><div class='col-md-3'>"
					+ "<span class='box'>Price: <label class='value'>"
					+ bookingObj['totalTourCost']
					+ "</label></span></div><div class='col-md-3'><span class='box'> Return Date:<label class='value'>"
					+ bookingObj['returnDate']
					+ "</label></span></div></div><div class='row' style='padding: 10px;'><div><label>Hotel Details</label></div><div class='col-md-12' id='hotel-info-div'></div></div></div><div style='text-align: center;' class='modal-footer'><button class='btn btn-primary' style='margin: 5px;' id='bookingConfirmBtn' onclick='adminConfirmBooking("
					+ bookingObj['bookingId']
					+ ")' >Confirm "
					+ "Booking</button><button  style='margin: 5px;' class='btn btn-primary' id='bookingCancelBtn'onclick='adminCancelBooking("
					+ bookingObj['bookingId']
					+ ")' >Cancel Booking</button></div></div>";
			var bookingPageContainer = document
					.getElementById('contact_us-container');
			bookingPageContainer.innerHTML = bookingPopUp;
			validateBtnOperationsBasedOnBokkingStatus(bookingObj['tourStatus']);
			bookingPageContainer.style.display = "block";
		}

		function adminConfirmBooking(bookingId) {
			performBookingActionAjax(bookingId, 1);
			closePopUp();
		}
		function adminCancelBooking(bookingId) {
			performBookingActionAjax(bookingId, 0);
			closePopUp();

		}
		function performBookingActionAjax(booking_Id, booking_Action) {
			var prepareDataSet = {
				bookingAction : booking_Action,
				bookingId : booking_Id
			}
			$.ajax({
				type : "POST",
				json : true, // added this
				url : 'performBookingAction',
				'Content-Type' : 'application/x-www-form-urlencoded',
				data : prepareDataSet,
				async : false,
				success : function(json) {
					alert(json['response']);

				},
				error : function(e) {
					console.log("jQuery error message = " + e.message);
				}

			});
		}
		function validateBtnOperationsBasedOnBokkingStatus(bookingStatus) {
			if (bookingStatus === 'Confirmed') {
				var confirmBtn = document.getElementById('bookingConfirmBtn');
				confirmBtn.disabled = true;

			} else if (bookingStatus === 'Cancelled') {
				var confirmBtn = document.getElementById('bookingConfirmBtn');
				var cancelBtn = document.getElementById('bookingCancelBtn');
				confirmBtn.disabled = true;
				cancelBtn.disabled = true;
			}
		}
		function closePopUp() {
			var bookingPageContainer = document
					.getElementById('contact_us-container');
			bookingPageContainer.style.display = "none";
		}
	</script>

</body>
</html>
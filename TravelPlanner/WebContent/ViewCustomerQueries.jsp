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
<title>Queries Section</title>

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
							<h1 class="text-upper">Queries Section</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="adminpanel.jsp">Admin Panel</a></li>
								<li class="active">Queries Section</li>
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
				<div id="page" >

					<!-- START #contactForm -->
					<section id=""
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin-bottom: 10px"
						class="col-md-5 col-md-offset-1">
						<div style="text-align: center;">
							<label>In-App Customers</label>
						</div>
						<div class="table-responsive"
							style="display: block; position: relative; height: 250px; overflow: auto;">
							<table id='pending' class='table' align='center'>
								<tr style='color: white; background: black'>
									<th class="col-md-1">Name</th>
									<th class="col-md-1">Contact Number</th>
									<th class="col-md-3">Query</th>
								</tr>
								<%=request.getAttribute("registeredUser")%>
							</table>
						</div>

					</section>
					<section id="confirm_section"
						style="box-shadow: 5px 5px 20px 5px; border-radius: 15px; padding: 25px; margin: 0px 0px 0px 15px;"
						class="col-md-5">
						<div style="text-align: center;">
							<label>External Customers</label>
						</div>
						<div class="table-responsive"
							style="display: block; position: relative; height: 250px; overflow: auto;">
							<table id='pending' class='table' align='center'>
								<tr style='color: white; background: black'>
									<th class="col-md-1">Name</th>
									<th class="col-md-1">Contact Number</th>
									<th class="col-md-3">Query</th>
								</tr>
								<%=request.getAttribute("non_registeredUser")%>
							</table>
						</div>
					</section>

					<!-- END #contactForm -->
				</div>

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

		function fetchQueriesByIdAjax(query_id) {
			var prepareDataSet = {
				queryId : query_id,
			}
			$.ajax({
				type : "POST",
				json : true, // added this
				url : 'fetchRecordByQueryId',
				'Content-Type' : 'application/x-www-form-urlencoded',
				data : prepareDataSet,
				async : false,
				success : function(json) {
					if (json['errMsg'] == "")
						createBookingDetailsPopUp(json);
					else {
						alert(json['errMsg']);
					}

				},
				error : function(e) {
					console.log("jQuery error message = " + e.message);
				}

			});
		}

		function createBookingDetailsPopUp(bookingObj) {

			var bookingPopUp = "<div class='modal-content'><div class='modal-header'><span onclick='closePopUp()'class='close'>&times;</span><h3>Query Box</h3><span style='margin: 5px;'>Name: <label>"
					+ bookingObj['name']
					+ "</span><span style='margin: 5px;'>Phone <label> "
					+ bookingObj['phone']
					+ "</label></span><p><span style='margin: 5px;'>Email:<label>"
					+ bookingObj['email']
					+ "</label></span></p></div>"
					+ "<div class='modal-body row'><div class='col-md-12' style='padding: 10px;margin: 12px;'><p><label>Customer Query: </label></p><div style='background-color: lightgray;padding: 10px;margin: 12px;'><label>"
					+ bookingObj['query']
					+ "</label></p></div></div></div></div>";
			var bookingPageContainer = document
					.getElementById('contact_us-container');
			bookingPageContainer.innerHTML = bookingPopUp;
			bookingPageContainer.style.display = "block";
		}

		function closePopUp() {
			var bookingPageContainer = document
					.getElementById('contact_us-container');
			bookingPageContainer.style.display = "none";
		}
	</script>

</body>
</html>
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
<title>Add Tour</title>

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
<script type="text/javascript" src="js/tinymce.min.js"></script>
<script src="js/styleswitcher.js"></script>
<script type="text/javascript">
	tinymce
			.init({
				selector : "textarea",
				plugins : [ "autolink lists", " paste" ],
				toolbar : "bold italic | alignleft aligncenter alignright alignjustify"
			});
</script>
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
							<h1 class="text-upper">Add Tour</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="adminpanel.jsp">Admin Panel</a></li>
								<li class="active">Add Tour</li>
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
				<div id="page">

					<!-- START #contactForm -->
					<section id="signup-form">
						<form action="addTour" method="Post" enctype="multipart/form-data">
							<ul class="formFields list-unstyled">
								<li class="row">
									<div class="col-md-6"></div>
								</li>
							</ul>
							<div class="row"
								style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px;">
								<div>
									<label style="font-size: 24px;">Basic Tour Details</label>
								</div>
								<div class="col-md-12">
									<div class="col-md-6">
										<label>Tour Name <span class="required small">(Required)</span></label>
										<input type="text" class="form-control" name="name" value=""
											required />
									</div>
									<div class="col-md-6">
										<label>Tour Status</label> <select name="tour_status"
											id="tour_status" class="form-control">
											<option disabled="disabled" selected="selected">Choose
												Status</option>
											<option value="1">Active</option>
											<option value="0">In-Active</option>
										</select>

									</div>
								</div>
								<div class="col-md-12">
									<div class="col-md-6">
										<label>Tour Duration <span class="required small">(Required)</span></label>
										<input type="text" class="form-control" name="duration"
											value="" required />
									</div>
									<div class="col-md-6">
										<label>Category </label><select
											name="category" id="category" class="form-control">
											<option disabled="disabled" selected="selected">Choose
												Category</option>
											<option value="1">Hill Station</option>
											<option value="2">City</option>
											<option value="3">Beach</option>
											<option value="4">Wildlife</option>
										</select>
									</div>
								</div>
								<div class="col-md-12">
									<div class="col-md-6">
										<label>Adult Cost <span class="required small">(Required)</span></label>
										<input type="text" name="adult_price" id="adult_price"
											class="form-control" required />
									</div>

									<div class="col-md-6">
										<label>Child Cost <span class="required small">(Required)</span>
										</label> <input type="text" name="child_price" id="child_price"
											class="form-control" required />
									</div>
								</div>
							</div>


							<div class="row"
								style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px;">
								<div>
									<label style="font-size: 24px;">Add Hotel Details</label>
								</div>
								<div class="col-md-6">
									<label>Tour State </label> <input name="tour_state"
										id="tour_state" class="form-control">
									<div>
										<button type="button" style="margin: 5px;" id="getHotelBtn"
											onclick="getHotelsAjax()">Get Hotels</button>
									</div>
								</div>

								<div class="col-md-6">
									<div class="col-md-12"
										style="text-align: center; display: none" id="HotelHeadingDiv">
										<label>Select Hotels</label>
									</div>
									<div class="col-md-12" id="hotelDiv"></div>
								</div>
							</div>

							<div id="tour_info_1" class="row"
								style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px; display: none;">
								<div>
									<label style="font-size: 24px;">Tour Info Part-1</label>
								</div>
								<div class="col-md-6">
									<label>Description </label>
									<textarea name="description" id="address2" cols="45" rows="8"
										class="form-control"></textarea>
								</div>
								<div class="col-md-6">
									<label>Itinerary </label>
									<textarea name="iternary" id="iternary" cols="80" rows="8"
										class="form-control"></textarea>
								</div>
							</div>
							<div id="tour_info_2" class="row"
								style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px; display: none;">
								<div>
									<label style="font-size: 24px;">Tour Info Part-2</label>
								</div>
								<div class="col-md-6">
									<label>Inclusions</label>
									<textarea name="inclusion" id="inclusion" cols="45" rows="8"
										class="form-control"></textarea>
								</div>
								<div class="col-md-6">
									<label>Exclusions</label>
									<textarea name="exclusion" id="exclusion" cols="45" rows="8"
										class="form-control"></textarea>
								</div>
							</div>

							<div id="tour_info_3" class="row"
								style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px; display: none;">
								<div>
									<label style="font-size: 24px;">Tour Images</label>
								</div>
								<div>
									<div class="col-md-4">
										<label>Image 1</label> <input type="file" name="image1"
											id="image1" class="form-control" />
									</div>
									<div class="col-md-4">
										<label>Image 2</label> <input type="file" name="image2"
											id="image2" class="form-control" />
									</div>

									<div class="col-md-4">
										<label>Image 3</label> <input type="file" name="image3"
											id="image3" class="form-control" />
									</div>
								</div>
							</div>


							<div id="tour_photos" class="row" style="display: none;">
								<div class="col-md-12">
									<input type="submit" class="btn btn-primary btn-lg text-upper"
										name="submit" value="Add Tour" />

								</div>
							</div>


						</form>
					</section>
				</div>
			</div>
			<!-- END #contactForm -->
		</div>
		<!-- END #page -->
	</div>
	</div>
	<!-- END .main-contents -->

	<!-- START footer -->
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


</body>
<script type="text/javascript">
	function getHotelsAjax() {
		var prepareDataSet = {
			tourState : document.getElementById('tour_state').value,
		}
		$
				.ajax({
					type : "POST",
					json : true, // added this
					url : 'fetchHotelInfo',
					'Content-Type' : 'application/x-www-form-urlencoded',
					data : prepareDataSet,
					async : false,
					success : function(json) {
						document.getElementById("HotelHeadingDiv").style.display = "block";
						document.getElementById("getHotelBtn").style.display = "none";
						for (var i = 0; i < json.length; i++) {
							createHotelCheckBoxList(json[i]);
						}
						displayOtherBlocks();

					},
					error : function(e) {
						alert("System Error");
					}

				});

	}
	function createHotelCheckBoxList(json) {
		var hotelCheckBoxDiv = document.createElement("div");
		hotelCheckBoxDiv.setAttribute("class", "col-md-5");
		hotelCheckBoxDiv.style.margin = "10px";
		var hotelCheckBox = document.createElement("INPUT");
		hotelCheckBox.setAttribute("type", "checkbox");
		hotelCheckBox.setAttribute("name", "hotel_" + json['id']);
		hotelCheckBox.style.position = "absolute";
		hotelCheckBox.style.marginLeft = "5px";
		hotelCheckBox.id = "hotel_" + json['id'];
		var hotelNameLabel = document.createElement('label');
		hotelNameLabel.setAttribute("for", "hotel_" + json['id']);
		var hotelName = document.createTextNode(json['name'] + ","
				+ json['address']);
		hotelNameLabel.appendChild(hotelName)

		hotelCheckBoxDiv.appendChild(hotelNameLabel);
		hotelCheckBoxDiv.appendChild(hotelCheckBox);
		document.getElementById("hotelDiv").appendChild(hotelCheckBoxDiv);

	}
	function displayOtherBlocks() {
		document.getElementById("tour_info_1").style.display = "block";
		document.getElementById("tour_info_2").style.display = "block";
		document.getElementById("tour_info_3").style.display = "block";
		document.getElementById("tour_photos").style.display = "block";
	}
</script>
</html>
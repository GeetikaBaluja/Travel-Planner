<!DOCTYPE html>
<html lang="en" dir="ltr">

<!-- START head -->
<head>
<!-- Site meta charset -->
<meta charset="UTF-8">

<!-- title -->
<title>Update Tour</title>

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
	tinymce.init({
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
							<h1 class="text-upper">Update Tour</h1>
						</section>

						<!-- breadcrumbs -->
						<section class="col-sm-6">
							<ol class="breadcrumb">
								<li class="home"><a href="adminpanel.jsp">Admin Panel</a></li>
								<li class="active">Update Tour</li>
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
						<form action="updateTourDetails" method="post"
							enctype="multipart/form-data">
							<fieldset>
								<div class="row"
									style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px;">
									<div>
										<label style="font-size: 24px;">Basic Tour Details</label>
									</div>
									<div class="col-md-12">
										<div class="col-md-6">
											<label>Tour Name <span class="required small">(Required)</span></label>
											<input type="text" class="form-control" name="name"
												value="<%=request.getAttribute("name")%>" required /> <input
												type="hidden" id="tour_id" name="tour_id"
												value="<%=request.getAttribute("tour_id")%>">
										</div>
										<div class="col-md-6">
											<label>Tour Status</label> <select name="tour_status"
												id="tour_status" class="form-control">
												<option id="-1" disabled="disabled" selected="selected">Choose
													Status</option>
												<option id="1" value="1">Active</option>
												<option id="0" value="0">In-Active</option>
											</select> <input type="hidden" id="tour_status_temp"
												value="<%=request.getAttribute("tour_status")%>">
										</div>
									</div>
									<div class="col-md-12">
										<div class="col-md-6">
											<label>Tour Duration <span class="required small">(Required)</span></label>
											<input type="text" class="form-control" name="duration"
												value="<%=request.getAttribute("duration")%>" required />
										</div>
										<div class="col-md-6">
											<label>Category </label> <label>Choose Category</label> <select
												name="category" id="category" class="form-control">
												<option id="-1" disabled="disabled" selected="selected">Choose
													Category</option>
												<option id="1" value="1">Hill Station</option>
												<option id="2" value="2">City</option>
												<option id="3" value="3">Beach</option>
												<option id="4" value="4">Wild-life</option>
											</select> <input type="hidden" id="category_temp"
												value="<%=request.getAttribute("category")%>">
										</div>
									</div>
									<div class="col-md-12">
										<div class="col-md-6">
											<label>Price </label> <input name="adult_price" type="text"
												required class="form-control" id="adult_price"
												value="<%=request.getAttribute("adult_price")%>" />
										</div>
										<div class="col-md-6">
											<label>Children Cost <span class="required small">(Required)</span>
											</label> <input type="text" name="child_price" id="child_price"
												class="form-control"
												value="<%=request.getAttribute("child_price")%>" required />
										</div>
									</div>
								</div>
								<div class="row"
									style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px;">
									<div>
										<label style="font-size: 24px;">Tour Info Part-1</label>
									</div>
									<div class="col-md-6">
										<label>Description </label>
										<textarea name="description" id="address2" cols="45" rows="8"
											class="form-control"><%=request.getAttribute("description")%></textarea>
									</div>

									<div class="col-md-6">
										<label>Iternary </label>
										<textarea name="iternary" id="iternary" cols="80" rows="8"
											class="form-control"><%=request.getAttribute("iternary")%></textarea>
									</div>
								</div>


								<div class="row"
									style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px;">
									<div>
										<label style="font-size: 24px;">Tour Info Part-2</label>
									</div>
									<div class="col-md-6">
										<label>Inclusion</label>
										<textarea name="inclusion" id="inclusion" cols="45" rows="8"
											class="form-control"><%=request.getAttribute("inclusion")%></textarea>
									</div>


									<div class="col-md-6">
										<label>Exclusions</label>
										<textarea name="exclusion" id="exclusion" cols="45" rows="8"
											class="form-control"><%=request.getAttribute("exclusion")%></textarea>
									</div>
								</div>
								<div class="row"
									style="box-shadow: 2px 5px 12px 6px; padding: 10px; margin: 25px; border-radius: 10px;">
									<div>
										<label style="font-size: 24px;">Tour Images</label>
									</div>
									<div>
										<div class="col-md-4">
											<div>
												<label>Image 1</label>
											</div>
											<img style="display: block; margin: 0 auto;"
												src='uploads/<%=request.getAttribute("image1")%>'
												width=100px height=100px> <input type="file"
												name="image1" id="image1" class="form-control" /> <input
												type="hidden" id="image1_hidden" name="image1_hidden"
												value="<%=request.getAttribute("image1")%>">
										</div>
										<div class="col-md-4">
											<div>
												<label>Image 2</label>
											</div>
											<img style="display: block; margin: 0 auto;"
												src='uploads/<%=request.getAttribute("image2")%>'
												width=100px height=100px> <input type="file"
												name="image2" id="image2" class="form-control" /> <input
												type="hidden" id="image2_hidden" name="image2_hidden"
												value="<%=request.getAttribute("image2")%>">
										</div>

										<div class="col-md-4">
											<div>
												<label>Image 3</label>
											</div>
											<img style="display: block; margin: 0 auto;"
												src='uploads/<%=request.getAttribute("image3")%>'
												width=100px height=100px> <input type="file"
												name="image3" id="image3" class="form-control" /> <input
												type="hidden" id="image3_hidden" name="image3_hidden"
												value="<%=request.getAttribute("image3")%>">
										</div>

									</div>
								</div>

								<li class="row">
									<div class="col-md-12">
										<input type="submit" class="btn btn-primary btn-lg text-upper"
											name="submit" value="Update Tour" />

									</div>
								</li>
								</ul>
							</fieldset>
						</form>
					</section>
					<!-- END #contactForm -->
				</div>
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


</body>
<script>
	window.onload = function() {
		setTourStatusValue();
		setTourCategoryValue();
	};

	function setTourStatusValue() {
		var tourStatusValue = document.getElementById('tour_status_temp');
		var tourStatus = document.getElementById('tour_status');
		for (var i = 0; i < tourStatus.options.length; i++) {
			if (tourStatus.options[i].id == tourStatusValue.value) {
				tourStatus.options[i].selected = true;
				break;
			}
		}
	}
	function setTourCategoryValue() {
		var tourStatusValue = document.getElementById('category_temp');
		var tourStatus = document.getElementById('category');
		for (var i = 0; i < tourStatus.options.length; i++) {
			if (tourStatus.options[i].id == tourStatusValue.value) {
				tourStatus.options[i].selected = true;
				break;
			}
		}
	}
</script>
</html>
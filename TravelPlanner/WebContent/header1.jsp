
<header>
	<!-- START #top-header -->
	<div id="top-header">
		<div class="container">
			<div class="row"
				style="line-height: 0; margin-top: 8px; background-color: black;">
				<div class="col-md-12">
					<div style="float: right;">
						<span class="top-link small"> <%
 	if (session.getAttribute("admin") != null) {
 		out.println("<font color='black'>Welcome " + session.getAttribute("admin") + "</font>");
 	} else {
 		response.sendRedirect("login.jsp");
 	}
 %>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END #top-header -->

	<!-- START #main-header -->
	<div id="main-header">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<a id="site-logo" href="#"> <img
						src="img/Travel_Planner_logo.png" alt="Travel Planner" width="120" />
					</a>
				</div>
				<div class="col-md-9">
					<nav class="main-nav">
						<span>MENU</span>
						<ul id="main-menu">
							<li><a href="adminpanel.jsp" title="">Home</a></li>
							<li><a title="" href="addtour.jsp">Add Tour</a></li>
							<li><a title="" href="fetchBookingRecords">Bookings</a></li>
							<li>
								<%
									if (session.getAttribute("admin") != null) {
										out.println("<a href='logout'>Signout</a>");
									}
								%>


							</li>

						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- END #main-header -->
</header>
<!-- END header -->
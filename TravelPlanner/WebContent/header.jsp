
<header>
	<!-- START #top-header -->
	<div id="top-header">
		<div class="container">
			<div class="row"
				style="line-height: 0; margin-top: 8px; background-color: black;">
				<div class="col-md-12">
					<div style="float: right;">
						<span class="top-link small"> <%
 	if (session.getAttribute("uname") != null) {
 		out.println("<font color='black'>Welcome " + session.getAttribute("uname") + "</font>");
 	} else if (session.getAttribute("admin") != null) {
 		out.println("<font color='black'>Welcome " + session.getAttribute("admin")
 				+ " | <a href=adminpanel.jsp>Admin Panel</a></font>");
 	} else {
 		out.println("Welcome Guest");
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
							<li><a href="index.jsp" title="">HOME</a>
							<li><a title="">TOURS</a>
								<ul>
									<li><a href="lookForPlacesController?cat=1" title="">Hill
											Station</a></li>
									<li><a href="lookForPlacesController?cat=2" title="">City</a></li>
									<li><a href="lookForPlacesController?cat=3" title="">Beach</a></li>
									<li><a href="lookForPlacesController?cat=4" title="">Wildlife</a></li>
								</ul></li>


							<%
								if (session.getAttribute("uname") != null) {
									out.println("<li><a href='customerTourBooking'>Profile</a></li>");
									out.println("<li><a href='logout'>Sign out</a></li>");
								} else if (session.getAttribute("admin") != null) {
									out.println("<li><a href='logout'>Sign out</a></li>");
								} else {
									out.println("<li><a href='login.jsp'>Login</a> </li><li> <a href='signup.jsp'>Sign up</a></li>");
								}
							%>

						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id=logged_in_user name="logged_in_user"
		value='<%=session.getAttribute("uname")%>'>
	<!-- END #main-header -->
</header>
<!-- END header -->
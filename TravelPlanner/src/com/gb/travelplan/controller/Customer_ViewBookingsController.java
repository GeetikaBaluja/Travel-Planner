package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/customerTourBooking")
public class Customer_ViewBookingsController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder pageResponse = new StringBuilder();
		StringBuilder pageResponse1 = new StringBuilder();
		HttpSession session = request.getSession();
		try {
			getAllTourBookingsOfCustomer(request, response, session, pageResponse, pageResponse1);
		} catch (SQLException | ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("pageResponse", pageResponse.toString());
		request.setAttribute("pageResponse1", pageResponse1.toString());
		request.getRequestDispatcher("/viewcustomertourbookings.jsp").forward(request, response);

	}

	private void getAllTourBookingsOfCustomer(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, StringBuilder midbox2Response, StringBuilder pageResponseForForm)
			throws SQLException, ServletException, IOException {
		StringBuilder topbox1Response = new StringBuilder();
		StringBuilder topbox2Response = new StringBuilder();
		StringBuilder midbox1Response = new StringBuilder();
		StringBuilder midbox3Response = new StringBuilder();
		int totalBookingCount = 0;
		int confirmedBookingCount = 0;
		int pendingBookingCount = 0;
		int cancelledBookingCount = 0;
		Connection myconnection = null;
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();
			String q1 = "select * from tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid inner join tourismdb.usertable u on b.username=u.emailid where b.username like ? order by requestdate desc";
			PreparedStatement mystatement = myconnection.prepareStatement(q1);
			mystatement.setString(1, (String) session.getAttribute("emailid"));
			ResultSet myresult = mystatement.executeQuery();
			String fetchUserDetails = "select * from tourismdb.usertable where emailid=? ";
			PreparedStatement fetchUserDetailsStatement = myconnection.prepareStatement(fetchUserDetails);
			fetchUserDetailsStatement.setString(1, (String) session.getAttribute("emailid"));
			ResultSet fetchUserDetailsResultSet = fetchUserDetailsStatement.executeQuery();
			if (myresult.next()) {
				int rowcount = 0;
				midbox2Response.append("<table class='table'align='center'>");
				midbox2Response.append(
						"<tr style='color:white;background:black'><th class=\"col-md-2\">Tour</th><th class=\"col-md-1\">Departure Date</th><th class=\"col-md-1\">Return Date</th><th class=\"col-md-1\">Booking Status</th></tr>");
				do {
					if (myresult.getString("booking_status").equalsIgnoreCase("Confirmed")) {
						confirmedBookingCount++;
					} else if (myresult.getString("booking_status").equalsIgnoreCase("Pending")) {
						pendingBookingCount++;
					} else if (myresult.getString("booking_status").equalsIgnoreCase("Cancelled")) {
						cancelledBookingCount++;
					}
					totalBookingCount++;

					pageResponseForForm.append("<div><form id='form" + rowcount
							+ "' action='getBookedTourDetails' method='POST'><input type=hidden name='bookingId' id='bookingId' value='"
							+ myresult.getString("srno") + "' /></form></div>");
					midbox2Response.append(
							"<tr class=bookings onclick=document.getElementById(\"form" + rowcount + "\").submit()>");

					midbox2Response.append("<td class=\"col-md-2\">" + myresult.getString("t.name") + "</td>");
//						pageResponse.append("<td>" + "<a href='tourInfo?id=" + myresult.getString("tourid") + ">"
//								+ myresult.getString("t.name") + "</a></td>");
					midbox2Response.append("<td class=\"col-md-1\">" + myresult.getString("ddate") + "</td>");
					midbox2Response.append("<td class=\"col-md-1\">" + myresult.getString("rdate") + "</td>");
//						pageResponse.append("<td>" + myresult.getString("persons") + "</td>");
					midbox2Response.append("<td class=\"col-md-1\">" + myresult.getString("booking_status") + "</td>");
					midbox2Response.append("</tr>");
					rowcount++;
				} while (myresult.next());
				midbox3Response.append("</div>");
				midbox2Response.append("</table>");
			} else {
				midbox2Response.append("<h3 align='center'>No Bookings available yet</h3>");
			}
			if (fetchUserDetailsResultSet.next()) {
				setTopBox1Response(topbox1Response, fetchUserDetailsResultSet);
				setTopBox2Response(topbox2Response, fetchUserDetailsResultSet);
				setMidBox1Response(midbox1Response, fetchUserDetailsResultSet, totalBookingCount, confirmedBookingCount,
						pendingBookingCount, cancelledBookingCount);
			}

			setMidBox3Response(midbox3Response, myconnection, session);
			request.setAttribute("midbox1Response", midbox1Response);
			request.setAttribute("midbox3Response", midbox3Response);
			request.setAttribute("box1Response", topbox1Response);
			request.setAttribute("box2Response", topbox2Response);
		} catch (

		Exception e) {
			request.setAttribute("errMsg", "System Error");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} finally {
			myconnection.close();
		}
	}

	private void setTopBox2Response(StringBuilder topbox2Response, ResultSet myresult) throws SQLException {

		topbox2Response.append("<p>" + myresult.getString("house_number") + "</p>" + "<p>"
				+ myresult.getString("street_name") + "," + myresult.getString("city") + "</p>" + "<p>"
				+ myresult.getString("state") + "," + myresult.getString("pincode") + "</p>");
	}

	private void setTopBox1Response(StringBuilder topbox1Response, ResultSet myresult) throws SQLException {
		topbox1Response.append("<div style='color:white;'><table><tr><td>Phone</td><td>" + myresult.getString("phone")
				+ "</td></tr><tr><td>Email</td><td>" + myresult.getString("emailid") + "</td></tr></table></div>");
	}

	private void setMidBox3Response(StringBuilder midbox3Response, Connection myconnection, HttpSession session)
			throws SQLException {
		String fetchFeedbackAndBookingTourQuery = "select * from tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid inner join tourismdb.user_feedback f on f.booking_id=b.srno where b.username like ?";
		PreparedStatement fetchFeedbackAndBookingTourStatement = myconnection
				.prepareStatement(fetchFeedbackAndBookingTourQuery);
		fetchFeedbackAndBookingTourStatement.setString(1, (String) session.getAttribute("emailid"));
		ResultSet fetchFeedbackAndBookingTourResultSet = fetchFeedbackAndBookingTourStatement.executeQuery();
		if (fetchFeedbackAndBookingTourResultSet.next()) {
//			midbox3Response.append("<div>");
			do {

				midbox3Response.append(
						"<div style='height: 190px;'><marquee behavior='scroll' direction='up' scrollamount='2'><label  style='background-color: gray; color: white; border-radius: 10px; padding: 10px;'><p>"
								+ fetchFeedbackAndBookingTourResultSet.getString("t.name") + "</p>");
				highlightStars(midbox3Response, fetchFeedbackAndBookingTourResultSet.getString("f.user_rating"));
				midbox3Response.append("</label></marquee></div>");
			} while (fetchFeedbackAndBookingTourResultSet.next());
		} else {
			midbox3Response.append("<p align='center'>No Feedback available yet</p>");
		}
//		midbox3Response.append("</div>");
	}

	private void highlightStars(StringBuilder midbox3Response, String userRating) throws SQLException {
		int totalStars = 5;
		int checkedStar = Integer.parseInt(userRating);
		int uncheckedStar = totalStars - checkedStar;
		for (int i = 0; i < checkedStar; i++) {
			midbox3Response.append("<span class=\"fa fa-star checked\" name=\"star_ratings\"></span>");
		}
		for (int i = 0; i < uncheckedStar; i++) {
			midbox3Response.append("<span class=\"fa fa-star\" name=\"star_ratings\"></span>");
		}
	}

	private void setMidBox1Response(StringBuilder midbox1Response, ResultSet fetchUserDetailsResultSet,
			int totalBookingCount, int confirmedBookingCount, int pendingBookingCount, int cancelledBookingCount)
			throws SQLException {
		midbox1Response.append("<p>Member Since: <label>" + fetchUserDetailsResultSet.getString("registeration_date")
				+ "</label></p><p>Total Bookings: <label style=\" background-color: deepskyblue; color: white; border-radius: 10px; padding: 2px;\">"
				+ totalBookingCount + "</label></p>"
				+ "<p>Confirmed Bookings: <label style=\" background-color: lawngreen; color: black; border-radius: 20px; padding: 2px;\">"
				+ confirmedBookingCount
				+ "</label></p><p>Pending Bookings: <label style=\" background-color: yellow; border-radius: 20px; padding: 2px;\">"
				+ pendingBookingCount
				+ "</label></p><p>Cancelled Bookings: <label style=\" background-color: red; color: white; border-radius: 20px; padding: 2px;\">"
				+ cancelledBookingCount + "</label></p>");
	}

}

package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/getBookedTourDetails")
public class Customer_BookedTourDetails extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		getCustomerSelectedTourInformation(request);
//		request.setAttribute("pageResponse", pageResponse.toString());
		request.getRequestDispatcher("/changeCustomerBookingStatus.jsp").forward(request, response);
	}

	private void getCustomerSelectedTourInformation(HttpServletRequest request) {
		Connection myconnection = null;
		StringBuilder hotelResponse = new StringBuilder();
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();
			try {
				String q1 = "SELECT * FROM tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid inner join tourismdb.tours_hotels th on t.tourid=th.tour_id inner join tourismdb.hotel_info hi on th.hotel_id=hi.hotel_id  left join tourismdb.user_feedback f on f.booking_id=b.srno where srno=?";
				PreparedStatement mystatement = myconnection.prepareStatement(q1);
				mystatement.setString(1, request.getParameter("bookingId"));// TODO Auto-generated method stub
				ResultSet myresult = mystatement.executeQuery();
				if (myresult.next()) {
					request.setAttribute("bookingId", request.getParameter("bookingId"));
					request.setAttribute("travelDate", myresult.getString("b.ddate"));
					request.setAttribute("adults", myresult.getString("b.adults"));
					request.setAttribute("children", myresult.getString("b.children"));
					request.setAttribute("touringDaysCount", myresult.getString("b.booking_days"));
					request.setAttribute("totalTourCost", myresult.getString("b.booking_cost"));
					request.setAttribute("tourId", myresult.getString("t.tourid"));
					request.setAttribute("tourName", myresult.getString("t.name"));
					request.setAttribute("tourStatus", myresult.getString("b.booking_status"));
					request.setAttribute("returnDate", myresult.getString("b.rdate"));
					request.setAttribute("requestDate", myresult.getString("b.requestdate"));
					request.setAttribute("roomsbooked", myresult.getString("b.room_bookings"));
					if (myresult.getInt("f.s_no") > 0) {
						request.setAttribute("feedbackSubmitted", true);
					} else {
						request.setAttribute("feedbackSubmitted", false);
					}
					request.setAttribute("feedbackSubmissionDate", myresult.getString("f.feedback_submission_date"));

					if (!myresult.getString("b.booking_status").equalsIgnoreCase("Cancelled")) {
						request.setAttribute("cancelBtnDisable", "false");
					} else {
						request.setAttribute("cancelBtnDisable", "true");
					}

					do {
						hotelResponse.append("<tr><td><span>Hotel: </span></td>" + "<td style='font-weight: bold;'><span>"
								+ myresult.getString("hotel_name") + ",</span><span>"
								+ myresult.getString("hotel_street_address")
								+ "</span></td><td><span>Rooms Booked: </span></td>" + "<td><span>"
								+ myresult.getString("b.room_bookings") + "</span></td></tr>");
					} while (myresult.next());
				}
				request.setAttribute("hotelResponse", hotelResponse);
			} catch (Exception e) {
//				pageResponse.append("Error in Query " + e.getMessage());
			} finally {
				myconnection.close();
			}
		} catch (Exception e) {
//			pageResponse.append("Error in Connection " + e.getMessage());
		}

	}
}

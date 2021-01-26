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

import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;
import com.gb.travelplan.utility.MessagingService;

@WebServlet(urlPatterns = "/performBookingAction")
public class Admin_BookingAction extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			performBookingAction(request, response);
		} catch (IOException | JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void performBookingAction(HttpServletRequest request, HttpServletResponse response)
			throws IOException, JSONException {
		String bookingAction = request.getParameter("bookingAction");
		String bookingId = request.getParameter("bookingId");
		JSONObject responseObj = new JSONObject();
		Connection myconnection;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			if (bookingAction.equals("0")) {
				String cancelBookingByBookingId = "update tourismdb.bookingrequest set booking_status='Cancelled' where srno=?";
				PreparedStatement cancelBookingByBookingIdStatement = myconnection
						.prepareStatement(cancelBookingByBookingId);
				cancelBookingByBookingIdStatement.setString(1, bookingId);
				int isSuccessful = cancelBookingByBookingIdStatement.executeUpdate();
				if (isSuccessful > 0) {
					responseObj.put("response", "Booking Cancelled for Id:" + bookingId);
					informUserByMessage(request, myconnection, bookingAction);
				}
			} else if (bookingAction.equals("1")) {
				String confirmBookingByBookingId = "update tourismdb.bookingrequest set booking_status='Confirmed' where srno=?";
				PreparedStatement confirmBookingByBookingIdStatement = myconnection
						.prepareStatement(confirmBookingByBookingId);
				confirmBookingByBookingIdStatement.setString(1, bookingId);
				int isSuccessful = confirmBookingByBookingIdStatement.executeUpdate();
				if (isSuccessful > 0) {
					responseObj.put("response", "Booking Confirmed for Id:" + bookingId);
					informUserByMessage(request, myconnection, bookingAction);
				}

			} else {
				responseObj.put("response", "Invalid Request");
			}

		} catch (Exception e) {
			e.printStackTrace();
			responseObj.put("response", "System Failure");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(responseObj);
	}

	private void informUserByMessage(HttpServletRequest request, Connection myconnection, String bookingAction)
			throws SQLException {
		String userQuery = "SELECT * FROM tourismdb.bookingrequest b inner join tourismdb.usertable u on b.username=u.emailid inner join tourismdb.tours t ON t.tourid=b.tourid where b.srno=?";
		PreparedStatement userDetailsStatement = myconnection.prepareStatement(userQuery);
		userDetailsStatement.setString(1, request.getParameter("bookingId"));
		ResultSet userDetails = userDetailsStatement.executeQuery();
		if (userDetails.next()) {
			String msgResponse = null;
			if ("1".equals(bookingAction)) {
				msgResponse = "Hi " + userDetails.getString("name") + " Your Booking for "
						+ userDetails.getString("t.name") + " with Booking Ref Id " + request.getParameter("bookingId")
						+ " is " + "Confirmed";
			} else {
				msgResponse = "Hi " + userDetails.getString("name") + " Your Booking for "
						+ userDetails.getString("t.name") + " with Booking Ref Id " + request.getParameter("bookingId")
						+ " is " + "Cancelled";
			}
			MessagingService msgService = new MessagingService(userDetails.getString("phone"), msgResponse);

			msgService.sendMessage();
		}
	}

}

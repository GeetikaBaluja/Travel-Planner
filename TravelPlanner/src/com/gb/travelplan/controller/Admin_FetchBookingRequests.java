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

@WebServlet(urlPatterns = "/fetchBookingRecords")
public class Admin_FetchBookingRequests extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder pendingRequestResponse = new StringBuilder();
		StringBuilder confirmRequestResponse = new StringBuilder();
		StringBuilder cancelledRequestResponse = new StringBuilder();
		prepareBookingResponse(pendingRequestResponse, confirmRequestResponse, cancelledRequestResponse, request);
		request.getRequestDispatcher("/viewbookingrequests.jsp").forward(request, response);

	}

	private void prepareBookingResponse(StringBuilder pendingRequestResponse, StringBuilder confirmRequestResponse,
			StringBuilder cancelledRequestResponse, HttpServletRequest request) {
		Connection myconnection = null;
		StringBuilder confirmRequestForm = new StringBuilder();
		StringBuilder pendingRequestForm = new StringBuilder();
		StringBuilder cancelledRequestForm = new StringBuilder();
		int totalBookingCount = 0;
		int confirmedBookingCount = 0;
		int pendingBookingCount = 0;
		int cancelledBookingCount = 0;

		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String fetchAllBookings = "select * from tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid inner join tourismdb.usertable u on b.username=u.emailid order by b.ddate asc ";
			PreparedStatement fetchAllBookingsStatement = myconnection.prepareStatement(fetchAllBookings);
			ResultSet fetchAllBookingsResult = fetchAllBookingsStatement.executeQuery();
			if (fetchAllBookingsResult.next()) {

				do {
					if (fetchAllBookingsResult.getString("booking_status").equalsIgnoreCase("Confirmed")) {
						confirmedBookingCount++;

						confirmRequestResponse.append("<tr class=bookings onclick=fetchRecordByBookingIdAjax('"
								+ fetchAllBookingsResult.getString("b.srno") + "')>");
						confirmRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("b.srno") + "</td>");
						confirmRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("u.name") + "</td>");
						confirmRequestResponse.append(
								"<td class=\"col-md-2\">" + fetchAllBookingsResult.getString("t.name") + "</td>");
						confirmRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("b.ddate") + "</td>");
						confirmRequestResponse.append("</tr>");

					} else if (fetchAllBookingsResult.getString("booking_status").equalsIgnoreCase("Pending")) {
						pendingBookingCount++;
						pendingRequestResponse.append("<tr class=bookings onclick=fetchRecordByBookingIdAjax('"
								+ fetchAllBookingsResult.getString("b.srno") + "')>");
						pendingRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("b.srno") + "</td>");
						pendingRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("u.name") + "</td>");
						pendingRequestResponse.append(
								"<td class=\"col-md-2\">" + fetchAllBookingsResult.getString("t.name") + "</td>");
						pendingRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("b.ddate") + "</td>");
						pendingRequestResponse.append("</tr>");
					} else if (fetchAllBookingsResult.getString("booking_status").equalsIgnoreCase("Cancelled")) {
						cancelledBookingCount++;
						cancelledRequestResponse.append("<tr class=bookings onclick=fetchRecordByBookingIdAjax('"
								+ fetchAllBookingsResult.getString("b.srno") + "')>");
						cancelledRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("b.srno") + "</td>");
						cancelledRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("u.name") + "</td>");
						cancelledRequestResponse.append(
								"<td class=\"col-md-2\">" + fetchAllBookingsResult.getString("t.name") + "</td>");
						cancelledRequestResponse.append(
								"<td class=\"col-md-1\">" + fetchAllBookingsResult.getString("b.ddate") + "</td>");
						cancelledRequestResponse.append("</tr>");
					}

				} while (fetchAllBookingsResult.next());

			}
			if (confirmedBookingCount == 0) {
				confirmRequestResponse
						.append("<tr><td colspan='4' style='text-align: center;'>No Record Available...</td></tr>");
			}
			if (pendingBookingCount == 0) {
				pendingRequestResponse
						.append("<tr><td colspan='4' style='text-align: center;'>No Record Available...</td></tr>");
			}
			if (cancelledBookingCount == 0) {
				cancelledRequestResponse
						.append("<tr><td colspan='4' style='text-align: center;'>No Record Available...</td></tr>");
			}
			request.setAttribute("confirmedBookingCount", confirmedBookingCount);
			request.setAttribute("pendingBookingCount", pendingBookingCount);
			request.setAttribute("cancelledBookingCount", cancelledBookingCount);

			request.setAttribute("confirmRequestForm", confirmRequestForm);
			request.setAttribute("pendingRequestForm", pendingRequestForm);
			request.setAttribute("cancelledRequestForm", cancelledRequestForm);

		} catch (Exception e) {
			pendingRequestResponse.delete(0, pendingRequestResponse.length());
			pendingRequestResponse.append("<tr><td colspan='4' style='text-align: center;'>System Error.</td></tr>");
			confirmRequestResponse.delete(0, confirmRequestResponse.length());
			confirmRequestResponse.append("<tr><td colspan='4' style='text-align: center;'>System Error.</td></tr>");
			cancelledRequestResponse.delete(0, cancelledRequestResponse.length());
			cancelledRequestResponse.append("<tr><td colspan='4' style='text-align: center;'>System Error.</td></tr>");
		}
		request.setAttribute("confirmRequestResponse", confirmRequestResponse);
		request.setAttribute("pendingRequestResponse", pendingRequestResponse);
		request.setAttribute("cancelledRequestResponse", cancelledRequestResponse);
	}
}
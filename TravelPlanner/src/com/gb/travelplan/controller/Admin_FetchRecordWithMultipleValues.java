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

import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchRecordByBookingWithMVs")
public class Admin_FetchRecordWithMultipleValues extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fetchBookingRecordWithMVs(request, response);
		} catch (JSONException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void fetchBookingRecordWithMVs(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, IOException {
		Connection myconnection;
		JSONObject responseObj = new JSONObject();
		StringBuilder bookingListResponse = new StringBuilder();
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String fetchBooking = "select * from tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid inner join tourismdb.usertable u on b.username=u.emailid where b.username=? and b.ddate=? and u.phone=? ";
			PreparedStatement fetchBookingStatement = myconnection.prepareStatement(fetchBooking);
			fetchBookingStatement.setString(1, request.getParameter("emailId"));
			fetchBookingStatement.setString(2, request.getParameter("travelDate"));
			fetchBookingStatement.setString(3, request.getParameter("contactNo"));
			ResultSet fetchBookingResult = fetchBookingStatement.executeQuery();
			while (fetchBookingResult.next()) {
//				responseObj.put("errMsg", "");
//				responseObj.put("name", fetchBookingResult.getString("u.name"));
//				responseObj.put("phone", fetchBookingResult.getString("u.phone"));
//				responseObj.put("email", fetchBookingResult.getString("b.username"));
//				responseObj.put("bookingId", fetchBookingResult.getString("b.srno"));
//				responseObj.put("travelDate", fetchBookingResult.getString("b.ddate"));
//				responseObj.put("children", fetchBookingResult.getString("b.children"));
//				responseObj.put("touringDaysCount", fetchBookingResult.getString("b.booking_days"));
//				responseObj.put("totalTourCost", fetchBookingResult.getString("b.booking_cost"));
//				responseObj.put("tourName", fetchBookingResult.getString("t.name"));
//				responseObj.put("tourStatus", fetchBookingResult.getString("b.booking_status"));
//				responseObj.put("returnDate", fetchBookingResult.getString("b.rdate"));
//				responseObj.put("requestDate", fetchBookingResult.getString("b.requestdate"));
//				responseObj.put("roomsbooked", fetchBookingResult.getString("b.room_bookings"));
				bookingListResponse.append("<tr class=bookings onclick=fetchRecordByBookingIdAjax('"
						+ fetchBookingResult.getString("b.srno") + "')>");
				bookingListResponse
						.append("<td class=\"col-md-1\">" + fetchBookingResult.getString("b.srno") + "</td>");
				bookingListResponse
						.append("<td class=\"col-md-1\">" + fetchBookingResult.getString("u.name") + "</td>");
				bookingListResponse
						.append("<td class=\"col-md-2\">" + fetchBookingResult.getString("t.name") + "</td>");
				bookingListResponse
						.append("<td class=\"col-md-1\">" + fetchBookingResult.getString("b.ddate") + "</td>");
				bookingListResponse.append("</tr>");

			}
			if (bookingListResponse.toString().isEmpty()) {
				responseObj.put("bookingListResponse",
						"<tr><td colspan='4' style='text-align: center;'>No Record Available.</td></tr>");
			} else {
				responseObj.put("bookingListResponse", bookingListResponse);
			}
		} catch (Exception e) {
			responseObj.put("errMsg", "System Error.");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(responseObj);
	}
}

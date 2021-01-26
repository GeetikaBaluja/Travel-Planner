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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchRecordByBookingId")
public class Admin_FetchRecordByBookingId extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fetchBookingByBookingId(request, response);
		} catch (JSONException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void fetchBookingByBookingId(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, IOException {
		Connection myconnection;
		JSONObject responseObj = new JSONObject();
		JSONArray hotelInfoArr = new JSONArray();
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String fetchBookingByBookingId = "select * from tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid inner join tourismdb.tours_hotels th on t.tourid=th.tour_id inner join tourismdb.hotel_info hi on th.hotel_id=hi.hotel_id  inner join tourismdb.usertable u on b.username=u.emailid where b.srno=? ";
			PreparedStatement fetchBookingByBookingIdStatement = myconnection.prepareStatement(fetchBookingByBookingId);
			fetchBookingByBookingIdStatement.setString(1, request.getParameter("bookingId"));
			ResultSet fetchBookingResult = fetchBookingByBookingIdStatement.executeQuery();
			if (fetchBookingResult.next()) {
				responseObj.put("errMsg", "");
				responseObj.put("name", fetchBookingResult.getString("u.name"));
				responseObj.put("phone", fetchBookingResult.getString("u.phone"));
				responseObj.put("email", fetchBookingResult.getString("b.username"));
				responseObj.put("bookingId", fetchBookingResult.getString("b.srno"));
				responseObj.put("travelDate", fetchBookingResult.getString("b.ddate"));
				responseObj.put("adults", fetchBookingResult.getString("b.adults"));
				responseObj.put("children", fetchBookingResult.getString("b.children"));
				responseObj.put("touringDaysCount", fetchBookingResult.getString("b.booking_days"));
				responseObj.put("totalTourCost", fetchBookingResult.getString("b.booking_cost"));
				responseObj.put("tourName", fetchBookingResult.getString("t.name"));
				responseObj.put("tourStatus", fetchBookingResult.getString("b.booking_status"));
				responseObj.put("returnDate", fetchBookingResult.getString("b.rdate"));
				responseObj.put("requestDate", fetchBookingResult.getString("b.requestdate"));
				responseObj.put("roomsbooked", fetchBookingResult.getString("b.room_bookings"));
				do {
					JSONObject hotelInfo = new JSONObject();
					hotelInfo.put("hotelName", fetchBookingResult.getString("hotel_name"));
					hotelInfo.put("hotelAddress", fetchBookingResult.getString("hotel_street_address"));
					hotelInfoArr.put(hotelInfo);

				} while (fetchBookingResult.next());
				responseObj.put("hotelInfoArr", hotelInfoArr);
			} else {
				responseObj.put("errMsg", "No Record Available.");
			}
		} catch (Exception e) {
			responseObj.put("errMsg", "System Error.");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(responseObj);

	}

}

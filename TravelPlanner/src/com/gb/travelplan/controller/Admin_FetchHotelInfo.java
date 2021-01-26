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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchHotelInfo")
public class Admin_FetchHotelInfo extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			fetchHotelInfoByState(request, response);
		} catch (JSONException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void fetchHotelInfoByState(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, SQLException, IOException {
		Connection myconnection = null;
		JSONObject responseObj = new JSONObject();
		String state = request.getParameter("tourState");
		JSONArray hotelInfoArr = new JSONArray();
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();

			String query = "select * from hotel_info where hotel_location like?";
			PreparedStatement mystatement = myconnection.prepareStatement(query);
			mystatement.setString(1, "%" + state + "%");
			ResultSet hotelDetails = mystatement.executeQuery();
			if (hotelDetails.next()) {
				do {
					JSONObject hotelInfo = new JSONObject();
					hotelInfo.put("id", hotelDetails.getString("hotel_id"));
					hotelInfo.put("name", hotelDetails.getString("hotel_name"));
					hotelInfo.put("address", hotelDetails.getString("hotel_street_address"));
					hotelInfoArr.put(hotelInfo);
				} while (hotelDetails.next());
			}

		} catch (Exception e) {

			responseObj.put("", "");
		} finally {
			myconnection.close();
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(hotelInfoArr);
	}
}

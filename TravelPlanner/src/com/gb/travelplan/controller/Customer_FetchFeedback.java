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

import org.json.HTTP;
import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchFeedbackByBookingId")
public class Customer_FetchFeedback extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fetchFeedbackByBookingId(request, response);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void fetchFeedbackByBookingId(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, IOException {
		JSONObject jsonObject = new JSONObject();
		Connection myconnection;
		int bookingId = Integer.valueOf(request.getParameter("bookingId"));
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String query = "select * from user_feedback where booking_id=?";
			PreparedStatement mystatement = myconnection.prepareStatement(query);
			mystatement.setInt(1, bookingId);
			ResultSet myResultSet = mystatement.executeQuery();
			if (myResultSet.next()) {
				do {
					jsonObject.put("response", "");
					jsonObject.put("user_rating", myResultSet.getString("user_rating"));
					jsonObject.put("highlights", myResultSet.getString("user_highlights"));
					jsonObject.put("experience", myResultSet.getString("user_experience"));
				} while (myResultSet.next());
			}

		} catch (Exception e) {
			jsonObject.put("response", "Contact Admin");
			e.printStackTrace();
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonObject);
	}
}

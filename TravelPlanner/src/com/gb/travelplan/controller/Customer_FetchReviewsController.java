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

@WebServlet(urlPatterns = "/fetchReviews")
public class Customer_FetchReviewsController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fetchReviewsByTourId(request, response);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void fetchReviewsByTourId(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, IOException {
		Connection myconnection;
		JSONArray jsonArray = new JSONArray();
		int bookingId = Integer.valueOf(request.getParameter("tourId"));
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String query = "select * from tourismdb.user_feedback f  where f.tour_id=?";
			PreparedStatement mystatement = myconnection.prepareStatement(query);
			mystatement.setInt(1, bookingId);
			ResultSet myResultSet = mystatement.executeQuery();
			if (myResultSet.next()) {
				do {

					JSONObject jsonObject = new JSONObject();
					jsonObject.put("name", myResultSet.getString("f.cust_name"));
					jsonObject.put("user_rating", myResultSet.getString("f.user_rating"));
					jsonObject.put("highlights", myResultSet.getString("f.user_highlights"));
					jsonObject.put("experience", myResultSet.getString("f.user_experience"));
					jsonArray.put(jsonObject);
				} while (myResultSet.next());
			}

		} catch (Exception e) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("response", "Contact Admin");
			jsonArray.put(jsonObject);
			e.printStackTrace();
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonArray);
	}

}

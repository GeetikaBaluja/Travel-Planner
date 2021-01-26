package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/saveFeedback")
public class Customer_SaveFeedbackController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			saveFeedbackIntoDb(request, response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void saveFeedbackIntoDb(HttpServletRequest request, HttpServletResponse response)
			throws IOException, JSONException {
		HttpSession session=request.getSession();
		JSONObject jsonObject = new JSONObject();
		String bookingId = request.getParameter("bookingId");
		String customerName = (String) session.getAttribute("uname");
		String tourId = request.getParameter("tourId");
		String highlights = request.getParameter("highlights");
		String user_rating = request.getParameter("user_rating");
		String experience = request.getParameter("experience");
		String feedback_submission_date = LocalDate.now().toString();
		Connection myconnection;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();

			String query = "insert into user_feedback(booking_id,cust_name,tour_id,user_rating,user_highlights,user_experience,feedback_submission_date) values(?,?,?,?,?,?,?)";
			PreparedStatement mystatement = myconnection.prepareStatement(query);
			mystatement.setString(1, bookingId);
			mystatement.setString(2, customerName);
			mystatement.setString(3, tourId);
			mystatement.setString(4, user_rating);
			mystatement.setString(5, highlights);
			mystatement.setString(6, experience);
			mystatement.setString(7, feedback_submission_date);
			int isRecordAdded = mystatement.executeUpdate();
			if (isRecordAdded > 0) {
				jsonObject.put("response", "Thanks for the your valueable Feeback");
			} else {
				jsonObject.put("response", "Failed to save the Feedback Contact Admin.");
			}

		} catch (Exception e) {
			jsonObject.put("response", "System Failure Contact Admin.");
			e.printStackTrace();
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(jsonObject);

	}
}

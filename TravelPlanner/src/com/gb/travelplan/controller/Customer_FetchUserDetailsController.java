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

@WebServlet(urlPatterns = "/fetchUserDetails")
public class Customer_FetchUserDetailsController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fetchUserDetailsByUserName(request, response);
		} catch (JSONException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void fetchUserDetailsByUserName(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, IOException {
		String userName = request.getParameter("uname");
		Connection myconnection;
		JSONObject userObject = new JSONObject();
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String queryAllDetailsOfUserByName = "SELECT * FROM tourismdb.usertable where name=?";
			PreparedStatement userDetailsStatement = myconnection.prepareStatement(queryAllDetailsOfUserByName);
			userDetailsStatement.setString(1, userName);
			ResultSet userDetailsResultSet = userDetailsStatement.executeQuery();
			if (userDetailsResultSet.next()) {
				userObject.put("emailId", userDetailsResultSet.getString("emailid"));
				userObject.put("phone", userDetailsResultSet.getString("phone"));
			}
		} catch (Exception e) {
			userObject.put("response", "Contact Admin");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(userObject);
	}
}
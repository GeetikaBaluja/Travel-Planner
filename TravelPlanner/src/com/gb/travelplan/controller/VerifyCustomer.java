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
import javax.servlet.http.HttpSession;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/verifyOtp")
public class VerifyCustomer extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		verifyOTP(request, response);
	}

	private void verifyOTP(HttpServletRequest request, HttpServletResponse response) {
		Connection conn;
		try {
			conn = new DatabaseConnection().getDatabaseConnection();
			String fetchUserQuery = "SELECT * FROM tourismdb.usertable where phone=?";
			PreparedStatement fetchUserSt = conn.prepareStatement(fetchUserQuery);
			fetchUserSt.setString(1, request.getParameter("phone"));
			ResultSet rs = fetchUserSt.executeQuery();
			if (rs.next()) {
				String dbOtp = rs.getString("verified_user");
				if (request.getParameter("otp").equals(dbOtp)) {
					if (updateUser(request, conn)) {
						request.setAttribute("successMsg", "Thanks for Verification");
						HttpSession session= request.getSession();
						session.setAttribute("uname", rs.getString("name"));
						session.setAttribute("emailid", rs.getString("emailid"));
						
					}
				} else {
					request.setAttribute("errMsg", "OTP Not Matched,Please Login to Retry!");
				}
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private boolean updateUser(HttpServletRequest request, Connection conn) throws SQLException {
		String updateUserQuery = "UPDATE tourismdb.usertable SET verified_user='#' where phone=?";
		PreparedStatement updateUserSt = conn.prepareStatement(updateUserQuery);
		updateUserSt.setString(1, request.getParameter("phone"));
		if (updateUserSt.executeUpdate() > 0) {
			return true;
		} else {
			return false;
		}
	}
}

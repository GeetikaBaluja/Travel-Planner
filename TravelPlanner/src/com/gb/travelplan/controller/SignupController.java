package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gb.travelplan.utility.DatabaseConnection;
import com.gb.travelplan.utility.MessagingService;

@WebServlet(urlPatterns = "/signup")
public class SignupController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			registerUser(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/verifyuser.jsp").forward(request, response);
	}

	private void registerUser(HttpServletRequest request, HttpServletResponse response)
			throws SQLException, ServletException, IOException {
		Connection myconnection = null;

		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String p1 = request.getParameter("password1");
			String p2 = request.getParameter("password2");
			if (p1.equals(p2)) {
				Random randomOTP = new Random();
				String otp = String.valueOf(randomOTP.longs(100000, 999999).findAny().getAsLong());
				MessagingService msgService = new MessagingService(request.getParameter("phone"),
						"Thanks for Signing Up. Your OTP is :" + otp);
				String query = "insert into usertable values(?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement mystatement = myconnection.prepareStatement(query);
				mystatement.setString(1, request.getParameter("emailid"));
				mystatement.setString(2, request.getParameter("password1"));
				mystatement.setString(3, request.getParameter("name"));
				mystatement.setString(4, request.getParameter("phone"));
				mystatement.setString(5, request.getParameter("house_no"));
				mystatement.setString(6, request.getParameter("street_name"));
				mystatement.setString(7, request.getParameter("city"));
				mystatement.setString(8, request.getParameter("state"));
				mystatement.setString(9, request.getParameter("pincode"));
				mystatement.setString(10, "user");
				Date mydate = new Date();
				SimpleDateFormat myformat = new SimpleDateFormat("yyyy-MM-dd");
				mystatement.setString(11, myformat.format(mydate));
				mystatement.setString(12, otp);
				int a = mystatement.executeUpdate();
				if (a == 1) {
					msgService.sendMessage();
					request.setAttribute("successMsg", "Signup Successful. OTP Sent to verify Mobile .");
					request.setAttribute("phone", request.getParameter("phone"));
				}
			} else {
				request.setAttribute("errMsg", "Password does not match.");
			}

		} catch (Exception e) {
			if (SQLIntegrityConstraintViolationException.class.equals(e.getClass())) {
				request.setAttribute("errMsg", "User already registered");
			} else {
				request.setAttribute("errMsg", "System Error");
			}
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		} finally {
			myconnection.close();
		}
	}
}

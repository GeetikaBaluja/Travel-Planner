package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gb.travelplan.utility.DatabaseConnection;
import com.gb.travelplan.utility.MessagingService;

@WebServlet(urlPatterns = "/login")
public class LoginContoller extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Connection myconnection = null;
		StringBuilder pageResponse = new StringBuilder("");
		verifyLoginCredentials(request, response, session, myconnection, pageResponse);

	}

	private void verifyLoginCredentials(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Connection myconnection, StringBuilder pageResponse) {
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			try {
				String q = "select * from usertable where emailid=? and password=?";
				PreparedStatement mystatement = myconnection.prepareStatement(q);
				mystatement.setString(1, request.getParameter("emailid"));
				mystatement.setString(2, request.getParameter("password"));

				ResultSet myresult = mystatement.executeQuery();

				if (myresult.next()) {
					if (myresult.getString("usertype").equals("admin")) {
						session.setAttribute("admin", myresult.getString("name"));
						session.setAttribute("tourid", null);
						response.sendRedirect("adminpanel.jsp");
					} else if (myresult.getString("usertype").equals("user")) {
						if ("#".equals(myresult.getString("verified_user"))) {
							session.setAttribute("uname", myresult.getString("name"));
							session.setAttribute("emailid", myresult.getString("emailid"));
							if (session.getAttribute("tourid") != null) {
								response.sendRedirect("tourInfo");
							} else {
								response.sendRedirect("index.jsp");
							}
						} else {
							Random randomOTP = new Random();
							String otp = String.valueOf(randomOTP.longs(100000, 999999).findAny().getAsLong());
							if (updateUser(request, myconnection, myresult.getString("phone"), otp)) {
								new MessagingService(myresult.getString("phone"),
										"Hi " + myresult.getString("name") + ", your OTP is :" + otp).sendMessage();
								request.setAttribute("phone", myresult.getString("phone"));
								request.getRequestDispatcher("/verifyuser.jsp").forward(request, response);
							} else {
								request.setAttribute("errMsg", "System Error(Contact US)");
								request.getRequestDispatcher("/index.jsp").forward(request, response);
							}
						}
					}
				} else {
					pageResponse.append("<font color='red'>Wrong Username/password</font>");
					request.setAttribute("pageResponse", pageResponse.toString());
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}

			} catch (Exception e) {
				pageResponse.append("<font color='red'>error in query " + e.getMessage() + "</font>");
				request.setAttribute("pageResponse", pageResponse.toString());
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}

		} catch (Exception e) {
			pageResponse.append("<font color='red'>Error in connection " + e.getMessage() + "</font>");
			request.setAttribute("pageResponse", pageResponse.toString());
			try {
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			} catch (ServletException | IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

		} finally {
			try {
				myconnection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private boolean updateUser(HttpServletRequest request, Connection conn, String phone, String otp)
			throws SQLException {
		String updateUserQuery = "UPDATE tourismdb.usertable SET verified_user=? where phone=?";
		PreparedStatement updateUserSt = conn.prepareStatement(updateUserQuery);
		updateUserSt.setString(1, otp);
		updateUserSt.setString(2, phone);
		if (updateUserSt.executeUpdate() > 0) {
			return true;
		} else {
			return false;
		}
	}
}

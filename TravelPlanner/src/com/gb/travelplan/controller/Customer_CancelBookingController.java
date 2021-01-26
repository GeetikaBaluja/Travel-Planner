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

import com.gb.travelplan.utility.DatabaseConnection;
import com.gb.travelplan.utility.MessagingService;

@WebServlet(urlPatterns = "/changeCustomerBookingStatus")
public class Customer_CancelBookingController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			getCustomerSelectedTourInformation(request);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		request.setAttribute("pageResponse", pageResponse.toString());
		request.getRequestDispatcher("/changeCustomerBookingStatus.jsp").forward(request, response);
	}

	private void getCustomerSelectedTourInformation(HttpServletRequest request) throws SQLException {
		Connection myconnection = null;
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();
			String q1 = "SELECT * FROM tourismdb.bookingrequest b inner join tourismdb.tours t on b.tourid=t.tourid where srno=?";
			PreparedStatement mystatement = myconnection.prepareStatement(q1);
			mystatement.setString(1, request.getParameter("id"));// TODO Auto-generated method stub
			ResultSet myresult = mystatement.executeQuery();
			if (myresult.next()) {
				request.setAttribute("bookingId", request.getParameter("id"));
				request.setAttribute("travelDate", myresult.getString("b.ddate"));
				request.setAttribute("persons", myresult.getString("b.persons"));
				request.setAttribute("touringDaysCount", myresult.getString("b.booking_days"));
				request.setAttribute("totalTourCost", myresult.getString("b.booking_cost"));
				request.setAttribute("tourId", myresult.getString("t.tourid"));
				request.setAttribute("tourName", myresult.getString("t.name"));
				request.setAttribute("tourStatus", myresult.getString("b.booking_status"));
				request.setAttribute("returnDate", myresult.getString("b.rdate"));
				request.setAttribute("requestDate", myresult.getString("b.requestdate"));
				if (!myresult.getString("b.booking_status").equalsIgnoreCase("Cancelled")) {
					request.setAttribute("cancelBtnDisable", "false");
				} else {
					request.setAttribute("cancelBtnDisable", "true");
				}
			}

		} catch (Exception e) {
//			pageResponse.append("Error in Connection " + e.getMessage());
		} finally {
			myconnection.close();
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			cancelBookingByCustomer(request);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("/index.jsp").forward(request, response);

	}

	private void cancelBookingByCustomer(HttpServletRequest request) throws SQLException {
		Connection myconnection = null;
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();
			String q1 = "update tourismdb.bookingrequest set booking_status='Cancelled' where srno=?";
			PreparedStatement mystatement = myconnection.prepareStatement(q1);
			mystatement.setString(1, request.getParameter("bookingId"));// TODO Auto-generated method stub
			int statusUpdated = mystatement.executeUpdate();
			if (statusUpdated > 0) {
				informUserByMessage(request, myconnection);

				request.setAttribute("pageResponse", "<p style='text-align: center; color: red;'>Your trip to <b>"
						+ request.getParameter("tourName") + "</b> is cancelled.</p>");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errMsg", "System Error(Contact US)");
		} finally {
			myconnection.close();
		}

	}

	private void informUserByMessage(HttpServletRequest request, Connection myconnection) throws SQLException {
		String userQuery = "SELECT * FROM tourismdb.usertable where emailid=?";
		PreparedStatement userDetailsStatement = myconnection.prepareStatement(userQuery);
		userDetailsStatement.setString(1, request.getSession().getAttribute("emailid").toString());
		ResultSet userDetails = userDetailsStatement.executeQuery();
		if (userDetails.next()) {
			MessagingService msgService = new MessagingService(userDetails.getString("phone"),
					"Hi "+userDetails.getString("name")+", Your Booking to " + request.getParameter("tourName") + " is cancelled. Booking Reference Id: "
							+ request.getParameter("bookingId"));
			msgService.sendMessage();
		}
	}

}

package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gb.travelplan.utility.DatabaseConnection;
import com.gb.travelplan.utility.MessagingService;

@WebServlet(urlPatterns = "/completeBookingController")
public class Customer_ConfirmBookingController extends HttpServlet {
	private String exceptionDescription = null;
	private long bookingId = 0;
	MessagingService msgService = null;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!isTourSelected(request, response)) {
			return;
		}
		initiateBookingCancellationProcess(request, response);
	}

	private void initiateBookingCancellationProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		clearBookingValues(request);
		String pageResponse = "Your booking is cancelled.";
		request.setAttribute("successMsg", pageResponse);
		request.getRequestDispatcher("/index.jsp").forward(request, response);

	}

	private void clearBookingValues(HttpServletRequest request) {
		HttpSession session = request.getSession();
		request.removeAttribute("tourName");
		request.removeAttribute("touringDaysCount");
		request.removeAttribute("totalTourCost");
		session.removeAttribute("tourid");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean isSuccessful = false;
		String pageResponse = null;
		if (!isTourSelected(request, response)) {
			return;
		}
		HttpSession session = request.getSession();
		isSuccessful = processBooking(request, session);
		clearBookingValues(request);
		if (isSuccessful) {
			pageResponse = "Booking successful(Booking Id:" + bookingId + "). We will contact you in few days.";
			msgService.sendMessage();
			request.setAttribute("successMsg", pageResponse);
		} else {
			pageResponse = "System Error(Contact US)";
			request.setAttribute("errMsg", pageResponse);
		}

		request.getRequestDispatcher("/index.jsp").forward(request, response);

	}

	private boolean isTourSelected(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getSession().getAttribute("tourid") == null) {
			clearBookingValues(request);
			request.setAttribute("errMsg", "Error Occured: Tour Not Selected");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			return false;
		}
		return true;
	}

	private boolean processBooking(HttpServletRequest request, HttpSession session) {
		Connection myconnection = null;

		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			try {
				storeBookingToDB(myconnection, request, session);
//				sendTourPackageConfirmation(session,tourPackageCost);
			} catch (Exception e) {
				exceptionDescription = e.getMessage();
				return false;
			} finally {
				myconnection.close();
			}

		} catch (Exception e) {
			exceptionDescription = e.getMessage();
			return false;

		}
		return true;

	}

	private boolean storeBookingToDB(Connection myconnection, HttpServletRequest request, HttpSession session)
			throws SQLException {
		// TODO: Cost Column to be added
		String q = "insert into bookingrequest(username,tourid,ddate,rdate,adults,children,dcity,requestdate,booking_cost,booking_status,booking_days,room_bookings) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement mystatement = myconnection.prepareStatement(q);
		mystatement.setString(1, session.getAttribute("emailid").toString());
		mystatement.setString(2, session.getAttribute("tourid").toString());
		mystatement.setString(3, request.getParameter("travelDate"));
		mystatement.setString(4, request.getParameter("travelReturnDate"));
		mystatement.setString(5, request.getParameter("adults"));
		mystatement.setString(6, request.getParameter("children"));
		mystatement.setString(7, request.getParameter("customercity"));
		Date mydate = new Date();
		SimpleDateFormat myformat = new SimpleDateFormat("yyyy-MM-dd");
		mystatement.setString(8, myformat.format(mydate));
		mystatement.setLong(9, Long.valueOf(request.getParameter("totalTourCost")));
		mystatement.setString(10, "Pending");
		mystatement.setString(11, request.getParameter("touringDaysCount"));
		mystatement.setString(12, request.getParameter("roomsBooked"));
		int a = mystatement.executeUpdate();
		if (a == 1) {

			String q1 = "SELECT LAST_INSERT_ID() from bookingrequest";
			PreparedStatement mystatement1 = myconnection.prepareStatement(q1);
			ResultSet myresult = mystatement1.executeQuery();

			if (myresult.next()) {
				bookingId = myresult.getInt(1);
			}
			String userQuery = "SELECT * FROM tourismdb.bookingrequest b inner join tourismdb.usertable u on b.username=u.emailid inner join tourismdb.tours t ON t.tourid=b.tourid where b.username=?;";
			PreparedStatement userDetailsStatement = myconnection.prepareStatement(userQuery);
			userDetailsStatement.setString(1, session.getAttribute("emailid").toString());
			ResultSet userDetails = userDetailsStatement.executeQuery();
			if (userDetails.next()) {
				msgService = new MessagingService(userDetails.getString("phone"),
						"Hi " + userDetails.getString("name") + ", Your Booking request for "
								+ userDetails.getString("t.name")
								+ " is successfully Placed. Your Reference Booking Id:" + bookingId);
			}
			return true;
		}
		return false;
	}

}

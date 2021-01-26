package com.gb.travelplan.controller;

import java.io.IOException;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.text.SimpleDateFormat;
//import java.util.Properties;
//
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

@WebServlet(urlPatterns = "/tourBookingController")
public class Customer_PreBookingStageController extends HttpServlet {
	private String exceptionDescription = null;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder pageResponse = new StringBuilder();
		if (!isTourSelected(request, response)) {
			return;
		}
		HttpSession session = request.getSession();
		fetchTourInformation(request, response, session, pageResponse);
		request.setAttribute("pageResponse1", pageResponse);
		request.getRequestDispatcher("/requestbooking.jsp").forward(request, response);
	}

	private void fetchTourInformation(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			StringBuilder pageResponse) {
		Connection myconnection = null;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();

			try {
				String q = "select * from tours where tourid=?";
				PreparedStatement mystatement = myconnection.prepareStatement(q);
				mystatement.setString(1, session.getAttribute("tourid").toString());

				ResultSet myresult = mystatement.executeQuery();

				if (myresult.next()) {
					pageResponse.append("<h3 style='text-align: center;'>" + myresult.getString("name") + "</h3>");

					if (myresult.getString("image1") != "") {

						pageResponse.append("<p align='center'><img style= 'border-radius: 50%;' src='uploads/"
								+ myresult.getString("image1") + "' width='200px' height='200px'></p>");
						request.setAttribute("touringDaysCount", myresult.getString("duration"));
					}

				}
			} catch (Exception e) {
				pageResponse.append("error in query " + e.getMessage());
			} finally {
				myconnection.close();
			}
		} catch (Exception e) {
			pageResponse.append("error in connection " + e.getMessage());
			pageResponse.append("<script type='text/javascript'>alert('Error in Connection')</script>");
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!isTourSelected(request, response)) {
			return;
		}
		HttpSession session = request.getSession();
		long tourPackageCost = calculateTourPackageCost(request, session);
		request.setAttribute("travelDate", request.getParameter("sdate1"));
		request.setAttribute("travelReturnDate", request.getParameter("enddate1"));
		request.setAttribute("touringDaysCount", request.getParameter("touringDaysCount"));
		request.setAttribute("customercity", request.getParameter("dcity"));
		request.setAttribute("totalTourCost", tourPackageCost);
		request.getRequestDispatcher("/confirmCustomerBooking.jsp").include(request, response);
		// isSuccessful = processBooking(request, session);
		//
		// if (isSuccessful) {
		// pageResponse = "<font color='green'>Thanks for booking request. We will
		// contact you in few days. Your Booking request number is lastid </font>";
		// } else {
		// pageResponse = "<font color='red'>Error in connection " +
		// exceptionDescription + "</font>";
		//
		// }
		// request.setAttribute("pageResponse", pageResponse);
		// request.getRequestDispatcher("/requestbooking.jsp").forward(request,
		// response);

	}

	private long calculateTourPackageCost(HttpServletRequest request, HttpSession session) {
		Connection myconnection = null;
		long adultPrice = 0;
		long childPrice = 0;
		String tourName = null;
		String hotelName = null;
		String hotelAddress = null;
		StringBuilder hotelResponse = new StringBuilder();
		float adultsCount = 0;
		float childrenCount = 0;
		int roomsToBeBooked = 0;

		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			try {

				String q = "SELECT * FROM tourismdb.tours t inner join tourismdb.tours_hotels th on t.tourid=th.tour_id inner join tourismdb.hotel_info hi on th.hotel_id=hi.hotel_id where t.tourid=?";
				PreparedStatement mystatement = myconnection.prepareStatement(q);
				mystatement.setString(1, session.getAttribute("tourid").toString());
				ResultSet myresult = mystatement.executeQuery();

				adultsCount = Float.parseFloat(request.getParameter("adults"));
				childrenCount = Float.parseFloat(request.getParameter("children"));
				roomsToBeBooked = (Math.round(adultsCount / 2) > Math.round(childrenCount / 2))
						? Math.round(adultsCount / 2)
						: Math.round(childrenCount / 2);
				if (myresult.next()) {
					adultPrice = Long.parseLong(myresult.getString("adult_price"));
					childPrice = Long.parseLong(myresult.getString("child_price"));
					tourName = myresult.getString("name");
					do {

						hotelResponse.append("<tr><td><span>Hotel: </span></td>"
								+ "<td style='font-weight: bold;'><span>" + myresult.getString("hotel_name")
								+ ", </span><span>" + myresult.getString("hotel_street_address") + "</span></td>"
								+ "<td><span>Rooms Booked: </span></td>" + "<td style='font-weight: bold;'><span>"
								+ roomsToBeBooked + "</span></td></tr>");
					} while (myresult.next());
				}
				request.setAttribute("hotelResponse", hotelResponse);
				request.setAttribute("tourName", tourName);
				request.setAttribute("roomsBooked", roomsToBeBooked);
				request.setAttribute("adults", (int) adultsCount);
				request.setAttribute("children", (int) childrenCount);
				return (long) ((adultsCount * adultPrice) + (childrenCount * childPrice));
			} catch (Exception e) {
				exceptionDescription = e.getMessage();
				return 0;
			}
		} catch (Exception e) {
			exceptionDescription = e.getMessage();
			return 0;
		} finally {
			try {
				myconnection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	private boolean isTourSelected(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if (request.getSession().getAttribute("tourid") == null) {
			request.setAttribute("errMsg", "Error Occured: Tour Not Selected");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			return false;
		}
		return true;
	}

}

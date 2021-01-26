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

@WebServlet(urlPatterns = "/tourInfo")
public class Customer_TourDescriptionPageController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder tourDescription = new StringBuilder();
		StringBuilder pageResponse = new StringBuilder();
		StringBuilder adultPrice = new StringBuilder();
		StringBuilder pageResponse2 = new StringBuilder();
		StringBuilder childPrice = new StringBuilder();
		fetchTourInformation(request, response, pageResponse, adultPrice, childPrice, pageResponse2, tourDescription);
		request.setAttribute("tourDescription", tourDescription.toString());
		request.setAttribute("pageResponse", pageResponse.toString());
		request.setAttribute("adultPrice", adultPrice.toString());
		request.setAttribute("childPrice", childPrice.toString());
		request.setAttribute("pageResponse2", pageResponse2.toString());
		request.getRequestDispatcher("/viewtourdetail.jsp").forward(request, response);

	}

	private void fetchTourInformation(HttpServletRequest request, HttpServletResponse response,
			StringBuilder pageResponse, StringBuilder adultPrice, StringBuilder childPrice, StringBuilder pageResponse2,
			StringBuilder tourDescription) {
		StringBuilder feedbackResponse = new StringBuilder();
		HttpSession session = request.getSession(true);
//		if (request.getParameter("id") != null) {
		String tourId = session.getAttribute("tourid") != null ? (String) session.getAttribute("tourid")
				: request.getParameter("id");

		Connection myconnection = null;

		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			try {
				String queryAllDetailsOfTourById = "select * from tours where tourid=?";
				String queryFeedbackBasedOnTourId = "select * from tourismdb.user_feedback f  where f.tour_id=?  order by user_rating desc Limit 2;";
				PreparedStatement tourDetailsStatement = myconnection.prepareStatement(queryAllDetailsOfTourById);
				PreparedStatement feedbackStatement = myconnection.prepareStatement(queryFeedbackBasedOnTourId);
				tourDetailsStatement.setString(1, tourId);
				feedbackStatement.setString(1, tourId);
				ResultSet selectedTourDetails = tourDetailsStatement.executeQuery();
				ResultSet feedbackDetails = feedbackStatement.executeQuery();

				if (selectedTourDetails.next()) {
					do {
						tourDescription.append("<h1 class='featured-cy text-upper'>"
								+ selectedTourDetails.getString("name") + "</h1>");
						tourDescription.append("<div style='color: white;'><p>"
								+ selectedTourDetails.getString("description") + "</p></div>");

						pageResponse.append("<div id='tour' style='box-shadow: 5px 10px 20px 5px;"
								+ "    border-radius: 10px 10px 10px 10px;" + "    padding: 10px;'>");
						pageResponse.append(
								"<ul class='nav nav-tabs text-upper' style='padding-left:20px'><li><h2>Itinerary</h2></li></ul>");
						pageResponse.append("<p>" + selectedTourDetails.getString("iternary") + "</p>");
						pageResponse.append("<hr><h2>Inclusions</h2>");
						pageResponse.append("<p>" + selectedTourDetails.getString("inclusion") + "</p>");
						pageResponse.append("<hr><h2>Exclusions</h2>");
						pageResponse.append("<p>" + selectedTourDetails.getString("exclusion") + "</p><hr>");

						pageResponse.append("</div>");
						pageResponse.append("<input type='hidden' id='tour_status' value='"
								+ selectedTourDetails.getString("tour_status") + "'>");
						preparePriceAndPhotoResponse(adultPrice, childPrice, pageResponse2, selectedTourDetails);
					} while (selectedTourDetails.next());
				} else {
					pageResponse.append("No Tours added");
				}
				if (feedbackDetails.next()) {
					do {
						feedbackResponse.append("<div id=>" + "<label style=\"margin: 10px;\">"
								+ feedbackDetails.getString("f.cust_name") + "</label>");
						highlightStars(feedbackResponse, feedbackDetails);
						feedbackResponse.append("<p style=\"margin-left: 40px;\">"
								+ feedbackDetails.getString("f.user_highlights") + "</p></div>");

					} while (feedbackDetails.next());
				} else {
					feedbackResponse.append("No Reviews Available");
				}
				request.setAttribute("feedbackResponse", feedbackResponse.toString());
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

	private void highlightStars(StringBuilder feedbackResponse, ResultSet feedbackDetails) throws SQLException {
		int totalStars = 5;
		int checkedStar = feedbackDetails.getInt("user_rating");
		int uncheckedStar = totalStars - checkedStar;
		for (int i = 0; i < checkedStar; i++) {
			feedbackResponse.append("<span class=\"fa fa-star checked\" name=\"star_ratings\"></span>");
		}
		for (int i = 0; i < uncheckedStar; i++) {
			feedbackResponse.append("<span class=\"fa fa-star\" name=\"star_ratings\"></span>");
		}

	}

	private void preparePriceAndPhotoResponse(StringBuilder adultPrice, StringBuilder childPrice,
			StringBuilder pageResponse2, ResultSet toursDetail) throws SQLException {
		adultPrice.append("Rs. " + toursDetail.getString("adult_price") + "/-");
		childPrice.append("Rs. " + toursDetail.getString("child_price") + "/-");

		preparePhotoResponse(pageResponse2, toursDetail);
	}

	private void preparePhotoResponse(StringBuilder pageResponse, ResultSet toursDetail) throws SQLException {
		do {
			if (toursDetail.getString("image1") != "") {
				pageResponse.append("<div><h2>Photos</h2>");

				pageResponse.append("<div><img  class='tripPhotos' src='uploads/" + toursDetail.getString("image1")
						+ "' width='200px' height='200px'>");
			}
			if (!toursDetail.getString("image2").equals("")) {
				pageResponse.append("<img class='tripPhotos' src='uploads/" + toursDetail.getString("image2")
						+ "' width='200px' height='200px'>");
			}
			if (!toursDetail.getString("image3").equals("")) {
				pageResponse.append("<img class='tripPhotos' src='uploads/" + toursDetail.getString("image3")
						+ "' width='200px' height='200px'></div></div>");
			}

		} while (toursDetail.next());
	}

}

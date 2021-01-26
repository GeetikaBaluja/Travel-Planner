package com.gb.travelplan.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(urlPatterns = "/lookForPlacesController")
public class Customer_AvailableToursListController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder pageResponse = new StringBuilder();
		if (request.getParameter("id") != null || request.getParameter("place") != null) {
			lookForToursAvailable(request, response, pageResponse);
		}
		request.setAttribute("pageResponse", pageResponse);
		request.getRequestDispatcher("/viewtours.jsp").forward(request, response);

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder pageResponse = new StringBuilder();
		request.getSession().setAttribute("tourid", null);
		lookForToursAvailable(request, response, pageResponse);
		request.setAttribute("pageResponse", pageResponse);
		request.getRequestDispatcher("/viewtours.jsp").forward(request, response);
	}

	private void lookForToursAvailable(HttpServletRequest request, HttpServletResponse response,
			StringBuilder pageResponse) throws ServletException, IOException {
		Connection myconnection = null;
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();
			String query;
			PreparedStatement mystatement;
			if (request.getParameter("cat") != null) {
				query = "SELECT * FROM tours  where category = ? and tour_status=1";
				mystatement = myconnection.prepareStatement(query);
				mystatement.setString(1, request.getParameter("cat"));
				if (request.getParameter("cat").equals("1")) {
					request.setAttribute("category", "Hill Station");
				} else if (request.getParameter("cat").equals("2")) {
					request.setAttribute("category", "City");
				} else if (request.getParameter("cat").equals("3")) {
					request.setAttribute("category", "Beach");
				} else if (request.getParameter("cat").equals("4")) {
					request.setAttribute("category", "Wildlife");
				}

			} else {
				query = "select * from tours where name like ?";
				mystatement = myconnection.prepareStatement(query);
				mystatement.setString(1, "%" + request.getParameter("place") + "%");
			}
			ResultSet myresult = mystatement.executeQuery();
			if (myresult.next()) {

				pageResponse.append("<h1>Tours Available</h1>");
				do {
					pageResponse.append("<div class='col-md-12'>"
							+ "<div class='tour-plans' style='padding: 15px; border-radius: 15px; box-shadow: 10px 10px 10px 10px;'>"
							+ "<div class='plan-image'>");
					pageResponse.append("<a href='tourInfo?id=" + myresult.getString("tourid") + "'><img src='uploads/"
							+ myresult.getString("image1") + "' class='img-responsive1' align='left' border='0'></a>"
							+ "");
					pageResponse.append("<div class='offer-box'>"
							+ "<div class='offer-top'><span class='featured-cr text-upper'>Visit</span><h2 class='featured-cy text-upper'>"
							+ myresult.getString("name") + "</h2>" + "</div>");
					pageResponse.append(
							"<div class='offer-bottom'><span class='featured-stf'>Starting From </span><span class='featured-spe'>Rs."
									+ myresult.getString("adult_price") + "</span>" + "</div></div></div>");
					pageResponse.append("<div class='post-desc'>");
					pageResponse.append("<h2><a href='tourInfo?id=" + myresult.getString("tourid") + "'>"
							+ myresult.getString("name") + "</h2></a>");

					pageResponse.append("<div class='post-desc'><p>" + myresult.getString("description") + "</p>");
					pageResponse.append("<p align='right'><a class='btn btn-primary marb20' href='tourInfo?id="
							+ myresult.getString("tourid") + "'>More Details</a></p>");

					pageResponse.append("</div></div></div></div>");
				} while (myresult.next());
			} else {
				request.setAttribute("errMsg", "No Tours Available");
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}

		} catch (Exception e) {
			request.setAttribute("errMsg", "System Error");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		} finally {
			try {
				myconnection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}

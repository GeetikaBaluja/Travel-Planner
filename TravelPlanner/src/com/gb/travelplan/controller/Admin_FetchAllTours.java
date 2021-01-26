package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchAllTours")
public class Admin_FetchAllTours extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			getAllTours(request);
			request.getRequestDispatcher("/listoftours.jsp").forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void getAllTours(HttpServletRequest request) throws SQLException {
		Connection myconnection = null;
		StringBuilder pageResponse = new StringBuilder();
		StringBuilder tourFormResponse = new StringBuilder();
		int toursCount = 0;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String fetchAllTours = "select * from tours";
			PreparedStatement fetchAllToursStatement = myconnection.prepareStatement(fetchAllTours);

			ResultSet fetchAllToursResult = fetchAllToursStatement.executeQuery();

			if (fetchAllToursResult.next()) {

				do {
					toursCount++;
					pageResponse.append("<tr>");

					pageResponse.append("<td>" + fetchAllToursResult.getString("name") + "</td>");
					pageResponse.append("<td>" + getCategoryName(fetchAllToursResult.getString("category")) + "</td>");
					pageResponse.append(
							"<td>" + (fetchAllToursResult.getString("tour_status").equals("0") ? "In-Active" : "Active")
									+ "</td>");
					pageResponse.append("<td><button onclick=document.getElementById('" + toursCount
							+ "').submit() class='btn btn-primary'>Update</button></td>");
					pageResponse.append("</tr>");
					tourFormResponse.append("<div><form id='" + toursCount
							+ "' action='fetchSelectedTour' method='Post'><input type='hidden' name=tour_id value='"
							+ fetchAllToursResult.getString("tourid") + "'></form></div>");
				} while (fetchAllToursResult.next());

			} else {
				pageResponse.append("<tr align='center'>No Tours Available</tr>");
			}
		} catch (Exception e) {
			pageResponse.delete(0, pageResponse.length());
			pageResponse.append("<tr><td colspan='4' style='text-align:center;'>System Error.</td></tr>");
		} finally {
			myconnection.close();
		}
		request.setAttribute("pageResponse", pageResponse);
		request.setAttribute("tourFormResponse", tourFormResponse);
	}

	private String getCategoryName(String category) {
		if (category.equals("1")) {
			return "Hill Station";
		} else if (category.equals("2")) {
			return "City";
		} else if (category.equals("3")) {
			return "Beach";
		} else if (category.equals("4")) {
			return "Wildlife";
		} else {
			return "Error";
		}
	}

}

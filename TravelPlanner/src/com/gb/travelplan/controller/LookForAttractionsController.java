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

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/lookForAttractionsController")
public class LookForAttractionsController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder pageResponse = new StringBuilder("''");
		lookForAvailableAttractions(request, response, pageResponse);
		request.setAttribute("pageResponse", pageResponse.toString());
		request.getRequestDispatcher("/showattractions.jsp").forward(request, response);
	}

	private void lookForAvailableAttractions(HttpServletRequest request, HttpServletResponse response,
			StringBuilder pageResponse) {
		Connection myconnection;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			try {
				String q = "select * from attractions where category=?";
				PreparedStatement mystatement = myconnection.prepareStatement(q);
				mystatement.setString(1, request.getParameter("cat"));
				ResultSet myresult = mystatement.executeQuery();

				if (myresult.next()) {

					pageResponse.append("<div>");
					pageResponse.append("<div class='ft-item'><ul>");
					do {

						pageResponse.append("<li><span class='ft-image'><a href='lookForPlacesController?place="
								+ myresult.getString("name") + "'><img src='uploads/" + myresult.getString("pic")
								+ "' /></a></span><br />"
								+ "<div class='ft-data'><a href='lookForPlacesController?place="
								+ myresult.getString("name") + "'>" + myresult.getString("name") + "</a></div></li>");

					} while (myresult.next());
					pageResponse.append("</ul></div></div>");
				} else {
					pageResponse.append("<h3>No Destinations available yet</h3>");
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
}

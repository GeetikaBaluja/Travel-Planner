package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchSelectedTour")
public class Admin_FetchSelectedTour extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		fetchSelectedTourById(request, response);
		request.getRequestDispatcher("/updatetour.jsp").forward(request, response);
	}

	private void fetchSelectedTourById(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Connection myconnection;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String q1 = "select * from tours where tourid=?";
			PreparedStatement mystatement = myconnection.prepareStatement(q1);
			mystatement.setString(1, request.getParameter("tour_id"));
			ResultSet myresult = mystatement.executeQuery();

			if (myresult.next()) {
				request.setAttribute("name", myresult.getString("name"));
				request.setAttribute("description", myresult.getString("description"));
				request.setAttribute("iternary", myresult.getString("iternary"));
				request.setAttribute("adult_price", myresult.getString("adult_price"));
				request.setAttribute("inclusion", myresult.getString("inclusion"));
				request.setAttribute("exclusion", myresult.getString("exclusion"));
				request.setAttribute("image1", myresult.getString("image1"));
				request.setAttribute("image2", myresult.getString("image2"));
				request.setAttribute("image3", myresult.getString("image3"));
				request.setAttribute("category", myresult.getString("category"));
				request.setAttribute("child_price", myresult.getString("child_price"));
				request.setAttribute("tour_status", myresult.getString("tour_status"));
				request.setAttribute("tour_id", myresult.getString("tourid"));
				request.setAttribute("duration", myresult.getString("duration"));
			} else {
				request.setAttribute("errMsg", "System Error");
				request.getRequestDispatcher("/adminpanel.jsp").forward(request, response);
			}

		} catch (Exception e) {
			request.setAttribute("errMsg", "System Error");
			request.getRequestDispatcher("/adminpanel.jsp").forward(request, response);
		}

	}
}

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

@WebServlet(urlPatterns = "/viewCustomerQueries")
public class Admin_ViewCustomerQueries extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		getAllCustomerQueries(request, response);
		request.getRequestDispatcher("/ViewCustomerQueries.jsp").forward(request, response);
	}

	private void getAllCustomerQueries(HttpServletRequest request, HttpServletResponse response) {
		StringBuilder registeredUser = new StringBuilder();
		int registeredUserQueriesCount = 0;
		StringBuilder non_registeredUser = new StringBuilder();
		int non_registeredUserQueriesCount = 0;
		Connection myconnection;
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String fetchAllQueries = "select * from tourismdb.contact_us;";
			PreparedStatement fetchAllQueriesStatement = myconnection.prepareStatement(fetchAllQueries);
			ResultSet fetchAllQueriesResult = fetchAllQueriesStatement.executeQuery();
			while (fetchAllQueriesResult.next()) {
				if (fetchAllQueriesResult.getString("valid_customer").equals("1")) {
					registeredUserQueriesCount++;
					registeredUser.append("<tr class=bookings onclick=fetchQueriesByIdAjax('"
							+ fetchAllQueriesResult.getString("s_no") + "')>");
					registeredUser
							.append("<td class=\"col-md-1\">" + fetchAllQueriesResult.getString("name") + "</td>");
					registeredUser.append(
							"<td class=\"col-md-1\">" + fetchAllQueriesResult.getString("contact_number") + "</td>");
					registeredUser
							.append("<td class=\"col-md-1\">" + fetchAllQueriesResult.getString("query") + "</td>");
					registeredUser.append("</tr>");
				} else if (fetchAllQueriesResult.getString("valid_customer").equals("0")) {
					non_registeredUserQueriesCount++;
					non_registeredUser.append("<tr class=bookings onclick=fetchQueriesByIdAjax('"
							+ fetchAllQueriesResult.getString("s_no") + "')>");
					non_registeredUser
							.append("<td class=\"col-md-1\">" + fetchAllQueriesResult.getString("name") + "</td>");
					non_registeredUser.append(
							"<td class=\"col-md-1\">" + fetchAllQueriesResult.getString("contact_number") + "</td>");
					non_registeredUser
							.append("<td class=\"col-md-1\">" + fetchAllQueriesResult.getString("query") + "</td>");
					non_registeredUser.append("</tr>");
				}

			}
			if (registeredUser.toString().isEmpty()) {
				registeredUser.delete(0, registeredUser.length());
				registeredUser.append("<tr><td colspan='4' style='text-align: center;'>No Record Available.</td></tr>");
			}
			if (non_registeredUser.toString().isEmpty()) {
				non_registeredUser.delete(0, registeredUser.length());
				non_registeredUser
						.append("<tr><td colspan='4' style='text-align: center;'>No Record Available.</td></tr>");
			}
			request.setAttribute("registeredUser", registeredUser);
			request.setAttribute("registeredUserQueriesCount", registeredUserQueriesCount);
			request.setAttribute("non_registeredUser", non_registeredUser);
			request.setAttribute("non_registeredUserQueriesCount", non_registeredUserQueriesCount);
		} catch (Exception e) {
			registeredUser.delete(0, registeredUser.length());
			registeredUser.append("<tr><td colspan='4' style='text-align: center;'>System Error.</td></tr>");
			non_registeredUser.delete(0, registeredUser.length());
			non_registeredUser.append("<tr><td colspan='4' style='text-align: center;'>System Error.</td></tr>");
		}
	}
}

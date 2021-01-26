package com.gb.travelplan.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/contactUs")
public class Customer_ContactUsController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			saveCustomerQuery(request, response);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void saveCustomerQuery(HttpServletRequest request, HttpServletResponse response)
			throws JSONException, IOException {
		Connection myconnection;
		JSONObject responseObj = new JSONObject();
		String name = request.getParameter("uname");
		String emailId = request.getParameter("emailId");
		String contactNumber = request.getParameter("contactNumber");
		String queryText = request.getParameter("queryText");
		boolean validCustomer = Boolean.valueOf(request.getParameter("validCustomer"));
		try {

			myconnection = new DatabaseConnection().getDatabaseConnection();

			String query = "insert into contact_us(name,email_id,contact_number,query,valid_customer) values(?,?,?,?,?)";
			PreparedStatement mystatement = myconnection.prepareStatement(query);
			mystatement.setString(1, name);
			mystatement.setString(2, emailId);
			mystatement.setString(3, contactNumber);
			mystatement.setString(4, queryText);
			mystatement.setBoolean(5, validCustomer);
			int succussful = mystatement.executeUpdate();
			if (succussful > 0) {
				responseObj.put("response", "Thanks " + name + ", Our Team will contact you shortly.");
			}

		} catch (Exception e) {
			responseObj.put("response", "System Error");
			e.printStackTrace();
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(responseObj);
	}

}

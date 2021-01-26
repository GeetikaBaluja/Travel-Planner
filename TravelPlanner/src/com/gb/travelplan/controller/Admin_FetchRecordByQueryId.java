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

import org.json.JSONException;
import org.json.JSONObject;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/fetchRecordByQueryId")
public class Admin_FetchRecordByQueryId extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			fetchRecordByQueryId(request,response);
		} catch (JSONException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void fetchRecordByQueryId(HttpServletRequest request, HttpServletResponse response) throws JSONException, IOException {
		Connection myconnection;
		JSONObject responseObj = new JSONObject();
		try {
			myconnection = new DatabaseConnection().getDatabaseConnection();
			String fetchQueryById = "SELECT * FROM tourismdb.contact_us where s_no=? ";
			PreparedStatement fetchQueryByIdStatement = myconnection.prepareStatement(fetchQueryById);
			fetchQueryByIdStatement.setString(1, request.getParameter("queryId"));
			ResultSet fetchQueryResult = fetchQueryByIdStatement.executeQuery();
			if (fetchQueryResult.next()) {
				responseObj.put("errMsg", "");
				responseObj.put("name", fetchQueryResult.getString("name"));
				responseObj.put("email", fetchQueryResult.getString("email_Id"));
				responseObj.put("phone", fetchQueryResult.getString("contact_number"));
				responseObj.put("query", fetchQueryResult.getString("query"));
				

			} else {
				responseObj.put("errMsg", "No Record Available.");
			}
		} catch (Exception e) {
			responseObj.put("errMsg", "System Error.");
		}
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(responseObj);

	}

}

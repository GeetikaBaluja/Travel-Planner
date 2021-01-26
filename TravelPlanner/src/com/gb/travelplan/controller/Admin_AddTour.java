package com.gb.travelplan.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.gb.travelplan.utility.DatabaseConnection;

@WebServlet(urlPatterns = "/addTour")
public class Admin_AddTour extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			addTour(request, response);
			request.getRequestDispatcher("/adminpanel.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void addTour(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Connection myconnection = null;

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		String tourName = "", iternary = "", adultPrice = "", childPrice = "", tourStatus = "", category = "",
				duration = "", description = "", filename1 = "", filename2 = "", filename3 = "", inclusion = "",
				exclusion = "", tourState = "";
		String[] selectedHotel = new String[6];
		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = null;
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			Iterator itr = items.iterator();
			int selectedHotelCounter = 0;
			while (itr.hasNext()) {

				FileItem item = (FileItem) itr.next();
				if (item.isFormField()) {
					String itemName1 = item.getFieldName();
					String value = item.getString();

					if (itemName1.equals("name")) {
						tourName = value;
					} else if (itemName1.equals("description")) {
						description = value;
					} else if (itemName1.equals("iternary")) {
						iternary = value;
					} else if (itemName1.equals("adult_price")) {
						adultPrice = value;
					}

					else if (itemName1.equals("inclusion")) {
						inclusion = value;
					} else if (itemName1.equals("exclusion")) {
						exclusion = value;
					} else if (itemName1.equals("category")) {
						category = value;
					} else if (itemName1.equals("tour_status")) {
						tourStatus = value;
					} else if (itemName1.equals("child_price")) {
						childPrice = value;
					} else if (itemName1.equals("duration")) {
						duration = value;
					} else if (itemName1.equals("tour_state")) {
						tourState = value;
					} else if (itemName1.startsWith("hotel_")) {
						selectedHotel[selectedHotelCounter] = itemName1.substring(6);
						selectedHotelCounter++;

					}

				} else {
					String type = item.getContentType();
					long size = item.getSize(); // bytes
					if (size > 0) {
						if (type.equals("image/pjpeg") || type.equals("image/jpeg") || type.equals("image/png")
								|| type.equals("image/x-png") || type.equals("image/gif")) {

							java.util.Date obj = new java.util.Date();
							SimpleDateFormat myformat = new SimpleDateFormat("ddMMyyyyhhmmss");
							String newdate = myformat.format(obj);
							if (item.getFieldName().equals("image1")) {
								filename1 = newdate + item.getName();
								String Path = this.getServletContext().getRealPath("/") + "\\uploads\\" + filename1;
								File savefile = new File(Path);
								item.write(savefile);
							}
							if (item.getFieldName().equals("image2")) {
								filename2 = newdate + item.getName();
								String Path = this.getServletContext().getRealPath("/") + "\\uploads\\" + filename2;
								File savefile = new File(Path);
								item.write(savefile);

							}
							if (item.getFieldName().equals("image3")) {
								filename3 = newdate + item.getName();
								String Path = this.getServletContext().getRealPath("/") + "\\uploads\\" + filename3;
								File savefile = new File(Path);
								item.write(savefile);

							}
							// out.println("<center><img src='images/" + filename + "' width=300px
							// height=200px></center>");
						} else {
							System.out.println("Sorry only images are allowed to upload");
						}
					}
				}

			}

			try {
				myconnection = new DatabaseConnection().getDatabaseConnection();
				String q = "insert into tours(name,duration,adult_price,child_price,tour_status,category,description,iternary,inclusion,exclusion,image1,image2,image3)  values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement mystatement = myconnection.prepareStatement(q);
				mystatement.setString(1, tourName);
				mystatement.setString(2, duration);
				mystatement.setString(3, adultPrice);
				mystatement.setString(4, childPrice);
				mystatement.setString(5, tourStatus);
				mystatement.setString(6, category);
				mystatement.setString(7, description);
				mystatement.setString(8, iternary);
				mystatement.setString(9, inclusion);
				mystatement.setString(10, exclusion);
				mystatement.setString(11, filename1);
				mystatement.setString(12, filename2);
				mystatement.setString(13, filename3);
				int a = mystatement.executeUpdate();
				assignHotelWithTour(myconnection, selectedHotel);
				if (a == 1) {
					request.setAttribute("successMsg", "Tour added.");
				}
			}

			catch (Exception e) {
				request.setAttribute("errMsg", "System Error.");
			}

			finally {
				myconnection.close();
			}
		}
	}

	private void assignHotelWithTour(Connection myconnection, String[] selectedHotel) throws SQLException {
		String tourId = null;
		String q1 = "SELECT LAST_INSERT_ID() from tours";
		PreparedStatement mystatement1 = myconnection.prepareStatement(q1);
		ResultSet myresult = mystatement1.executeQuery();

		if (myresult.next()) {
			tourId = myresult.getString(1);
		}
		for (int i = 0; i < selectedHotel.length; i++) {
			String hotelId = selectedHotel[i];
			if (hotelId==null) {
				break;
			} else {
				String mapTourWithHotel = "insert into tours_hotels(tour_id,hotel_id)values(?,?)";
				PreparedStatement mapTourWithHotelStatement = myconnection.prepareStatement(mapTourWithHotel);
				mapTourWithHotelStatement.setString(1, tourId);
				mapTourWithHotelStatement.setString(2, hotelId);
				mapTourWithHotelStatement.executeUpdate();
			}

		}

	}
}

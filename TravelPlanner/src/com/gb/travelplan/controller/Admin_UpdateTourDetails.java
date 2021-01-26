package com.gb.travelplan.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

@WebServlet(urlPatterns = "/updateTourDetails")
public class Admin_UpdateTourDetails extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			updateTourDetailsById(request);
			request.getRequestDispatcher("/adminpanel.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void updateTourDetailsById(HttpServletRequest request) throws Exception {
		String tourName = "", iternary = "", adultPrice = "", childPrice = "", tourStatus = "", category = "",
				duration = "", description = "", filename1 = "", filename2 = "", filename3 = "", inclusion = "",
				exclusion = "", tourid = "", image1 = "", image2 = "", image3 = "";

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);

		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = null;
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}

			Iterator itrImages = items.iterator();
			while (itrImages.hasNext()) {
				FileItem item = (FileItem) itrImages.next();
				if (item.isFormField()) {
					String itemName1 = item.getFieldName();
					String value = item.getString();

					if (itemName1.equals("image1_hidden")) {
						image1 = value;
					} else if (itemName1.equals("image2_hidden")) {
						image2 = value;
					} else if (itemName1.equals("image3_hidden")) {
						image3 = value;
					}

				}}
			Iterator itr = items.iterator();
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
					} else if (itemName1.equals("tour_id")) {
						tourid = value;
					}

				} else {
					String type = item.getContentType();
					long size = item.getSize(); // bytes
					java.util.Date obj = new java.util.Date();
					SimpleDateFormat myformat = new SimpleDateFormat("ddMMyyyyhhmmss");
					String newdate = myformat.format(obj);
					if (item.getFieldName().equals("image1")) {
						if (size > 0) {
							if (type.equals("image/pjpeg") || type.equals("image/jpeg") || type.equals("image/png")
									|| type.equals("image/x-png") || type.equals("image/gif")) {

								filename1 = newdate + item.getName();
								String Path = this.getServletContext().getRealPath("/") + "\\uploads\\" + filename1;
								File savefile = new File(Path);
								item.write(savefile);
							} else {
//								out.println("<h3>Upload image only</h3>");
							}
						} else {
							filename1 = image1;
						}
					}

					if (item.getFieldName().equals("image2")) {
						if (size > 0) {
							if (type.equals("image/pjpeg") || type.equals("image/jpeg") || type.equals("image/png")
									|| type.equals("image/x-png") || type.equals("image/gif")) {

								filename2 = newdate + item.getName();
								String Path = this.getServletContext().getRealPath("/") + "\\uploads\\" + filename2;
								File savefile = new File(Path);
								item.write(savefile);
							} else {
//								out.println("<h3>Upload image only</h3>");
							}
						} else {
							filename2 = image2;
						}
					}
					if (item.getFieldName().equals("image3")) {
						if (size > 0) {
							if (type.equals("image/pjpeg") || type.equals("image/jpeg") || type.equals("image/png")
									|| type.equals("image/x-png") || type.equals("image/gif")) {

								filename3 = newdate + item.getName();
								String Path = this.getServletContext().getRealPath("/") + "\\uploads\\" + filename3;
								File savefile = new File(Path);
								item.write(savefile);
							} else {
//								out.println("<h3>Upload image only</h3>");
							}
						} else {
							filename3 = image3;
						}
					}
// out.println("<center><img src='images/" + filename + "' width=300px height=200px></center>");
				}

			}

			Connection myconnection = null;
			try {
				myconnection = new DatabaseConnection().getDatabaseConnection();
				String updateTourById = "update tours set name=?,duration=?,adult_price=?,child_price=?,tour_status=?,category=?,description=?,iternary=?,inclusion=?,exclusion=?,image1=?,image2=?,image3=? where tourid=?";
				PreparedStatement mystatement = myconnection.prepareStatement(updateTourById);
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
				mystatement.setString(14, tourid);
				int a = mystatement.executeUpdate();
				if (a == 1) {
					request.setAttribute("successMsg", "Tour details updated.");
				}
			}

			catch (Exception e) {
				request.setAttribute("errMsg", "System Failure");
			}

			finally {
				myconnection.close();
			}

		}

	}
}

package com.gb.travelplan.utility;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class MessagingService {
	private String recipient;
	private String message;
	private String username = "admin";
	private String password = "admin";
	private String originator = "+441234567";

	public MessagingService(String recipient, String message) {
		this.message = message;
		this.recipient = recipient;
	}

	public void sendMessage() {
		try {

			String requestUrl = "http://127.0.0.1:9501/api?action=sendmessage&" + "username="
					+ URLEncoder.encode(username, "UTF-8") + "&password=" + URLEncoder.encode(password, "UTF-8")
					+ "&recipient=" + URLEncoder.encode(recipient, "UTF-8") + "&messagetype=SMS:TEXT" + "&messagedata="
					+ URLEncoder.encode(message, "UTF-8") + "&originator=" + URLEncoder.encode(originator, "UTF-8")
					+ "&serviceprovider=HTTPServer0" + "&responseformat=html";

			URL url = new URL(requestUrl);
			HttpURLConnection uc = (HttpURLConnection) url.openConnection();
			System.out.println(uc.getResponseMessage());
			uc.disconnect();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

}

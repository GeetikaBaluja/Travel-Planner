<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Contact US</title>
</head>
<body>
	<form action="" class="contact_us-container">
		<h2>Contact US</h2>
		<label for="name"><b>Name</b></label> <input type="text"
			placeholder="Name" name="name" id="name" required> <label
			for="email_id"><b>Email</b></label> <input type="text"
			placeholder="Enter Email" name="email_id" id="email_id" required>
		<label for="contact_number"><b>Phone No.</b></label> <input
			type="text" placeholder="Enter Phone No." name="contact_number"
			id="contact_number" minlength="10" maxlength="10" required> <label
			for="queryBox"><b>Query Box</b></label>
		<textarea id="queryBox" rows="4" cols="50"
			placeholder="Ask your Query here" required></textarea>
		<input type="hidden" name="validCustomer" id="validCustomer">


		<button type="button" onclick="submitQueryDetailsAjax()" class="btn">Send</button>
		<button type="button" class="btn cancel"
			onclick="closeContactUsPage()">Close</button>
	</form>

	<script>
		function fetchUserDetailsAjax() {
			var prepareDataSet = {
				uname : document.getElementById('logged_in_user').value,
			}
			$
					.ajax({
						type : "POST",
						json : true, // added this
						url : 'fetchUserDetails',
						'Content-Type' : 'application/x-www-form-urlencoded',
						data : prepareDataSet,
						async : false,
						success : function(json) {
							document.getElementById('name').value = (document
									.getElementById('logged_in_user').value);
							document.getElementById('name').readOnly = true;
							document.getElementById('email_id').value = (json['emailId']);
							document.getElementById('email_id').readOnly = true;
							document.getElementById('contact_number').value = (json['phone']);
							document.getElementById('contact_number').readOnly = true;
							document.getElementById('validCustomer').value = (true);

						},
						error : function(e) {
							console.log("jQuery error message = " + e.message);
						}

					});
		}
		function submitQueryDetailsAjax() {
			if (document.getElementById('name').value == ""
					|| document.getElementById('email_id').value == ""
					|| document.getElementById('contact_number').value == ""
					|| document.getElementById('queryBox').value == "") {
				alert("Required details missing.")
			} else {
				var prepareDataSet = {
					uname : document.getElementById('name').value,
					emailId : document.getElementById('email_id').value,
					contactNumber : document.getElementById('contact_number').value,
					queryText : document.getElementById('queryBox').value,
					validCustomer : document.getElementById('validCustomer').value
				}
				$.ajax({
					type : "POST",
					json : true, // added this
					url : 'contactUs',
					'Content-Type' : 'application/x-www-form-urlencoded',
					data : prepareDataSet,
					async : false,
					success : function(json) {
						alert(json['response']);
						closeContactUsPage();

					},
					error : function(e) {
						console.log("jQuery error message = " + e.message);
					}

				});

			}

		}

		function openContactUsPage() {
			if (document.getElementById("logged_in_user").value != "null") {
				fetchUserDetailsAjax();
				document.getElementById('queryBox').value = "";
			} else {
				document.getElementById('validCustomer').value = (false);
				document.getElementById('name').value = "";
				document.getElementById('email_id').value = "";
				document.getElementById('contact_number').value = "";
				document.getElementById('queryBox').value = "";
				
				
			}
			document.getElementById("contactUsPage").style.display = "block";
			var reviewPageElement = document.getElementById("reviewsPage");
			if (reviewPageElement != null) {
				reviewPageElement.style.display = "none";
			}
		}

		function closeContactUsPage() {
			document.getElementById("contactUsPage").style.display = "none";
		}
	</script>
</body>
</html>
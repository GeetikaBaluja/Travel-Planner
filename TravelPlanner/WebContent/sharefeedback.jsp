<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Feedback</title>
</head>
<body>
	<div class="feedback-container">
		<h2>
			<p>
				<label>Hi&nbsp;</label><label><%=session.getAttribute("uname")%>,
				</label>
			</p>
			<p>Share you Trip experience with us.</p>
		</h2>
		<div>
			<p>
				<label><%=request.getAttribute("tourName")%></label>
			</p>
			<p>
				<label>Traveling Period </label><label>&nbsp;<%=request.getAttribute("travelDate")%></label><label>
					&nbsp;to&nbsp;<%=request.getAttribute("returnDate")%></label>
			</p>
			<div>
				<label>User Rating</label>
				<div class="main">
					<div class="stars" id="user_rating" data-rating="1">
						<span class="star">&nbsp;</span> <span class="star">&nbsp;</span>
						<span class="star">&nbsp;</span> <span class="star">&nbsp;</span>
						<span class="star">&nbsp;</span>
					</div>
				</div>
			</div>
			<div>
				<label>Experience Highlights</label>
				<textarea id="highlights"></textarea>
			</div>
			<div>
				<label>Overall Experience</label>
				<textarea id="experience" rows="5"></textarea>
			</div>

		</div>
		<button type="button" id="submit_feedback_btn" class="btn"
			onclick="submitFeedbackAjax()">Save</button>
		<button type="button" class="btn cancel" onclick="closeFeedbackPage()">Close</button>
	</div>
</body>
<style>
.star {
	color: goldenrod;
	font-size: 2.0rem;
	padding: 0 1rem; /* space out the stars */
}

.star::before {
	content: '\2606'; /* star outline */
	cursor: pointer;
}

.star.rated::before {
	/* the style for a selected star */
	content: '\2605'; /* filled star */
}

.stars {
	counter-reset: rateme 0;
	font-size: 2.0rem;
	font-weight: 900;
}

.star.rated {
	counter-increment: rateme 1;
}

.stars::after {
	content: counter(rateme) '/5';
}
</style>
<script>
	//initial setup
	document.addEventListener('DOMContentLoaded', function() {
		let stars = document.querySelectorAll('.star');
		stars.forEach(function(star) {
			star.addEventListener('click', setRating);
		});

		let rating = parseInt(document.querySelector('.stars').getAttribute(
				'data-rating'));
		let target = stars[rating - 1];
		target.dispatchEvent(new MouseEvent('click'));
	});

	function setRating(ev) {
		let span = ev.currentTarget;
		let stars = document.querySelectorAll('.star');
		let match = false;
		let num = 0;
		stars.forEach(function(star, index) {
			if (match) {
				star.classList.remove('rated');
			} else {
				star.classList.add('rated');
			}
			//are we currently looking at the span that was clicked
			if (star === span) {
				match = true;
				num = index + 1;
			}
		});
		document.querySelector('.stars').setAttribute('data-rating', num);
	}

	function fillFeedbackBox() {
		document.getElementById('user_rating').dataset.rating = document
				.getElementById('user_rating_hidden').value;
		
		let stars = document.querySelectorAll('.star');
		stars.forEach(function(star) {
			star.addEventListener('click', setRating);
		});

		let rating = parseInt(document.querySelector('.stars').getAttribute(
				'data-rating'));
		let target = stars[rating - 1];
		target.dispatchEvent(new MouseEvent('click'));
		
		
		document.getElementById('highlights').value = document
				.getElementById('highlights_hidden').value;
		document.getElementById('experience').value = document
				.getElementById('experience_hidden').value;
	}
	function fetchFeedbackAjax() {
		var prepareDataSet = {
			bookingId : document.getElementById('bookingId').value
		}
		$
				.ajax({
					type : "POST",
					json : true, // added this
					url : 'fetchFeedbackByBookingId',
					'Content-Type' : 'application/x-www-form-urlencoded',
					data : prepareDataSet,
					async:false,
					success : function(json) {
						if (json['response'] === "") {
							document.getElementById('user_rating_hidden').value = (json['user_rating']);
							document.getElementById('highlights_hidden').value = (json['highlights']);
							document.getElementById('experience_hidden').value = (json['experience']);
						}

					},
					error : function(e) {
						console.log("jQuery error message = " + e.message);
					}

				});
	}

	function submitFeedbackAjax() {
		var prepareDataSet = {
			bookingId : document.getElementById('bookingId').value,
			tourId : document.getElementById('tourId').value,
			user_rating : document.getElementById('user_rating').dataset.rating,
			highlights : document.getElementById('highlights').value,
			experience : document.getElementById('experience').value
		}
		$.ajax({
			type : "POST",
			json : true, // added this
			url : 'saveFeedback',
			'Content-Type' : 'application/x-www-form-urlencoded',
			data : prepareDataSet,
			success : function(json) {
				alert(json['response']);
				closeFeedbackPage();
			},
			error : function(e) {
				console.log("jQuery error message = " + e.message);
			}

		});
	}
</script>

</html>
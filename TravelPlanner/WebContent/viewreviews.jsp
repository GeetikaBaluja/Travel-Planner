<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- Font Awesome Icon Library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Reviews</title>
<style>
.checked {
	color: orange;
}
</style>
</head>
<body>

	<div class="reviews-container">
		<h2>Reviews</h2>
		<div id="review-list"></div>
		<button type="button" class="btn cancel" onclick="closeReviewsPage()">Close</button>
	</div>
	<script>
		function fetchReviewsAjax() {
			var prepareDataSet = {
				tourId : document.getElementById('tourId').value,
			}
			$.ajax({
				type : "POST",
				json : true, // added this
				url : 'fetchReviews',
				'Content-Type' : 'application/x-www-form-urlencoded',
				data : prepareDataSet,
				async : false,
				success : function(json) {
					for (var i = 0; i < json.length; i++) {
						createReviewsSkeleton(i,json[i]);
					}
				},
				error : function(e) {
					console.log("jQuery error message = " + e.message);
				}

			});
		}
		function showUserRatingWithStars(user_rating,name) {
			var star_mapping_arr = document.getElementsByName(name);
			var user_rating = parseInt(user_rating);
			for (var i = 0; i < user_rating; i++) {
				star_mapping_arr[i].classList.add("checked");
			}

		}
		function createReviewsSkeleton(reviews_count,dataObj) {
			var reviewListContainer=document.getElementById('review-list');
			var reviewDiv=document.createElement('div');
			reviewDiv.id=reviews_count;
			var customerNameLabel=document.createElement('label');
			customerNameLabel.style.margin='10px';
			var customerNameNode = document.createTextNode(dataObj['name']);
			customerNameLabel.appendChild(customerNameNode);
			reviewDiv.appendChild(customerNameLabel);
			for(var i=0;i<5;i++){
				var userRatingStarsSpan=document.createElement('span');
				userRatingStarsSpan.classList.add("fa");
				userRatingStarsSpan.classList.add("fa-star");
				userRatingStarsSpan.setAttribute("name","star_ratings"+reviews_count);
				reviewDiv.appendChild(userRatingStarsSpan);
				}
			var customerHighlights=document.createElement('p');
			customerHighlights.style.marginLeft='40px';
			var customerHighlightsNode = document.createTextNode(dataObj['highlights']);
			customerHighlights.appendChild(customerHighlightsNode);
			reviewDiv.appendChild(customerHighlights);
			reviewListContainer.appendChild(reviewDiv);
			showUserRatingWithStars(dataObj['user_rating'],"star_ratings"+reviews_count);
		}
	</script>
</body>
</html>
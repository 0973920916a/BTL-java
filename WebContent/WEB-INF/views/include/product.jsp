<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="col-sm col-md-6 col-lg ftco-animate">
	<div class="product">
		<a href="#" class="img-prod"><img class="img-fluid"
			src="${item.getImage() }" alt="Colorlib Template"></a>
		<div class="text py-3 px-3">
			<h3>
				<a href="#">${item.getName() }</a>
			</h3>
			<div class="d-flex">
				<div class="pricing">
					<p class="price">
						<span>${item.getPrice()	}</span>
					</p>
				</div>
				<div class="rating">
					<p class="text-right">
						<span class="ion-ios-star-outline"></span> <span
							class="ion-ios-star-outline"></span> <span
							class="ion-ios-star-outline"></span> <span
							class="ion-ios-star-outline"></span> <span
							class="ion-ios-star-outline"></span>
					</p>
				</div>
			</div>
			<hr>
			<p class="bottom-area d-flex">
				<a href="#" class="add-to-cart"><span>Thêm vào giỏ <i
						class="ion-ios-add ml-1"></i></span></a> <a href="#" class="ml-auto"><span><i
						class="ion-ios-heart-empty"></i></span></a>
			</p>
		</div>
	</div>
</div>
</body>
</html>
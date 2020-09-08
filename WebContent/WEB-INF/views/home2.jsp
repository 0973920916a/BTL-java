<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="Entity.Accounts"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Lato:100,300,400,700,900"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Condensed:300,400,700"
	rel="stylesheet">

<link rel="stylesheet" href="assets/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="assets/css/animate.css">

<link rel="stylesheet" href="assets/css/owl.carousel.min.css">
<link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
<link rel="stylesheet" href="assets/css/magnific-popup.css">

<link rel="stylesheet" href="assets/css/aos.css">

<link rel="stylesheet" href="assets/css/ionicons.min.css">

<link rel="stylesheet" href="assets/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="assets/css/jquery.timepicker.css">


<link rel="stylesheet" href="assets/css/flaticon.css">
<link rel="stylesheet" href="assets/css/icomoon.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
	<%
		HttpSession ss = request.getSession();
		if (ss.getAttribute("user") != null) {
			request.setAttribute("loginAction", "logout");
			request.setAttribute("logtext", "Đăng xuất");
			Object o = ss.getAttribute("user");
			Accounts acc = (Accounts) o;
			request.setAttribute("name", acc.getName());
		} else {
			request.setAttribute("loginAction", "login");
			request.setAttribute("logtext", "Đăng nhập");
			request.setAttribute("name", "Đăng nhập để mua hàng !");
		}
	%>
	<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="home">${name}</a>
			<br>
			<p>${message}</p>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#ftco-nav" aria-controls="ftco-nav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a href="home" class="nav-link">Home</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="dropdown04"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Shop</a>
						<div class="dropdown-menu" aria-labelledby="dropdown04">
							<a class="dropdown-item" href="product-single.html">Nhân viên</a>
							<a class="dropdown-item" href="cart.html">Quản trị</a>
						</div></li>

					<li class="nav-item"><a href="${loginAction}" class="nav-link">${logtext}</a></li>
					<li class="nav-item cta cta-colored"><a href="cart"
						class="nav-link"><span class="icon-shopping_cart"
							onclick="login"></span></a></li>

				</ul>
			</div>
		</div>
	</nav>
	<div class="hero-wrap js-fullheight"
		style="background-image: url('assets/images/bg_1.jpg');">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text js-fullheight align-items-center justify-content-center">
				<h3 class="v">Book Store - Best quality</h3>
				<h3 class="vr">9 - 2020</h3>
				<div class="col-md-11 ftco-animate text-center">
					<h1>Book Store</h1>
					<h2>
						<span>-</span>
					</h2>
				</div>
				<div class="mouse">
					<a href="#" class="mouse-icon">
						<div class="mouse-wheel">
							<span class="ion-ios-arrow-down"></span>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>

	<div class="goto-here"></div>

	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-content-center mb-3 pb-3">
				<div class="col-md-12 heading-section text-center ftco-animate">
					<h1 class="big">San pham</h1>
					<h2 class="mb-4">Book Store</h2>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<c:forEach items="${list}" var="item" varStatus="loop">
						<div class="col-sm col-md-6 col-lg ftco-animate">
						<form action="home" method="post">
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
										<button name="action" value="${item.getId()}" class="add-to-cart"><span>Thêm vào giỏ +</span></button> <a href="#" class="ml-auto">
										<span><i
												class="ion-ios-heart-empty"></i></span></a>
									</p>
								</div>
							</div>
							</form>
						</div>
					
				</c:forEach>
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-section-more img"
		style="background-image: url(assets/images/bg_5.jpg);">
		<div class="container">
			<div class="row justify-content-center mb-3 pb-3">
				<div class="col-md-12 heading-section ftco-animate">
					<h2>Mùa hè dài</h2>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center mb-3 pb-3">
				<div class="col-md-12 heading-section text-center ftco-animate">
					<h1 class="big">bai viet noi bat</h1>
					<h2>Bài viết</h2>
				</div>
			</div>
			<div class="row d-flex">
				<div class="col-md-4 d-flex ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="blog-single.html" class="block-20"
							style="background-image: url('assets/images/image_1.jpg');">
						</a>
						<div class="text mt-3 d-block">
							<h3 class="heading mt-3">
								<a href="#">Thời trang 2020</a>
							</h3>
							<div class="meta mb-3">
								<div>
									<a href="#">4 - 9 - 2020</a>
								</div>
								<div>
									<a href="#">Linh Chi</a>
								</div>
								<div>
									<a href="#" class="meta-chat"><span class="icon-chat"></span>
										3</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 d-flex ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="blog-single.html" class="block-20"
							style="background-image: url('assets/images/image_2.jpg');">
						</a>
						<div class="text mt-3">
							<h3 class="heading mt-3">
								<a href="#">Thời tiết 2020</a>
							</h3>
							<div class="meta mb-3">
								<div>
									<a href="#">4 - 9 - 2020</a>
								</div>
								<div>
									<a href="#">Linh Chi</a>
								</div>
								<div>
									<a href="#" class="meta-chat"><span class="icon-chat"></span>
										3</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 d-flex ftco-animate">
					<div class="blog-entry align-self-stretch">
						<a href="blog-single.html" class="block-20"
							style="background-image: url('assets/images/image_3.jpg');">
						</a>
						<div class="text mt-3">
							<h3 class="heading mt-3">
								<a href="#">Thời sự 2020</a>
							</h3>
							<div class="meta mb-3">
								<div>
									<a href="#">4 - 9 - 2020</a>
								</div>
								<div>
									<a href="#">Linh Chi</a>
								</div>
								<div>
									<a href="#" class="meta-chat"><span class="icon-chat"></span>
										3</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="ftco-section-parallax">
		<div class="parallax-img d-flex align-items-center">
			<div class="container">
				<div class="row d-flex justify-content-center py-5">
					<div class="col-md-7 text-center heading-section ftco-animate">
						<h1 class="big">Đăng kí</h1>
						<h2>Đăng kí để nhận thông báo !</h2>
						<div class="row d-flex justify-content-center mt-5">
							<div class="col-md-8">
								<form action="#" class="subscribe-form">
									<div class="form-group d-flex">
										<input type="text" class="form-control"
											placeholder="Nhập địa chỉ email..."> <input
											type="submit" value="Đăng kí" class="submit px-3">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<footer class="ftco-footer bg-light ftco-section">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">Linh Chi Store</h2>
						<ul
							class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
							<li class="ftco-animate"><a href="#"><span
									class="icon-twitter"></span></a></li>
							<li class="ftco-animate"><a href="#"><span
									class="icon-facebook"></span></a></li>
							<li class="ftco-animate"><a href="#"><span
									class="icon-instagram"></span></a></li>
						</ul>
					</div>
				</div>
				<div class="col-md">
					<div class="ftco-footer-widget mb-4 ml-md-5">
						<h2 class="ftco-heading-2">Menu</h2>
						<ul class="list-unstyled">
							<li><a href="#" class="py-2 d-block">Shop</a></li>
							<li><a href="#" class="py-2 d-block">Giới thiệu</a></li>
							<li><a href="#" class="py-2 d-block">Giỏ hàng</a></li>
							<li><a href="#" class="py-2 d-block">Liên hệ</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-4">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">Trợ giúp</h2>
						<div class="d-flex">
							<ul class="list-unstyled mr-l-5 pr-l-3 mr-4">
								<li><a href="#" class="py-2 d-block">Giao hàng</a></li>
								<li><a href="#" class="py-2 d-block">Tư vấn dịch vụ</a></li>
								<li><a href="#" class="py-2 d-block">Điều khoản</a></li>
								<li><a href="#" class="py-2 d-block">Lưu ý</a></li>
							</ul>
							<ul class="list-unstyled">
								<li><a href="#" class="py-2 d-block">FAQs</a></li>
								<li><a href="#" class="py-2 d-block">Contact</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-md">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">Thắc mắc vui lòng liên hệ</h2>
						<div class="block-23 mb-3">
							<ul>
								<li><span class="icon icon-map-marker"></span><span
									class="text">Linh Chi - ĐHHH</span></li>
								<li><a href="#"><span class="icon icon-phone"></span><span
										class="text">03 0321 0321</span></a></li>
								<li><a href="#"><span class="icon icon-envelope"></span><span
										class="text">linhchi@gmail.com</span></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">

					<p>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						<i class="icon-heart color-danger" aria-hidden="true"></i> by <a
							href="https://facebook.com" target="_blank">Chi</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</p>
				</div>
			</div>
		</div>
	</footer>



	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>


	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="assets/js/popper.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.easing.1.3.js"></script>
	<script src="assets/js/jquery.waypoints.min.js"></script>
	<script src="assets/js/jquery.stellar.min.js"></script>
	<script src="assets/js/owl.carousel.min.js"></script>
	<script src="assets/js/jquery.magnific-popup.min.js"></script>
	<script src="assets/js/aos.js"></script>
	<script src="assets/js/jquery.animateNumber.min.js"></script>
	<script src="assets/js/bootstrap-datepicker.js"></script>
	<script src="assets/js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="assets/js/google-map.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>
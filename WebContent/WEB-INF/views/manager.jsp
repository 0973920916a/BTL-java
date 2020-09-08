<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="Entity.Orders"%>
<%@ page import="Entity.Accounts"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lí sản phẩm</title>
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
			<a class="navbar-brand" href="home">${name}</a> <br>
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
							<a class="dropdown-item" href="employee">Nhân viên</a> <a
								class="dropdown-item" href="manager">Quản trị</a>
						</div></li>

					<li class="nav-item"><a href="${loginAction}" class="nav-link">${logtext}</a></li>
					<li class="nav-item cta cta-colored"><a href="cart"
						class="nav-link"><span class="icon-shopping_cart"
							onclick="login"></span></a></li>

				</ul>
			</div>
		</div>
	</nav>
	<%-- --%>
	<section class="ftco-section ftco-cart">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ftco-animate">
					<div class="cart-list">
						<table class="table">
							<thead class="thead-primary">
								<tr class="text-center">
									<th>Id</th>
									<th>Tên</th>
									<th>Hình</th>
									<th>Giá</th>
									<th>Ngày tạo</th>
									<th>#</th>
									<th>#</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="item">
									<form action="editproduct" method="get">
										<tr class="text-center">
											<td>${item.getId() }</td>
											<td>${item.getName() }</td>
											<td>${item.getImage() }</td>
											<td>${item.getPrice() }</td>
											<td>${item.getCreateDate()}</td>
											<td><button name="action" value="${item.getId()}"
													target="_blank">Chi tiết</button></td>
											<td><button name="action" value="${item.getId()}delete"
													target="_blank">Xóa</button></td>
										</tr>
										<!-- END TR-->
									</form>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<form action="manager" method="post">
			<div class="row justify-content-end">

				<div class="col col-lg-5 col-md-6 mt-5 cart-wrap ftco-animate">
					<p>
						<label>Nhập tên:</label>
					</p>
					<p>
						<input name="name" type="text" placeholder="  Nhap ten..."
							style="width: 300px">
					</p>
					<p>
						<label>Link ảnh:</label>
					</p>
					<p>
						<input name="image" type="text" placeholder="  Nhap link anh..."
							style="width: 300px">
					</p>
					<p>
						<label>Nhập giá:</label>
					</p>
					<p>
						<input name="price" type="number" placeholder="  Nhap gia..."
							min="0" style="width: 300px">
					</p>
					<p>
						<button name="action" value="pay">LƯU SẢN PHẨM</button>
					</p>
					<p>${message}</p>
				</div>
			</div>
		</form>
	</section>

	<%-- --%>
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
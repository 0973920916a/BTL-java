<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="Entity.Carts"%>
<%@ page import="Entity.Products"%>
<%@ page import="Entity.Accounts"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ Hàng</title>
<meta charset="utf-8">
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
							<a class="dropdown-item" href="employee">Nhân viên</a>
							<a class="dropdown-item" href="manager">Quản trị</a>
						</div></li>

					<li class="nav-item"><a href="${loginAction}" class="nav-link">${logtext}</a></li>
					<li class="nav-item cta cta-colored"><a href="cart"
						class="nav-link"><span class="icon-shopping_cart"
							onclick="login"></span></a></li>

				</ul>
			</div>
		</div>
	</nav>
	<section class="ftco-section ftco-cart">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ftco-animate">
					<div class="cart-list">
						<table class="table">
							<thead class="thead-primary">
								<tr class="text-center">
									<th>Sản phẩm</th>
									<th>Giá</th>
									<th>Số lượng</th>
									<th>Tổng</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="item" varStatus="myIndex">
									<form action="cart" method="post">
										<tr class="text-center">
											<td>${listProduct.get(myIndex.index).getName()}</td>
											<td>${item.getPrice()}đ</td>
											<td>${item.getQuantity()}</td>
											<td>${item.getPrice()*item.getQuantity()}đ</td>
										</tr>
									</form>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<form action="cart" method="post">
				<div class="row justify-content-end">

					<div class="col col-lg-5 col-md-6 mt-5 cart-wrap ftco-animate">
						<p>
							<h4 style="color: red">Tổng tiền: ${total} đ</h4>
						</p>
						<p>
							<label>Địa chỉ: ${order.getAddress()}</label>
						</p>
						<p>
							<label>Email: ${order.getEmail()}</label>
						</p>
						<p>
							<label>Số điện thoại: ${order.getPhone()}</label>
						</p>
						<p>
							<label>Tên người nhận: ${order.getName()}</label>
						</p>
						<p>
							<label>Ngày tạo: ${order.getDate()}</label>
						</p>
					</div>


				</div>
			</form>
		</div>
	</section>

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

	<script>
		$(document).ready(function() {

			var quantitiy = 0;
			$('.quantity-right-plus').click(function(e) {

				// Stop acting like a button
				e.preventDefault();
				// Get the field name
				var quantity = parseInt($('#quantity').val());

				// If is not undefined

				$('#quantity').val(quantity + 1);

				// Increment

			});

			$('.quantity-left-minus').click(function(e) {
				// Stop acting like a button
				e.preventDefault();
				// Get the field name
				var quantity = parseInt($('#quantity').val());

				// If is not undefined

				// Increment
				if (quantity > 0) {
					$('#quantity').val(quantity - 1);
				}
			});

		});
	</script>
</body>
</html>
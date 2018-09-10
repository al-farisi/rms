<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>RMS - Resource Management System</title>

<!-- Bootstrap core CSS -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../css/styles.css" rel="stylesheet">

</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="/rms-servlet-web">Mitrais - RMS</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a class="nav-link"
						href="/rms-servlet-web">Home <span class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/rms-servlet-web/users/list">Users</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/rms-servlet-web/products/list">Products</a></li>
					<%
						if (session.getAttribute("user") == null) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="/rms-servlet-web/login">Log In</a></li>
					<%
						} else {
					%>
					<li class="nav-item"><a class="nav-link"
						href="/rms-servlet-web/logout">Log Out</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Content -->
	<div class="container">
		<div style="display:inline-block; vertical-align:top; height:100px;"></div>
		<h1>List of Users</h1>
		<br>
		<div class="row">
			<div class="col-md-8">
				<div class="row">
					<a href="#"
						onclick="window.location.href='add-user-form'; return false;"
						class="btn btn-info" role="button">Add User</a> <br>
				</div>
				</br>
				<div class="row">

					<table class="table table hover">
						<thead>
							<tr>
								<th scope="col">Username</th>
								<th scope="col">Password</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="user" items="${users}">

								<!-- set up a link for each student -->
								<c:url var="tempLink" value="/users/load">
									<c:param name="userId" value="${user.id}" />
								</c:url>

								<!--  set up a link to delete a student -->
								<c:url var="deleteLink" value="/users/delete">
									<c:param name="userId" value="${user.id}" />
								</c:url>

								<tr>
									<td>${user.userName}</td>
									<td>${user.password}</td>
									<td><a href="${tempLink}" class="btn btn-warning"
										role="button">Update</a> <a href="${deleteLink}"
										class="btn btn-danger" role="button"
										onclick="if (!(confirm('Are you sure you want to delete this user?'))) return false">
											Delete</a></td>
								</tr>

							</c:forEach>

						</tbody>
					</table>
				</div>


			</div>


			<!-- Sidebar Widgets Column -->
			<div class="col-md-4">

				<!-- Search Widget -->
				<div class="card my-4">
					<h5 class="card-header">Search</h5>
					<div class="card-body">
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="Search for..."> <span
								class="input-group-btn">
								<button class="btn btn-secondary" type="button">Go!</button>
							</span>
						</div>
					</div>
				</div>

				<!-- Side Widget -->
				<div class="card my-4">
					<h5 class="card-header">Side Widget</h5>
					<div class="card-body">You can put anything you want inside
						of these side widgets. They are easy to use, and feature the new
						Bootstrap 4 card containers!</div>
				</div>

			</div>
		</div>
		<!-- /.container -->

		<!-- Footer -->
		<footer class="py-5 bg-dark">
			<div class="container">
				<p class="m-0 text-center text-white">Copyright &copy; Your
					Website 2018</p>
			</div>
	</div>
	<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>

</body>

</html>

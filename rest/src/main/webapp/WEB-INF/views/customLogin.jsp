<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

  <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <script src="/resources/vendor/jquery/jquery.min.js"></script>
  <!-- Custom styles for this template-->
  <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<title>Insert title here</title>
</head>
<body>
	<h1>Custom Login Page</h1>
	
	<form role="form" method="post" action="/login">
		<fieldset>
			<div class="form-group">
				<input class="form-control" placeholder="userid" name="username" type="text" autofocus>				
			</div>
			<div class="form-group">
				<input class="form-control" placeholder="Password" name="password" type="password" vlaue="">
			</div>
			<div class="checkbox">
				<label><input name="remember-me" type="checkbox">Remember Me</label>
			</div>
			<button class="btn btn-lg btn-success btn-block">Login</button>
		</fieldset>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
</body>

<script>
	$(document).ready(function(){
		
		$(".btn-success").on("click", function(e){
			e.preventDefault();
			$("form").submit();
		});
		
	});
		
</script>

 <!-- Bootstrap core JavaScript-->

  <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="/resources/js/sb-admin-2.min.js"></script>
  
  <script src="/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</html>
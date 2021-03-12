<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>員工的登入頁面</title>

    <!-- Custom fonts for this template-->
    <link href="<%=request.getContextPath()%>/dist/backTemp/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="<%=request.getContextPath()%>/dist/backTemp/css/sb-admin-2.min.css" rel="stylesheet">
    <style>
    .bg-gradient-primary{
    	background-color:white;
    	background-image: linear-gradient(180deg,#FFFFFF 10%,#FFFFFF 100%);
    }
    .father{
    	position:relative;
    }
    .son{
    	position:absolute;
    	width:100%;
    	height:100%;
    	object-fit:cover;
    }
    </style>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block father"><img src="<%=request.getContextPath()%>/dist/images/gakki.jpg" class="son"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">員工登入</h1>
                                    </div>
                                    <%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
										<font style="color: red">請修正以下錯誤:</font>
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color: red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>
                                    <form  method="post" action="<%=request.getContextPath()%>/staff/staff.do">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user" name="staAcct" placeholder="Enter Email Address...">
                                 		</div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" name="staPswd" placeholder="Password">                                               
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">Remember
                                                    Me</label>
                                            </div>
                                        </div>
                                        <input type="hidden" name="action" value="login">
                                        <input class="btn btn-primary btn-user btn-block" type="submit" value="Login" style="background-color:#D8CF9E;border-color:#D8CF9E;">

                                        
										
                                    </form>
                                    
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="<%=request.getContextPath()%>/dist/backTemp/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="<%=request.getContextPath()%>/dist/backTemp/js/sb-admin-2.min.js"></script>

</body>

</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">ATI Admin Panel</span>
        <span class="text-white me-3">Welcome, <%= session.getAttribute("adminUser") %></span>
        <a href="${pageContext.request.contextPath}/adminLogout" class="btn btn-sm btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">
    <div class="row g-3">
        <div class="col-md-3">
            <a href="manageNotices.jsp" class="text-decoration-none">
                <div class="card text-white bg-primary text-center p-3">
                    <h5>Manage Notices</h5>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="uploadGallery.jsp" class="text-decoration-none">
                <div class="card text-white bg-success text-center p-3">
                    <h5>Gallery Upload</h5>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="manageResults.jsp" class="text-decoration-none">
                <div class="card text-white bg-warning text-center p-3">
                    <h5>Exam Results</h5>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="manageCourses.jsp" class="text-decoration-none">
                <div class="card text-white bg-secondary text-center p-3">
                    <h5>Courses</h5>
                </div>
            </a>
        </div>
    </div>
</div>
</body>
</html>
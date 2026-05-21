<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%@ include file="/includes/adminNavbar.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">

        <%@ include file="/includes/adminSidebar.jsp" %>

        <div class="col-md-9 col-lg-10">
            <h4 class="fw-bold text-primary mb-4">Dashboard</h4>

            <div class="row g-3">
                <div class="col-sm-6 col-lg-3">
                    <a href="${pageContext.request.contextPath}/admin/notices"
                       class="text-decoration-none">
                        <div class="card border-0 shadow-sm text-center p-3 h-100">
                            <div class="display-5 mb-2">📢</div>
                            <h6 class="fw-bold text-primary">Notices</h6>
                            <small class="text-muted">Manage newsline notices</small>
                        </div>
                    </a>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <a href="${pageContext.request.contextPath}/admin/courses"
                       class="text-decoration-none">
                        <div class="card border-0 shadow-sm text-center p-3 h-100">
                            <div class="display-5 mb-2">📚</div>
                            <h6 class="fw-bold text-success">Courses</h6>
                            <small class="text-muted">Add or edit programmes</small>
                        </div>
                    </a>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <a href="${pageContext.request.contextPath}/admin/gallery"
                       class="text-decoration-none">
                        <div class="card border-0 shadow-sm text-center p-3 h-100">
                            <div class="display-5 mb-2">🖼️</div>
                            <h6 class="fw-bold text-warning">Gallery</h6>
                            <small class="text-muted">Upload event images</small>
                        </div>
                    </a>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <a href="${pageContext.request.contextPath}/admin/results"
                       class="text-decoration-none">
                        <div class="card border-0 shadow-sm text-center p-3 h-100">
                            <div class="display-5 mb-2">📋</div>
                            <h6 class="fw-bold text-danger">Results</h6>
                            <small class="text-muted">Manage exam results</small>
                        </div>
                    </a>
                </div>
            </div>

            <div class="alert alert-info mt-4">
                <strong>Visitor count today:</strong>
                ${applicationScope.visitorCount} total visits
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
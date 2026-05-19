<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Courses - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<%@ include file="/includes/navbar.jsp" %>

<div class="container mt-4">
    <h2>Our Courses</h2>

    <%-- Group by category --%>
    <h4 class="mt-4">Diploma Programmes</h4>
    <div class="row">
        <c:forEach var="course" items="${courses}">
            <c:if test="${course.category == 'Diploma'}">
                <div class="col-md-4 mb-3">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">${course.name}</h5>
                            <p class="card-text text-muted">
                                Duration: ${course.duration}
                            </p>
                            <p class="card-text">${course.description}</p>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <h4 class="mt-4">Certificate Programmes</h4>
    <div class="row">
        <c:forEach var="course" items="${courses}">
            <c:if test="${course.category == 'Certificate'}">
                <div class="col-md-4 mb-3">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">${course.name}</h5>
                            <p class="card-text text-muted">
                                Duration: ${course.duration}
                            </p>
                            <p class="card-text">${course.description}</p>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <%-- Show message if no courses exist yet --%>
    <c:if test="${empty courses}">
        <div class="alert alert-info">
            No courses available at the moment. Check back soon.
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<%-- Increment visitor on load via servlet --%>
<%
    // Forward through HomeServlet for data loading
    // This page is reached AFTER HomeServlet sets attributes
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">ATI Badulla</a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/courses.jsp">Courses</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/gallery.jsp">Gallery</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
        </div>
    </div>
</nav>

<!-- News Ticker -->
<div class="news-ticker bg-warning py-1 px-3">
    <strong>Notices: </strong>
    <marquee behavior="scroll" direction="left" scrollamount="4">
        <c:forEach var="notice" items="${notices}">
            ${notice.title} &nbsp;|&nbsp;
        </c:forEach>
        <c:if test="${empty notices}">No notices at this time.</c:if>
    </marquee>
</div>

<!-- Carousel -->
<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <c:forEach var="img" items="${carouselImages}" varStatus="loop">
            <div class="carousel-item ${loop.first ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/uploads/${img.imagePath}"
                     class="d-block w-100" style="height:450px;object-fit:cover;"
                     alt="${img.caption}">
                <div class="carousel-caption d-none d-md-block">
                    <p>${img.caption}</p>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty carouselImages}">
            <div class="carousel-item active">
                <div class="bg-secondary text-white text-center py-5">
                    <h3>Welcome to ATI Badulla</h3>
                </div>
            </div>
        </c:if>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<!-- Visitor Counter -->
<div class="text-center my-3">
    <span class="badge bg-secondary fs-6">
        Visitors: ${applicationScope.visitorCount}
    </span>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
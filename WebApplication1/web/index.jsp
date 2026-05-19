<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATI Badulla - Home</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<%@ include file="/includes/navbar.jsp" %>

<%-- News Ticker --%>
<div class="bg-warning py-2 px-3 d-flex align-items-center">
    <span class="badge bg-danger me-2 flex-shrink-0">NOTICES</span>
    <div style="overflow:hidden; white-space:nowrap; flex:1;">
        <div class="ticker-content">
            <c:choose>
                <c:when test="${not empty notices}">
                    <c:forEach var="notice" items="${notices}">
                        <span class="me-5">${notice.title}</span>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <span>Welcome to ATI Badulla Web Portal</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%-- Carousel --%>
<div id="mainCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
    <div class="carousel-indicators">
        <c:forEach var="img" items="${carouselImages}" varStatus="loop">
            <button type="button" data-bs-target="#mainCarousel"
                    data-bs-slide-to="${loop.index}"
                    class="${loop.first ? 'active' : ''}"></button>
        </c:forEach>
    </div>
    <div class="carousel-inner">
        <c:choose>
            <c:when test="${not empty carouselImages}">
                <c:forEach var="img" items="${carouselImages}" varStatus="loop">
                    <div class="carousel-item ${loop.first ? 'active' : ''}">
                        <img src="${pageContext.request.contextPath}/assets/uploads/${img.imagePath}"
                             class="d-block w-100"
                             style="height:480px; object-fit:cover;"
                             alt="${img.caption}">
                        <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded p-2">
                            <p class="mb-0">${img.caption}</p>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="carousel-item active">
                    <div class="d-flex align-items-center justify-content-center bg-primary text-white"
                         style="height:480px;">
                        <div class="text-center">
                            <h1 class="display-4 fw-bold">ATI Badulla</h1>
                            <p class="lead">Advanced Technological Institute</p>
                            <a href="${pageContext.request.contextPath}/courses"
                               class="btn btn-light btn-lg mt-2">View Our Courses</a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <button class="carousel-control-prev" type="button"
            data-bs-target="#mainCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button"
            data-bs-target="#mainCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<%-- Visitor Counter --%>
<div class="bg-light border-bottom py-2 text-center">
    <small class="text-muted">
        <i>Total Visitors:</i>
        <strong class="text-primary">${applicationScope.visitorCount}</strong>
    </small>
</div>

<%-- Quick Links Section --%>
<div class="container my-5">
    <div class="row text-center g-4">
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/courses" class="text-decoration-none">
                <div class="card border-0 shadow-sm h-100 p-3">
                    <div class="card-body">
                        <div class="display-4 mb-2">📚</div>
                        <h5 class="card-title text-primary">Our Courses</h5>
                        <p class="card-text text-muted small">
                            Explore diploma and certificate programmes
                        </p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/gallery" class="text-decoration-none">
                <div class="card border-0 shadow-sm h-100 p-3">
                    <div class="card-body">
                        <div class="display-4 mb-2">🖼️</div>
                        <h5 class="card-title text-success">Event Gallery</h5>
                        <p class="card-text text-muted small">
                            Photos from our events and activities
                        </p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/results" class="text-decoration-none">
                <div class="card border-0 shadow-sm h-100 p-3">
                    <div class="card-body">
                        <div class="display-4 mb-2">📋</div>
                        <h5 class="card-title text-warning">Exam Results</h5>
                        <p class="card-text text-muted small">
                            Check your examination results here
                        </p>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/contact.jsp" class="text-decoration-none">
                <div class="card border-0 shadow-sm h-100 p-3">
                    <div class="card-body">
                        <div class="display-4 mb-2">📞</div>
                        <h5 class="card-title text-danger">Contact Us</h5>
                        <p class="card-text text-muted small">
                            Get in touch with ATI Badulla
                        </p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
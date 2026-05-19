<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<%@ include file="/includes/navbar.jsp" %>

<div class="container my-5">
    <h2 class="fw-bold text-primary mb-4">Event Gallery</h2>

    <c:choose>
        <c:when test="${not empty images}">
            <div class="row g-3">
                <c:forEach var="img" items="${images}">
                    <div class="col-md-4 col-sm-6">
                        <div class="card border-0 shadow-sm">
                            <img src="${pageContext.request.contextPath}/assets/uploads/${img.imagePath}"
                                 class="card-img-top"
                                 style="height:200px; object-fit:cover;"
                                 alt="${img.caption}">
                            <div class="card-body py-2">
                                <p class="card-text small text-muted mb-0">${img.caption}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">
                No gallery images available yet. Check back soon.
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/includes/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
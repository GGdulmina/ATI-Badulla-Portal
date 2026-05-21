<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
    <title>Manage Gallery - ATI Admin</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .gallery-thumb {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 6px 6px 0 0;
        }
        .carousel-badge {
            position: absolute;
            top: 8px;
            left: 8px;
        }
    </style>
</head>
<body class="bg-light">

<%@ include file="/includes/adminNavbar.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">

        <%@ include file="/includes/adminSidebar.jsp" %>

        <div class="col-md-9 col-lg-10">
            <h4 class="fw-bold text-primary mb-3">Manage Gallery</h4>

            <%-- Upload form --%>
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-warning fw-bold">Upload New Image</div>
                <div class="card-body">
                    <%-- enctype is REQUIRED for file upload --%>
                    <form action="${pageContext.request.contextPath}/admin/gallery"
                          method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="upload">
                        <div class="row g-2 align-items-end">
                            <div class="col-md-4">
                                <label class="form-label">
                                    Image File <span class="text-danger">*</span>
                                </label>
                                <input type="file" name="imageFile"
                                       class="form-control" accept="image/*" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Caption</label>
                                <input type="text" name="caption" class="form-control"
                                       placeholder="Image caption (optional)">
                            </div>
                            <div class="col-md-2 d-flex align-items-center gap-2 pt-3">
                                <input type="checkbox" name="isCarousel"
                                       class="form-check-input" id="carouselCheck">
                                <label class="form-check-label" for="carouselCheck">
                                    Add to Carousel
                                </label>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-warning w-100">
                                    Upload
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%-- Carousel count info --%>
            <div class="alert alert-info py-2 small mb-3">
                <strong>Carousel:</strong> The homepage shows the 10 most recently
                marked carousel images. Toggle the ⭐ button on any image to
                add or remove it from the carousel.
            </div>

            <%-- Image grid --%>
            <c:choose>
                <c:when test="${not empty images}">
                    <div class="row g-3">
                        <c:forEach var="img" items="${images}">
                            <div class="col-md-3 col-sm-4 col-6">
                                <div class="card shadow-sm position-relative">
                                    <%-- Carousel badge --%>
                                    <c:if test="${img.carousel}">
                                        <span class="badge bg-warning text-dark carousel-badge">
                                            ⭐ Carousel
                                        </span>
                                    </c:if>

                                    <img src="${pageContext.request.contextPath}/assets/uploads/${img.imagePath}"
                                         class="gallery-thumb"
                                         alt="${img.caption}"
                                         onerror="this.src='https://via.placeholder.com/300x160?text=Image'">

                                    <div class="card-body p-2">
                                        <p class="small text-muted mb-2" style="min-height:32px;">
                                            ${empty img.caption ? '(no caption)' : img.caption}
                                        </p>

                                        <%-- Toggle carousel --%>
                                        <form action="${pageContext.request.contextPath}/admin/gallery"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="action" value="toggleCarousel">
                                            <input type="hidden" name="id" value="${img.id}">
                                            <button type="submit"
                                                    class="btn btn-sm ${img.carousel ? 'btn-warning' : 'btn-outline-secondary'} w-100 mb-1">
                                                ${img.carousel ? '⭐ Remove from Carousel' : '☆ Add to Carousel'}
                                            </button>
                                        </form>

                                        <%-- Delete --%>
                                        <form action="${pageContext.request.contextPath}/admin/gallery"
                                              method="post"
                                              onsubmit="return confirm('Delete this image permanently?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${img.id}">
                                            <button type="submit"
                                                    class="btn btn-sm btn-outline-danger w-100">
                                                🗑 Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-secondary text-center py-5">
                        No images uploaded yet. Use the form above to upload your first image.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
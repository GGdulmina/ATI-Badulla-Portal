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
    <title>Manage Courses - ATI Admin</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%@ include file="/includes/adminNavbar.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">

        <%@ include file="/includes/adminSidebar.jsp" %>

        <div class="col-md-9 col-lg-10">
            <h4 class="fw-bold text-primary mb-3">Manage Courses</h4>

            <%-- Add course form --%>
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-success text-white fw-bold">Add New Course</div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/courses"
                          method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <label class="form-label">Course Name <span class="text-danger">*</span></label>
                                <input type="text" name="name" class="form-control"
                                       placeholder="e.g. Diploma in ICT" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Duration</label>
                                <input type="text" name="duration" class="form-control"
                                       placeholder="e.g. 2 Years">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Category</label>
                                <select name="category" class="form-select">
                                    <option value="Diploma">Diploma</option>
                                    <option value="Certificate">Certificate</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control"
                                          rows="2" placeholder="Course description..."></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-success px-4">
                                    Add Course
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%-- Courses table --%>
            <div class="card shadow-sm">
                <div class="card-header fw-bold">All Courses</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Category</th>
                                    <th>Duration</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty courses}">
                                        <c:forEach var="c" items="${courses}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td class="fw-bold">${c.name}</td>
                                                <td>
                                                    <span class="badge ${c.category == 'Diploma' ? 'bg-primary' : 'bg-success'}">
                                                        ${c.category}
                                                    </span>
                                                </td>
                                                <td>${c.duration}</td>
                                                <td class="text-muted small">${c.description}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#editCourseModal"
                                                            data-id="${c.id}"
                                                            data-name="${c.name}"
                                                            data-duration="${c.duration}"
                                                            data-description="${c.description}"
                                                            data-category="${c.category}">
                                                        Edit
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/admin/courses"
                                                          method="post" class="d-inline"
                                                          onsubmit="return confirm('Delete this course?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <button type="submit"
                                                                class="btn btn-sm btn-outline-danger">
                                                            Delete
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">
                                                No courses yet. Add one above.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- Edit Course Modal --%>
<div class="modal fade" id="editCourseModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Edit Course</h5>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/courses" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="editCourseId">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Course Name</label>
                        <input type="text" name="name" id="editCourseName"
                               class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Duration</label>
                        <input type="text" name="duration" id="editCourseDuration"
                               class="form-control">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <select name="category" id="editCourseCategory" class="form-select">
                            <option value="Diploma">Diploma</option>
                            <option value="Certificate">Certificate</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" id="editCourseDesc"
                                  class="form-control" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('editCourseModal').addEventListener('show.bs.modal', function (e) {
        const btn = e.relatedTarget;
        document.getElementById('editCourseId').value       = btn.dataset.id;
        document.getElementById('editCourseName').value     = btn.dataset.name;
        document.getElementById('editCourseDuration').value = btn.dataset.duration;
        document.getElementById('editCourseDesc').value     = btn.dataset.description;
        document.getElementById('editCourseCategory').value = btn.dataset.category;
    });
</script>
</body>
</html>
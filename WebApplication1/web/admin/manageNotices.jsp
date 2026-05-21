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
    <title>Manage Notices - ATI Admin</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%@ include file="/includes/adminNavbar.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">

        <%-- Sidebar --%>
        <%@ include file="/includes/adminSidebar.jsp" %>

        <%-- Main content --%>
        <div class="col-md-9 col-lg-10">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="fw-bold text-primary">Manage Notices</h4>
            </div>

            <%-- Success message --%>
            <c:if test="${not empty param.msg}">
                <div class="alert alert-success alert-dismissible fade show">
                    Notice saved successfully.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <%-- Add new notice form --%>
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white fw-bold">
                    Add New Notice
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/notices"
                          method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="row g-2">
                            <div class="col-md-8">
                                <label class="form-label">Title <span class="text-danger">*</span></label>
                                <input type="text" name="title" class="form-control"
                                       placeholder="Notice title" required maxlength="200">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Priority</label>
                                <select name="priority" class="form-select">
                                    <option value="0">Normal</option>
                                    <option value="1">Important</option>
                                    <option value="2">Urgent</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Content <span class="text-danger">*</span></label>
                                <textarea name="content" class="form-control" rows="3"
                                          placeholder="Notice content..." required></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary px-4">
                                    Save Notice
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%-- Existing notices table --%>
            <div class="card shadow-sm">
                <div class="card-header fw-bold">All Notices</div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Title</th>
                                    <th>Content</th>
                                    <th>Priority</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty notices}">
                                        <c:forEach var="n" items="${notices}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td>${n.title}</td>
                                                <td class="text-muted small">${n.content}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${n.priority == 2}">
                                                            <span class="badge bg-danger">Urgent</span>
                                                        </c:when>
                                                        <c:when test="${n.priority == 1}">
                                                            <span class="badge bg-warning text-dark">Important</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">Normal</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="small">${n.postedDate}</td>
                                                <td>
                                                    <%-- Edit button triggers modal --%>
                                                    <button class="btn btn-sm btn-outline-primary"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#editModal"
                                                            data-id="${n.id}"
                                                            data-title="${n.title}"
                                                            data-content="${n.content}"
                                                            data-priority="${n.priority}">
                                                        Edit
                                                    </button>
                                                    <%-- Delete --%>
                                                    <form action="${pageContext.request.contextPath}/admin/notices"
                                                          method="post" class="d-inline"
                                                          onsubmit="return confirm('Delete this notice?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${n.id}">
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
                                                No notices yet. Add one above.
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

<%-- Edit Modal --%>
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Edit Notice</h5>
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/notices" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" id="editId">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Title</label>
                        <input type="text" name="title" id="editTitle"
                               class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Content</label>
                        <textarea name="content" id="editContent"
                                  class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Priority</label>
                        <select name="priority" id="editPriority" class="form-select">
                            <option value="0">Normal</option>
                            <option value="1">Important</option>
                            <option value="2">Urgent</option>
                        </select>
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
    // Populate edit modal with row data when Edit button is clicked
    document.getElementById('editModal').addEventListener('show.bs.modal', function (e) {
        const btn = e.relatedTarget;
        document.getElementById('editId').value       = btn.dataset.id;
        document.getElementById('editTitle').value    = btn.dataset.title;
        document.getElementById('editContent').value  = btn.dataset.content;
        document.getElementById('editPriority').value = btn.dataset.priority;
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Notices</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-dark bg-dark px-3">
    <span class="navbar-brand">Admin — Notices</span>
    <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
       class="btn btn-sm btn-secondary">← Dashboard</a>
</nav>

<div class="container mt-4">

    <%-- CREATE form --%>
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">Add New Notice</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/notices" method="post">
                <input type="hidden" name="action" value="create">
                <div class="mb-2">
                    <input type="text" name="title" class="form-control"
                           placeholder="Notice title" required>
                </div>
                <div class="mb-2">
                    <textarea name="content" class="form-control" rows="3"
                              placeholder="Notice content" required></textarea>
                </div>
                <div class="mb-2">
                    <select name="priority" class="form-select">
                        <option value="0">Normal</option>
                        <option value="1">Important</option>
                        <option value="2">Urgent</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Save Notice</button>
            </form>
        </div>
    </div>

    <%-- LIST with edit and delete --%>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>Title</th>
                <th>Content</th>
                <th>Priority</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="notice" items="${notices}">
                <tr>
                    <td>${notice.title}</td>
                    <td>${notice.content}</td>
                    <td>
                        <c:choose>
                            <c:when test="${notice.priority == 2}">
                                <span class="badge bg-danger">Urgent</span>
                            </c:when>
                            <c:when test="${notice.priority == 1}">
                                <span class="badge bg-warning text-dark">Important</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">Normal</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${notice.postedDate}</td>
                    <td>
                        <%-- DELETE button --%>
                        <form action="${pageContext.request.contextPath}/admin/notices"
                              method="post" style="display:inline"
                              onsubmit="return confirm('Delete this notice?')">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${notice.id}">
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty notices}">
                <tr>
                    <td colspan="5" class="text-center text-muted">No notices yet.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
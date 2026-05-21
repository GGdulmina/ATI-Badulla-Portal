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
    <title>Manage Results - ATI Admin</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">

<%@ include file="/includes/adminNavbar.jsp" %>

<div class="container-fluid mt-4">
    <div class="row">

        <%@ include file="/includes/adminSidebar.jsp" %>

        <div class="col-md-9 col-lg-10">
            <h4 class="fw-bold text-primary mb-3">Manage Exam Results</h4>

            <%-- Add result form --%>
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-danger text-white fw-bold">Add New Result</div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/results"
                          method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="row g-2">
                            <div class="col-md-3">
                                <label class="form-label">
                                    Student Index <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="studentIndex" class="form-control"
                                       placeholder="e.g. ATI/2024/001" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">
                                    Course Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="courseName" class="form-control"
                                       placeholder="e.g. Diploma in ICT" required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">
                                    Marks (0–100) <span class="text-danger">*</span>
                                </label>
                                <input type="number" name="marks" class="form-control"
                                       min="0" max="100" required
                                       oninput="previewGrade(this.value)">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Grade (auto)</label>
                                <input type="text" id="gradePreview" class="form-control"
                                       readonly placeholder="—">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">
                                    Exam Date <span class="text-danger">*</span>
                                </label>
                                <input type="date" name="examDate" class="form-control" required>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-danger px-4">
                                    Add Result
                                </button>
                                <small class="text-muted ms-2">
                                    Grade is calculated automatically from marks.
                                </small>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <%-- Results table --%>
            <div class="card shadow-sm">
                <div class="card-header fw-bold d-flex justify-content-between">
                    <span>All Results
                        <span class="badge bg-secondary ms-1">${results.size()}</span>
                    </span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>#</th>
                                    <th>Index No.</th>
                                    <th>Course</th>
                                    <th>Marks</th>
                                    <th>Grade</th>
                                    <th>Exam Date</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty results}">
                                        <c:forEach var="r" items="${results}" varStatus="s">
                                            <tr>
                                                <td>${s.count}</td>
                                                <td class="fw-bold">${r.studentIndex}</td>
                                                <td>${r.courseName}</td>
                                                <td>${r.marks}</td>
                                                <td>
                                                    <span class="badge
                                                        ${r.grade == 'A' ? 'bg-success' :
                                                          r.grade == 'B' ? 'bg-primary' :
                                                          r.grade == 'C' ? 'bg-warning text-dark' :
                                                          r.grade == 'S' ? 'bg-info text-dark' : 'bg-danger'}">
                                                        ${r.grade}
                                                    </span>
                                                </td>
                                                <td>${r.examDate}</td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/results"
                                                          method="post"
                                                          onsubmit="return confirm('Delete this result?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${r.id}">
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
                                            <td colspan="7" class="text-center text-muted py-4">
                                                No results added yet.
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Live grade preview as admin types marks
    function previewGrade(marks) {
        const m = parseInt(marks);
        let grade = '';
        if      (m >= 75) grade = 'A';
        else if (m >= 65) grade = 'B';
        else if (m >= 55) grade = 'C';
        else if (m >= 40) grade = 'S';
        else if (marks)   grade = 'F';
        document.getElementById('gradePreview').value = grade;
    }
</script>
</body>
</html>
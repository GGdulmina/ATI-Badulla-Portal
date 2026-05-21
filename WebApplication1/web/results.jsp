<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Results - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<%@ include file="/includes/navbar.jsp" %>

<div class="container my-5">
    <h2 class="fw-bold text-primary mb-4">Exam Results</h2>

    <%-- Search form --%>
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/results" method="get"
                  class="row g-2 align-items-end">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Search by Student Index Number</label>
                    <input type="text" name="index" class="form-control"
                           placeholder="e.g. ATI/2024/001"
                           value="${searchIndex}">
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary w-100">Search</button>
                </div>
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/results"
                       class="btn btn-outline-secondary w-100">Show All</a>
                </div>
            </form>
        </div>
    </div>

    <%-- Results table --%>
    <c:choose>
        <c:when test="${not empty results}">
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>Index No.</th>
                            <th>Course</th>
                            <th>Marks</th>
                            <th>Grade</th>
                            <th>Exam Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="result" items="${results}">
                            <tr>
                                <td class="fw-bold">${result.studentIndex}</td>
                                <td>${result.courseName}</td>
                                <td>${result.marks}</td>
                                <td>
                                    <span class="badge
                                        ${result.grade == 'A' ? 'bg-success' :
                                          result.grade == 'B' ? 'bg-primary' :
                                          result.grade == 'C' ? 'bg-warning text-dark' :
                                          result.grade == 'S' ? 'bg-info text-dark' : 'bg-danger'}">
                                        ${result.grade}
                                    </span>
                                </td>
                                <td>${result.examDate}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-warning">
                <c:choose>
                    <c:when test="${not empty searchIndex}">
                        No results found for index number <strong>${searchIndex}</strong>.
                        Please check the index number and try again.
                    </c:when>
                    <c:otherwise>
                        No exam results have been published yet.
                    </c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/includes/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="col-md-3 col-lg-2">
    <div class="card shadow-sm">
        <div class="card-header bg-secondary text-white fw-bold small">
            ADMIN MENU
        </div>
        <div class="list-group list-group-flush">
            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
               class="list-group-item list-group-item-action">
                🏠 Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/notices"
               class="list-group-item list-group-item-action">
                📢 Notices
            </a>
            <a href="${pageContext.request.contextPath}/admin/courses"
               class="list-group-item list-group-item-action">
                📚 Courses
            </a>
            <a href="${pageContext.request.contextPath}/admin/gallery"
               class="list-group-item list-group-item-action">
                🖼️ Gallery
            </a>
            <a href="${pageContext.request.contextPath}/admin/results"
               class="list-group-item list-group-item-action">
                📋 Results
            </a>
        </div>
    </div>
</div>
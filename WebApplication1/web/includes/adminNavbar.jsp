<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-dark bg-dark px-3">
    <div class="container-fluid">
        <span class="navbar-brand fw-bold">⚙️ ATI Badulla — Admin</span>
        <div class="d-flex align-items-center gap-3">
            <span class="text-white-50 small">
                Logged in as: <strong class="text-white">
                    <%= session.getAttribute("adminUser") %>
                </strong>
            </span>
            <a href="${pageContext.request.contextPath}/adminLogout"
               class="btn btn-sm btn-outline-danger">Logout</a>
        </div>
    </div>
</nav>
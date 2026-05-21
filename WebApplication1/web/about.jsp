<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<%@ include file="/includes/navbar.jsp" %>

<div class="container my-5">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <h2 class="fw-bold text-primary mb-4">About ATI Badulla</h2>

            <p class="lead">
                The Advanced Technological Institute (ATI) Badulla is a government-owned
                technical and vocational education institution operating under the Ministry
                of Education, Sri Lanka.
            </p>

            <hr class="my-4">

            <h4 class="text-secondary">Our Mission</h4>
            <p>
                To provide quality technical education and training to empower youth with
                practical skills that meet industry demands and contribute to national
                development.
            </p>

            <h4 class="text-secondary mt-4">Our Vision</h4>
            <p>
                To be the leading centre of excellence in technical and vocational
                education in the Uva Province.
            </p>

            <hr class="my-4">

            <h4 class="text-secondary">Quick Facts</h4>
            <div class="row g-3 mt-2">
                <div class="col-md-6">
                    <div class="card border-start border-primary border-4 shadow-sm">
                        <div class="card-body">
                            <h6 class="text-muted mb-1">Location</h6>
                            <p class="mb-0 fw-bold">Badulla, Uva Province, Sri Lanka</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-start border-success border-4 shadow-sm">
                        <div class="card-body">
                            <h6 class="text-muted mb-1">Established</h6>
                            <p class="mb-0 fw-bold">Under Ministry of Education</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-start border-warning border-4 shadow-sm">
                        <div class="card-body">
                            <h6 class="text-muted mb-1">Programmes Offered</h6>
                            <p class="mb-0 fw-bold">Diplomas & Certificates</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card border-start border-danger border-4 shadow-sm">
                        <div class="card-body">
                            <h6 class="text-muted mb-1">Medium of Instruction</h6>
                            <p class="mb-0 fw-bold">Sinhala, Tamil & English</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
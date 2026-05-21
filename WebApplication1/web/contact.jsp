<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - ATI Badulla</title>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<%@ include file="/includes/navbar.jsp" %>

<div class="container my-5">
    <h2 class="fw-bold text-primary mb-4">Contact Us</h2>
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h5 class="card-title text-secondary">Get In Touch</h5>
                    <hr>
                    <p><strong>📍 Address:</strong><br>
                       Advanced Technological Institute,<br>
                       Badulla, Uva Province,<br>
                       Sri Lanka.
                    </p>
                    <p><strong>📞 Phone:</strong><br>
                       +94 55 222 XXXX
                    </p>
                    <p><strong>📧 Email:</strong><br>
                       info@ati-badulla.edu.lk
                    </p>
                    <p><strong>🕐 Office Hours:</strong><br>
                       Monday – Friday: 8:00 AM – 4:30 PM
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card shadow-sm h-100">
                <div class="card-body">
                    <h5 class="card-title text-secondary">Send a Message</h5>
                    <hr>
                    <form>
                        <div class="mb-3">
                            <label class="form-label">Your Name</label>
                            <input type="text" class="form-control" placeholder="Full name">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <input type="email" class="form-control" placeholder="email@example.com">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Message</label>
                            <textarea class="form-control" rows="4"
                                      placeholder="Your message here..."></textarea>
                        </div>
                        <button type="button" class="btn btn-primary"
                                onclick="alert('Thank you! We will get back to you soon.')">
                            Send Message
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
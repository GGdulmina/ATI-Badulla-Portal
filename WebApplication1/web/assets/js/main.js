document.addEventListener('DOMContentLoaded', function () {

    // Pause news ticker on hover
    const ticker = document.querySelector('.ticker-content');
    if (ticker) {
        ticker.addEventListener('mouseenter', () => {
            ticker.style.animationPlayState = 'paused';
        });
        ticker.addEventListener('mouseleave', () => {
            ticker.style.animationPlayState = 'running';
        });
    }

    // Highlight active navbar link based on current URL
    const links = document.querySelectorAll('.navbar .nav-link');
    links.forEach(link => {
        if (window.location.href.includes(link.getAttribute('href'))) {
            link.classList.add('active', 'fw-bold');
        }
    });

    // Auto-dismiss alerts after 4 seconds
    document.querySelectorAll('.alert-success').forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 4000);
    });

    // Confirm before all delete forms
    document.querySelectorAll('form[data-confirm]').forEach(form => {
        form.addEventListener('submit', function (e) {
            if (!confirm(this.dataset.confirm)) e.preventDefault();
        });
    });
});
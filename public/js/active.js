document.addEventListener("DOMContentLoaded", function () {
    const links = document.querySelectorAll(".side-nav ul a");

    function setActiveLink(activeUrl) {
        links.forEach(link => link.classList.remove("active"));

        // Add active class to the currently viewed link
        links.forEach(link => {
            if (link.getAttribute("href") === activeUrl) {
                link.classList.add("active");
            }
        });
    }

    // Add click event listener to update the active class
    links.forEach(link => {
        link.addEventListener("click", function (event) {
            const pageUrl = this.getAttribute("href");
            setActiveLink(pageUrl);
        });
    });

    setActiveLink("pages/dashboard.html");
});

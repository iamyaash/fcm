document.addEventListener("DOMContentLoaded", function () {
    const links = document.querySelectorAll(".side-nav ul a");

    // Function to handle active link highlighting
    function setActiveLink(activeUrl) {
        // Remove active class from all links
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
            const pageUrl = this.getAttribute("href"); // Get the clicked page URL
            setActiveLink(pageUrl); // Highlight the active link
        });
    });

    // Highlight the default active page (home.html) on page load
    setActiveLink("pages/home.html");
});

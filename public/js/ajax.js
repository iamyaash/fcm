document.addEventListener("DOMContentLoaded", function () {
    const links = document.querySelectorAll(".side-nav ul a");
    const contentArea = document.querySelector(".content");

    // Function to load a page
    function loadPage(pageUrl) {
        contentArea.innerHTML = `<div class="loading">Loading...</div>`;

        fetch(pageUrl)
            .then(response => {
                console.log(`Fetch response for ${pageUrl}:`, response);
                if (!response.ok) {
                    throw new Error(`Page not found: ${response.status}`);
                }
                return response.text();
            })
            .then(data => {
                contentArea.innerHTML = data;
            })
            .catch(error => {
                console.error(`Error loading ${pageUrl}:`, error);
                contentArea.innerHTML = `<h1>Error</h1><p>${error.message}</p>`;
            });
    }

    // Load the default page on initial load
    console.log("Loading default page: pages/home.html");
    loadPage("pages/home.html");

    // Add click event listener to each link
    links.forEach(link => {
        link.addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation
            const pageUrl = this.getAttribute("href"); // Get the URL of the page
            console.log(`Navigation link clicked. Loading: ${pageUrl}`);
            loadPage(pageUrl);
        });
    });
});

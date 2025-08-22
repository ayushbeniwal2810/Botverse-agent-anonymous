// This function would be called when the chat modal opens
async function loadCategories() {
    try {
        // 1. Frontend sends a request to the backend API endpoint
        const response = await fetch('http://your-backend-server.com/api/categories');
        const categories = await response.json();

        const categoryButtonsContainer = document.getElementById('category-buttons');
        categoryButtonsContainer.innerHTML = ''; // Clear existing buttons

        // 2. Frontend uses the data from the backend to build the HTML
        categories.forEach(category => {
            const button = document.createElement('button');
            button.className = 'category-btn bg-gray-200 text-gray-800 rounded-full py-2 px-4 hover:bg-blue-200 transition-colors';
            button.textContent = category.name;
            // Store the category ID for later use
            button.dataset.categoryId = category.id;

            button.addEventListener('click', () => handleCategorySelection(category.name, category.id));
            categoryButtonsContainer.appendChild(button);
        });

    } catch (error) {
        console.error('Failed to load categories:', error);
        // Display an error message to the user in the chat
    }
}
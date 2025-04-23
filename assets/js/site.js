// Load lunr.js if not already loaded
if (typeof lunr === 'undefined') {
  const loadLunr = () => {
    return new Promise((resolve, reject) => {
      const script = document.createElement('script');
      script.src = "https://unpkg.com/lunr/lunr.js";
      script.onload = resolve;
      script.onerror = reject;
      document.head.appendChild(script);
    });
  };

  (async function() {
    try {
      await loadLunr();
      initSearch();
      focusSearch();
    } catch (error) {
      console.error('Failed to load lunr.js:', error);
    }
  })();
} else {
  // lunr already loaded, initialize search
  initSearch();
  focusSearch();
}

// Function to focus search input
function focusSearch() {
  const searchInput = document.getElementById('site-search-input');
  if (searchInput) {
    // Focus the input
    searchInput.focus();
    // Move cursor to end of any existing text
    const len = searchInput.value.length;
    searchInput.setSelectionRange(len, len);
  }
}

// Re-focus search on keyboard shortcut (/)
document.addEventListener('keydown', function(e) {
  if (e.key === '/' && !['INPUT', 'TEXTAREA'].includes(document.activeElement.tagName)) {
    e.preventDefault();
    focusSearch();
  }
});

// Add slider refocus behavior
document.addEventListener('mouseup', function(e) {
    if (e.target.matches('input[type="range"]') || e.target.closest('input[type="range"]')) {
        setTimeout(focusSearch, 100);
    }
});

function initSearch() {
  // Initialize search functionality
  let searchIndex, searchData;

  // Fetch the search index
  fetch('/search.json')
    .then(response => response.json())
    .then(data => {
      // Initialize lunr with data
      const idx = lunr(function() {
        this.ref('url');
        this.field('title', { boost: 10 });
        this.field('content');
        
        // Only add these fields if they exist in the data
        if (data.length > 0 && data[0].keywords) {
          this.field('keywords', { boost: 5 });
        }
        
        // Add GSC keywords with higher boost since they represent actual search behavior
        if (data.length > 0 && data[0].gsc_keywords) {
          this.field('gsc_keywords', { boost: 8 });
        }
        
        if (data.length > 0 && data[0].description) {
          this.field('description', { boost: 2 });
        }
        
        data.forEach(function(doc) {
          // Add document to the index if it has required fields
          if (doc.title && doc.url) {
            this.add(doc);
          }
        }, this);
      });
      
      // Store the index and data
      searchIndex = idx;
      searchData = data;
      
      // Set up event listener for search input
      const searchInput = document.getElementById('site-search-input');
      if (searchInput) {
        searchInput.addEventListener('keyup', performSearch);
        
        // Show/hide results container based on focus
        searchInput.addEventListener('focus', () => {
          const results = document.getElementById('site-search-results');
          if (results) {
            results.style.display = searchInput.value.trim() ? 'block' : 'none';
          }
        });
      }
    })
    .catch(error => {
      console.error('Failed to fetch search data:', error);
    });

  function performSearch() {
    const query = document.getElementById('site-search-input').value.trim();
    const resultsContainer = document.getElementById('site-search-results');
    
    if (!resultsContainer) return;
    
    if (query === '') {
      resultsContainer.style.display = 'none';
      return;
    }
    
    resultsContainer.style.display = 'block';
    
    try {
      const results = searchIndex.search(query);
      
      if (results.length === 0) {
        resultsContainer.innerHTML = '<p>No results found</p>';
        return;
      }
      
      // Show up to 20 results instead of 10
      // And no "see all results" link now
      resultsContainer.innerHTML = results
        .slice(0, 20)
        .map(result => {
          const item = searchData.find(post => post.url === result.ref);
          if (!item) return '';
          
          return `
            <div class="search-result">
              <h3><a href="${item.url}">${item.title}</a></h3>
              <p class="date">${item.date}</p>
              ${item.description ? `<p class="description">${item.description}</p>` : ''}
            </div>
          `;
        })
        .join('') + 
        (results.length > 20 ? '<p class="more-results">Showing 20 of ' + results.length + ' results. Refine your search for more specific results.</p>' : '');
    } catch (error) {
      console.error('Search error:', error);
      resultsContainer.innerHTML = '<p>Search error occurred. Please try a different query.</p>';
    }
  }

  // Close results when clicking outside
  document.addEventListener('click', function(event) {
    const container = document.getElementById('site-search-container');
    const input = document.getElementById('site-search-input');
    const results = document.getElementById('site-search-results');
    
    if (container && !container.contains(event.target)) {
      if (results) {
        results.style.display = 'none';
      }
    }
  });
}

// Function to set a cookie
function setCookie(name, value, days) {
    const expires = new Date();
    expires.setTime(expires.getTime() + (days * 24 * 60 * 60 * 1000));
    document.cookie = name + '=' + value + ';expires=' + expires.toUTCString() + ';path=/';
}

// Function to get a cookie
function getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');
    for(let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

// Disable slider functionality on mobile
function isMobile() {
    return window.innerWidth <= 768;
}

function updateWidth() {
    if (isMobile()) return;
    const newWidth = slider.value;
    container.style.maxWidth = `${newWidth}px`;
    
    if (window.innerWidth > 768) {
        // Desktop behavior only
        headerTitle.style.fontSize = `calc(${newWidth}px * 0.28)`;
        wheel.style.width = `calc(${newWidth}px * 0.18)`;
        
        // Calculate the top value for the wheel
        const minSliderValue = 850;
        const maxSliderValue = MAX_WIDTH;
        const minTopValue = -1;
        const maxTopValue = -3;
        
        const topValue = minTopValue + (maxTopValue - minTopValue) * 
                            (newWidth - minSliderValue) / (maxSliderValue - minSliderValue);
        
        wheel.style.top = `${topValue}vw`;
    }
    
    // Save the new width to a cookie
    setCookie('containerWidth', newWidth, 30);
}

// Resize handler and mobile check
let resizeTimer;
function handleResize() {
    if (window.innerWidth > 768) {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            location.reload();
        }, 250);
    }
}

window.addEventListener('resize', function() {
    if (!isMobile()) {
        handleResize();
    }
});
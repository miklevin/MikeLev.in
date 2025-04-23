// IMPORTANT: This sets the maximum width of the slider to the page width in pixels
const MAX_WIDTH = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);

const slider = document.getElementById('widthSlider');
const container = document.querySelector('.container');
const headerTitle = document.getElementById('headerTitle');
const wheel = document.getElementById('wheel');

// IMPORTANT: Update the slider's max attribute to match the page width
slider.max = MAX_WIDTH;

// Set initial slider value from cookie or calculate default middle value
const savedWidth = getCookie('containerWidth');
const defaultWidth = Math.min(1600, Math.floor((850 + MAX_WIDTH) / 2)); // reasonable middle ground
slider.value = savedWidth ? savedWidth : defaultWidth;

// Modify the existing event listeners
if (!isMobile()) {
    slider.addEventListener('input', updateWidth);
}

updateWidth(); // Initialize with saved or default value

// IMPORTANT: This creates a media query to limit the maximum width on larger screens
const style = document.createElement('style');
style.textContent = `
    @media (min-width: ${MAX_WIDTH}px) {
        body > footer, body > header, body > main {
            max-width: 850px;
        }
    }
`;
document.head.appendChild(style);
// Matrix rain effect
function initMatrix() {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    
    // Position canvas absolutely over the ASCII art
    canvas.style.position = 'absolute';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.width = '100%';
    canvas.style.height = '100%';
    canvas.style.zIndex = '1';
    
    // Set canvas size
    function resize() {
        const container = document.querySelector('.ascii-alice');
        canvas.width = container.offsetWidth;
        canvas.height = container.offsetHeight;
    }
    
    // Initial setup
    resize();
    window.addEventListener('resize', resize);

    // Your existing Matrix code here
    const fontSize = 15;
    const cols = Math.floor(canvas.width / fontSize) + 1;
    let yPositions = Array(cols).fill(0);

    // Your path points array here
    const pathPoints = [
        [46.5, 18.1],
        // ... (rest of your points)
    ];

    // Your existing createAlicePath and drawMatrix functions
    function createAlicePath() {
        // ... (your existing path creation code)
    }

    function drawMatrix() {
        // ... (your existing draw code)
    }

    setInterval(drawMatrix, 30); // Faster animation
    
    // Add canvas to container
    document.querySelector('.ascii-alice').appendChild(canvas);
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', initMatrix);
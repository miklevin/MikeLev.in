// Matrix rain effect
function initMatrix() {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    const fontSize = 8;
    let yPositions;
    
    // Position canvas absolutely over the ASCII art
    canvas.style.position = 'absolute';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.width = '100%';
    canvas.style.height = '100%';
    canvas.style.zIndex = '1';
    
    // Store original coordinates
    const originalPathPoints = [
        [46.5, 18.1], [46.6, 18.4], [46.6, 18.1], [51.0, 18.3],
        [51.7, 27.6], [54.3, 33.4], [59.2, 33.4], [60.3, 36.3],
        [61.9, 36.1], [62.9, 33.0], [61.5, 32.8], [61.0, 30.5],
        [61.0, 24.5], [62.9, 21.4], [69.2, 21.4], [71.4, 27.6],
        [70.1, 30.5], [71.2, 33.2], [70.8, 36.7], [70.3, 39.0],
        [68.2, 39.2], [68.6, 42.9], [70.1, 45.4], [71.7, 45.6],
        [75.7, 54.8], [75.5, 57.9], [77.1, 61.0], [76.8, 63.3],
        [73.9, 63.3], [73.1, 60.8], [73.5, 60.6], [73.5, 57.7],
        [72.7, 57.1], [70.3, 51.3], [69.0, 51.3], [66.5, 45.6],
        [63.3, 51.8], [63.3, 54.8], [61.0, 57.7], [60.8, 66.8],
        [61.8, 67.2], [62.6, 69.5], [61.1, 71.1], [59.6, 70.9],
        [59.4, 72.4], [56.6, 72.4], [55.6, 75.5], [54.0, 75.3],
        [53.1, 78.4], [51.7, 78.3], [49.3, 72.4], [46.8, 72.6],
        [45.7, 69.7], [44.2, 69.7], [43.3, 66.6], [41.9, 66.4],
        [35.2, 81.9], [34.3, 83.7], [29.9, 83.1], [28.4, 81.6],
        [29.5, 78.8], [33.3, 78.4], [34.4, 75.7], [35.9, 75.7],
        [36.7, 73.2], [36.2, 70.1], [35.9, 69.1], [39.2, 61.4],
        [39.0, 53.2], [37.9, 52.8], [25.1, 52.8], [24.0, 52.2],
        [24.3, 48.7], [24.6, 48.0], [23.1, 45.4], [22.7, 41.6],
        [23.7, 41.0], [24.8, 41.2], [25.6, 42.7], [28.1, 48.5],
        [38.1, 48.3], [39.3, 45.4], [40.9, 45.4], [43.0, 39.6],
        [46.8, 39.2], [47.6, 38.6], [49.3, 42.3], [50.9, 43.9],
        [52.6, 44.1], [53.1, 45.0], [54.3, 45.4], [55.1, 42.9],
        [55.0, 39.4], [52.8, 39.0], [49.6, 30.7], [48.7, 30.5],
        [48.8, 27.4], [49.6, 27.0], [48.2, 24.1], [46.3, 23.9],
        [46.1, 18.8], [46.6, 18.1]
    ];
    
    let pathPoints = [];  // Will be scaled in resize()
    
    // Set canvas size and scale coordinates to match ASCII art
    function resize() {
        const container = document.querySelector('.ascii-alice');
        const pre = container.querySelector('pre');
        const computedStyle = window.getComputedStyle(pre);
        const lineHeight = parseFloat(computedStyle.lineHeight);
        const charWidth = pre.offsetWidth / 40; // This width factor is good
        
        canvas.width = pre.offsetWidth;
        canvas.height = pre.offsetHeight;
        
        // Scale path points to match ASCII art dimensions
        pathPoints = originalPathPoints.map(point => [
            point[0] * charWidth / 2.5,    // Keep width scaling as is
            point[1] * lineHeight / 3.2     // Adjust height scaling factor from 4.2 to 3.2
        ]);
        
        yPositions = Array(Math.floor(canvas.width / fontSize) + 1).fill(0);
    }
    
    // Initial setup
    resize();
    window.addEventListener('resize', resize);

    function createAlicePath() {
        ctx.beginPath();
        const firstPoint = pathPoints[0];
        ctx.moveTo(
            firstPoint[0],
            firstPoint[1]
        );
        
        for (let i = 1; i < pathPoints.length; i++) {
            const point = pathPoints[i];
            ctx.lineTo(
                point[0],
                point[1]
            );
        }
        
        ctx.closePath();
    }

    function drawMatrix() {
        ctx.save();
        ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        createAlicePath();
        
        // Debug: visualize the clipping path
        ctx.strokeStyle = 'red';
        ctx.lineWidth = 2;
        ctx.stroke();
        
        ctx.clip();

        ctx.fillStyle = '#0F0';
        ctx.font = fontSize + 'px monospace';

        yPositions.forEach((y, i) => {
            const char = String.fromCharCode(0x30A0 + Math.random() * 96);
            const x = i * fontSize;
            ctx.fillText(char, x, y);
            if (y > canvas.height && Math.random() > 0.95) {
                yPositions[i] = 0;
            } else {
                yPositions[i] = y + fontSize;
            }
        });

        ctx.restore();
    }

    setInterval(drawMatrix, 30); // Faster animation
    
    // Add canvas to container
    document.querySelector('.ascii-alice').appendChild(canvas);
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', initMatrix);
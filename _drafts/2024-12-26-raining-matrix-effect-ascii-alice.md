---
title: Raining Matrix Effect on The ASCII Alice
permalink: /futureproof/raining-matrix-effect-ascii-alice/
description: 
layout: post
sort_order: 2
---

## Full-screen Raining Matrix Effect

First, we get a basic competent full-screen Raining Matrix effect.

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            background: black;
            overflow: hidden;
        }
        canvas {
            display: block;
        }
    </style>
</head>
<body>
    <canvas id="matrix"></canvas>

    <script>
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');

        // Set canvas size to window size
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        // Column setup
        const fontSize = 15;
        const cols = Math.floor(canvas.width / fontSize) + 1;
        const yPositions = Array(cols).fill(0);

        // Initial black background
        ctx.fillStyle = '#000';
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        function drawMatrix() {
            // Create fade effect
            ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            // Set text properties
            ctx.fillStyle = '#0f0';
            ctx.font = fontSize + 'px monospace';

            // Draw the characters
            yPositions.forEach((y, i) => {
                // Random character
                const char = String.fromCharCode(0x30A0 + Math.random() * 96);
                const x = i * fontSize;

                // Draw the character
                ctx.fillText(char, x, y);

                // Reset position if it's too far down, otherwise move it down
                if (y > canvas.height && Math.random() > 0.975) {
                    yPositions[i] = 0;
                } else {
                    yPositions[i] = y + fontSize;
                }
            });
        }

        // Run animation
        setInterval(drawMatrix, 50);

        // Handle window resize
        window.onresize = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            ctx.fillStyle = '#000';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        };
    </script>
</body>
</html>
```

## Overlay ASCII Alice

Next, we overlay the Alice ASCII art (my own work).

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            background: black;
            overflow: hidden;
        }
        canvas {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }
        .ascii-alice {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
        }
        .ascii-alice pre {
            margin: 0;
            padding: 0;
            color: white;
            font-family: monospace;
            white-space: pre;
            line-height: 1.2;
        }
    </style>
</head>
<body>
    <canvas id="matrix"></canvas>
    <div class="ascii-alice">
        <pre>
                    ___
                   |   |         _____
                   |_  |        /     \
                     \ |       |       \
                     |  \      |       /
                      \  \____ \_      \
                       \      \_/      |
                 ___.   \_            _/
.-,             /    \    |          |
|  \          _/      `--_/           \_
 \  \________/                     /\   \
 |                                /  \_  \
 `-----------,                   |     \  \
             |                  /       \  |
             |                 |         | \
             /                 |         \__|
            /   _              |
           /   / \_             \
           |  /    \__      __--`
          _/ /        \   _/
      ___/  /          \_/
     /     /
     `----`</pre>
    </div>

    <script>
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');

        // Set canvas size to window size
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        // Column setup
        const fontSize = 15;
        const cols = Math.floor(canvas.width / fontSize) + 1;
        const yPositions = Array(cols).fill(0);

        // Initial black background
        ctx.fillStyle = '#000';
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        function drawMatrix() {
            // Create fade effect
            ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            // Set text properties
            ctx.fillStyle = '#0f0';
            ctx.font = fontSize + 'px monospace';

            // Draw the characters
            yPositions.forEach((y, i) => {
                // Random character
                const char = String.fromCharCode(0x30A0 + Math.random() * 96);
                const x = i * fontSize;

                // Draw the character
                ctx.fillText(char, x, y);

                // Reset position if it's too far down, otherwise move it down
                if (y > canvas.height && Math.random() > 0.975) {
                    yPositions[i] = 0;
                } else {
                    yPositions[i] = y + fontSize;
                }
            });
        }

        // Run animation
        setInterval(drawMatrix, 50);

        // Handle window resize
        window.onresize = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            ctx.fillStyle = '#000';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        };
    </script>
</body>
</html>
```

## Polygon Masking 

Next we ensure that polygon punch-through masking will work.

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            background: black;
            overflow: hidden;
        }
        canvas {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }
        .ascii-alice {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            background-color: transparent;
            overflow-x: auto;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
        }
        .ascii-alice pre {
            margin: 0;
            padding: 0;
            color: white;
            border: none;
            white-space: pre;
            font-size: 1em;
            line-height: 1.2;
        }
    </style>
</head>
<body>
    <canvas id="matrix"></canvas>
    <div class="ascii-alice">
        <pre>
                    ___
                   |   |         _____
                   |_  |        /     \
                     \ |       |       \
                     |  \      |       /
                      \  \____ \_      \
                       \      \_/      |
                 ___.   \_            _/
.-,             /    \    |          |
|  \          _/      `--_/           \_
 \  \________/                     /\   \
 |                                /  \_  \
 `-----------,                   |     \  \
             |                  /       \  |
             |                 |         | \
             /                 |         \__|
            /   _              |
           /   / \_             \
           |  /    \__      __--`
          _/ /        \   _/
      ___/  /          \_/
     /     /
     `----`</pre>
    </div>

    <script>
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');

        // Set canvas size to window size
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        // Column setup
        const fontSize = 15;
        const cols = Math.floor(canvas.width / fontSize) + 1;
        const yPositions = Array(cols).fill(0);

        // Define Alice's silhouette as a path
        function createAlicePath() {
            const centerX = canvas.width / 2;
            const centerY = canvas.height / 2;
            const scale = 100; // Adjust this value to change size

            ctx.beginPath();
            // Drawing a simplified Alice silhouette
            ctx.moveTo(centerX, centerY - scale); // Top of head
            ctx.bezierCurveTo(
                centerX + scale/2, centerY - scale,     // Head right curve
                centerX + scale/2, centerY,             // Body right curve
                centerX + scale/3, centerY + scale      // Dress right
            );
            ctx.lineTo(centerX - scale/3, centerY + scale); // Dress bottom
            ctx.bezierCurveTo(
                centerX - scale/2, centerY,             // Body left curve
                centerX - scale/2, centerY - scale,     // Head left curve
                centerX, centerY - scale                // Back to top
            );
            ctx.closePath();
        }

        function drawMatrix() {
            // Save the current canvas state
            ctx.save();

            // Clear canvas with fade effect
            ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            // Create and apply the clipping path
            createAlicePath();
            ctx.clip();

            // Draw the Matrix effect
            ctx.fillStyle = '#0f0';
            ctx.font = fontSize + 'px monospace';

            yPositions.forEach((y, i) => {
                const char = String.fromCharCode(0x30A0 + Math.random() * 96);
                const x = i * fontSize;
                ctx.fillText(char, x, y);
                if (y > canvas.height && Math.random() > 0.975) {
                    yPositions[i] = 0;
                } else {
                    yPositions[i] = y + fontSize;
                }
            });

            // Restore the canvas state (removes clipping)
            ctx.restore();
        }

        // Run animation
        setInterval(drawMatrix, 50);

        // Handle window resize
        window.onresize = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            ctx.fillStyle = '#000';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        };
    </script>
</body>
</html>
```

## Interactive Clip Path Tool

Next, we need a tool to interactively draw our clip path:

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            background: black;
            overflow: hidden;
        }
        canvas {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }
        .ascii-alice {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            background-color: transparent;
            overflow-x: auto;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
        }
        .ascii-alice pre {
            margin: 0;
            padding: 0;
            color: white;
            border: none;
            white-space: pre;
            font-size: 1em;
            line-height: 1.2;
        }
        .controls {
            position: fixed;
            top: 10px;
            left: 10px;
            z-index: 4;
            color: white;
            background: rgba(0,0,0,0.7);
            padding: 10px;
        }
        #points {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 3;
        }
        .point {
            position: absolute;
            width: 6px;
            height: 6px;
            background: red;
            border-radius: 50%;
            transform: translate(-50%, -50%);
            pointer-events: none;
        }
    </style>
</head>
<body>
    <div class="controls">
        <button onclick="startDrawing()">Start Drawing</button>
        <button onclick="finishDrawing()">Finish Shape</button>
        <button onclick="reset()">Reset</button>
        <div id="coordinates"></div>
    </div>
    <canvas id="matrix"></canvas>
    <div id="points"></div>
    <div class="ascii-alice">
        <pre>
                    ___
                   |   |         _____
                   |_  |        /     \
                     \ |       |       \
                     |  \      |       /
                      \  \____ \_      \
                       \      \_/      |
                 ___.   \_            _/
.-,             /    \    |          |
|  \          _/      `--_/           \_
 \  \________/                     /\   \
 |                                /  \_  \
 `-----------,                   |     \  \
             |                  /       \  |
             |                 |         | \
             /                 |         \__|
            /   _              |
           /   / \_             \
           |  /    \__      __--`
          _/ /        \   _/
      ___/  /          \_/
     /     /
     `----`</pre>
    </div>

    <script>
        // Matrix effect code (unchanged from before)
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');

        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const fontSize = 15;
        const cols = Math.floor(canvas.width / fontSize) + 1;
        const yPositions = Array(cols).fill(0);

        // Point collection
        let points = [];
        let isDrawing = false;
        let pointsContainer = document.getElementById('points');

        function startDrawing() {
            isDrawing = true;
            points = [];
            pointsContainer.innerHTML = '';
            document.addEventListener('click', addPoint);
        }

        function addPoint(e) {
            if (!isDrawing) return;

            const point = document.createElement('div');
            point.className = 'point';
            point.style.left = e.clientX + 'px';
            point.style.top = e.clientY + 'px';
            pointsContainer.appendChild(point);

            points.push({
                x: (e.clientX / window.innerWidth) * 100,
                y: (e.clientY / window.innerHeight) * 100
            });

            updatePath();
        }

        function finishDrawing() {
            isDrawing = false;
            document.removeEventListener('click', addPoint);
            const pathCoords = points.map(p => `${p.x.toFixed(1)}% ${p.y.toFixed(1)}%`).join(',\n    ');
            document.getElementById('coordinates').innerHTML = 
                `clip-path: polygon(\n    ${pathCoords}\n);`;
        }

        function reset() {
            points = [];
            pointsContainer.innerHTML = '';
            document.getElementById('coordinates').innerHTML = '';
            isDrawing = false;
            document.removeEventListener('click', addPoint);
        }

        function createAlicePath() {
            if (points.length < 3) return;
            
            ctx.beginPath();
            ctx.moveTo(
                (points[0].x / 100) * canvas.width,
                (points[0].y / 100) * canvas.height
            );
            
            for (let i = 1; i < points.length; i++) {
                ctx.lineTo(
                    (points[i].x / 100) * canvas.width,
                    (points[i].y / 100) * canvas.height
                );
            }
            
            ctx.closePath();
        }

        function drawMatrix() {
            ctx.save();
            ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            if (points.length >= 3) {
                createAlicePath();
                ctx.clip();
            }

            ctx.fillStyle = '#0f0';
            ctx.font = fontSize + 'px monospace';

            yPositions.forEach((y, i) => {
                const char = String.fromCharCode(0x30A0 + Math.random() * 96);
                const x = i * fontSize;
                ctx.fillText(char, x, y);
                if (y > canvas.height && Math.random() > 0.975) {
                    yPositions[i] = 0;
                } else {
                    yPositions[i] = y + fontSize;
                }
            });

            ctx.restore();
        }

        setInterval(drawMatrix, 50);

        window.onresize = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        };
    </script>
</body>
</html>
```

## Add The Clipping Path

Okay, I traced that Alice ASCII art and got my clipping path.

```html
<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            margin: 0;
            background: black;
            overflow: hidden;
        }
        canvas {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }
        .ascii-alice {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            background-color: transparent;
            overflow-x: auto;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 2;
        }
        .ascii-alice pre {
            margin: 0;
            padding: 0;
            color: white;
            border: none;
            white-space: pre;
            font-size: 1em;
            line-height: 1.2;
        }
    </style>
</head>
<body>
    <canvas id="matrix"></canvas>
    <div class="ascii-alice">
        <pre><!-- Your ASCII art here --></pre>
    </div>

    <script>
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');

        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const fontSize = 15;
        const cols = Math.floor(canvas.width / fontSize) + 1;
        const yPositions = Array(cols).fill(0);

        // Your exact path coordinates
        const pathPoints = [
            [46.5, 18.1], // Slightly adjusted for smoother connection
            [46.6, 18.4],
            [46.6, 18.1], // Extra point to reinforce the seal
            [51.0, 18.3],
            [51.7, 27.6],
            [54.3, 33.4],
            [59.2, 33.4],
            [60.3, 36.3],
            [61.9, 36.1],
            [62.9, 33.0],
            [61.5, 32.8],
            [61.0, 30.5],
            [61.0, 24.5],
            [62.9, 21.4],
            [69.2, 21.4],
            [71.4, 27.6],
            [70.1, 30.5],
            [71.2, 33.2],
            [70.8, 36.7],
            [70.3, 39.0],
            [68.2, 39.2],
            [68.6, 42.9],
            [70.1, 45.4],
            [71.7, 45.6],
            [75.7, 54.8],
            [75.5, 57.9],
            [77.1, 61.0],
            [76.8, 63.3],
            [73.9, 63.3],
            [73.1, 60.8],
            [73.5, 60.6],
            [73.5, 57.7],
            [72.7, 57.1],
            [70.3, 51.3],
            [69.0, 51.3],
            [66.5, 45.6],
            [63.3, 51.8],
            [63.3, 54.8],
            [61.0, 57.7],
            [60.8, 66.8],
            [61.8, 67.2],
            [62.6, 69.5],
            [61.1, 71.1],
            [59.6, 70.9],
            [59.4, 72.4],
            [56.6, 72.4],
            [55.6, 75.5],
            [54.0, 75.3],
            [53.1, 78.4],
            [51.7, 78.3],
            [49.3, 72.4],
            [46.8, 72.6],
            [45.7, 69.7],
            [44.2, 69.7],
            [43.3, 66.6],
            [41.9, 66.4],
            [35.2, 81.9],
            [34.3, 83.7],
            [29.9, 83.1],
            [28.4, 81.6],
            [29.5, 78.8],
            [33.3, 78.4],
            [34.4, 75.7],
            [35.9, 75.7],
            [36.7, 73.2],
            [36.2, 70.1],
            [35.9, 69.1],
            [39.2, 61.4],
            [39.0, 53.2],
            [37.9, 52.8],
            [25.1, 52.8],
            [24.0, 52.2],
            [24.3, 48.7],
            [24.6, 48.0],
            [23.1, 45.4],
            [22.7, 41.6],
            [23.7, 41.0],
            [24.8, 41.2],
            [25.6, 42.7],
            [28.1, 48.5],
            [38.1, 48.3],
            [39.3, 45.4],
            [40.9, 45.4],
            [43.0, 39.6],
            [46.8, 39.2],
            [47.6, 38.6],
            [49.3, 42.3],
            [50.9, 43.9],
            [52.6, 44.1],
            [53.1, 45.0],
            [54.3, 45.4],
            [55.1, 42.9],
            [55.0, 39.4],
            [52.8, 39.0],
            [49.6, 30.7],
            [48.7, 30.5],
            [48.8, 27.4],
            [49.6, 27.0],
            [48.2, 24.1],
            [46.3, 23.9],
            [46.1, 18.8],
            [46.6, 18.1],
        ];

        function createAlicePath() {
            ctx.beginPath();
            
            // Convert percentage to actual canvas coordinates
            const firstPoint = pathPoints[0];
            ctx.moveTo(
                (firstPoint[0] / 100) * canvas.width,
                (firstPoint[1] / 100) * canvas.height
            );
            
            // Draw the rest of the path
            for (let i = 1; i < pathPoints.length; i++) {
                const point = pathPoints[i];
                ctx.lineTo(
                    (point[0] / 100) * canvas.width,
                    (point[1] / 100) * canvas.height
                );
            }
            
            ctx.closePath();
        }

        function drawMatrix() {
            ctx.save();
            ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            createAlicePath();
            ctx.clip();

            ctx.fillStyle = '#0f0';
            ctx.font = fontSize + 'px monospace';

            yPositions.forEach((y, i) => {
                const char = String.fromCharCode(0x30A0 + Math.random() * 96);
                const x = i * fontSize;
                ctx.fillText(char, x, y);
                if (y > canvas.height && Math.random() > 0.975) {
                    yPositions[i] = 0;
                } else {
                    yPositions[i] = y + fontSize;
                }
            });

            ctx.restore();
        }

        setInterval(drawMatrix, 50);

        window.onresize = () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        };
    </script>
</body>
</html>
```



[1mdiff --git a/draw.js b/draw.js[m
[1mnew file mode 100644[m
[1mindex 0000000..8a51c54[m
[1m--- /dev/null[m
[1m+++ b/draw.js[m
[36m@@ -0,0 +1,45 @@[m
[32m+[m[32mfunction drawLives() {[m
[32m+[m[32m    ctx.font = "16px Arial";[m
[32m+[m[32m    ctx.fillStyle = "#0095DD";[m
[32m+[m[32m    ctx.fillText("Lives: "+lives, canvas.width-65, 20);[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction drawScore() {[m
[32m+[m[32m    ctx.font = "16px Arial";[m
[32m+[m[32m    ctx.fillStyle = "#0095DD";[m
[32m+[m[32m    ctx.fillText("Score: "+score, 8, 20);[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction drawBricks() {[m
[32m+[m[32m    for(var c=0; c<brickColumnCount; c++) {[m
[32m+[m[32m        for(var r=0; r<brickRowCount; r++) {[m
[32m+[m[32m            if(bricks[c][r].status == 1) {[m
[32m+[m[32m                var brickX = (c*(brickWidth+brickPadding))+brickOffsetLeft;[m
[32m+[m[32m                var brickY = (r*(brickHeight+brickPadding))+brickOffsetTop;[m
[32m+[m[32m                bricks[c][r].x = brickX;[m
[32m+[m[32m                bricks[c][r].y = brickY;[m
[32m+[m[32m                ctx.beginPath();[m
[32m+[m[32m                ctx.rect(brickX, brickY, brickWidth, brickHeight);[m
[32m+[m[32m                ctx.fillStyle = "#0095DD";[m
[32m+[m[32m                ctx.fill();[m
[32m+[m[32m                ctx.closePath();[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction drawBall() {[m
[32m+[m[32m    ctx.beginPath();[m
[32m+[m[32m    ctx.arc(x, y, ballRadius, 0, Math.PI*2);[m
[32m+[m[32m    ctx.fillStyle = "#0095DD";[m
[32m+[m[32m    ctx.fill();[m
[32m+[m[32m    ctx.closePath();[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction drawPaddle() {[m
[32m+[m[32m    ctx.beginPath();[m
[32m+[m[32m    ctx.rect(paddleX, canvas.height-paddleHeight, paddleWidth, paddleHeight);[m
[32m+[m[32m    ctx.fillStyle = "#0095DD";[m
[32m+[m[32m    ctx.fill();[m
[32m+[m[32m    ctx.closePath();[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/engine.js b/engine.js[m
[1mnew file mode 100644[m
[1mindex 0000000..310b679[m
[1m--- /dev/null[m
[1m+++ b/engine.js[m
[36m@@ -0,0 +1,95 @@[m
[32m+[m[32mfunction keyDownHandler(e) {[m
[32m+[m[32m    if(e.keyCode == 39) {[m
[32m+[m[32m        rightPressed = true;[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(e.keyCode == 37) {[m
[32m+[m[32m        leftPressed = true;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction keyUpHandler(e) {[m
[32m+[m[32m    if(e.keyCode == 39) {[m
[32m+[m[32m        rightPressed = false;[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(e.keyCode == 37) {[m
[32m+[m[32m        leftPressed = false;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction mouseMoveHandler(e) {[m
[32m+[m[32m    var relativeX = e.clientX - canvas.offsetLeft;[m
[32m+[m[32m    if(relativeX > 0 && relativeX < canvas.width) {[m
[32m+[m[32m        paddleX = relativeX - paddleWidth/2;[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction collisionDetection() {[m
[32m+[m[32m    for(var c=0; c<brickColumnCount; c++) {[m
[32m+[m[32m        for(var r=0; r<brickRowCount; r++) {[m
[32m+[m[32m            var b = bricks[c][r];[m
[32m+[m[32m            if(b.status == 1) {[m
[32m+[m[32m                if(x > b.x && x < b.x+brickWidth && y > b.y && y < b.y+brickHeight) {[m
[32m+[m[32m                    dy = -dy;[m
[32m+[m[32m                    b.status = 0;[m
[32m+[m[32m                    score++;[m
[32m+[m[32m                    if(score == brickRowCount*brickColumnCount) {[m
[32m+[m[32m                        alert("YOU WIN, CONGRATULATIONS!");[m
[32m+[m[32m                        document.location.reload();[m
[32m+[m[32m                    }[m
[32m+[m[32m                }[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mfunction draw() {[m
[32m+[m[32m    ctx.clearRect(0, 0, canvas.width, canvas.height);[m
[32m+[m[32m    drawBricks();[m
[32m+[m[32m    drawBall();[m
[32m+[m[32m    drawPaddle();[m
[32m+[m[32m    drawScore();[m
[32m+[m[32m    drawLives();[m
[32m+[m[32m    collisionDetection();[m
[32m+[m
[32m+[m[32m    if(x + dx > canvas.width-ballRadius || x + dx < ballRadius) {[m
[32m+[m[32m        dx = -dx;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if(y + dy < ballRadius) {[m
[32m+[m[32m        dy = -dy;[m
[32m+[m[32m    } else if(y + dy > canvas.height-ballRadius) {[m
[32m+[m[32m        if(x > paddleX && x < paddleX + paddleWidth) {[m
[32m+[m[32m            dy = -dy;[m
[32m+[m[32m        }[m
[32m+[m[32m        else {[m
[32m+[m[32m            lives--;[m
[32m+[m[32m            if(!lives) {[m
[32m+[m[32m                alert("GAME OVER");[m
[32m+[m[32m                document.location.reload();[m
[32m+[m[32m            }[m
[32m+[m[32m            else {[m
[32m+[m[32m                x = canvas.width/2;[m
[32m+[m[32m                y = canvas.height-30;[m
[32m+[m[32m                dx = 2;[m
[32m+[m[32m                dy = -2;[m
[32m+[m[32m                paddleX = (canvas.width-paddleWidth)/2;[m
[32m+[m[32m            }[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if(rightPressed && paddleX < canvas.width-paddleWidth) {[m
[32m+[m[32m        paddleX += 7;[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(leftPressed && paddleX > 0) {[m
[32m+[m[32m        paddleX -= 7;[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    x += dx;[m
[32m+[m[32m    y += dy;[m
[32m+[m
[32m+[m[32m    requestAnimationFrame(draw);[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mdocument.addEventListener("mousemove", mouseMoveHandler, false);[m
[32m+[m[32mdocument.addEventListener("keydown", keyDownHandler, false);[m
[32m+[m[32mdocument.addEventListener("keyup", keyUpHandler, false);[m
[1mdiff --git a/index.html b/index.html[m
[1mnew file mode 100644[m
[1mindex 0000000..7476a1e[m
[1m--- /dev/null[m
[1m+++ b/index.html[m
[36m@@ -0,0 +1,35 @@[m
[32m+[m[32m<!-- Source: https://developer.mozilla.org/en-US/docs/Games/Tutorials/2D_Breakout_game_pure_JavaScript -->[m
[32m+[m[32m<!DOCTYPE html>[m
[32m+[m[32m<html>[m
[32m+[m
[32m+[m[32m<head>[m
[32m+[m[32m    <meta charset="utf-8" />[m
[32m+[m[32m    <title>Gamedev Canvas Workshop</title>[m
[32m+[m[32m    <style>[m
[32m+[m[32m        * {[m
[32m+[m[32m            padding: 0;[m
[32m+[m[32m            margin: 0;[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        canvas {[m
[32m+[m[32m            background: #eee;[m
[32m+[m[32m            display: block;[m
[32m+[m[32m            margin: 0 auto;[m
[32m+[m[32m        }[m
[32m+[m[32m    </style>[m
[32m+[m[32m</head>[m
[32m+[m
[32m+[m[32m<body>[m
[32m+[m
[32m+[m[32m    <canvas id="myCanvas" width="480" height="320"></canvas>[m
[32m+[m
[32m+[m[32m    <script src="variables.js"></script>[m
[32m+[m[32m    <script src="draw.js"></script>[m
[32m+[m[32m    <script src="engine.js"></script>[m
[32m+[m[32m    <script>[m
[32m+[m[32m        draw();[m
[32m+[m[32m    </script>[m
[32m+[m
[32m+[m[32m</body>[m
[32m+[m
[32m+[m[32m</html>[m
\ No newline at end of file[m
[1mdiff --git a/variables.js b/variables.js[m
[1mnew file mode 100644[m
[1mindex 0000000..b2ae0da[m
[1m--- /dev/null[m
[1m+++ b/variables.js[m
[36m@@ -0,0 +1,34 @@[m
[32m+[m[32mvar canvas = document.getElementById("myCanvas");[m
[32m+[m[32mvar ctx = canvas.getContext("2d");[m[41m  [m
[32m+[m
[32m+[m[32mvar score = 0;[m
[32m+[m[32mvar lives = 3;[m
[32m+[m
[32m+[m[32mvar x = canvas.width/2;[m
[32m+[m[32mvar y = canvas.height-30;[m
[32m+[m[32mvar dx = 2;[m
[32m+[m[32mvar dy = -2;[m
[32m+[m[32mvar ballRadius = 10;[m
[32m+[m
[32m+[m[32mvar paddleHeight = 10;[m
[32m+[m[32mvar paddleWidth = 75;[m
[32m+[m[32mvar paddleX = (canvas.width-paddleWidth)/2;[m
[32m+[m
[32m+[m[32mvar brickRowCount = 3;[m
[32m+[m[32mvar brickColumnCount = 5;[m
[32m+[m[32mvar brickWidth = 75;[m
[32m+[m[32mvar brickHeight = 20;[m
[32m+[m[32mvar brickPadding = 10;[m
[32m+[m[32mvar brickOffsetTop = 30;[m
[32m+[m[32mvar brickOffsetLeft = 30;[m
[32m+[m
[32m+[m[32mvar bricks = [];[m
[32m+[m[32mfor(var c=0; c<brickColumnCount; c++) {[m
[32m+[m[32m    bricks[c] = [];[m
[32m+[m[32m    for(var r=0; r<brickRowCount; r++) {[m
[32m+[m[32m        bricks[c][r] = { x: 0, y: 0, status: 1 };[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mvar rightPressed = false;[m
[32m+[m[32mvar leftPressed = false;[m
\ No newline at end of file[m

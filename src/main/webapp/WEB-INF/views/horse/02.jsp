<!DOCTYPE html>
<html>
  <head>
    <title>Canvas</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      canvas {
        background: #eee;
      }
    </style>
  </head>

  <body>
    <canvas class="canvas" width="600" height="400">이 브라우저는 캔버스를 지원하지 않습니다.</canvas>

  <!--   <script>
      // fillRect x,y,width,height 왼쪽위 기본 black
      // clearRect x,y,width,height 색을 지움
      // strokeRect x,y,width,height 선을 그음
      const canvas = document.querySelector('.canvas');
      const context = canvas.getContext('2d');
      console.log(context);

      context.fillRect(50, 50, 100, 100);
      
      context.fillStyle = 'red';//아래에 적용
      context.fillRect(0, 0, 100, 100);
      context.clearRect(80, 80, 50, 50);
      context.strokeRect(150, 150, 100, 100);
      
    </script>
      
      <canvas class="canvas2" width="600" height="400">이 브라우저는 캔버스를 지원하지 않습니다.</canvas>
<script>
//beginPath
//moveto
//lineto
//closePath
const canvas= document.querySelector('.canvas2');
//캔버스 클래스 가져옴
const context = canvas.getContext('2d');
//context객체를 호출 

context.beginPath();//선으 시작
context.moveTo(100,100);//을 x,y위치로 옳긴다
context.lineTo(300,200);//xy 위치로 선을 그음
context.stroke();//선을 그음
context.closePath();//선 마감

context
//context.fill();
</script>
 -->
<!--       
      <canvas class="canvas" width="600" height="400">이 브라우저는 캔버스를 지원하지 않습니다.</canvas>
<script>
//beginPath
//arc
//closePath
const canvas= document.querySelector('.canvas');
//캔버스 클래스 가져옴
const context = canvas.getContext('2d');
//context객체를 호출 
function a(x){
	return x*Math.PI/180;
}
context.beginPath();//선으 시작
//context.stroke();//선을 그음
context.arc(300,200,50,0,a(180),false); //x,y , 반지름 ,시작각도 , 끝각도
context.closePath();//선 마감
context.arc(500,100,20,0,a(360),false);// 그림을 그린후 패스 닫아줘야함
context.fill();

context
//context.fill();
</script>
     -->
     
<!--       <canvas class="canvas" width="600" height="400">이 브라우저는 캔버스를 지원하지 않습니다.</canvas>
<script>
//beginPath
//arc
//closePath
const canvas= document.querySelector('.canvas');
const context = canvas.getContext('2d');
let xPos = 10;

function draw(){
	context.clearRect(0,0, canvas.width,canvas.height);
	context.beginPath();// 안적을시 선으로 
	context.arc(xPos,150,5,0,Math.PI*2,false);
	context.fill();
	xPos += 0.5;
	console.log('draw');

requestAnimationFrame(draw);// 1/60초마다 그려줌
//리플로우 :크기와 위치 설정  >draw > 리페인트 :결과 보여줌 
}

draw();

context
//context.fill();
</script>
 -->
<!--  
 <canvas class="canvas" width="500" height="300"></canvas>

    <script>
      const canvas = document.querySelector('.canvas');
      const context = canvas.getContext('2d');
      let xPos = 10;
      let timerId;

      function draw() {
        context.clearRect(0, 0, canvas.width, canvas.height);
        context.beginPath();
        context.arc(xPos, 150, 10, 0, Math.PI*2, false);
        context.fill();
        xPos += 1;
        // xPos = xPos + 3;

        // if (xPos >= canvas.width-10) {
        //   return;
        // }

        timerId = requestAnimationFrame(draw);

        // if (xPos >= canvas.width-10) {
        //   cancelAnimationFrame(timerId);
        // }
      }

      draw();

      canvas.addEventListener('click', () => {
        cancelAnimationFrame(timerId);
      });
 <!-- 
  <canvas class="canvas" width="500" height="300"></canvas>

    <script>
      const canvas = document.querySelector('.canvas');
      const context = canvas.getContext('2d');
      let xPos = 10;
      let timerId;

      function draw() {
        context.clearRect(0, 0, canvas.width, canvas.height);
        context.beginPath();
        context.arc(xPos, 150, 10, 0, Math.PI*2, false);
        context.fill();
        xPos += 1;
        // xPos = xPos + 3;
      }
setInterval(draw,500);
      /* timerId = setInterval(draw, 500);
      canvas.addEventListener('click', () => {
        clearInterval(timerId);
       );*/
    </script> -->
     -->
     
   <!--   
         <script>
      const canvas = document.querySelector('.canvas');
      const context = canvas.getContext('2d');

      // const imgElem = document.createElement('img');
      const imgElem = new Image();
      imgElem.src = '../resources/images/ilbuni1.png';
      imgElem.addEventListener('load', () => {
    	  //drawImage     context.drawImage(imgElem, dx, dy  dwidth, dheight);
      }
        context.drawImage(imgElem, 50, 50);
        context.drawImage(imgElem, 50, 50, 70, 120);
        context.drawImage(imgElem, 100, 100, 200, 200, 0, 0, 100, 100);
      });
    </script> -->
    
    
         <script>
      const canvas = document.querySelector('.canvas');
      const context = canvas.getContext('2d');
      function clickHandler() {
    	  context.arc(100,100,10,0,Math.PI*2,false);
    	  fontext.fill();
    	  
      }
      
      canvas.addEventListener('click',clickHandler);
    
  </body>
</html>










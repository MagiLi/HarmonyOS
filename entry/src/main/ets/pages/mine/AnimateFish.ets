import router from '@ohos.router';
import curves from '@ohos.curves';

@Entry
@Component
struct AnimateFish {
  @State fishX: number = 200;
  @State fishY: number = 100;
  @State angle: number = 0;
  @State src: Resource = $r('app.media.icon')
  // 是否开始动画
  @State isBegin: boolean = false;

  // 摇杆中心区域坐标
  private centerX: number = 120;
  private centerY: number = 120;

  // 大、小圆半径
  private maxRadius: number = 100;
  private radius: number = 20;

  // 摇杆小圆球初始位置
  @State positionX: number = this.centerX;
  @State positionY: number = this.centerY;

  // 角度正弦、余弦值
  sin: number = 0;
  cos: number = 0;

  // 小鱼移动速度
  speed: number = 0;
  // 任务id
  taskId: number = 1;

  build() {
    Stack() {
      Button("返回")
        .position({x: 0, y: 0})
        .backgroundColor("#20101010")
        .onClick(()=>{
          router.back();
        })

      if (!this.isBegin) {
        Button("开始游戏")
          .onClick(()=>{
            animateTo(
              {duration:1000},
              ()=> {
                this.isBegin = true;
              }
            )
          })
      } else {
        Image(this.src)
          .position({x: this.fishX - 20, y: this.fishY - 20})
          .rotate({angle: this.angle, centerX: '50%', centerY: '50%'})
          .width(40)
          .height(40)
          .transition({
            type: TransitionType.Insert,
            opacity: 0,
            translate: {x: -250}
          })
      }

      Row() {
        Circle({width: this.maxRadius * 2, height: this.maxRadius * 2})
          .fill("#20101010")
          .position({x: this.centerX-this.maxRadius, y: this.centerY-this.maxRadius})
        Circle({width: this.radius * 2, height: this.radius * 2})
          .fill("#403A3A3A")
          .position({x: this.positionX-this.radius, y: this.positionY-this.radius})
      }
      .height(240)
      .width(240)
      .justifyContent(FlexAlign.Center)
      .position({x: 0, y: 120})
      .onTouch(this.handleTouchEvent.bind(this))
    }
    .height('100%')
    .width('100%')
  }

  handleTouchEvent(event:TouchEvent) {
    switch (event.type) {
      case TouchType.Up:
        // 还原小鱼的速度
        this.speed = 0
        // 结束定时任务
        clearInterval(this.taskId)

        animateTo(
          { curve: curves.responsiveSpringMotion() },
          () => {
            this.positionX = this.centerX;
            this.positionY = this.centerY;
          })

        break;
      case TouchType.Down:
        // 开始定时任务
        this.taskId = setInterval(() => {
          // 修改小鱼的坐标
          this.fishX += this.speed * this.cos
          this.fishY += this.speed * this.sin
        }, 40)
        break;
      case TouchType.Move:
        // 1.手指位置坐标
        let x = event.touches[0].x
        let y = event.touches[0].y
        // 2.计算手指与中心点的坐标差值
        let vx = x - this.centerX
        let vy = y - this.centerY
        // 3.计算手指与中心点连线和x轴正半轴的夹角. 单位是弧度
        let angle = Math.atan2(vy, vx)
        // 4.计算手指与中心点的距离
        let distance = this.getDistance(vx, vy)
        console.log('拖动拖动：angle' + angle.toFixed(2))
        console.log('拖动拖动： distance' + distance.toFixed(2))
        // 5.计算摇杆小球的坐标
        this.cos = Math.cos(angle)
        this.sin = Math.sin(angle)

        animateTo(
          { curve: curves.responsiveSpringMotion() },
          () => {

            this.positionX = this.centerX + distance * this.cos;
            this.positionY = this.centerY + distance * this.sin;

            // 修改小鱼的角度 弧度 -> 角度
            this.angle = angle * 180 / Math.PI
            // 设置小鱼的速度
            this.speed = 10
          })

        break;
    }
  }

  getDistance(x: number, y: number) {
    let d = Math.sqrt(x * x + y * y)
    return Math.min(d, this.maxRadius)
  }
}
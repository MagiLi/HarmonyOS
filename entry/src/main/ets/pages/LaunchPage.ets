
import curves from '@ohos.curves';
@Entry
@Component
struct LaunchPage {

  @State currentScale:number = 0;
  @State currentOpacity:number = 0;

  build() {
    Flex({direction: FlexDirection.Column, alignItems:ItemAlign.Center, justifyContent:FlexAlign.SpaceEvenly}) {
      Shape() {
        Path()
          .commands('M162 128.7 a222 222 0 0 1 100.8 374.4 H198 a36 36 0 0 3 -36 -36')
          .fill(Color.White)
      }
      .width(210)
      .height(210)
      .scale({x:this.currentScale, y:this.currentScale})
      .opacity(this.currentOpacity)
      .backgroundColor(Color.Brown)
      .onAppear(()=>{
        console.log("展示启动页");
        animateTo({duration:1000, curve:curves.cubicBezierCurve(0.4, 0, 1, 1), delay:100, onFinish:()=>{

        }}, ()=> {
          this.currentOpacity = 1.0;
          this.currentScale = 1.0;
        })
      })

      Column() {
        Text('启动标题')
          .fontColor(Color.White)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Text('=启动介绍介绍启动介绍介绍启动介绍介绍启动介绍介绍启动介绍介绍启动介绍介绍')
          .fontColor(Color.White)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({top:5})
      }
      .margin({left:15, right:15})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Pink)

  }
}
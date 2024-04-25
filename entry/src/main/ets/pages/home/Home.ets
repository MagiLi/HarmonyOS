import router from '@ohos.router';
import axios from '@ohos/axios';

// @Component
// class TestC {
//   obj1:number = 0
//   obj2:number = 0
// }

@Component
export struct Home {
  @State imageWidth: number = 50;
  //The '@Prop' decorated attribute 't' must be of the string, number, or boolean type. <etsLint>
  //@Prop t:TestC

  @Styles card() {
    .width('95%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(15)
    .shadow({ radius: 5, color: '#1F000000', offsetX: 2, offsetY: 4 })
  }

  build() {
    Column() {
      Row() {
        Button() {
          Image($r('app.media.icon'))
            .width(this.imageWidth)
            .interpolation(ImageInterpolation.Low)
        }
        .onClick(() => {
          console.log("home");
          this.requestData()
            .then((data)=>{

            })
            .catch((error)=>{
              
            })
        })
      }
      .height(400)

      Row() {
        Text('图片宽度')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .width('30%')
          .backgroundColor(Color.White)
        TextInput({ placeholder: '输入图片宽度10-300', text: this.imageWidth.toFixed(0) })
          .backgroundColor(Color.White)
          .width('50%')
      }
      .justifyContent(FlexAlign.SpaceAround)
      .card()

      Slider({
        min: 10,
        max: 300,
        value: this.imageWidth,
        step: 10
      })
        .trackThickness(8) // 滑块粗细
        .blockColor('#36D')
        .width('90%')
        .showTips(true)
        .onChange((value: number) => {
          this.imageWidth = value
        })
      Button('文档列表')
        .onClick(() => {
          console.log('文档列表')
          router.pushUrl({
            url: 'pages/DocumentListPage'
          }, router.RouterMode.Single, (error) => {
            if (error) {
              console.log(`跳转DocumentListPage页面报错:${error.code.toFixed(0)}_${error.message}`)
            }
          })
        })
        .width(150)
        .height(50)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ff08a8f1')
  }

  requestData(): Promise<any> {
    return new Promise((resolve, reject) => {
      axios.get(
        'http://sss',
        {
          params: { 'param1': '' },
          data: { 'param1': '' }
        }
      )
        .then(resp => {
          if (resp.status === 200) {
            console.log(JSON.stringify(resp.data))
            //resp.data
            resolve(resp.data)
          } else {
            reject('')
          }
        })
        .catch(error => {
          console.log('error:', JSON.stringify(error))
          reject(error)
        })
    })
  }
}

import router from '@ohos.router';

@Entry
@Component
struct Second {

  @State message: string = 'hi here'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize('30')
          .fontWeight(FontWeight.Bold)
        Button() {
          Text('Back')
            .fontSize('30')
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .backgroundColor('#0D9FBB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          try {
            router.back()
          } catch (err){
 console.error(`Failed to return to the first page.Code is ${err.code}, message is ${err.message}`)
          }
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
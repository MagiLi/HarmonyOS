import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'

@Entry
@Component
struct DocumentPage {
  private context = getContext(this) as common.UIAbilityContext
  @State editTitle: boolean = true
  @State title: string = '标题'
  @State content: string = ''
  build() {
    Row() {
      Column({space: 10}) {
        Row({space:10}) {
          Image($r('app.media.arrow_left'))
            .width(30)
            .onClick(() => {
              let want: Want = {
                deviceId: '',
                bundleName: 'com.example.myapplication',
                moduleName: 'entry',
                abilityName: 'EntryAbility',
              }
              this.context.startAbility(want)
            })
          if (!this.editTitle) {
            Text(this.title)
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .onClick(() => this.editTitle = true)
          }
        }
      }
      Text(this.title)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .width('100%')
    }
    .height('100%')
  }
}
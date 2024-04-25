import Want from '@ohos.app.ability.Want'
import common from '@ohos.app.ability.common'
import router from '@ohos.router'

@Entry
@Component
struct DocumentListPage {
  @State message: string = 'DocumentListPage'

  @State index:number = 1

  @State docs:Array<number> = []

  private  context = getContext(this) as common.UIAbilityContext

  build() {
    Row() {
      Column({space:10}) {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Button("新建文档")
          .onClick(() => {
            this.docs.push(this.index)

            let want: Want = {
              deviceId: '',
              bundleName: 'com.example.myapplication',
              moduleName: 'entry',
              abilityName: 'DocumentAbility',
              parameters: {
                instanceKey: 'index_' + this.index++
              }
            }
            this.context.startAbility(want)
          })

        ForEach(this.docs, id => {
          Row({space:10}) {
            Image($r('app.media.emoji_smile'))
              .width(20)
              .height(20)
            Text(`文档${id}`)
              .fontSize(18)
              .fontColor(Color.Red)
              .onClick(() => {
                let want: Want = {
                  deviceId: '',
                  bundleName: 'com.example.myapplication',
                  moduleName: 'entry',
                  abilityName: 'DocumentAbility',
                  parameters: {
                    instanceKey: 'index_' + id
                  }
                }
                this.context.startAbility(want)
              })
          }
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
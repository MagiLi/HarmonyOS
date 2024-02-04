import router from '@ohos.router';
import { Home } from './home/Home';
import { Mine } from './mine/Mine';
import { tabsList } from './ViewModel/TabsModel';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State currentIndex:number = 0;

  @Builder TabBuild(index:number) {
    Column() {
      Image(this.currentIndex === index ? tabsList[index].imageSel : tabsList[index].imageNormal)
        .width('40%')
        .height('40%')
        .objectFit(ImageFit.Contain)
      Text(tabsList[index].title)
        .fontSize(10)
        .fontColor(this.currentIndex === index ? '#1698CE' : '#6B6B6B')
        .padding({ top: 5})
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({barPosition: BarPosition.End}) {
      TabContent(){
        Navigation(){
          Home();
        }
        .title('H')
        .mode(NavigationMode.Auto)
        // .menus([{value: "", icon: "./image/ic_public_search.svg", action: ()=>{}},
        //   {value: "", icon: "./image/ic_public_add.svg", action: ()=>{}}])
      }
      .tabBar(this.TabBuild(0))
      TabContent(){
        Navigation(){
          Mine();
        }
        .title('M')
        .mode(NavigationMode.Auto)
      }
      .tabBar(this.TabBuild(1))
    }
    .onChange((index:number)=> {
      this.currentIndex = index;
    })
    /*
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button(){
          Text('Next')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
          .type(ButtonType.Capsule)
          .margin({
            top: 20
          })
          .backgroundColor('#0D9FFB')
          .width('40%')
          .height('5%')
        // 跳转按钮绑定onClick事件，点击时跳转到第二页
        .onClick(() => {

          router.pushUrl({url: 'pages/Second'}).then(() => {
            console.info('Succeeded in jumping to the second page.')
          }).catch((err) => {
            console.error(`Failed to jump to the second page.Code is ${err.code}, message is ${err.message}`)
          })
        })
      }
      .width('100%')
    }
    .height('100%')
    */
  }
}
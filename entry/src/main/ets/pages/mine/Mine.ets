import router from '@ohos.router';

@Component
export struct Mine {

  build() {
    Column() {
      Button('AnimateFish')
        .onClick(()=> {
          router.pushUrl({
           url:'pages/mine/AnimateFish'
          }, router.RouterMode.Single, (error) => {
            if (error) {
              console.log('跳转AnimateFish页面报错：${error.code}_${error.message}')
            }

          })
          console.log('AnimateFish');
        })

      Text("格式化代码：按下快捷键 Ctrl + Alt + L（Windows/Linux）或 Option + Command + L（MacOS）。")
    }
  }
}
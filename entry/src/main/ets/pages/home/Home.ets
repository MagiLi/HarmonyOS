
@Component
export struct Home {

  build() {
    Stack() {
      Button("home")
        .onClick(()=> {
          console.log("home");
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ff08a8f1')
  }

}
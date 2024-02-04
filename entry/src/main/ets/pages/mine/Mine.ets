

@Component
export struct Mine {

  build() {
    Stack() {
      Button('Mine')
        .onClick(()=> {
          console.log('mine clicked');
        })
    }
  }
}
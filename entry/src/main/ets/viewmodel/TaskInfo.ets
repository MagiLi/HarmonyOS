
@Observed
export default class TaskInfo {
  id: number
  // 任务名称
  name: string
  finished:boolean

  constructor(id: number, name: string) {
    this.id = id
    this.name = name
    this.finished = false
  }
}
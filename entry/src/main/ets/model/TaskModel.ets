import relationalStore from '@ohos.data.relationalStore';
import TaskInfo from '../viewmodel/TaskInfo'
class  TaskModel {

  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'TASK'
  /**
   * 初始化任务表
   */

  initTaskDB(context) {
    // 1.rdb配置
    const config = {
      name: 'MyApplication.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S1 // 数据库安全级别
    }
    // 2.初始化表的SQL
    const sql = `CREATE TABLE IF NOT EXISTS TASK (
                  ID INTEGER PRIMARY KEY,
                  NAME TEXT NOT NULL,
                  FINISHED bit
                 )`

    // 3.获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        console.log('testTag', '获取rdbStore失败')
        return
      }
      console.log('testTag', '获取rdbStore成功')
      // 2.4 执行Sql，后续所有的增删改查都是使用rdbStore对象
      rdbStore.executeSql(sql)
      this.rdbStore = rdbStore
    })
  }

  /*
   * 查询任务列表
   */
  async  getTaskList() {
    //1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    //2.查询
    let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'FINISHED'])
    //3.解析查询结果
    let tasks: TaskInfo[] = []
    while (!result.isAtLastRow) {
      result.goToNextRow()

      let id = result.getLong(result.getColumnIndex('ID'))
      let name = result.getString(result.getColumnIndex('NAME'))
      let finished = result.getLong(result.getColumnIndex('FINISHED'))
      // finished两次取反 由number变成boolean
      tasks.push({id, name, finished: !!finished})
    }
  }

}
let taskModel = new TaskModel();

export default taskModel as TaskModel;
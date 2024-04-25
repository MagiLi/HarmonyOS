import preferences from '@ohos.data.preferences';

class  PreferencesUtil {

  prefMap:Map<string, preferences.Preferences> = new Map()

  // 加载 preferences
  async loadPreference(context, name:string) {
    try {
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name, pref)
      console.log('testTag', '加载Preference[${name}]成功')
    } catch (e) {
      console.log('testTag', '加载Preference[${name}]失败', JSON.stringify(e))
    }
  }

  // 保存数据
  async putPreferencesValue(name:string, key:string, value:preferences.ValueType) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', 'Preference[${name}]尚未初始化')
      return
    }

    try {
      let pref = this.prefMap.get(name)
      // 写入数据
      await pref.put(key, value)
      // 刷新磁盘
      await pref.flush()
      console.log('testTag', '保存Preference[${name}.${key} = ${value}]成功')
    } catch (e) {
      console.log('testTag', '保存Preference[${name}.${key}]失败', JSON.stringify(e))
    }

  }
  // 读取数据
  async getPreferencesValue(name:string, key:string, defaultValue:preferences.ValueType) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', 'Preference[${name}]尚未初始化')
      return
    }

    try {
      let pref = this.prefMap.get(name)
      // 读数据
      let value = await pref.get(key, defaultValue)
      console.log('testTag', '读取Preference[${name}.${key} = ${value}]成功')
      return value
    } catch (e) {
      console.log('testTag', '读取Preference[${name}.${key}]失败', JSON.stringify(e))
    }
  }
  // 删除数据
  async deletePreferencesValue(name:string, key:string) {
    if (!this.prefMap.has(name)) {
      console.log('testTag', 'Preference[${name}]尚未初始化')
      return
    }

    try {
      let pref = this.prefMap.get(name)
      await pref.delete(key)
      await pref.flush()
      console.log('testTag', '删除Preference[${name}.${key}]成功')
    } catch (e) {
      console.log('testTag', '读取Preference[${name}.${key}]失败', JSON.stringify(e))
    }
  }

}

const preferencesUtil = new PreferencesUtil()
export default preferencesUtil as PreferencesUtil
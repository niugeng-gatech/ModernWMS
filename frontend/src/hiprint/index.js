import { hiprint, defaultElementTypeProvider } from './hiprint.bundle.js'
// 调用浏览器打印js
import './plugins/jquery.hiwprint.js'
// 默认配置
import './hiprint.config.js'
// 样式
import './css/hiprint.css'
import './css/print-lock.css'

/**
 * 自动连接 / 连接
 * cb: 连接回调， (status, msg) {
 *   // status: true/false
 *   // msg: status == true 时 返回socket.connect回调 e
 * }
 */
const autoConnect = function (cb) {
  window.autoConnect = true
  window.hiwebSocket && window.hiwebSocket.hasIo() && window.hiwebSocket.start(cb)
}

/**
 * 取消自动连接 / 断开连接
 */
const disAutoConnect = function () {
  window.autoConnect = false
  window.hiwebSocket && window.hiwebSocket.hasIo() && window.hiwebSocket.stop()
}

const hiPrintPlugin = {
  disAutoConnect,
  install(Vue, name = '$hiPrint', autoConnect = true) {
    if (!autoConnect) {
      disAutoConnect()
    }
    const globalVue = Vue.prototype || Vue.config.globalProperties
    globalVue[name] = hiprint
    /**
     * 预览打印，调起系统打印预览
     * provider 左侧拖拽元素
     * template 模版json字符串
     * args 打印数据data, options,
     */
    globalVue.$print = function (provider = defaultElementTypeProvider, template, ...args) {
      hiprint.init({
        // eslint-disable-next-line new-cap
        providers: [new provider()]
      })
      const hiprintTemplate = new hiprint.PrintTemplate({
        template
      })
      hiprintTemplate.print(...args)
      return hiprintTemplate
    }
    /**
     * 单模版直接打印， 需客户端支持
     * provider 左侧拖拽项对象
     * template 模版json字符串
     * args 打印数据data, options,
     */
    globalVue.$print2 = function (provider = defaultElementTypeProvider, template, ...args) {
      hiprint.init({
         // eslint-disable-next-line new-cap
        providers: [new provider()]
      })
      const hiprintTemplate = new hiprint.PrintTemplate({
        template
      })
      hiprintTemplate.print2(...args)
      return hiprintTemplate
    }
  }
}

window.hiprint = hiprint
export { autoConnect, disAutoConnect, hiprint, hiPrintPlugin, defaultElementTypeProvider }

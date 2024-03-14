import { createI18n } from 'vue-i18n'
import XEUtils from 'xe-utils'
import { getSelectedLang, getLangPackage } from './method/index'

// get language
const defaultLang = getStorageLang()
const messages: { zh_CN?: any; en_US?: any; zh_TW?: any } = getLangPackage(defaultLang)

const i18n = createI18n({
  legacy: false,
  globalInjection: true,
  locale: getStorageLang(),
  messages
})

// get language in storage or default
function getStorageLang() {
  const lang = localStorage.getItem('language')
  if (lang) {
    return getSelectedLang(lang)
  }

  // Default browser language
  const browserLang = navigator.language
  let langStr = ''
  if (browserLang && XEUtils.isString(browserLang)) {
    // String
    langStr = browserLang
  } else if (browserLang && XEUtils.isArray(browserLang) && browserLang.length > 0) {
    // Array
    langStr = browserLang[0]
  }

  switch (langStr) {
    case 'zh-CN':
      return 'zh_CN'
    case 'zh-TW':
      return 'zh_TW'
    case 'en':
    default:
      return 'en_US'
  }
}

export default i18n

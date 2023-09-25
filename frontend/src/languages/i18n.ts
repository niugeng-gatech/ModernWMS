import { createI18n } from 'vue-i18n'
import messages from './langs/index'
import { getSelectedLang } from './method/index'

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
  return 'en_US'
}

export default i18n

import i18n from '@/languages/i18n'
import { hookComponent } from '@/components/system'

// Obtain the code for error information
function extractNumbers(str: string): any {
  const regex = /^(\d{3})\s/
  const match = str.match(regex)

  return match ? match[1] : null
}

// Return the corresponding error information based on the error code
export const httpCodeJudge = (msg: string, showTip = true) => {
  const code = extractNumbers(msg)
  if (code) {
    switch (code) {
      case '202':
        if (showTip) {
          hookComponent.$message({
            type: 'error',
            content: i18n.global.t(`${ i18n.global.t('system.tips.dataExpirationAutoRefresh') }`)
          })
        }
        return true
      default:
        return false
    }
  }

  return false
}

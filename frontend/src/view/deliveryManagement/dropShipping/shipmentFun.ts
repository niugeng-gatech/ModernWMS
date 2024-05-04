import i18n from '@/languages/i18n'

// Get the status display according to the key value
export function getShipmentState(state: number) {
  switch (state) {
    case 0:
      return i18n.global.t('wms.dropShipping.preShipment')
    case 1:
      return i18n.global.t('wms.dropShipping.newShipment')
    case 2:
      return i18n.global.t('wms.dropShipping.goodsToBePicked')
    case 3:
      return i18n.global.t('wms.dropShipping.picked')
    case 4:
      return i18n.global.t('wms.dropShipping.packaged')
    case 5:
      return i18n.global.t('wms.dropShipping.weighed')
    case 6:
      return i18n.global.t('wms.dropShipping.outOfWarehouse')
    case 7:
      return i18n.global.t('wms.dropShipping.signedIn')
  }
}
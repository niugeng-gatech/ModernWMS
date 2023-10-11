export const PRINT_MENU = [{
  vue_path: 'commodityManagement',
  i18nName: 'base.commodityManagement',
  children: [{
    tab_page: 'commodityManagement',
    form: {
      id: 0,
    spu_code: '',
    spu_name: '',
    category_id: 0,
    category_name: '',
    spu_description: '',
    supplier_id: 0,
    supplier_name: '',
    brand: '',
    origin: '',
    length_unit: 1,
    volume_unit: 0,
    weight_unit: 1,
    detailList: {
      name: 'commodityManagement',
      columns: ['sku_code', 'sku_name', 'unit', 'weight', 'width', 'height', 'volume', 'cost', 'price']
    }
    }
  }]
},
{
  vue_path: 'customer',
  i18nName: 'base.customer',
  children: [{
    tab_page: 'customer',
    form: {
      id: 0,
      customer_name: '',
      city: '',
      address: '',
      manager: '',
      email: '',
      contact_tel: '',
    }
  }]
}]
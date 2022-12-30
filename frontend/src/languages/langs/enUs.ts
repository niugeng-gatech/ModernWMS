export default {
  system: {
    hookComponent: {
      dialog: {
        defaultClose: 'Close',
        defaultConfirm: 'Agree',
        defaultTitle: 'Tips'
      }
    },
    page: {
      add: 'Add',
      update: 'Update',
      refresh: 'Refresh',
      export: 'Export',
      operate: 'Operate',
      edit: 'Edit',
      delete: 'Delete',
      close: 'Colse',
      submit: 'Submit',
      reset: 'Reset',
      confirm: 'Confirm',
      insertOneRow: 'Insert One Row',
      view: 'View'
    },
    tips: {
      success: ' success!',
      fail: ' fail!',
      beforeDeleteMessage: 'Do you want to delete this data?',
      beforeDeleteDetailMessage: 'Are you sure you want to delete this row?',
      detailLengthIsZero: 'Details verification before document submission!',
      detailHasItemRepeat: 'The details contain duplicate items!',
      noData: 'no data'
    },
    checkText: {
      checkFormFail: 'Operation failed. Please check the data and try again!',
      mustInput: 'Please fill in the '
    },
    homeHeader: {
      logout: 'Logout'
    },
    combobox: {
      sex: {
        male: 'Male',
        female: 'Female'
      },
      yesOrNo: {
        yes: 'yes',
        no: 'no'
      }
    }
  },
  router: {
    sideBar: {
      homepage: 'Home Page',
      baseModule: 'Basic Settings',
      ownerOfCargo: 'Owner Information',
      menuBasicSettings: 'Menu',
      userManagement: 'User Management',
      commodityCategorySetting: 'Commodity Category',
      commodityManagement: 'Commodity Management',
      userRoleSetting: 'User Role',
      companySetting: 'Company Information',
      freightSetting: 'Freight Setting',
      warehouseSetting: 'Warehouse Setting',
      customer: 'Customer Info',
      supplier: 'Supplier Info',
      roleMenu: 'Role Menu Settings',
      stockManagement: 'Stock Management',
      warehouseWorkingModule: 'Warehouse Working',
      warehouseProcessing: 'Warehouse Processing',
      warehouseMove: 'Inventory Move',
      warehouseFreeze: 'Inventory freeze',
      warehouseAdjust: 'Inventory Adjust',
      warehouseTaking: 'Inventory Take'
    }
  },
  login: {
    welcomeTitle: 'Welcome to ModernWMS!👋🏻',
    mainButtonLabel: 'Login',
    rememberTips: 'Remember me',
    userName: 'UserName',
    password: 'Password',
    loginSuccess: 'Login succeeded!',
    notAuthority: 'Your account does not contain any menu, please contact the administrator to add it!'
  },
  base: {
    freightSetting: {
      carrier: 'carrier',
      departure_city: 'Departure City',
      arrival_city: 'Arrival City',
      price_per_weight: 'Weight Fee',
      price_per_volume: 'Volume Fee',
      min_payment: 'Min Payment'
    },
    userManagement: {
      user_num: 'User Num',
      user_name: 'User Name',
      user_role: 'Role',
      contact_tel: 'Contact Information',
      sex: 'Sex',
      is_valid: 'Valid',
      restPwd: 'Reset password',
      checkboxIsNull: 'Please select data!',
      beforeResetPwd: 'Are you sure you want to reset the passwords of these users?',
      afterResetPwd: 'Password reset succeeded!'
    },
    warehouseSetting: {
      warehouseSetting: 'Warehouse Setting',
      reservoirSetting: 'Reservoir Setting',
      locationSetting: 'Location Setting',
      locationSelectModal: 'Location Select Modal',
      email: 'Email',
      warehouse_name: 'Warehouse Name',
      city: 'City',
      address: 'Address',
      contact_tel: 'Acontact Tel',
      manager: 'Manager',
      is_valid: 'Valid',
      area_name: 'Reservoir Name',
      area_property: 'Reservoir Category',
      location_name: 'Location Code',
      location_length: 'Location Length(m)',
      location_width: 'Location Width(m)',
      location_heigth: 'Location Height(m)',
      location_volume: 'Location Volume（m³）',
      location_load: 'Location Load（kg）',
      roadway_number: 'Roadway Number',
      shelf_number: 'Shelf Number',
      layer_number: 'Layer Number',
      tag_number: 'Tag Number',
      picking_area: 'Picking Area',
      stocking_area: 'Stocking Area',
      receiving_area: 'Receiving Area',
      return_area: 'Return Area',
      defective_area: 'Defective Area',
      inventory_area: 'Inventory Area'
    },
    customer: {
      customer_name: 'Customer Name',
      city: 'City',
      address: 'Address',
      manager: 'Manager',
      email: 'Email',
      contact_tel: 'Contact Tel',
      creator: 'Creater',
      create_time: 'Create Time',
      last_update_time: 'Last Update Time',
      is_valid: 'Valid'
    },
    supplier: {
      supplier_name: 'Supplier Name',
      city: 'City',
      address: 'Address',
      email: 'Email',
      manager: 'Manager',
      contact_tel: 'Contact Tel',
      creator: 'Creator',
      create_time: 'Create Time',
      last_update_time: 'Last Update Time',
      is_valid: 'Valid'
    },
    userRoleSetting: {
      role_name: 'User Role',
      is_valid: 'Valid'
    },
    companySetting: {
      company_name: 'Corporate Name',
      city: 'City',
      address: 'Detailed Address',
      manager: 'Person In Charge',
      contact_tel: 'Contact Information'
    },
    ownerOfCargo: {
      goods_owner_name: 'Owner Of Cargo',
      city: 'City',
      address: 'Detailed Address',
      manager: 'Person In Charge',
      contact_tel: 'Contact Information',
      creator: 'Creater',
      create_time: 'Creation Time'
    },
    commodityCategorySetting: {
      category_name: 'Commodity category',
      parent_name: 'Parent Category',
      creator: 'Creater',
      create_time: 'Creation Time'
    },
    roleMenu: {
      role_name: 'Role Name',
      menu_name: 'Menu Name',
      beforeUpdateOrDel: 'Please select the data to be processed first!'
    },
    commodityManagement: {
      spu_code: 'Commodity Code',
      spu_name: 'Commodity Name',
      category_name: 'Commodity Category',
      spu_description: 'Commodity Description',
      bar_code: 'Specification Code',
      sku_code: 'Specification Code',
      sku_name: 'Specification Name',
      supplier_name: 'Supplier Name',
      brand: 'Brand',
      unit: 'Commodity Unit',
      cost: 'Commodity Cost',
      price: 'Commodity Price',
      origin: 'origin',
      length_unit: 'Length Unit',
      volume_unit: 'Volume Unit',
      weight_unit: 'Weight Unit'
    }
  },
  wms: {
    stock: {
      stockSelectModal: 'Stock Select Modal',
      skuSelectModal: 'Commodity Select Modal',
      warehouse: 'Warehouse Name',
      location_name: 'Location Code',
      qty_available: 'Available Qty'
    },
    warehouseWorking: {
      warehouseProcessing: {
        job_code: 'Job Code',
        job_type: 'Job Type',
        process_status: 'Process Status',
        processor: 'Processor',
        process_time: 'Process Time',
        qty: 'Qty',
        is_source: 'Is Source',
        spu_code: 'Commodity Code',
        spu_name: 'Commodity Name',
        sku_code: 'Specification Code',
        sku_name: 'Specification Name',
        target_warehouse: 'Target Warehouse',
        target_location: 'Target Location',
        unit: 'Unit',
        is_update_stock: 'Is Updated Stock',
        creator: 'Creator',
        create_time: 'Create Time',
        last_update_time: 'Last Update Time',
        adjust_status: 'Is Updated Stock',
        source: 'Source',
        target: 'Target',
        process_split: 'Split Processing',
        process_combine: 'Combine Processing',
        confirmProcess: 'Confirm Process',
        confirmAdjust: 'Confirm Adjust',
        qtyMoreThanAvailable: 'Can\'t more than the number of Available',
        beforeConfirmProcess: 'Are you sure to process this data?',
        beforeConfirmAdjust: 'Are you sure to adjust this data?',
        alreadyProcess: 'The data can\'t delete because it had been processed',
        alreadyAdjust: 'The data can\'t delete because it had been adjusted'
      },
      warehouseMove: {
        move_status: 'Move Status',
        qty: 'Qty',
        handler: 'Handler',
        handle_time: 'Handle Time',
        orig_goods_warehouse: 'Origin Warehouse',
        orig_goods_location_name: 'Origin Location',
        dest_googs_warehouse: 'Target Warehouse',
        dest_googs_location_name: 'Target Location',
        confirmMove: 'Confirm Move',
        creator: 'Creator',
        create_time: 'Create Time',
        beforeConfirmMove: 'Are you sure to move this data?',
        unadjust: 'Unadjust',
        adjusted: 'Adjusted'
      },
      warehouseFreeze: {
        job_code: 'Job Code',
        job_type: 'Job Type',
        handler: 'Handler',
        handle_time: 'Handle Time',
        creator: 'Creator',
        create_time: 'Create Time',
        warehouse: 'Warehouse',
        location_name: 'Location Code',
        freeze: 'Freeze',
        unfreeze: 'Unfreeze'
      },
      warehouseAdjust: {
        job_code: 'Job Code',
        job_type: 'Job Type',
        warehouse: 'Warehouse',
        location_name: 'Location Code',
        handler: 'Handler',
        handle_time: 'Handle Time',
        creator: 'Creator',
        create_time: 'Create Time',
        qty: 'Difference Qty',
        warehouseTake: 'Warehouse Take',
        processCombine: 'Warehouse Process',
        processSplit: 'Warehouse Process',
        warehouseMove: 'Warehouse Move',
        confirmAdjust: 'Confirm Adjust',
        beforeConfirmAdjust: 'Are you sure to adjust this data?',
      },
      warehouseTaking: {
        job_code: 'Job Code',
        job_status: 'Job Status',
        warehouse: 'Warehouse',
        location_name: 'Location Code',
        book_qty: 'Book Qty',
        counted_qty: 'Actual Qty',
        difference_qty: 'Difference Qty',
        handler: 'Handler',
        handle_time: 'Handle Time',
        creator: 'Creator',
        create_time: 'Create Time',
        confirmTaking: 'Confirm Taking',
        unfinish: 'Unfinish',
        finish: 'Finish'
      }
    },
    stockManagement: {
      stockLocation: 'Stock Location'
    },
    stockLocation: {
      warehouse: 'Warehouse',
      location_name: 'Location Code',
      spu_code: 'Commodity code',
      spu_name: 'Trade name',
      sku_id: 'Sku Id',
      sku_code: 'Specification code',
      sku_name: 'Form Name',
      qty: 'Quantity',
      qty_available: 'Available Quantity',
      qty_locked: 'Locked Quantity',
      qty_frozen: 'Frozen Quantity'
    }
  }
}

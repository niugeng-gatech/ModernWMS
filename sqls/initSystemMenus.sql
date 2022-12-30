insert into menu(menu_name, module, vue_path, vue_directory, tenant_id, sort)
VALUES
('companySetting', 'baseModule', 'companySetting', 'base/companySetting', 1, 1),
('userRoleSetting', 'baseModule', 'userRoleSetting', 'base/userRoleSetting', 1, 2),
('roleMenu', 'baseModule', 'roleMenu', 'base/roleMenu', 1, 3),
('userManagement', 'baseModule', 'userManagement', 'base/userManagement', 1, 4),
('commodityCategorySetting', 'baseModule', 'commodityCategorySetting', 'base/commodityCategorySetting', 1, 5),
('commodityManagement', 'baseModule', 'commodityManagement', 'base/commodityManagement', 1, 6),
('supplier', 'baseModule', 'supplier', 'base/supplier', 1, 7),
('warehouseSetting', 'baseModule', 'warehouseSetting', 'base/warehouseSetting', 1, 8),
('ownerOfCargo', 'baseModule', 'ownerOfCargo', 'base/ownerOfCargo', 1, 9),
('freightSetting', 'baseModule', 'freightSetting', 'base/freightSetting', 1, 10),
('customer', 'baseModule', 'customer', 'base/customer', 1, 11),
('stockManagement', '', 'stockManagement', 'wms/stockManagement', 1, 12),
('warehouseProcessing', 'warehouseWorkingModule', 'warehouseProcessing', 'warehouseWorking/warehouseProcessing', 1, 13),
('warehouseMove', 'warehouseWorkingModule', 'warehouseMove', 'warehouseWorking/warehouseMove', 1, 14)
('warehouseFreeze', 'warehouseWorkingModule', 'warehouseFreeze', 'warehouseWorking/warehouseFreeze', 1, 15)
('warehouseAdjust', 'warehouseWorkingModule', 'warehouseAdjust', 'warehouseWorking/warehouseAdjust', 1, 16)
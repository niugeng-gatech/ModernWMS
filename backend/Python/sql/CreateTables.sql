DROP TABLE IF EXISTS "asn";
DROP TABLE IF EXISTS "asnmaster";
DROP TABLE IF EXISTS "asnprocess";
DROP TABLE IF EXISTS "asnsort";
DROP TABLE IF EXISTS "category";
DROP TABLE IF EXISTS "company";
DROP TABLE IF EXISTS "customer";
DROP TABLE IF EXISTS "dispatchpicklist";
DROP TABLE IF EXISTS "dispatchlist";
DROP TABLE IF EXISTS "freightfee";
DROP TABLE IF EXISTS "goodslocation";
DROP TABLE IF EXISTS "goodsowner";
DROP TABLE IF EXISTS "menu";
DROP TABLE IF EXISTS "rolemenu";
DROP TABLE IF EXISTS "stock";
DROP TABLE IF EXISTS "stockadjust";
DROP TABLE IF EXISTS "stockfreeze";
DROP TABLE IF EXISTS "stockmove";
DROP TABLE IF EXISTS "stocktaking";
DROP TABLE IF EXISTS "supplier";
DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS "userrole";
DROP TABLE IF EXISTS "warehouse";
DROP TABLE IF EXISTS "warehousearea";
DROP TABLE IF EXISTS "sku";
DROP TABLE IF EXISTS "stockprocessdetail";
DROP TABLE IF EXISTS "action_log";
DROP TABLE IF EXISTS "sku_safety_stock";
DROP TABLE IF EXISTS "spu";
DROP TABLE IF EXISTS "stockprocess";
CREATE TABLE "asnsort" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_asnsort" PRIMARY KEY IDENTITY(1,1),
    "asn_id" INTEGER NOT NULL,
    "sorted_qty" INTEGER NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "series_number" TEXT, 
    "putaway_qty" INTEGER NOT NULL);
CREATE TABLE "spu" (	
    "id" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),	
    "spu_code" TEXT,	"spu_name" TEXT,	
    "category_id" INTEGER,	
    "spu_description" TEXT,	
    "supplier_id" INTEGER,	
    "supplier_name" TEXT,	
    "brand" TEXT,	
    "origin" TEXT,	
    "length_unit" BINARY NOT NULL,	
    "volume_unit" BINARY NOT NULL,	
    "weight_unit" BINARY NOT NULL,	
    "creator" TEXT,	
    "create_time" DATETIME DEFAULT CURRENT_TIMESTAMP,	
    "last_update_time" DATETIME DEFAULT CURRENT_TIMESTAMP,	
    "is_valid" INTEGER,	
    "tenant_id" INTEGER);
CREATE TABLE "category" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_category" PRIMARY KEY IDENTITY(1,1),
    "category_name" TEXT NOT NULL,
    "parent_id" INTEGER NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "company" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_company" PRIMARY KEY IDENTITY(1,1),
    "company_name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "manager" TEXT NOT NULL,
    "contact_tel" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "customer" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_customer" PRIMARY KEY IDENTITY(1,1),
    "customer_name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "manager" TEXT NOT NULL,
    "contact_tel" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "dispatchlist" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_dispatchlist" PRIMARY KEY IDENTITY(1,1),
    "dispatch_no" TEXT NOT NULL,
    "dispatch_status" INTEGER NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "customer_name" TEXT NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "weight" TEXT NOT NULL,
    "volume" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "damage_qty" INTEGER NOT NULL,
    "lock_qty" INTEGER NOT NULL,
    "picked_qty" INTEGER NOT NULL,
    "intrasit_qty" INTEGER NOT NULL,
    "package_qty" INTEGER NOT NULL,
    "weighing_qty" INTEGER NOT NULL,
    "actual_qty" INTEGER NOT NULL,
    "sign_qty" INTEGER NOT NULL,
    "package_no" TEXT NOT NULL,
    "package_person" TEXT NOT NULL,
    "package_time" TEXT NOT NULL,
    "weighing_no" TEXT NOT NULL,
    "weighing_person" TEXT NOT NULL,
    "weighing_weight" TEXT NOT NULL,
    "waybill_no" TEXT NOT NULL,
    "carrier" TEXT NOT NULL,
    "freightfee" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL, 
    "series_number" TEXT);
CREATE TABLE "freightfee" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_freightfee" PRIMARY KEY IDENTITY(1,1),
    "carrier" TEXT NOT NULL,
    "departure_city" TEXT NOT NULL,
    "arrival_city" TEXT NOT NULL,
    "price_per_weight" TEXT NOT NULL,
    "price_per_volume" TEXT NOT NULL,
    "min_payment" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "goodslocation" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_goodslocation" PRIMARY KEY IDENTITY(1,1),
    "warehouse_id" INTEGER NOT NULL,
    "warehouse_name" TEXT NOT NULL,
    "warehouse_area_name" TEXT NOT NULL,
    "warehouse_area_property" INTEGER NOT NULL,
    "location_name" TEXT NOT NULL,
    "location_length" TEXT NOT NULL,
    "location_width" TEXT NOT NULL,
    "location_heigth" TEXT NOT NULL,
    "location_volume" TEXT NOT NULL,
    "location_load" TEXT NOT NULL,
    "roadway_number" TEXT NOT NULL,
    "shelf_number" TEXT NOT NULL,
    "layer_number" TEXT NOT NULL,
    "tag_number" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "warehouse_area_id" INTEGER NOT NULL
);
CREATE TABLE "goodsowner" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_goodsowner" PRIMARY KEY IDENTITY(1,1),
    "goods_owner_name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "manager" TEXT NOT NULL,
    "contact_tel" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "menu" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_menu" PRIMARY KEY IDENTITY(1,1),
    "menu_name" TEXT NOT NULL,
    "module" TEXT NOT NULL,
    "vue_path" TEXT NOT NULL,
    "vue_path_detail" TEXT NOT NULL,
    "vue_directory" TEXT NOT NULL,
    "sort" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL, 
    "menu_actions" TEXT DEFAULT "[]");
CREATE TABLE "rolemenu" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_rolemenu" PRIMARY KEY IDENTITY(1,1),
    "userrole_id" INTEGER NOT NULL,
    "menu_id" INTEGER NOT NULL,
    "authority" INTEGER NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL, 
    "menu_actions_authority" TEXT DEFAULT "[]");
CREATE TABLE "stock" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stock" PRIMARY KEY IDENTITY(1,1),
    "sku_id" INTEGER NOT NULL,
    "goods_location_id" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "is_freeze" INTEGER NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL, 
    "series_number" TEXT);
CREATE TABLE "stockadjust" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stockadjust" PRIMARY KEY IDENTITY(1,1),
    "job_code" TEXT NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "goods_location_id" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "is_update_stock" INTEGER NOT NULL,
    "job_type" INTEGER NOT NULL,
    "source_table_id" INTEGER NOT NULL, 
    "series_number" TEXT NOT NULL);
CREATE TABLE "stockfreeze" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stockfreeze" PRIMARY KEY IDENTITY(1,1),
    "job_code" TEXT NOT NULL,
    "job_type" INTEGER NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "goods_location_id" INTEGER NOT NULL,
    "handler" TEXT NOT NULL,
    "handle_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL, 
    "series_number" TEXT NOT NULL);
CREATE TABLE "stockmove" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stockmove" PRIMARY KEY IDENTITY(1,1),
    "job_code" TEXT NOT NULL,
    "move_status" INTEGER NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "orig_goods_location_id" INTEGER NOT NULL,
    "dest_googs_location_id" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "handler" TEXT NOT NULL,
    "handle_time" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL, 
    "series_number" TEXT);
CREATE TABLE "stockprocess" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stockprocess" PRIMARY KEY IDENTITY(1,1),
    "job_code" TEXT NOT NULL,
    "job_type" INTEGER NOT NULL,
    "process_status" INTEGER NOT NULL,
    "processor" TEXT NOT NULL,
    "process_time" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "stocktaking" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stocktaking" PRIMARY KEY IDENTITY(1,1),
    "job_code" TEXT NOT NULL,
    "job_status" INTEGER NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "goods_location_id" INTEGER NOT NULL,
    "book_qty" INTEGER NOT NULL,
    "counted_qty" INTEGER NOT NULL,
    "difference_qty" INTEGER NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "handler" TEXT NOT NULL,
    "handle_time" TEXT NOT NULL
);
CREATE TABLE "supplier" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_supplier" PRIMARY KEY IDENTITY(1,1),
    "supplier_name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "manager" TEXT NOT NULL,
    "contact_tel" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "user" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_user" PRIMARY KEY IDENTITY(1,1),
    "user_num" TEXT NOT NULL,
    "user_name" TEXT NOT NULL,
    "contact_tel" TEXT NOT NULL,
    "user_role" TEXT NOT NULL,
    "sex" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "auth_string" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "userrole" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_userrole" PRIMARY KEY IDENTITY(1,1),
    "role_name" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "warehouse" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_warehouse" PRIMARY KEY IDENTITY(1,1),
    "warehouse_name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "manager" TEXT NOT NULL,
    "contact_tel" TEXT NOT NULL,
    "creator" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL
);
CREATE TABLE "warehousearea" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_warehousearea" PRIMARY KEY IDENTITY(1,1),
    "warehouse_id" INTEGER NOT NULL,
    "area_name" TEXT NOT NULL,
    "parent_id" INTEGER NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "is_valid" INTEGER NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "area_property" INTEGER NOT NULL
);
CREATE TABLE "dispatchpicklist" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_dispatchpicklist" PRIMARY KEY IDENTITY(1,1),
    "dispatchlist_id" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "goods_location_id" INTEGER NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "pick_qty" INTEGER NOT NULL,
    "picked_qty" INTEGER NOT NULL,
    "is_update_stock" INTEGER NOT NULL,
    "last_update_time" TEXT NOT NULL, 
    "series_number" TEXT,
    CONSTRAINT "FK_dispatchpicklist_dispatchlist_dispatchlist_id" FOREIGN KEY ("dispatchlist_id") REFERENCES "dispatchlist" ("id") ON DELETE CASCADE
);
CREATE TABLE "sku" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_sku" PRIMARY KEY IDENTITY(1,1),
    "spu_id" INTEGER NOT NULL,
    "sku_code" TEXT NOT NULL,
    "sku_name" TEXT NOT NULL,
    "weight" TEXT NOT NULL,
    "lenght" TEXT NOT NULL,
    "width" TEXT NOT NULL,
    "height" TEXT NOT NULL,
    "volume" TEXT NOT NULL,
    "unit" TEXT NOT NULL,
    "cost" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "create_time" TEXT NOT NULL,
    "last_update_time" TEXT NOT NULL, 
    "bar_code" TEXT NOT NULL,
    CONSTRAINT "FK_sku_spu_spu_id" FOREIGN KEY ("spu_id") REFERENCES "spu" ("id") ON DELETE CASCADE
);
CREATE TABLE "stockprocessdetail" (
    "id" INTEGER NOT NULL CONSTRAINT "PK_stockprocessdetail" PRIMARY KEY IDENTITY(1,1),
    "stock_process_id" INTEGER NOT NULL,
    "sku_id" INTEGER NOT NULL,
    "goods_owner_id" INTEGER NOT NULL,
    "goods_location_id" INTEGER NOT NULL,
    "qty" INTEGER NOT NULL,
    "last_update_time" TEXT NOT NULL,
    "tenant_id" INTEGER NOT NULL,
    "is_source" INTEGER NOT NULL,
    "is_update_stock" INTEGER NOT NULL, 
    "series_number" TEXT,
    CONSTRAINT "FK_stockprocessdetail_stockprocess_stock_process_id" FOREIGN KEY ("stock_process_id") REFERENCES "stockprocess" ("id") ON DELETE CASCADE
);
CREATE TABLE "action_log" (	
	"id" INTEGER NOT NULL CONSTRAINT "PK_action_log" PRIMARY KEY IDENTITY(1,1),
	"vue_path" TEXT NOT NULL,	 
	"user_name" TEXT NOT NULL,	
	"action_content" TEXT NOT NULL,
	"action_time" DATETIME DEFAULT CURRENT_TIMESTAMP,
	"tenant_id" INTEGER);
CREATE TABLE "sku_safety_stock" (	
    "id" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),	
    "sku_id" INTEGER NOT NULL,	
    "safety_stock_qty" INTEGER,	
    "warehouse_id" INTEGER NOT NULL,	
    "warehouse_name" TEXT NOT NULL);
CREATE TABLE "asnmaster" (    
    "id" INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),    
    "asn_no" TEXT NOT NULL,    
    "asn_batch" TEXT NOT NULL,    
    "estimated_arrival_time" TEXT NOT NULL,    
    "asn_status" INTEGER NOT NULL,    
    "weight" REAL NOT NULL,    
    "volume" REAL NOT NULL,    
    "goods_owner_id" INTEGER NOT NULL,    
    "goods_owner_name" TEXT NOT NULL,    
    "creator" TEXT NOT NULL,    
    "create_time" DATETIME DEFAULT CURRENT_TIMESTAMP,    
    "last_update_time" DATETIME DEFAULT CURRENT_TIMESTAMP,    
    "tenant_id" INTEGER NOT NULL);
CREATE TABLE "asn" (    
    "id" INTEGER PRIMARY KEY IDENTITY(1,1),    
    "asn_no" TEXT NOT NULL,    
    "asn_status" INTEGER NOT NULL,    
    "spu_id" INTEGER NOT NULL,    
    "sku_id" INTEGER NOT NULL,    
    "asn_qty" INTEGER NOT NULL,    
    "actual_qty" INTEGER NOT NULL,    
    "sorted_qty" INTEGER NOT NULL,    
    "shortage_qty" INTEGER NOT NULL,    
    "more_qty" INTEGER NOT NULL,    
    "damage_qty" INTEGER NOT NULL,    
    "weight" TEXT NOT NULL,    
    "volume" TEXT NOT NULL,    
    "supplier_id" INTEGER NOT NULL,    
    "supplier_name" TEXT NOT NULL,    
    "goods_owner_id" INTEGER NOT NULL,    
    "goods_owner_name" TEXT NOT NULL,    
    "creator" TEXT NOT NULL,    
    "create_time" TEXT NOT NULL,    
    "last_update_time" TEXT NOT NULL,    
    "is_valid" INTEGER NOT NULL,    
    "tenant_id" INTEGER NOT NULL,	
    "asnmaster_id" INTEGER NOT NULL, 
    "arrival_time" DATETIME DEFAULT CURRENT_TIMESTAMP, 
    "unload_time" DATETIME DEFAULT CURRENT_TIMESTAMP, 
    "unload_person_id" INTEGER NOT NULL, 
    "unload_person" TEXT NOT NULL,	FOREIGN KEY (asnmaster_id) REFERENCES asnmaster(id));

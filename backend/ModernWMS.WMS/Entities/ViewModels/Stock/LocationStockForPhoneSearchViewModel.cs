﻿/*
* date：2023-9-3
* developer：NoNo
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ModernWMS.WMS.Entities.ViewModels
{
    /// <summary>
    /// get stock infomation by phone api input viewmodel
    /// </summary>
    public class LocationStockForPhoneSearchViewModel
    {
        /// <summary>
        /// sku_id
        /// </summary>
        public int sku_id { get; set; } = 0;

        /// <summary>
        /// goods_location_id
        /// </summary>
        public int goods_location_id { get; set; } = 0;

        /// <summary>
        /// 仓库标识
        /// </summary>
        public int warehouse_id { get; set; } = 0;
    }
}
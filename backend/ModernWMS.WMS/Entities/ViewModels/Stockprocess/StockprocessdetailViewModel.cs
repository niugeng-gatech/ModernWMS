/*
 * date：2022-12-23
 * developer：NoNo
 */

using System;
using System.ComponentModel.DataAnnotations;
using ModernWMS.Core.Utility;

namespace ModernWMS.WMS.Entities.ViewModels
{
    /// <summary>
    /// stockprocessdetail viewModel
    /// </summary>
    public class StockprocessdetailViewModel
    {
        #region constructor

        /// <summary>
        /// constructor
        /// </summary>
        public StockprocessdetailViewModel()
        {
        }

        #endregion constructor

        #region Property

        /// <summary>
        /// id
        /// </summary>
        [Display(Name = "id")]
        public int id { get; set; } = 0;

        /// <summary>
        /// stock_process_id
        /// </summary>
        [Display(Name = "stock_process_id")]
        public int stock_process_id { get; set; } = 0;

        /// <summary>
        /// sku_id
        /// </summary>
        [Display(Name = "sku_id")]
        public int sku_id { get; set; } = 0;

        /// <summary>
        /// goods_owner_id
        /// </summary>
        [Display(Name = "goods_owner_id")]
        public int goods_owner_id { get; set; } = 0;

        /// <summary>
        /// goods_location_id
        /// </summary>
        [Display(Name = "goods_location_id")]
        public int goods_location_id { get; set; } = 0;

        /// <summary>
        /// qty
        /// </summary>
        [Display(Name = "qty")]
        public int qty { get; set; } = 0;

        /// <summary>
        /// last_update_time
        /// </summary>
        [Display(Name = "last_update_time")]
        [DataType(DataType.DateTime, ErrorMessage = "DataType_DateTime")]
        public DateTime last_update_time { get; set; } = UtilConvert.MinDate;

        /// <summary>
        /// tenant_id
        /// </summary>
        [Display(Name = "tenant_id")]
        public long tenant_id { get; set; } = 0;

        /// <summary>
        /// is_source
        /// </summary>
        [Display(Name = "is_source")]
        public bool is_source { get; set; } = true;

        /// <summary>
        /// spu_code
        /// </summary>
        public string spu_code { get; set; } = string.Empty;

        /// <summary>
        /// spu_name
        /// </summary>
        public string spu_name { get; set; } = string.Empty;

        /// <summary>
        /// sku_code
        /// </summary>
        public string sku_code { get; set; } = string.Empty;

        /// <summary>
        /// unit
        /// </summary>
        public string unit { get; set; } = string.Empty;

        /// <summary>
        /// is_update_stock
        /// </summary>
        public bool is_update_stock { get; set; } = false;

        /// <summary>
        /// goods location name
        /// </summary>
        public string location_name { get; set; } = string.Empty;

        /// <summary>
        /// series_number
        /// </summary>
        [Display(Name = "series_number")]
        [MaxLength(64, ErrorMessage = "MaxLength")]
        public string series_number { get; set; } = string.Empty;

        /// <summary>
        /// expiry_date
        /// </summary>
        public DateTime expiry_date { get; set; } = UtilConvert.MinDate;

        /// <summary>
        /// price
        /// </summary>
        public decimal price { get; set; } = 0;

        #endregion Property
    }
}
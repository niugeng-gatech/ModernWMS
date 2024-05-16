﻿/*
 * date：2022-12-30
 * developer：AMo
 */
using System;
using System.ComponentModel.DataAnnotations;
using ModernWMS.Core.Utility;

namespace ModernWMS.WMS.Entities.ViewModels
{
    /// <summary>
    /// asn put away input viewModel
    /// </summary>
    public class AsnPutAwayInputViewModel
    {
        #region constructor
        /// <summary>
        /// constructor
        /// </summary>
        public AsnPutAwayInputViewModel()
        {

        }
        #endregion

        #region Property

        /// <summary>
        /// asn_id
        /// </summary>
        [Display(Name = "asn_id")]
        public int asn_id { get; set; } = 0;

        /// <summary>
        /// goods_owner_id
        /// </summary>
        [Display(Name = "goods_owner_id")]
        public int goods_owner_id { get; set; } = 0;

        /// <summary>
        /// serial_number
        /// </summary>
        [Display(Name = "serial_number")]
        public string serial_number { get; set; } = string.Empty;

        /// <summary>
        /// goods_location_id
        /// </summary>
        [Display(Name = "goods_location_id")]
        public int goods_location_id { get; set; } = 0;

        /// <summary>
        /// putaway_qty
        /// </summary>
        [Display(Name = "putaway_qty")]
        public int putaway_qty { get; set; } = 0;

        #endregion
    }
}

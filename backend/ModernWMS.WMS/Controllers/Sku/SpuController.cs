/*
 * date：2022-12-21
 * developer：NoNo
 */
 using Microsoft.AspNetCore.Mvc;
 using ModernWMS.Core.Controller;
 using ModernWMS.Core.Models;
 using ModernWMS.WMS.Entities.ViewModels;
 using ModernWMS.WMS.IServices;
 using Microsoft.Extensions.Localization;

namespace ModernWMS.WMS.Controllers
{
    /// <summary>
    /// spu controller
    /// </summary>
    [Route("spu")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "Base")]
    public class SpuController : BaseController
    {
        #region Args

        /// <summary>
        /// spu Service
        /// </summary>
        private readonly ISpuService _spuService;

        /// <summary>
        /// Localizer Service
        /// </summary>
        private readonly IStringLocalizer<ModernWMS.Core.MultiLanguage> _stringLocalizer;
        #endregion

        #region constructor
        /// <summary>
        /// constructor
        /// </summary>
        /// <param name="spuService">spu Service</param>
        /// <param name="stringLocalizer">Localizer</param>
        public SpuController(
            ISpuService spuService
          , IStringLocalizer<ModernWMS.Core.MultiLanguage> stringLocalizer
            )
        {
            this._spuService = spuService;
            this._stringLocalizer = stringLocalizer;
        }
        #endregion

        #region Api
        /// <summary>
        /// page search
        /// </summary>
        /// <param name="pageSearch">args</param>
        /// <returns></returns>
        [HttpPost("list")]
        public async Task<ResultModel<PageData<SpuBothViewModel>>> PageAsync(PageSearch pageSearch)
        {
            var (data, totals) = await _spuService.PageAsync(pageSearch, CurrentUser);

            return ResultModel<PageData<SpuBothViewModel>>.Success(new PageData<SpuBothViewModel>
            {
                Rows = data,
                Totals = totals
            });
        }
        /// <summary>
        /// get a record by id
        /// </summary>
        /// <returns>args</returns>
        [HttpGet]
        public async Task<ResultModel<SpuBothViewModel>> GetAsync(int id)
        {
            var data = await _spuService.GetAsync(id);
            if (data != null && data.id > 0)
            {
                return ResultModel<SpuBothViewModel>.Success(data);
            }
            else
            {
                return ResultModel<SpuBothViewModel>.Error(_stringLocalizer["exists_entity"]);
            }
        }
        /// <summary>
        /// add a new record
        /// </summary>
        /// <param name="viewModel">args</param>
        /// <returns></returns>
        [HttpPost]
        public async Task<ResultModel<int>> AddAsync(SpuBothViewModel viewModel)
        {
            var (id, msg) = await _spuService.AddAsync(viewModel, CurrentUser);
            if (id > 0)
            {
                return ResultModel<int>.Success(id);
            }
            else
            {
                return ResultModel<int>.Error(msg);
            }
        }

        /// <summary>
        /// update a record
        /// </summary>
        /// <param name="viewModel">args</param>
        /// <returns></returns>
        [HttpPut]
        public async Task<ResultModel<bool>> UpdateAsync(SpuBothViewModel viewModel)
        {
            var (flag, msg) = await _spuService.UpdateAsync(viewModel);
            if (flag)
            {
                return ResultModel<bool>.Success(flag);
            }
            else
            {
                return ResultModel<bool>.Error(msg, 400, flag);
            }
        }

        /// <summary>
        /// delete a record
        /// </summary>
        /// <param name="id">id</param>
        /// <returns></returns>
        [HttpDelete]
        public async Task<ResultModel<string>> DeleteAsync(int id)
        {
            var (flag, msg) = await _spuService.DeleteAsync(id);
            if (flag)
            {
                return ResultModel<string>.Success(msg);
            }
            else
            {
                return ResultModel<string>.Error(msg);
            }
        }
        #endregion

    }
}
 
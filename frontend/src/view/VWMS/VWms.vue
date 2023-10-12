<!--
 @name : VWMS.vue
 @Description : 
 @author : saal
 @date : 2023/10/6
-->
<template>
  <div class="VWMS-container">
    <Transition name="fade">
      <loading-page v-show="loading" />
    </Transition>
    <div class="VWms-header">
      <div class="warehouse-name">{{ warehouseInfo?.warehouse_name }}</div>

      <div class="tooltip">
        <div>
          <v-icon icon="mdi-menu-left"></v-icon>
        </div>
        <div>
          <v-icon icon="mdi-menu-left"></v-icon>
        </div>
        <div>
          <v-btn v-if="presentData?.type === 'shelf' || presentData?.type === 'shelfItem'" @click="handleShelfGrid">
            {{ showShelfGrid?'关闭':'打开' }}货架二维视图
          </v-btn>
        </div>
      </div>
    </div>
    <div class="VWMSIframe">
      <iframe
        ref="VWMSIframe"
        height="100%"
        src="unity/index.html"
        width="100%"
      />
    </div>
    <div>
      <Transition name="slide-fade-grid">
        <shelf-grid
          v-if="presentData?.type === 'shelf' && showShelfGrid || presentData?.type === 'shelfItem' && showShelfGrid"
          :shelf-grid-data="shelfGridData"
          :select-index="selectShelfItemTagNumber"
          @selectShelfItem="handleShelfGridSelect"
        ></shelf-grid>
      </Transition>
    </div>
    <div v-if="!loading" class="right-container">
      <Detail :present-data="presentData"></Detail>
      <Bar :bar-data="barData"></Bar>
      <Pie :pie-data="pieData"></Pie>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { useRoute } from 'vue-router'
import { onMounted, reactive, ref, watch } from 'vue'
import _ from 'lodash'
import LoadingPage from '@/view/VWMS/LoadingPage.vue'
import {
  getGoodsLocation,
  getWarehouse,
  getWarehouseAreaSelect,
  getWarehouseProduct
} from '@/api/base/warehouseSetting'
import { getGroupsData, handlePostJson } from '@/view/VWMS/handleData'
import {
  factoryDataType,
  factoryInfoType,
  factoryShowDataType,
  formatDataType,
  productDataType,
  productInfoType,
  shelfDataType,
  shelfGridDataType,
  shelfItemDataType,
  shelfItemInfoType,
  shelfItemShowDataType,
  shelfShowDataType,
  warehouseInfoType,
  warehouseShowDataType
} from '@/view/VWMS/types'
import Detail from '@/view/VWMS/Detail.vue'
import Bar from '@/view/VWMS/chat/Bar.vue'
import Pie from '@/view/VWMS/chat/Pie.vue'
import ShelfGrid from '@/view/VWMS/ShelfGrid.vue'

const VWMSIframe = ref()
const route = useRoute()
const loading = ref(true)
const warehouseId = parseInt(route.query.warehouseId as string)

onMounted(async () => {
  window.addEventListener('message', unityWatch)
})

const showShelfGrid = ref(true)
const handleShelfGrid = () => {
  showShelfGrid.value = !showShelfGrid.value
}
const handleShelfGridSelect = (index) => {
  selectObjectList.push({ itemName: 'shelfItem', itemId: index })
}

const unityWatch = ({ data }) => {
  const { event, guid } = data
  const allowEvent = ['loadSuccess', 'select', 'selectBreak']
  const unityEventHandleMap = {
    loadSuccess: handleLoadSuccess,
    select: handleSelect,
    selectBreak: handleSelectBreak
  }
  if (allowEvent.includes(event)) {
    unityEventHandleMap[event](guid)
  }
}
const handleLoadSuccess = async () => {
  await initData()
  startPostJson()
  setTimeout(() => {
    loading.value = false
  }, 2500)
}

interface selectObjectType {
  itemName: string,
  itemId: number
}

const selectObjectList = reactive<selectObjectType[]>([])
const presentData = ref<warehouseShowDataType | factoryShowDataType | shelfShowDataType | shelfItemShowDataType>()

const handleSelect = (guid: string) => {
  const itemName = guid.split('-')[0]
  const itemId = parseInt(guid.split('-')[1])
  const allowSelectItemName = ['factory', 'shelf', 'shelfItem']
  if (allowSelectItemName.includes(itemName)) {
    selectObjectList.push({ itemName, itemId })
  }
}

const handleSelectBreak = () => {
  if (selectObjectList.length > 1) {
    if (selectObjectList.length > 4) {
      selectObjectList.splice(2, selectObjectList.length - 2)
    } else {
      selectObjectList.pop()
    }
  }
}

const warehouseInfo = ref<warehouseInfoType>()
const factoryInfo = ref<factoryInfoType[]>([])
const shelfItemInfo = ref<shelfItemInfoType[]>([])
const productInfo = ref<productInfoType[]>([])
const formatData = ref<factoryDataType[]>([])
const selectFactoryData = ref<factoryDataType>()
const selectShelfName = ref()
const selectShelfItemTagNumber = ref()
const barData = ref()
const pieData = ref()

// 仓库 名称 地址 负责人 联系电话 email 库区数 总货物数
// 饼 存货类别占比(商品的类别) 柱 仓库库存大小
const getWarehouseData = (): warehouseShowDataType => {
  getWarehouseChatData()
  return {
    ...warehouseInfo.value!,
    factory_number: factoryInfo.value.length,
    warehouse_product_number: _.sumBy(productInfo.value, 'qty'),
    type: 'warehouse'
  }
}
// 仓库的图形数据
const getWarehouseChatData = () => {
  const barGroupsData = getGroupsData(productInfo.value, 'spu_name', 'qty').slice(0, 6)
  const barTitle = '库存商品量'
  barData.value = { barTitle, barGroupsData }

  const pieGroupsData = _.map(formatData.value, (obj) => {
    const totalQty = _.sumBy(obj.shelves, (shelf) => _.sumBy(shelf.shelfItems, (item) => _.sumBy(item.product, 'qty')))
    return { name: obj.area_name, value: totalQty }
  })

  const xData = _.map(pieGroupsData, 'name')
  const yData = _.map(pieGroupsData, 'value')
  const pieTitle = '库区容量'
  pieData.value = { pieTitle, xData, yData }
}

// 库区 名称 类型 货架数 库位数 剩余库位 已用空间
// 饼  存货类别占比 柱 货架库存大小
const getFactoryData = (id: number): factoryShowDataType => {
  const factory = _.filter(formatData.value, { id })[0]
  selectFactoryData.value = factory
  const factoryShelf = factory.shelves
  const factoryShelfItemNumber = _.sumBy(factoryShelf, shelf => shelf.layer * shelf.column)
  const usedFactoryShelfItem = _.flatMap(factoryShelf, shelf => _.flatMap(shelf.shelfItems, shelfItem => shelfItem.product))
  getFactoryChatData(usedFactoryShelfItem, factoryShelf)
  return {
    area_name: factory.area_name,
    area_property: factory.area_property,
    shelf_number: factoryShelf.length,
    shelf_item_number: factoryShelfItemNumber,
    surplus_number: factoryShelfItemNumber - usedFactoryShelfItem.length,
    factory_product_number: _.sumBy(usedFactoryShelfItem, 'qty'),
    type: 'factory'
  }
}

// 库区的图形数据
const getFactoryChatData = (usedFactoryShelfItem, factoryShelf) => {
  const barGroupsData = getGroupsData(usedFactoryShelfItem, 'spu_name', 'qty').slice(0, 6)
  const barTitle = '库区库存商品量'
  barData.value = { barTitle, barGroupsData }
  const pieGroupsData = _.map(factoryShelf, obj => {
    const totalQty = _.sumBy(obj.shelfItems, (item: shelfItemDataType) => _.sumBy(item.product, 'qty'))
    return { name: obj.shelf_name, value: totalQty }
  })

  const xData = _.map(pieGroupsData, 'name')
  const yData = _.map(pieGroupsData, 'value')
  const pieTitle = '货架容量'
  pieData.value = { pieTitle, xData, yData }
}

const shelfGridData = ref<shelfGridDataType>()
// 货架 名称 规格 闲置位 总货物数
// 饼 存货类别占比 柱 库位存量大小
const getShelfData = (id: number): shelfShowDataType => {
  const shelf: shelfDataType = selectFactoryData.value!.shelves.filter(shelf => shelf.shelf_name === `${ id }`)[0] as shelfDataType
  const shelfProduct: productDataType[] = _.flatMap(shelf.shelfItems, shelfItem => shelfItem.product)
  selectShelfName.value = shelf.shelf_name
  getShelfChatData(shelfProduct, shelf)
  // 货架二维图数据
  shelfGridData.value = {
    layer: shelf.layer,
    column: shelf.column,
    products: shelf.shelfItems.map(shelfItem => {
      if (shelfItem.product.length > 0) return parseInt(shelfItem.tag_number)
      return 0
    })
  }

  return {
    shelf_name: `${ shelf.shelf_name }号货架`,
    layer: shelf.layer,
    column: shelf.column,
    surplus_number: shelf.layer * shelf.column - _.sumBy(shelf.shelfItems, shelfItem => shelfItem.product.length),
    shelf_product_number: _.sumBy(shelfProduct, 'qty'),
    type: 'shelf'
  }
}

// 货架的图形数据
const getShelfChatData = (shelfProduct, shelf) => {
  const barGroupsData = getGroupsData(shelfProduct, 'sku_name', 'qty')
  const barTitle = '货架商品规格量'
  barData.value = { barTitle, barGroupsData }
  const pieGroupsData = _.map(shelf.shelfItems, (item) => {
    const totalQty = _.sumBy(item.product, 'qty')
    return { name: item.location_name, value: totalQty }
  })

  const xData = _.map(pieGroupsData, 'name')
  const yData = _.map(pieGroupsData, 'value')
  const pieTitle = '库位容量'
  pieData.value = { pieTitle, xData, yData }
}

// 货物 层号 库位号 库位编码
// 列表 商品名称 规格名称 数量 可用数量 货主
const getShelfItemData = (id: number): shelfItemShowDataType | any => {
  const shelf = _.filter(selectFactoryData.value?.shelves, { shelf_name: selectShelfName.value })[0]
  const shelfItem = _.filter(shelf.shelfItems, { tag_number: `${ id }` })[0]
  selectShelfItemTagNumber.value = id
  if (shelfItem) {
    return {
      ...shelfItem,
      type: 'shelfItem'
    }
  }
  return {
    tag_number: id,
    location_name: '无',
    layer_number: Math.ceil(id / shelf.column),
    product: [],
    type: 'shelfItem'
  }
}

watch(selectObjectList, () => {
  const targetData = selectObjectList[selectObjectList.length - 1]
  const handleMap = {
    playground: getWarehouseData,
    factory: getFactoryData,
    shelf: getShelfData,
    shelfItem: getShelfItemData
  }
  presentData.value = handleMap[targetData.itemName](targetData.itemId)
})

const initData = async () => {
  try {
    const promises = [
      getWarehouse(warehouseId),
      getWarehouseAreaSelect(warehouseId),
      getGoodsLocation(),
      getWarehouseProduct({ warehouse_id: warehouseId })
    ]
    const responses: any = await Promise.all(promises)
    warehouseInfo.value = responses[0].data.data
    factoryInfo.value = responses[1].data.data
    shelfItemInfo.value = responses[2].data.data
    productInfo.value = responses[3].data.data
  } catch (error) {
    window.alert(error)
    loading.value = true
  }
  selectObjectList.push({ itemName: 'playground', itemId: warehouseId })
  const data: formatDataType = handlePostJson(factoryInfo.value, shelfItemInfo.value, productInfo.value)
  formatData.value = data.area
}

const startPostJson = () => {
  const data: formatDataType = handlePostJson(factoryInfo.value, shelfItemInfo.value, productInfo.value)
  VWMSIframe.value.contentWindow.parent.postMessage({ guid: JSON.stringify(data), event: 'sendData' }, '*')
}

</script>

<style lang="less" scoped>
* {
  box-sizing: border-box;
}

.VWMS-container {
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #317972;
}
.VWms-header {
  position: fixed;
  top: 10px;
  left: 10px;
  z-index: 10;
  display: flex;
  height: 70px;
  align-items: center;
  background-color: rgba(255, 255, 255, 0.9);
  padding: 10px;
  border-radius: 2px;
  &>div {
    margin: 10px;
  }
  .warehouse-name {
    font-size: 18px;
    font-weight: 600;
  }
  .tooltip{
    display: flex;
    align-items: center;
    margin-left: 10px;
    &>div{
      margin-left: 10px;
    }
  }
}

.VWMSIframe {
  width: 100%;
  height: 100%;
  border: none;
  position: absolute;
}

.right-container {
  display: grid;
  grid-template-columns: 450px;
  grid-gap: 15px;
  position: absolute;
  right: 0;
  height: 100%;
  width: 500px;
  overflow: auto;
  padding: 10px 0;
  justify-content: center

}

.flex-center {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

::-webkit-scrollbar {
  display: none
}

.VWms-card {
  border-radius: 5px;
  padding: 15px;
  width: 100%;
  background-color: rgba(255, 255, 255, 0.9);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
.slide-fade-grid-enter-active {
  transition: all 0.3s ease-out;
}

.slide-fade-grid-leave-active {
  transition: all 0.5s ease-out;
}

.slide-fade-grid-enter-from,
.slide-fade-grid-leave-to {
  transform: translateX(-200px);
  opacity: 0;
}
</style>
<template>
  <div class="container">
    <div class="VWMS">
      <v-select
        label="Select"
        :items="warehouseInfo"
        item-title="name"
        item-value="value"
        @update:model-value="selectWarehouse"
      ></v-select>
      <v-btn @click="goVWMS">click</v-btn>
    </div>
    <div class="textBox">
      <div class="mainTitle">ModernWMS</div>
      <div class="subTitle">{{ i18n.global.t('homepage.subTitle') }}</div>
    </div>
    <div class="content">
      <div class="lottieBox">
        <lottie :src="dataJson"></lottie>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { useRouter } from 'vue-router'
import { ref, onMounted } from 'vue'
import lottie from '@/components/lottie.vue'
import dataJson from '@/assets/warehouse.json'
import i18n from '@/languages/i18n'
import { getWarehouseSelect } from '@/api/base/warehouseSetting'

const router = useRouter()

onMounted(() => {
  getWarehouseInfo()
})
const warehouseInfo = ref()
const getWarehouseInfo = async () => {
  const { data: res } = await getWarehouseSelect()
  if (res.isSuccess) {
    warehouseInfo.value = res.data
  }
}
const warehouseId = ref()
const selectWarehouse = (val:string) => {
  warehouseId.value = val
}
const goVWMS = () => {
  const href = router.resolve({
    path: '/VWMS',
    query: {
      warehouseId: warehouseId.value,
    },
  })
  window.open(href.href, '_blank')
}
</script>

<style scoped lang="less">
.container {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  position: relative;
  align-items: center;
}
.VWMS{
  position: absolute;
  top: 0;
  display: flex;
  align-items: center;
  width: 40%;
  z-index: 999999999;
}

.content {
  width: 60%;
}

.textBox {
  width: 100%;
  position: absolute;
  left: 50%;
  top: 5%;
  transform: translate(-50%, 0);
  letter-spacing: 5px;
  z-index: 999;
  font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}

.mainTitle {
  display: flex;
  justify-content: center;
  width: 100%;
  color: #9c27b0;
  font-weight: bold;
  font-size: 120px;
}

.subTitle {
  display: flex;
  justify-content: center;
  width: 100%;
  font-size: 30px;
  letter-spacing: 5px;
  color: #c9a7cf;
}

.lottieBox {
  min-width: 100%;
  max-width: 100%;
}
</style>

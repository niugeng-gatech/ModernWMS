<template>
  <v-dialog v-model="data.showDialog" :persistent="true" transition="dialog-top-transition" width="auto">
    <template #default>
      <v-card :title="$t('system.page.preView')">
        <v-card-text>
          <div class="print-area-container">
            <div class="print-area-scroll">
              <div
                id="printArea"
                :style="{'grid-template-columns': `repeat(${data.rowsNumber},1fr)`}"
                class="printArea"
              >
                <div v-for="(item, index) in data.printData" :key="index" class="code-container">
                  <svg :id="'printBarCode'+ item.id"></svg>
                </div>
              </div>
            </div>
          </div>
        </v-card-text>

        <v-card-actions class="justify-space-between">
          <div class="row-number-input">
            <v-text-field
              v-model.number="data.rowsNumber"
              hide-details="auto"
              :label="$t('system.page.rowsNumber')"
              width="300px"
            ></v-text-field>
          </div>
          <div class="padding-lr-16">
            <v-btn variant="text" @click="method.closeDialog">{{ $t('system.page.close') }}</v-btn>
            <v-btn v-print="'#printArea'" color="primary" :disabled="isDisabled" variant="text">{{ $t('system.page.print') }}</v-btn>
          </div>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script lang="ts" setup>
import { computed, nextTick, reactive, watch } from 'vue'
import JsBarcode from 'jsbarcode'

const data = reactive({
  showDialog: false,
  printData: [] as any,
  rowsNumber: 5
})
const isDisabled = computed(() => data.printData.length === 0)

watch(() => data.printData, () => {
  if (data.printData.length < 5) {
    data.rowsNumber = data.printData.length
  } else {
    data.rowsNumber = 5
  }
})

const method = reactive({
  openDialog: (row: any) => {
    data.printData = row

    data.showDialog = true

    nextTick(() => {
      for (const item of data.printData) {
        JsBarcode(`#printBarCode${ item.id }`, item.id, {
          fontSize: 12,
          width: 2,
          height: 40,
          displayValue: true
        })
      }
    })
  },
  closeDialog: () => {
    data.showDialog = false
  }
})

defineExpose({
  openDialog: method.openDialog,
  closeDialog: method.closeDialog
})
</script>

<style lang="less" scoped>

.print-area-container {
  background-color: #efefef;
  padding: 15px;
}

.print-area-scroll {
  overflow: auto;
  max-width: 900px;
  min-width: 300px;
  height: 500px;
}

.printArea {
  display: grid;
  align-items: center;
  grid-gap: 15px;

  .code-container {
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

.row-number-input {
  width: 300px;
  padding: 0 16px;
}

.padding-lr-16 {
  padding: 0 16px;
}
</style>

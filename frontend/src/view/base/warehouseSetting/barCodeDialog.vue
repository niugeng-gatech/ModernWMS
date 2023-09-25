<template>
  <v-dialog v-model="data.showDialog" width="348px" transition="dialog-top-transition" :persistent="true">
    <template #default>
      <v-card>
        <v-card-text>
          <div id="printArea" class="printArea">
            <div>
              <div style="width: 100%; height: 100%; display: flex; flex: none; justify-content: center; align-items: center">
                <svg id="printBarCode"></svg>
              </div>
            </div>
            <!-- </div> -->
          </div>
        </v-card-text>

        <v-card-actions class="justify-end">
          <v-btn variant="text" @click="method.closeDialog">{{ $t('system.page.close') }}</v-btn>
          <v-btn v-print="'#printArea'" color="primary" variant="text">{{ $t('system.page.print') }}</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script setup lang="tsx">
import { reactive, nextTick } from 'vue'
import JsBarcode from 'jsbarcode'

const data = reactive({
  showDialog: false,
  printData: {
    location_id: 0
  } as any
})

const method = reactive({
  openDialog: (row: any) => {
    data.printData = row

    data.showDialog = true

    nextTick(() => {
      JsBarcode('#printBarCode', data.printData.id, {
        fontSize: 12,
        width: 2,
        height: 40,
        displayValue: true
      })
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

<style scoped lang="less">
.printArea {
  width: 300px;

  // display: flex;
  // flex-wrap: wrap;
  // align-items: center;
  // justify-content: center;
  text-align: center;

  box-sizing: border-box;
  padding: 10px;

  .printTopContainer {
    display: flex;
    justify-content: space-between;
  }
}
.printLabel {
  font-size: 14px;
  font-weight: bold;

  display: flex;
  flex-wrap: wrap;
  align-items: center;

  box-sizing: border-box;
  padding-left: 20px;

  .labelTitle {
    opacity: 0.7;
    font-weight: 600;
  }

  div {
    width: 100%;
  }
}
</style>

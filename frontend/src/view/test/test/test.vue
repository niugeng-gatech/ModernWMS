<template>
  <div class="container">
    <div>
      <v-card class="mt-5">
        <v-card-text>
          <div class="operateArea">
            <v-row no-gutters>
              <!-- Operate Btn -->

              <!-- old version -->
              <v-col cols="12" sm="3" class="col">
                <!-- <tooltip-btn icon="mdi-plus" :tooltip-text="$t('system.page.add')" @click="method.add()"></tooltip-btn>
                <tooltip-btn icon="mdi-refresh" :tooltip-text="$t('system.page.refresh')" @click="method.refresh()"></tooltip-btn>
                <tooltip-btn icon="mdi-export-variant" :tooltip-text="$t('system.page.export')" @click="method.exportTable"></tooltip-btn> -->

                <!-- new version -->
                <BtnGroup :btn-list="data.btnList" />
              </v-col>

              <!-- Search Input -->
              <v-col cols="12" sm="9"> </v-col>
            </v-row>
          </div>

          <!-- Table -->
          <div
            class="mt-5"
            :style="{
              height: cardHeight
            }"
          >
            <WorkFlow :table-name="'nihao'" />
          </div>
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { computed, reactive, onMounted, ref } from 'vue'
import BtnGroup from '@/components/system/btnGroup.vue'
import i18n from '@/languages/i18n'
import { computedCardHeight } from '@/constant/style'
import WorkFlow from '../../../components/flow/workFlow.vue'

const xTable = ref()

const data = reactive({
  btnList: [
    {
      name: i18n.global.t('system.page.add'),
      icon: 'mdi-plus',
      code: 'add',
      click: () => {}
    },
    {
      name: i18n.global.t('system.page.refresh'),
      icon: 'mdi-refresh',
      code: 'refresh',
      click: () => {}
    },
    {
      name: i18n.global.t('system.page.export'),
      icon: 'mdi-export-variant',
      code: 'export',
      click: () => {}
    }
  ]
})

const method = reactive({})

onMounted(async () => {})

const cardHeight = computed(() => computedCardHeight({ hasTab: false }))
</script>

<style scoped lang="less">
.operateArea {
  width: 100%;
  min-width: 760px;
  display: flex;
  align-items: center;
  border-radius: 10px;
  padding: 0 10px;
}

.col {
  display: flex;
  align-items: center;
}
</style>

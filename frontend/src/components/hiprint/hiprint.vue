<template>
  <v-dialog v-model="data.formVisible" fullscreen :scrim="false" transition="dialog-bottom-transition">
    <v-card>
      <v-toolbar color="white">
        <v-toolbar-title>print</v-toolbar-title>
        <v-spacer></v-spacer>
        <!-- <v-toolbar-items>
          <v-btn variant="text" @click="method.init"> LOAD </v-btn>
        </v-toolbar-items> -->
        <v-btn icon @click="data.formVisible = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-toolbar>
      <div style="padding: 0 15px">
        <v-row>
          <v-col cols="2">
            <v-select
              v-model="data.mode"
              :items="data.modeList"
              item-title="label"
              item-value="value"
              density="compact"
              hide-details
              clearable
              @update:model-value="method.changeMode"
            ></v-select>
            <div class="left-box">
              <div class="rect-printElement-types hiprintEpContainer"> </div>
            </div>
          </v-col>
          <v-col cols="7">
            <div class="center-btn-box">
              <div>
                <v-btn
                  v-for="(value, type) in data.paperTypes"
                  :key="type"
                  :color="curPaperType === type ? 'indigo-darken-3' : 'white'"
                  @click="method.setPaper(type, value)"
                >
                  {{ type }}
                </v-btn>
                <v-btn
                  icon="mdi-magnify-minus-outline"
                  style="font-size: 14px; margin-left: 10px"
                  size="small"
                  @click="method.changeScale(false)"
                ></v-btn>
                <v-btn disabled size="small" style="margin-left: 10px; width: 70px">{{ scaleValueStr }}%</v-btn>
                <v-btn
                  icon="mdi-magnify-plus-outline"
                  style="font-size: 14px; margin-left: 10px"
                  size="small"
                  @click="method.changeScale(true)"
                ></v-btn>
              </div>
              <div>
                <v-btn style="font-size: 14px; margin-left: 10px" color="primary" @click="method.preView()"> {{ $t('system.page.submit') }} </v-btn>
                <v-btn style="font-size: 14px; margin-left: 10px" @click="method.preView()"> {{ $t('system.page.preView') }} </v-btn>
              </div>
            </div>

            <div class="center-box card-design">
              <div id="hiprint-printTemplate" style="margin-top: 20px" class="hiprint-printTemplate"></div>
            </div>
          </v-col>
          <v-col cols="3">
            <div class="box">
              <div id="PrintElementOptionSetting"></div>
            </div>
          </v-col>
        </v-row>
      </div>
    </v-card>
    <preViewDialog ref="preViewDialogRef" />
  </v-dialog>
</template>
<script lang="ts" setup>
import { reactive, ref, computed } from 'vue'
import $ from 'jquery'
import { hiprint } from '@/hiprint/index.js'
import i18n from '@/languages/i18n'
import preViewDialog from './preView.vue'

interface paperTypeData {
  width: number
  height: number
}
interface tableInterFace {
  name: string
  field: string
  columns: Array<string>
}
const props = defineProps<{
  form: object
  table?: Array<tableInterFace>
  i18nName: string
  vueName: string
}>()
const preViewDialogRef = ref()
const data = reactive({
  formVisible: false,
  hiprintTemplate: {} as any,
  mode: 1,
  modeList: [
    { label: '格式1', value: 1 },
    { label: '格式2', value: 2 }
  ],
  // 当前纸张
  curPaper: {
    type: 'A4',
    width: 210,
    height: 296.6
  },
  // 纸张类型
  paperTypes: {
    A3: {
      width: 420,
      height: 296.6
    },
    A4: {
      width: 210,
      height: 296.6
    },
    A5: {
      width: 210,
      height: 147.6
    },
    B3: {
      width: 500,
      height: 352.6
    },
    B4: {
      width: 250,
      height: 352.6
    },
    B5: {
      width: 250,
      height: 175.6
    }
  },
  scaleValue: 1,
  scaleMax: 5,
  scaleMin: 0.5,
  panel: {
    panels: [
      {
        index: 0,
        name: 1,
        height: 296.6,
        width: 210,
        paperHeader: 0,
        paperFooter: 840.7559055118112,
        printElements: [
          {
            options: {
              left: 110,
              top: 92.5,
              height: 17,
              width: 120,
              testData: '单据表头',
              fontSize: 16.5,
              fontWeight: '700',
              textAlign: 'center',
              hideTitle: true,
              title: '单据表头'
            },
            printElementType: { title: '单据表头', type: 'text' }
          },
          {
            options: {
              left: 135,
              top: 175,
              height: 16,
              width: 120,
              testData: '单据类型',
              fontSize: 15,
              fontWeight: '700',
              textAlign: 'center',
              hideTitle: true,
              title: '单据类型'
            },
            printElementType: { title: '单据类型', type: 'text' }
          },
          {
            options: {
              left: 302.5,
              top: 112.5,
              height: 16,
              width: 120,
              field: 'orderId',
              testData: 'XS888888888',
              fontSize: 6.75,
              fontWeight: '700',
              textAlign: 'left',
              textContentVerticalAlign: 'middle',
              title: '订单编号'
            },
            printElementType: { title: '订单编号', type: 'text' }
          }
        ],
        paperNumberLeft: 565,
        paperNumberTop: 204,
        paperNumberContinue: true,
        scale: 1,
        watermarkOptions: {}
      }
    ]
  }
})
const method = reactive({
  initProvider() {
    const elementList = [
      new hiprint.PrintElementTypeGroup(i18n.global.t('system.hiprint.routine'), [
        {
          tid: 'providerModule.customText',
          title: i18n.global.t('system.hiprint.text'),
          customText: i18n.global.t('system.hiprint.text'),
          custom: true,
          type: 'text'
        }
        // { tid: 'providerModule.image', title: 'Logo', data: '', type: 'image' }
      ])
    ]
    const userList = []
    for (const key in props.form) {
      const i18nName = `${ props.i18nName }.${ key }`
      const labelName = i18n.global.t(i18nName)
      if (labelName !== i18nName && !key.includes('detailList')) {
        userList.push({
          tid: `providerModule.${ key }`,
          title: labelName,
          data: labelName,
          type: 'text',
          options: {
            field: key,
            testData: labelName,
            height: 16,
            fontSize: 6.75,
            fontWeight: '700',
            textAlign: 'left',
            textContentVerticalAlign: 'middle'
          }
        })
      }
    }
    let index = 1
    props.table?.forEach((item) => {
      const object = {
        tid: `providerModule.table${ index.toString() }`,
        title: item.name,
        type: 'table',
        options: {
          field: item.field,
          fields: [{ text: '名称', field: 'NAME' }]
        },
        editable: true,
        columnDisplayEditable: true, // 列显示是否能编辑
        columnDisplayIndexEditable: true, // 列顺序显示是否能编辑
        columnTitleEditable: true, // 列标题是否能编辑
        columnResizable: true, // 列宽是否能调整
        columnAlignEditable: true, // 列对齐是否调整
        columns: [[{ title: '部门', align: 'center', field: 'dept', width: 50 }]]
      }
      object.columns[0] = []
      object.options.fields = []
      item.columns.forEach((col) => {
        const i18nName = `${ props.i18nName }.${ col }`
        const labelName = i18n.global.t(i18nName)
        if (i18nName !== labelName) {
          object.columns[0].push({ title: labelName, align: 'center', field: col, width: 50 })
          object.options.fields.push({ text: labelName, field: col })
        }
      })
      userList.push(object)
      index += 1
    })
    if (userList.length > 0) {
      elementList.push(new hiprint.PrintElementTypeGroup(i18n.global.t('system.hiprint.customer'), userList))
    }
    elementList.push(
      new hiprint.PrintElementTypeGroup(i18n.global.t('system.hiprint.auxiliary'), [
        {
          tid: 'providerModule.hline',
          title: i18n.global.t('system.hiprint.hline'),
          type: 'hline'
        },
        {
          tid: 'providerModule.vline',
          title: i18n.global.t('system.hiprint.vline'),
          type: 'vline'
        },
        {
          tid: 'providerModule.rect',
          title: i18n.global.t('system.hiprint.rect'),
          type: 'rect'
        },
        {
          tid: 'providerModule.oval',
          title: i18n.global.t('system.hiprint.oval'),
          type: 'oval'
        }
      ])
    )
    const addElementTypes = function (context: any) {
      context.removePrintElementTypes('providerModule')
      context.addPrintElementTypes('providerModule', elementList)
    }
    return {
      addElementTypes
    }
  },
  init() {
    // const provider = providers[0]
    hiprint.init({
      providers: [method.initProvider()]
    })
    $('.hiprintEpContainer').empty()
    hiprint.PrintElementTypeManager.build('.hiprintEpContainer', 'providerModule')
    $('#hiprint-printTemplate').empty()
    data.hiprintTemplate = new hiprint.PrintTemplate({
      template: data.panel,
      dataMode: 1, // 1:getJson 其他：getJsonTid 默认1
      history: false, // 是否需要 撤销重做功能
      // onDataChanged: (type, json) => {
      //   console.log(type) // 新增、移动、删除、修改(参数调整)、大小、旋转
      //   console.log(json) // 返回 template
      //   // 更新模板
      //   // hiprintTemplate.update(json)
      //   // console.log(hiprintTemplate.historyList)
      // },
      settingContainer: '#PrintElementOptionSetting',
      paginationContainer: '.hiprint-printPagination'
    })
    data.hiprintTemplate.design('#hiprint-printTemplate')
  },
  setPaper(type: string, value: paperTypeData) {
    try {
      if (Object.keys(data.paperTypes).includes(type)) {
        data.curPaper = { type, width: value.width, height: value.height }
      } else {
        data.curPaper = { type: 'other', width: value.width, height: value.height }
      }
      data.hiprintTemplate.setPaper(value.width, value.height)
    } catch (error) {
      console.log(error)
    }
  },
  changeScale(big: boolean) {
    let scaleValue = data.scaleValue
    if (big) {
      scaleValue += 0.1
      if (scaleValue > data.scaleMax) scaleValue = 5
    } else {
      scaleValue -= 0.1
      if (scaleValue < data.scaleMin) scaleValue = 0.5
    }
    scaleValue = Number(scaleValue.toFixed(1))
    if (data.hiprintTemplate) {
      // scaleValue: 放大缩小值, false: 不保存(不传也一样), 如果传 true, 打印时也会放大
      data.hiprintTemplate.zoom(scaleValue, true)
      data.scaleValue = scaleValue
    }
  },
  changeMode() {
    method.init()
  },
  preView() {
    const ref = preViewDialogRef.value
    ref.data.width = data.curPaper.width
    ref.data.hiprintTemplate = data.hiprintTemplate
    ref.data.printData = props.form
    ref.method.show()
  }
})
const scaleValueStr = computed(() => {
  let scaleValue = data.scaleValue * 100
  scaleValue = Number(scaleValue.toFixed(0))
  return scaleValue
})
const curPaperType = computed(() => {
  let type = 'other'
  const types = data.paperTypes
  for (const key in types) {
    const item = types[key]
    const { width, height } = data.curPaper
    if (item.width === width && item.height === height) {
      type = key
    }
  }
  return type
})

defineExpose({
  data
})
</script>
<style scoped lang="less">
@import '../../assets/css/bootstrap.min.css';
.center-btn-box {
  margin-bottom: 5px;
  display: flex;
  justify-content: space-between;
}
.center-box {
  height: calc(100vh - 123px);
  border: 2px solid #e8e8e8;
  box-sizing: border-box;
  border-radius: 2px;
  padding: 0 5px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
}
.left-box {
  height: calc(100vh - 123px);
  border: 2px solid #e8e8e8;
  box-sizing: border-box;
  border-radius: 2px;
  padding: 0 5px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  margin-top: 5px;
}
.box {
  height: calc(100vh - 123px);
  border: 2px solid #e8e8e8;
  box-sizing: border-box;
  border-radius: 2px;
  padding: 0 5px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  margin-top: 42px;
}
.hiprintEpContainer {
  max-width: 200px;
}
:deep(.hiprint-printElement-type > li > ul > li > a) {
  padding: 4px 4px;
  color: white;
  background-color: #9c27b0;
  font-family: 'Roboto', sans-serif;
  font-weight: 500;
  line-height: normal;
  vertical-align: middle;
  justify-content: center;
  height: 30px;
  border-radius: 4px;
  border-style: none;
  text-overflow: ellipsis;
  font-size: 14px;
  box-shadow: 0 3px 1px -2px var(--v-shadow-key-umbra-opacity, rgba(0, 0, 0, 0.2)),
    0 2px 2px 0 var(--v-shadow-key-penumbra-opacity, rgba(0, 0, 0, 0.14)), 0 1px 5px 0 var(--v-shadow-key-penumbra-opacity, rgba(0, 0, 0, 0.12));
}
:deep(.hiprint-printElement-type > li > .title) {
  color: #000000de;
  font-family: 'Roboto', sans-serif;
  font-weight: 500;
}
// 最右边样式，确认按钮背景色
:deep(.hiprint-option-item-settingBtn) {
  background: #9c27b0;
}
// 最右边样式，删除按钮背景色
:deep(.hiprint-option-item-deleteBtn) {
  background: #8d9098;
}
// 默认图片
:deep(.hiprint-printElement-image-content) {
  img {
    content: url('~@/assets/logo.png');
  }
}

// 设计容器
.card-design {
  overflow: hidden;
  overflow-x: auto;
  overflow-y: auto;
}
</style>
@/index@/hiprint/index.js

<template>
  <v-dialog v-model="data.formVisible" fullscreen :scrim="false" transition="dialog-bottom-transition">
    <v-card>
      <div style="padding: 15px 15px">
        <v-row>
          <v-col cols="2">
            <div class="left-top-box">
              <v-select
                v-model="data.mode"
                :items="data.modeList"
                density="compact"
                hide-details
                clearable
                @update:model-value="method.handleChangeMode"
              ></v-select>
              <v-btn icon="mdi-plus" style="font-size: 14px; margin-left: 10px" size="small" @click="method.handleAddScheme"></v-btn>
            </div>

            <div class="left-box">
              <div id="hiprintEpContainer" class="rect-printElement-types hiprintEpContainer"> </div>
            </div>
          </v-col>
          <v-col cols="7">
            <div class="center-btn-box">
              <div>
                <v-btn
                  v-for="(value, type) in data.paperTypes"
                  :key="type"
                  :color="curPaperType === type ? 'indigo-darken-3' : 'white'"
                  @click="method.handleSetPaper(type, value)"
                >
                  {{ type }}
                </v-btn>
                <v-btn
                  icon="mdi-magnify-minus-outline"
                  style="font-size: 14px; margin-left: 10px"
                  size="small"
                  @click="method.handleChangeScale(false)"
                ></v-btn>
                <v-btn disabled size="small" style="margin-left: 10px; width: 70px">{{ scaleValueStr }}%</v-btn>
                <v-btn
                  icon="mdi-magnify-plus-outline"
                  style="font-size: 14px; margin-left: 10px"
                  size="small"
                  @click="method.handleChangeScale(true)"
                ></v-btn>
              </div>
              <div>
                <v-btn style="font-size: 14px; margin-left: 10px" @click="method.handlePreView()"> {{ $t('system.page.preView') }} </v-btn>
                <v-btn style="font-size: 14px; margin-left: 10px" :disabled="!data.mode" color="primary" @click="method.handleSubmit">
                  {{ $t('system.page.submit') }}
                </v-btn>
              </div>
            </div>

            <div class="center-box card-design">
              <div id="hiprint-printTemplate" style="margin-top: 20px" class="hiprint-printTemplate"></div>
            </div>
          </v-col>
          <v-col cols="3">
            <div class="right-top-box">
              <v-btn icon style="font-size: 14px; margin-left: 10px" size="small" @click="data.formVisible = false">
                <v-icon>mdi-close</v-icon>
              </v-btn>
            </div>

            <div class="right-box">
              <div id="PrintElementOptionSetting"></div>
            </div>
          </v-col>
        </v-row>
      </div>
    </v-card>
    <preViewDialog ref="preViewDialogRef" />
    <addSchemeDialog ref="addSchemeDialogRef" :mode-list="data.modeList" @addScheme="method.addScheme" />
  </v-dialog>
</template>
<script lang="ts" setup>
import { reactive, ref, computed, watch, nextTick } from 'vue'
import { hiprint } from 'yk-vue-plugin-hiprint'
import { hookComponent } from '@/components/system/index'
import { addPrintSolution, updatePrintSolution, listByPath } from '@/api/sys/printSolution'
import { PrintSolutionVO, PrintSolutionGetByPathVo } from '@/types/System/PrintSolution'
import i18n from '@/languages/i18n'
import preViewDialog from './preView.vue'
import addSchemeDialog from './add-scheme.vue'

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
  vuePath: string
  tabPage: string
}>()
const preViewDialogRef = ref()
const addSchemeDialogRef = ref()
const data = reactive({
  formVisible: false,
  hiprintTemplate: {} as any,
  mode: '',
  modeList: [] as string[],
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
  panel: {},
  printSolutionList: [] as PrintSolutionVO[]
})
const method = reactive({
  provider() {
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
    const userList = [] as any[]
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
  initProvier() {
    hiprint.init({
      providers: [method.provider()]
    })
    // $('.hiprintEpContainer').empty()
    const dom = document.getElementById('hiprintEpContainer')
    if (dom !== null) {
      dom.innerHTML = ''
    }
    hiprint.PrintElementTypeManager.build('.hiprintEpContainer', 'providerModule')
  },
  initTemplate() {
    // const provider = providers[0]
    // $('#hiprint-printTemplate').empty()
    const dom = document.getElementById('hiprint-printTemplate')
    if (dom !== null) {
      dom.innerHTML = ''
    }
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
  async init() {
    const form = {
      vue_path: props.vuePath,
      tab_page: props.tabPage
    } as PrintSolutionGetByPathVo
    const { data: res } = await listByPath(form)
    if (res.isSuccess) {
      data.printSolutionList = res.data
      data.modeList = data.printSolutionList.map((item) => item.solution_name)
    }
    if (!data.mode && data.modeList.length > 0) {
      data.mode = data.printSolutionList[0].solution_name
      method.handleSetPaper(data.printSolutionList[0].report_direction, {
        height: data.printSolutionList[0].report_length,
        width: data.printSolutionList[0].report_width
      })
    }
    method.handleChangeMode()
  },
  handleSetPaper(type: string, value: paperTypeData) {
    try {
      if (Object.keys(data.paperTypes).includes(type)) {
        data.curPaper = { type, width: value.width, height: value.height }
      } else {
        data.curPaper = { type: 'other', width: value.width, height: value.height }
      }
      data.hiprintTemplate.handleSetPaper(value.width, value.height)
    } catch (error) {
      // console.log(error)
    }
  },
  handleChangeScale(big: boolean) {
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
  handleChangeMode() {
    const option = data.printSolutionList.filter((item) => item.solution_name === data.mode)
    if (option.length > 0) {
      data.panel = JSON.parse(option[0].config_json)
    } else {
      data.panel = {}
    }
    method.initTemplate()
  },
  async handleSubmit() {
    if (data.hiprintTemplate) {
      const jsonOut = JSON.stringify(data.hiprintTemplate.getJson() || {})
      const form = {
        id: 0,
        vue_path: props.vuePath,
        tab_page: props.tabPage,
        solution_name: data.mode,
        config_json: jsonOut,
        report_length: data.curPaper.height,
        report_width: data.curPaper.width,
        report_direction: data.curPaper.type,
        tenant_id: 0
      } as PrintSolutionVO
      const option = data.printSolutionList.filter((item) => item.solution_name === data.mode)
      if (option.length > 0) {
        form.id = option[0].id
      }

      const { data: res } = form.id === 0 ? await addPrintSolution(form) : await updatePrintSolution(form)
      if (!res.isSuccess) {
        hookComponent.$message({
          type: 'error',
          content: res.errorMessage
        })
        return
      }
      method.init()
      hookComponent.$message({
        type: 'success',
        content: `${ i18n.global.t('system.page.submit') }${ i18n.global.t('system.tips.success') }`
      })
    }
  },
  handleAddScheme() {
    const ref = addSchemeDialogRef.value
    ref.data.formVisible = true
  },
  addScheme(scheme: string) {
    data.modeList.push(scheme)
    data.mode = scheme
    method.handleChangeMode()
  },

  handlePreView() {
    const ref = preViewDialogRef.value
    ref.data.width = data.curPaper.width
    ref.data.hiprintTemplate = data.hiprintTemplate
    ref.data.printData = props.form
    ref.method.show()
  }
})

watch(
  () => data.formVisible,
  (val) => {
    if (val) {
      nextTick(() => {
        method.initProvier()
        method.init()
      })
    }
  }
)
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
.center-btn-box {
  margin-bottom: 5px;
  display: flex;
  justify-content: space-between;
}
.center-box {
  height: calc(100vh - 83px);
  border: 2px solid #e8e8e8;
  box-sizing: border-box;
  border-radius: 2px;
  padding: 0 5px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
}
.left-top-box {
  display: flex;
  justify-content: space-between; /* 水平居中对齐 */
}
.left-box {
  height: calc(100vh - 83px);
  border: 2px solid #e8e8e8;
  box-sizing: border-box;
  border-radius: 2px;
  padding: 0 5px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  margin-top: 5px;
}
.right-top-box {
  display: flex;
  justify-content: flex-end;
}
.right-box {
  height: calc(100vh - 83px);
  border: 2px solid #e8e8e8;
  box-sizing: border-box;
  border-radius: 2px;
  padding: 0 5px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  margin-top: 5px;
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

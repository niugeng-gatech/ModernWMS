<template>
  <v-dialog v-model="data.formVisible" width="400px" transition="dialog-top-transition" :persistent="true">
    <template #default>
      <v-card>
        <v-toolbar color="white" :title="`${$t('system.hiprint.addScheme')}`"></v-toolbar>
        <v-card-text>
          <v-row>
            <v-col cols="12">
              <v-form ref="formRef">
                <v-text-field
                  v-model="data.form.scheme"
                  :rules="data.rules.scheme"
                  :label="$t('system.hiprint.schemeName')"
                  variant="outlined"
                  density="compact"
                  clearable
                  class="mb-4"
                ></v-text-field>
              </v-form>
            </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions class="justify-end">
          <v-btn variant="text" @click="method.closeDialog">{{ $t('system.page.close') }}</v-btn>
          <v-btn color="primary" variant="text" @click="method.submit">{{ $t('system.page.submit') }}</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script lang="ts" setup>
import { reactive, ref, watch } from 'vue'
import i18n from '@/languages/i18n'
import { StringLength } from '@/utils/dataVerification/formRule'
import { hookComponent } from '@/components/system/index'

const formRef = ref()
const emit = defineEmits(['addScheme'])

const props = defineProps<{
  modeList: Array<string>
}>()

const data = reactive({
  formVisible: false,
  form: {
    scheme: ''
  },
  rules: {
    scheme: [
      (val: string) => !!val || `${ i18n.global.t('system.checkText.mustInput') }${ i18n.global.t('system.hiprint.schemeName') }!`,
      (val: string) => StringLength(val, 0, 32) === '' || StringLength(val, 0, 32),
      (val: string) => validScheme(val) === ''
    ]
  }
})
function validScheme(val:string) {
  if (props.modeList.includes(val)) {
    return `${ i18n.global.t('system.hiprint.repeatScheme') }`
  }
  return ''
}
const method = reactive({
  closeDialog: () => {
    data.formVisible = false
  },
  submit: async () => {
    const { valid } = await formRef.value.validate()
    if (valid) {
      emit('addScheme', data.form.scheme)
      method.closeDialog()
    } else {
      hookComponent.$message({
        type: 'error',
        content: i18n.global.t('system.checkText.checkFormFail')
      })
    }
  }
})
watch(
  () => data.formVisible,
  (val) => {
    if (val) {
      data.form.scheme = ''
    }
  }
)
defineExpose({
  data
})
</script>

<style scoped lang="less"></style>

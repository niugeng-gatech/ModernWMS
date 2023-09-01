<template>
  <v-dialog v-model="data.showDialog" :width="'30%'" transition="dialog-top-transition" :persistent="true">
    <template #default>
      <v-card class="formCard">
        <v-toolbar color="white" :title="`${$t('base.roleMenu.modalTitle.editMenuAction')}`"></v-toolbar>
        <v-card-text>
          <v-form ref="formRef">
            <v-select
              v-model="data.actions"
              :items="currentActionList"
              :menu-props="{ maxHeight: 400 }"
              item-title="label"
              item-value="value"
              :label="$t('base.roleMenu.modalTitle.actionTitle')"
              variant="outlined"
              chips
              multiple
              clearable
            >
            </v-select>
          </v-form>
        </v-card-text>
        <v-card-actions class="justify-end">
          <v-btn variant="text" @click="method.closeDialog">{{ $t('system.page.close') }}</v-btn>
          <v-btn color="primary" variant="text" @click="method.saveSuccess">{{ $t('system.page.submit') }}</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script setup lang="tsx">
import { reactive, computed, defineExpose } from 'vue'
import { actionDict, getActionName } from './actionList'
import { RoleMenuDetailVo } from '@/types/Base/RoleMenu'

const emit = defineEmits(['close', 'saveSuccess'])

const props = defineProps<{
  row: RoleMenuDetailVo
}>()

const currentActionList = computed(() => {
  if (props.row.menu_name && Object.hasOwn(actionDict, props.row.menu_name)) {
    const result = actionDict[props.row.menu_name].map((item: string) => ({ label: getActionName(item, props.row.menu_name), value: item }))
    return result
  }
  return []
})

const data = reactive({
  actions: [] as string[],
  showDialog: false as boolean
})

const method = reactive({
  openDialog: (cache: string[]) => {
    data.actions = []

    data.actions = cache

    data.showDialog = true
  },
  closeDialog: () => {
    data.showDialog = false
  },
  saveSuccess: () => {
    emit('saveSuccess', data.actions)
  }
})

defineExpose({
  openDialog: method.openDialog,
  closeDialog: method.closeDialog
})
</script>

<style scoped lang="less"></style>

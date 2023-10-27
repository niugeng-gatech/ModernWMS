<template>
  <v-row no-gutters @keyup.enter="method.sureSearch">
    <v-col v-if="[1].includes(searchSetting.length)" cols="4"> </v-col>
    <v-col v-if="[1, 2].includes(searchSetting.length)" cols="4"> </v-col>
    <v-col v-for="(item, index) of searchSetting" :key="index" cols="4">
      <template v-if="item.type === 'string'">
        <v-text-field
          v-model="searchForm[item.name]"
          clearable
          hide-details
          density="comfortable"
          class="searchInput ml-5 mt-1"
          :label="$t(`${props.i18nPrefix}.${item.name}`)"
          variant="solo"
        >
        </v-text-field>
      </template>
      <template v-else-if="item.type === 'datetime'">
        <v-datetime-picker v-model="searchForm[item.name]" :label="$t(`${props.i18nPrefix}.${item.name}`)" />
      </template>
    </v-col>
  </v-row>

  <set-search
    ref="SetSearchRef"
    :i18n-key="props.i18nPrefix"
    :options="props.searchSetting"
    @success="
      () => {
        emit('refreshSetSearch')
      }
    "
  />
</template>

<script setup lang="tsx">
import { reactive, computed, ref } from 'vue'
import vDatetimePicker from '../form/v-datetime-picker.vue'
import searchSettingSet from '@/constant/searchSettingSet'
import SetSearch from '@/components/system/set-search.vue'

const SetSearchRef = ref()

const emit = defineEmits(['sureSearch', 'update:modelValue', 'refreshSetSearch'])

const props = defineProps<{
  modelValue: any
  searchSetting: any[]
  menuName: string
  i18nPrefix: string
}>()

const method = reactive({
  sureSearch: () => {
    emit('sureSearch')
  }
})

const searchForm = computed({
  get: () => props.modelValue,
  set: (val: any) => {
    emit('update:modelValue', val)
  }
})

const searchSetting = computed(() => {
  const result = searchSettingSet[props.menuName].filter((item: any) => props.searchSetting.includes(item.name))
  return result
})

defineExpose({
  openDialog: () => {
    SetSearchRef.value.openDialog(props.menuName)
  }
})
</script>

<style scoped lang="less"></style>

import XEUtils from 'xe-utils'
import { SearchObject, SearchOperator } from '@/types/System/Form'

export const setSearchObject = (searchForm: any, operator: number = SearchOperator.INCLUDE) => {
  const searchObjects: Array<SearchObject> = []
  try {
    for (const key in searchForm) {
      const str = key as string
      const searchValue = searchForm[str as keyof typeof searchForm]

      if (searchValue && searchValue.trim() !== '') {
        searchObjects.push({
          name: key,
          operator,
          text: searchValue,
          value: searchValue
        })
      }
    }
    return searchObjects
  } catch (error) {
    return searchObjects
  }
}

// 移除数组为null,''的属性
export const removeArrayNull = (array: any) => {
  for (const obj of array) {
    Object.keys(obj).forEach((item) => {
      if (XEUtils.isString(obj[item])) {
        obj[item] = obj[item].replace(/(^\s*)|(\s*$)/g, '')
      }
      if (obj[item] === '' || obj[item] === null) {
        delete obj[item]
      }
    })
  }
  return array
}
// 移除对象为null,''的属性
export const removeObjectNull = (obj: any) => {
  const copy = JSON.parse(JSON.stringify(obj))
  Object.keys(copy).forEach((item) => {
    if (XEUtils.isString(copy[item])) {
      copy[item] = copy[item].replace(/(^\s*)|(\s*$)/g, '')
    }
    if (copy[item] === '' || copy[item] == null) {
      delete copy[item]
    }
  })
  return copy
}

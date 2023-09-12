import http from '@/utils/http/request'
import { PrintSolutionVO, PrintSolutionGetByPathVo } from '@/types/System/PrintSolution'
// Get user menu dynamically
export const addPrintSolution = (data: PrintSolutionVO) => http({
  url: '/PrintSolution',
  method: 'post',
  data
})
export const updatePrintSolution = (data: PrintSolutionVO) => http({
  url: '/PrintSolution',
  method: 'put',
  data
})
export const listByPath = (data: PrintSolutionGetByPathVo) => http({
  url: '/PrintSolution/get-by-path',
  method: 'post',
  data
})
export interface PrintSolutionVO {
  id: number
  vue_path: string
  tab_page: string
  solution_name: string
  config_json: string
  report_length: number
  report_width: number
  report_direction: string
}
export interface PrintSolutionGetByPathVo {
  vue_path: string
  tab_page: string
}
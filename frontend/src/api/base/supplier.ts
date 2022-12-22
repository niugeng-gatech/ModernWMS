import http from '@/utils/http/request'
import { PageConfigProps } from '@/types/System/Form'
import { SupplierVO } from '@/types/Base/Supplier'

// Get all
export const getSupplierAll = () => http({
    url: '/supplier/all',
    method: 'get'
  })

// Find Data by Pagination
export const getUserList = (data: PageConfigProps) => http({
    url: '/user/list',
    method: 'post',
    data
  })

// Add a new form
export const addSupplier = (data: SupplierVO) => http({
    url: '/supplier',
    method: 'post',
    data
  })

// Update form
export const updateSupplier = (data: SupplierVO) => http({
    url: '/supplier',
    method: 'put',
    data
  })

// Delete form
export const deleteSupplier = (id: number) => http({
    url: '/supplier',
    method: 'delete',
    params: {
      id
    }
  })

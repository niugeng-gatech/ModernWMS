export default {
  system: {
    hookComponent: {
      dialog: {
        defaultClose: '关闭',
        defaultConfirm: '确认',
        defaultTitle: '提示'
      }
    },
    page: {
      add: '新增',
      update: '修改',
      refresh: '刷新',
      export: '导出',
      operate: '操作',
      edit: '编辑',
      delete: '删除',
      close: '关闭',
      submit: '提交'
    },
    tips: {
      success: '成功!',
      fail: '失败!',
      beforeDeleteMessage: '您确定要删除此条数据吗?'
    },
    checkText: {
      checkFormFail: '操作失败, 请检查数据后重试!',
      mustInput: '请填写'
    },
    homeHeader: {
      logout: '注销'
    },
    combobox: {
      sex: {
        male: '男',
        female: '女'
      }
    }
  },
  router: {
    sideBar: {
      homepage: '首页',
      baseModule: '基础设置',
      ownerOfCargo: '货主信息',
      menuBasicSettings: '菜单基础设置',
      userManagement: '用户管理',
      commodityCategorySetting: '商品类别设置',
      commodityManagement: '商品管理',
      userRoleSetting: '用户角色设置',
      companySetting: '公司信息',
      freightSetting: '运费设置'
    }
  },
  login: {
    welcomeTitle: '欢迎来到ModernWMS!👋🏻',
    mainButtonLabel: '登录',
    rememberTips: '记住账号密码',
    userName: '用户名',
    password: '密码',
    loginSuccess: '登录成功'
  },
  base: {
    freightSetting: {
      transportationSupplier: '承运商',
      sendCity: '始发城市',
      receiverCity: '到货城市',
      weightFee: '单公斤运费',
      volumeFee: '单立方米运费',
      minPayment: '最小运费',
    },
    userManagement: {
      user_num: '员工编号',
      user_name: '员工名称',
      user_role: '角色',
      contact_tel: '联系方式',
      sex: '性别',
      is_valid: '是否有效',
      restPwd: '重置密码',
      checkboxIsNull: '请选中数据!',
      beforeResetPwd: '您确定要重置这些用户的密码吗?',
      afterResetPwd: '重置密码成功!'
    }
  }
}

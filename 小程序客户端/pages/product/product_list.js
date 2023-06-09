var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    queryViewHidden: true, //是否隐藏查询条件界面
    productClassObj_Index:"0", //套餐类别查询条件
    productClasss: [{"classId":0,"className":"不限制"}],
    productName: "", //服务名称查询关键字
    printShopObj_Index:"0", //打印店查询条件
    printShops: [{"shopUserName":"","shopName":"不限制"}],
    addTime: "", //发布时间查询关键字
    products: [], //界面显示的打印服务列表数据
    page_size: 8, //每页显示几条数据
    page: 1,  //当前要显示第几页
    totalPage: null, //总的页码数
    loading_hide: true, //是否隐藏加载动画
    nodata_hide: true, //是否隐藏没有数据记录提示
  },

  // 加载打印服务列表
  listProduct: function () {
    var self = this
    var url = config.basePath + "api/product/list"
    //如果要显示的页码超过总页码不操作
    if(self.data.totalPage != null && self.data.page > self.data.totalPage) return
    self.setData({
      loading_hide: false,  //显示加载动画
    })
    //提交查询参数到服务器查询数据列表
    utils.sendRequest(url, {
      "productClassObj.classId": self.data.productClasss[self.data.productClassObj_Index].classId,
      "productName": self.data.productName,
      "printShopObj.shopUserName": self.data.printShops[self.data.printShopObj_Index].shopUserName,
      "addTime": self.data.addTime,
      "page": self.data.page,
      "rows": self.data.page_size,
    }, function (res) { 
      wx.stopPullDownRefresh()
      setTimeout(function () {  
        self.setData({
          products: self.data.products.concat(res.data.list),
          totalPage: res.data.totalPage,
          loading_hide: true
        })
      }, 500)
      //如果当前显示的是最后一页，则显示没数据提示
      if(self.data.page == self.data.totalPage) {
        self.setData({
          nodata_hide: false,
        })
      }
    })
  },

  //显示或隐藏查询视图切换
  toggleQueryViewHide: function () {
    this.setData({
      queryViewHidden: !this.data.queryViewHidden,
    })
  },

  //点击查询按钮的事件
  queryProduct: function(e) {
    var self = this
    self.setData({
      page: 1,
      totalPage: null,
      products: [],
      loading_hide: true, //隐藏加载动画
      nodata_hide: true, //隐藏没有数据记录提示 
      queryViewHidden: true, //隐藏查询视图
    })
    self.listProduct()
  },

  //查询参数发布时间选择事件
  bind_addTime_change: function (e) {
    this.setData({
      addTime: e.detail.value
    })
  },
  //清空查询参数发布时间
  clear_addTime: function (e) {
    this.setData({
      addTime: "",
    })
  },

  //绑定查询参数输入事件
  searchValueInput: function (e) {
    var id = e.target.dataset.id
    if (id == "productName") {
      this.setData({
        "productName": e.detail.value,
      })
    }

  },

  //查询参数套餐类别选择事件
  bind_productClassObj_change: function(e) {
    this.setData({
      productClassObj_Index: e.detail.value
    })
  },

  //查询参数打印店选择事件
  bind_printShopObj_change: function(e) {
    this.setData({
      printShopObj_Index: e.detail.value
    })
  },

  init_query_params: function() { 
    var self = this
    var url = null
    //初始化套餐类别下拉框
    url = config.basePath + "api/productClass/listAll"
    utils.sendRequest(url,null,function(res){
      wx.stopPullDownRefresh();
      self.setData({
        productClasss: self.data.productClasss.concat(res.data),
      })
    })
    //初始化打印店下拉框
    url = config.basePath + "api/printShop/listAll"
    utils.sendRequest(url,null,function(res){
      wx.stopPullDownRefresh();
      self.setData({
        printShops: self.data.printShops.concat(res.data),
      })
    })
  },

  //删除打印服务记录
  removeProduct: function (e) {
    var self = this
    var productId = e.currentTarget.dataset.productid
    wx.showModal({
      title: '提示',
      content: '确定要删除productId=' + productId + '的记录吗？',
      success: function (sm) {
        if (sm.confirm) {
          // 用户点击了确定 可以调用删除方法了
          var url = config.basePath + "api/product/delete/" + productId
          utils.sendRequest(url, null, function (res) {
            wx.stopPullDownRefresh();
            wx.showToast({
              title: '删除成功',
              icon: 'success',
              duration: 500
            })
            //删除打印服务后客户端同步删除数据
            var products = self.data.products;
            for (var i = 0; i < products.length; i++) {
              if (products[i].productId == productId) {
                products.splice(i, 1)
                break
              }
            }
            self.setData({ products: products })
          })
        } else if (sm.cancel) {
          console.log('用户点击取消')
        }
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.listProduct()
    this.init_query_params()
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    var self = this
    self.setData({
      page: 1,  //显示最新的第1页结果
      products: [], //清空打印服务数据
      nodata_hide: true, //隐藏没数据提示
    })
    self.listProduct()
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    var self = this
    if (self.data.page < self.data.totalPage) {
      self.setData({
        page: self.data.page + 1, 
      })
      self.listProduct()
    }
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }

})


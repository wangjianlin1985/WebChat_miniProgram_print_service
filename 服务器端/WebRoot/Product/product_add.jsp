<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
<div id="productAddDiv">
	<form id="productAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">套餐类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productClassObj_classId" name="product.productClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">服务名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productName" name="product.productName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">服务图片:</span>
			<span class="inputControl">
				<input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">套餐价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_price" name="product.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">服务描述:</span>
			<span class="inputControl">
				<textarea id="product_productDesc" name="product.productDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">打印店:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_printShopObj_shopUserName" name="product.printShopObj.shopUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_addTime" name="product.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="productAddButton" class="easyui-linkbutton">添加</a>
			<a id="productClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Product/js/product_add.js"></script> 

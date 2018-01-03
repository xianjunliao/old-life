<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="cc" class="easyui-layout" style="width: 100%; height: 100%; border: none;">
		<div data-options="region:'center',border:false">
			<form id="treeLevelForm" method="post">
			<input type="hidden" name="level" value="${level}" />
				<table cellpadding="5" style="width: 99%;">
					<tr>
						<td align="right"><span>菜单名称:</span></td>
						<td><input class="easyui-textbox" style="width: 100%;" type="text" name="text" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td align="right">菜单icon:</td>
						<td><select class="easyui-combobox" name="iconCls" style="width: 100%;" data-options="required:true">
								<option value=""></option>
								<option value="tree-life">tree-life</option>
								<option value="tree-life2">tree-life2</option>
								<option value="tree-life3">tree-life3</option>
								<option value="tree-listen">tree-listen</option>
								<option value="xiaomai">xiaomai</option>
								<option value="tree-tv">tree-tv</option>
						</select></td>
					</tr>
					<tr>
						<td align="right">菜单url:</td>
						<td><input class="easyui-textbox" style="width: 100%;" type="text" name="url" <c:if test="${level!='1'}">data-options="required:true"</c:if>></input></td>
					</tr>
					<tr>
						<td align="right">打开方式:</td>
						<td><select class="easyui-combobox" name="readMode" style="width: 100%;" <c:if test="${level!='1'}">data-options="required:true"</c:if>>
								<option value=""></option>
								<option value="web">网页</option>
								<option value="rss">rss</option>
						</select></td>
					</tr>

					<tr>
						<td align="right">上级菜单:</td>
						<td><select class="easyui-combobox" name="pid" style="width: 100%;" <c:if test="${level!='1'}">data-options="required:true"</c:if>>
								<option value=""></option>
								<c:forEach items="${trees}" var="tree">
									<option <c:if test="${id==tree.id}">selected="selected"</c:if> value="${tree.id}">${tree.text}</option>
								</c:forEach>
						</select></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#treeLevelForm').form({
				url : '${base}tree/save',
				onSubmit : function() {
					progressLoad();
					var isValid = $(this).form('enableValidation').form('validate');
					if (!isValid) {
						progressClose();
					}
					return isValid;
				},
				success : function(result) {
					progressClose();
					result = $.parseJSON(result);
					if (result.code == '200') {
						$('#dialog').dialog('close');
						$.messager.alert('提示', result.message, 'info');
					} else {
						$.messager.alert("提示", result.message, "warning");
					}
				}
			});
		});
	</script>
</body>
</html>
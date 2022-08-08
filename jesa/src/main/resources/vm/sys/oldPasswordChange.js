Ext.require([
    'Ext.ux.window.Notification',
    'Ext.form.*'
]);
Ext.onReady(function() {
	var userId = '$!{userId}';
	var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>'; 
	var changeWin = Ext.create('Ext.window.Window', {
		layout: 'fit',
		modal: true, // 遮罩
		draggable: false, // 拖动
		closable: false, // 关闭
		resizable: false, // 大小
		border: false,
		title: '密码变更',
		width: 400,
		height: 150,
		items: {
			layout: 'form',
			xtype: 'form',
			frame: true,
			border: false,
			items: [{
				xtype: 'hiddenfield',
				name: 'userId',
				value: userId
			}, {
				xtype: 'textfield',
				fieldLabel: '新密码',
				labelWidth: 50,
				labelAlign: 'right',
				name: 'newPassword',
				allowBlank: false
			}, {
				xtype: 'displayfield',
				value: required + ' 系统迁移用户首次登录新系统需修改密码'
			}]
		},
		buttons: [{
			text: '提交',
			iconCls: 'save-icon',
			handler: function() {
				var params = {};
				var changeForm = changeWin.down('form').getForm();
				if (changeForm.isValid()) {
					changeForm.submit({
						url: 'doOldPasswordChange.ajax',
						success: function(form, action) {
							// jesAlert(action.result.msg);
							jesAlert('修改密码成功，3 秒后跳转到登录页面...');
							changeWin.close();
							setTimeout(function() {
								window.location.href = 'login.html';
							}, 3000);
						},
						failure: function(form, action) {
							switch (action.failureType) {
								case Ext.form.action.Action.CLIENT_INVALID:
									jesAlert('${message("owl.vm.owl.owlFtp.tjdzwx")}'); // 提交的表单的字段值无效
									break;
								case Ext.form.action.Action.CONNECT_FAILURE:
									jesAlert('${message("owl.vm.owl.owlFtp.ljfwqsb")}'); // 连接服务器失败
									break;
								case Ext.form.action.Action.SERVER_INVALID:
									jesAlert(action.result.msg);
							}
						}
					});
				}
			}
		}]
	}).show();
});
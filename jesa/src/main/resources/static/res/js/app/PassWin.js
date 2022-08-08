Ext.define('Sys.app.PassWin', {
    extend: 'Ext.window.Window',
    width: 300,
    height:150,
    modal : true,
    resizable : false,
    title:'修改密码',
    constructor:function(vp){
    	this.vp=vp;
    	Sys.app.PassWin.superclass.constructor.call(this);
    },
    listeners:{
    	close:function(){
    		if(this.vp){
    			this.vp.unmask();
    		}
    	},
    	show:function(){
    		var me=this;
    		me.getComponent('password').focus();
    	}
    },
	buttons: [
	      {
			text: '提交',
			inputType:'submit',
			handler:function(){
				var myWin=this.up('window');
				if(!myWin.down('field[name=password]').getValue()){
					Ext.Msg.alert('提示',"请输入原密码!");
					return;
				}
				if(!myWin.down('field[name=newPwd1]').getValue()){
					Ext.Msg.alert('提示',"请输入新密码!");
					return;
				}
				if(!myWin.down('field[name=newPwd2]').getValue()){
					Ext.Msg.alert('提示',"请重复输入密码!");
					return;
				}
				if(myWin.down('field[name=newPwd1]').getValue()!=myWin.down('field[name=newPwd2]').getValue()){
					Ext.Msg.alert('提示',"新设置的密码输入不一致!");
					return;
				}
				
				Ext.Ajax.request({
				    url: 'changePwd.do',
				    params: {
				    	oldPwd:myWin.down('field[name=password]').getValue(),
				        newPwd:myWin.down('field[name=newPwd1]').getValue()
				    },
				    success: function(response){
				    	var text = Ext.decode(response.responseText);
		                if(text.success == true){
		                    jesAlert(text.msg);
		                    myWin.close();
				    		if(myWin.vp){
				    			myWin.vp.unmask();
				    		}
		                }else{
		                    var msg = text.msg;
		                    Ext.Msg.alert('提示',msg);
		                }
				    }
				});
			}
		  }
    ],
    defaults: {
        padding: '5 5 0 5',
        labelAlign: 'right',
        labelWidth: 80
    },
	items: [
	  {
		  xtype    : 'textfield',
		  inputType: 'password',
          name     : 'password',
          itemId:'password',
          fieldLabel:'原密码'
	  } ,
	  {
		  xtype    : 'textfield',
		  inputType: 'password',
          name     : 'newPwd1',
          fieldLabel:'新密码'
	  },
	  {
		  xtype    : 'textfield',
		  inputType: 'password',
          name     : 'newPwd2',
          fieldLabel:'确认密码'
	  }
    ]
});


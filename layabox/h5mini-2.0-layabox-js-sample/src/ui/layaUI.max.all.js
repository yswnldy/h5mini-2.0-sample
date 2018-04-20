var CLASS$=Laya.class;
var STATICATTR$=Laya.static;
var View=laya.ui.View;
var Dialog=laya.ui.Dialog;
var TestPageUI=(function(_super){
		function TestPageUI(){
			
		    this.submitScore=null;
		    this.getRank=null;
		    this.playAd=null;

			TestPageUI.__super.call(this);
		}

		CLASS$(TestPageUI,'ui.test.TestPageUI',_super);
		var __proto__=TestPageUI.prototype;
		__proto__.createChildren=function(){
		    
			laya.ui.Component.prototype.createChildren.call(this);
			this.createView(TestPageUI.uiView);

		}

		TestPageUI.uiView={"type":"View","props":{"width":600,"height":400},"child":[{"type":"Image","props":{"y":0,"x":0,"width":600,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","height":400}},{"type":"Button","props":{"y":4,"x":563,"skin":"comp/btn_close.png","name":"close"}},{"type":"Button","props":{"y":158,"x":228,"width":150,"var":"submitScore","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"提交分数","height":37}},{"type":"Button","props":{"y":221,"x":228,"width":150,"var":"getRank","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"获得排行榜","height":37}},{"type":"Button","props":{"y":285,"x":228,"width":150,"var":"playAd","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"播放广告","height":37}}]};
		return TestPageUI;
	})(View);
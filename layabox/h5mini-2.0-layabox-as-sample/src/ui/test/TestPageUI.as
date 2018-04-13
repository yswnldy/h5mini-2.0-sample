/**Created by the LayaAirIDE,do not modify.*/
package ui.test {
	import laya.ui.*;
	import laya.display.*; 

	public class TestPageUI extends View {
		public var moreGame:Button;
		public var submitScore:Button;
		public var getRank:Button;
		public var playAd:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"width":600,"height":400},"child":[{"type":"Image","props":{"y":0,"x":0,"width":600,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","height":400}},{"type":"Button","props":{"y":84,"x":237,"width":150,"var":"moreGame","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"更多游戏","height":37}},{"type":"Button","props":{"y":4,"x":563,"skin":"comp/btn_close.png","name":"close"}},{"type":"Button","props":{"y":147,"x":237,"width":150,"var":"submitScore","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"提交积分","height":37}},{"type":"Button","props":{"y":209,"x":237,"width":150,"var":"getRank","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"获取排行榜","height":37}},{"type":"Button","props":{"y":272,"x":237,"width":150,"var":"playAd","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"播放广告","height":37}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}
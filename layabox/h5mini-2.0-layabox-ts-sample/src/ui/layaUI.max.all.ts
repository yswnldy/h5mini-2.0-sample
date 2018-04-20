
import View=laya.ui.View;
import Dialog=laya.ui.Dialog;
module ui.test {
    export class TestPageUI extends View {
		public submitScore:Laya.Button;
		public getRank:Laya.Button;
		public playAd:Laya.Button;

        public static  uiView:any ={"type":"View","props":{"width":600,"height":400},"child":[{"type":"Image","props":{"y":0,"x":0,"width":600,"skin":"comp/bg.png","sizeGrid":"30,4,4,4","height":400}},{"type":"Button","props":{"y":4,"x":563,"skin":"comp/btn_close.png","name":"close"}},{"type":"Button","props":{"y":158,"x":224,"width":150,"var":"submitScore","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"提交积分","height":37}},{"type":"Button","props":{"y":228,"x":224,"width":150,"var":"getRank","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"获得排行榜","height":37}},{"type":"Button","props":{"y":298,"x":224,"width":150,"var":"playAd","skin":"comp/button.png","sizeGrid":"4,4,4,4","label":"播放广告","height":37}}]};
        constructor(){ super()}
        createChildren():void {
        
            super.createChildren();
            this.createView(ui.test.TestPageUI.uiView);

        }

    }
}

var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var View = laya.ui.View;
var Dialog = laya.ui.Dialog;
var ui;
(function (ui) {
    var test;
    (function (test) {
        var TestPageUI = /** @class */ (function (_super) {
            __extends(TestPageUI, _super);
            function TestPageUI() {
                return _super.call(this) || this;
            }
            TestPageUI.prototype.createChildren = function () {
                _super.prototype.createChildren.call(this);
                this.createView(ui.test.TestPageUI.uiView);
            };
            TestPageUI.uiView = { "type": "View", "props": { "width": 600, "height": 400 }, "child": [{ "type": "Image", "props": { "y": 0, "x": 0, "width": 600, "skin": "comp/bg.png", "sizeGrid": "30,4,4,4", "height": 400 } }, { "type": "Button", "props": { "y": 88, "x": 224, "width": 150, "var": "moreGame", "skin": "comp/button.png", "sizeGrid": "4,4,4,4", "label": "跳转更多游戏", "height": 37 } }, { "type": "Button", "props": { "y": 4, "x": 563, "skin": "comp/btn_close.png", "name": "close" } }, { "type": "Button", "props": { "y": 158, "x": 224, "width": 150, "var": "submitScore", "skin": "comp/button.png", "sizeGrid": "4,4,4,4", "label": "提交积分", "height": 37 } }, { "type": "Button", "props": { "y": 228, "x": 224, "width": 150, "var": "getRank", "skin": "comp/button.png", "sizeGrid": "4,4,4,4", "label": "获得排行榜", "height": 37 } }, { "type": "Button", "props": { "y": 298, "x": 224, "width": 150, "var": "playAd", "skin": "comp/button.png", "sizeGrid": "4,4,4,4", "label": "播放广告", "height": 37 } }] };
            return TestPageUI;
        }(View));
        test.TestPageUI = TestPageUI;
    })(test = ui.test || (ui.test = {}));
})(ui || (ui = {}));
//# sourceMappingURL=layaUI.max.all.js.map
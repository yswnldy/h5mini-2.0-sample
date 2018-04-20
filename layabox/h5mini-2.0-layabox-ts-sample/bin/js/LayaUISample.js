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
var test = ui.test.TestPageUI;
var Label = Laya.Label;
var Handler = Laya.Handler;
var Loader = Laya.Loader;
var TestUI = /** @class */ (function (_super) {
    __extends(TestUI, _super);
    function TestUI() {
        var _this = _super.call(this) || this;
        //-----------------H5API使用案例---------------------
        //提交分数
        _this.submitScore.on(Laya.Event.CLICK, _this, _this.onSubmitScore);
        //获得排行榜
        _this.getRank.on(Laya.Event.CLICK, _this, _this.onGetRank);
        //播放广告
        _this.playAd.on(Laya.Event.CLICK, _this, _this.onPlayAd);
        return _this;
    }
    //提交分数
    TestUI.prototype.onSubmitScore = function () {
        Laya.Browser.window.h5api.submitScore(100, function (data) {
            Laya.Browser.window.console.log("提交结果", data);
        });
    };
    //获得排行榜
    TestUI.prototype.onGetRank = function () {
        Laya.Browser.window.h5api.getRank(function (data) {
            Laya.Browser.window.console.log("获得排行榜", data);
        });
    };
    //播放广告
    TestUI.prototype.onPlayAd = function () {
        if (Laya.Browser.window.h5api.canPlayAd()) {
            Laya.Browser.window.h5api.playAd();
        }
        else {
            Laya.Browser.window.console.log("没有广告资源可播放");
        }
    };
    return TestUI;
}(ui.test.TestPageUI));
//程序入口
Laya.init(600, 400);
//激活资源版本控制
Laya.ResourceVersion.enable("version.json", Handler.create(null, beginLoad), Laya.ResourceVersion.FILENAME_VERSION);
function beginLoad() {
    Laya.loader.load("res/atlas/comp.atlas", Handler.create(null, onLoaded));
}
function onLoaded() {
    //实例UI界面
    var testUI = new TestUI();
    Laya.stage.addChild(testUI);
}
//# sourceMappingURL=LayaUISample.js.map
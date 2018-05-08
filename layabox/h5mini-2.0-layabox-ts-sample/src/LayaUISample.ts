import test = ui.test.TestPageUI;
import Label = Laya.Label;
import Handler = Laya.Handler;
import Loader = Laya.Loader;

class TestUI extends ui.test.TestPageUI {

	constructor() {
		super();
		//-----------------H5API使用案例---------------------
		//提交分数
		this.submitScore.on(Laya.Event.CLICK, this, this.onSubmitScore);
		//获得排行榜
		this.getRank.on(Laya.Event.CLICK, this, this.onGetRank);
		//播放广告
		this.playAd.on(Laya.Event.CLICK, this, this.onPlayAd);
	}
	//提交分数
	private onSubmitScore(): void {
		Laya.Browser.window.h5api.submitScore(100, function (data): void {
			Laya.Browser.window.console.log("提交结果", data);
		});
	}
	//获得排行榜
	private onGetRank(): void {
		Laya.Browser.window.h5api.getRank(function (data: Object): void {
			Laya.Browser.window.console.log("获得排行榜", data);
		});
	}
	//播放广告
	private onPlayAd(): void {
		if (Laya.Browser.window.h5api.canPlayAd()) {
			Laya.Browser.window.h5api.playAd(function (data: Object): void {
				Laya.Browser.window.console.log("广告状态", data);
			});
		}
		else {
			Laya.Browser.window.console.log("没有广告资源可播放");
		}
	}
}

//程序入口
Laya.init(600, 400);
//激活资源版本控制
Laya.ResourceVersion.enable("version.json", Handler.create(null, beginLoad), Laya.ResourceVersion.FILENAME_VERSION);

function beginLoad() {
	Laya.loader.load("res/atlas/comp.atlas", Handler.create(null, onLoaded));
}

function onLoaded(): void {
	//实例UI界面
	var testUI: TestUI = new TestUI();
	Laya.stage.addChild(testUI);
}
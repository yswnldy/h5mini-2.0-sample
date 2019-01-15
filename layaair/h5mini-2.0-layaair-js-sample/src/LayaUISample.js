var Loader = laya.net.Loader;
var Handler = laya.utils.Handler;


// 创建TestPageUI的子类
function TestUI() {
	var Event = laya.events.Event;
	TestUI.super(this);

	//-----------------H5API使用案例---------------------
	//提交分数
	this.submitScore.on(Event.CLICK, this, onSubmitScore);
	//获得排行榜
	this.getRank.on(Event.CLICK, this, onGetRank);
	//播放广告
	this.playAd.on(Event.CLICK, this, onPlayAd);
	//提交分数
	function onSubmitScore() {
		window.h5api.submitScore(100, function (data) {
			console.log('提交结果', data);
		});
	}
	//获得排行榜
	function onGetRank() {
		window.h5api.getRank(function (data) {
			console.log('获得排行榜', data);
		});
	}
	//播放广告
	function onPlayAd() {
		if (window.h5api.canPlayAd()) {
			window.h5api.playAd(function (data) {
				console.log('广告状态', data);
			});
		} else {
			console.log("没有广告资源可播放");
		}
	}
}
Laya.class(TestUI, "TestUI", TestPageUI);

//程序入口
Laya.init(600, 400);
//激活资源版本控制
Laya.ResourceVersion.enable("version.json", Handler.create(null, beginLoad), Laya.ResourceVersion.FILENAME_VERSION);

function beginLoad() {
	Laya.loader.load("res/atlas/comp.atlas", Handler.create(null, onLoaded));
}

function onLoaded() {
	Laya.stage.addChild(new TestUI());
}
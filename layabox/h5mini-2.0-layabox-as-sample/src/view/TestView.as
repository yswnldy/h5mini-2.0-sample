package view
{
	import laya.events.Event;
	import laya.ui.Box;
	import laya.ui.Label;
	import laya.utils.Browser;

	import ui.test.TestPageUI;
	
	public class TestView extends TestPageUI
	{
		
		public function TestView()
		{
			//-----------------H5API使用案例---------------------
			//提交分数
			submitScore.on(Event.CLICK, this, onSubmitScore);
			//获得排行榜
			getRank.on(Event.CLICK, this, onGetRank);
			//播放广告
			playAd.on(Event.CLICK, this, onPlayAd);
		}
		
		//提交分数
		private function onSubmitScore(event:Event):void
		{
			Browser.window.h5api.submitScore(100, function(data:Object):void
				{
					Browser.window.console.log("提交结果", data);
				});
		}
		
		//获得排行榜
		private function onGetRank(event:Event):void
		{
			Browser.window.h5api.getRank(function(data:Object):void
				{
					Browser.window.console.log("获得排行榜", data);
				});
		}
		
		//播放广告
		private function onPlayAd(event:Event):void
		{
			if (Browser.window.h5api.canPlayAd())
			{
				Browser.window.h5api.playAd(function(data:Object):void
				{
					Browser.window.console.log("广告状态", data);
				});
			}
			else
			{
				Browser.window.console.log("没有广告资源可播放");
			}
		}
	}
}
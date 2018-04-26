# h5mini-2.0-sample

## 4399原创平台H5小游戏API案例

> 开放Egret、Cocos2dx、Layabox、Construct2等引擎的API使用案例及对应的工具库插件等。
> 
> 原创H5API默认为JS，各个案例及插件只是打通JS与引擎的交互。
> 
> 具体使用情况请参考各引擎针对JS第三方库的使用文档。
> 
## 发布说明

[CHANGELOG.md](CHANGELOG.md)

## 目录结构描述

    |--cocos2dx                                   //Cocos2dx案例
    |--construct2                                 //Construct2案例
    |--egret                                      //Egret案例
    |--layabox                                    //Layabox案例
    |--CHANGELOG.md                               //版本更新说明
    |--README.md                                  //项目说明

## H5API使用及函数说明

### 添加H5API的地址

> 打开你游戏项目的 `index.html`， 将H5API的地址 `http://h.api.4399.com/h5mini-2.0/h5api.php` 加入到 `<head></head>` 标签内。
> 
    <script src="http://h.api.4399.com/h5mini-2.0/h5api.php"></script> 
> 
> 如下图

![H5API地址](https://i.imgur.com/303Y654.png)

##### - 提交积分

> 调用此接口后，将会尝试匿名提交玩家分数到排行榜中，并将尝试提交接口返回给回调函数。
 
	window.h5api.submitScore({游戏分数}, function(data) {
            console.log('提交结果', data);
        });

> 返回结果为json数据，格式如下：

	{
	　　"code":10000,                      //提交分数是否成功，10000为成功，否则都为失败
	　　"message":"submit_successful.",    //消息
	　　"data":{
	　　　　"rank":17,                     //提交后排行榜玩家排名
	　　　　"score":43                     //玩家分数
	　　}
	}

##### - 获得排行榜

> 调用此接口后，将会尝试获取排行榜数据，并将排行榜数据返回给回调函数。
 
	window.h5api.getRank(function(data) {
            console.log('获得排行榜', data);
        });

> 返回结果为json数据，格式如下：

	{
	　　"code":10000,                      //获取排行榜是否成功，10000为成功，否则都为失败
	　　"message":"get_rank_successful.",  //消息
	　　"data":[
	　　　　{
	　　　　　　"score":"671",              //排行榜玩家分数
	　　　　　　"rank":1                    //排行榜玩家排名
	　　　　},
	　　　　{
	　　　　　　"score":"581",
	　　　　　　"rank":2
	　　　　},
	　　　　{
	　　　　　　"score":"459",
	　　　　　　"rank":3
	　　　　},
	　　　　...                             //最多只有前50条排行榜数据，开发者根据需要选择展示条数
	　　]
	}

##### - 是否可播放广告

> 此接口返回当前是否还有广告资源可播放，开发者应根据此接口确定是否需要展示播放广告的按钮及相关游戏流程。
 
	window.h5api.canPlayAd();

##### - 播放广告

> 调用此接口后，将全屏展现激励广告。
 
	window.h5api.playAd();


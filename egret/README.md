# 白鹭引擎游戏API使用说明

当前案例使用的是白鹭引擎是5.1.9beta版本，使用的Egret Wing 3 4.1.5版本进行开发。

API库以白鹭引擎第三方库方式引入项目并使用。配置方式以白鹭官方文档引入方式为准。

## API添加步骤

### 1. 初始化API库

> 进入当前文件夹下的 `egret_4399_h5api` 文件夹，使用命令行 `egret build` 生成API库文件，生成后会在 `egret_4399_h5api\bin\egret_4399_h5api` 文件夹下生成 `egret_4399_h5api.d.ts` 、`egret_4399_h5api.js` 、`egret_4399_h5api.min.js` 3个文件。
> 
> 此步骤根据项目按需进行。如已初始化生成或非必须，开发者可不必进行当前步骤。

##### 目录结构描述

	|--egret                                  //Egret案例
	   |--egret_4399_h5api                       //4399API库
          |--bin                                    //打包生成文件夹
             |--egret_4399_h5api                       //库文件夹
                |--egret_4399_h5api.d.ts                  //TS接口文件
                |--egret_4399_h5api.js                    //JS接口文件
                |--egret_4399_h5api.min.js                //JS压缩源码

### 2. 项目引入

> 复制 `egret_4399_h5api\bin\egret_4399_h5api` 文件夹，放置到 `{你的游戏项目地址}\libs` 文件夹下。并在 `{你的游戏项目地址}\egretProperties.json` 白鹭项目配置文件中增加4399API模块配置： `{"name": "egret_4399_h5api", "path": "../egret_4399_h5api"}` 。

> 如果开发者熟悉第三方库引入规范，可将4399API库放置到其他复用文件夹中，以供开发者其他游戏使用，只需配置好4399API模块配置中的 `path` 地址为复用文件夹即可。

##### 目录结构描述

    |--{你的游戏项目地址}                        //在本示例中，即为 h5mini-2.0-egret-sample 文件夹
       |--libs                                    //库文件夹
          |--egret_4399_h5api                       //4399API库（被复制过来）
             |--egret_4399_h5api.d.ts                  //TS接口文件
             |--egret_4399_h5api.js                    //JS接口文件
             |--egret_4399_h5api.min.js                //JS压缩源码
          |--modules                                //模块文件夹
       |--egretProperties.json                    //白鹭项目配置文件（需要添加模块配置）

##### 添加后的白鹭项目配置示例

	{
	    "engineVersion": "5.1.9",
	    "compilerVersion": "5.1.9",
	    "template": {},
	    "target": {
	        "current": "web"
	    },
	    "modules": [{
	            "name": "egret"
	        },
	        {
	            "name": "game"
	        },
	        {
	            "name": "tween"
	        },
	        {
	            "name": "assetsmanager"
	        },
	        {
	            "name": "promise"
	        },
	        {
	            "name": "egret_4399_h5api",
	            "path": "../egret_4399_h5api"
	        }
	    ]
	}

### 3. 游戏使用API

> 在游戏中使用 `egret_4399_h5api` 对象调用4399API代码。

> 在本地调试环境下，API使用将会出现异常，查看开发者工具可发现下图的警告或报错信息。请将集成4399API的项目打包文件上传到原创平台，在预览环境下进行测试。

![API调用警告及报错信息](https://i.imgur.com/pu9KEQW.png)

##### - 进度条

> 调用此接口后，将会控制4399进度条播放进度，值为0到100。
 
	egret_4399_h5api.progress({进度比例});

##### - 提交积分

> 调用此接口后，将会尝试匿名提交玩家分数到排行榜中，并将尝试提交接口返回给回调函数。
 
	egret_4399_h5api.submitScore({游戏分数}, data => {
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
 
	egret_4399_h5api.getRank(data => {
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
 
	egret_4399_h5api.canPlayAd();

##### - 播放广告

> 调用此接口后，将全屏展现激励广告，并返回广告播放状态。
 
	egret_4399_h5api.playAd(data =>{
        console.log('广告播放状态', data);
    });

> 返回结果为json数据，格式如下：

	{
	　　"code":10000,            //广告播放状态，10000为开始播放，10001为播放结束，10010为播放异常
	　　"message":"开始播放"      //播放状态消息
	}
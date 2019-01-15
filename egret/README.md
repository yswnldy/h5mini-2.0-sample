# 白鹭引擎游戏API使用说明

当前案例使用了白鹭引擎5.2.13版本、Egret Wing4.1.6版本进行开发。

API库以白鹭引擎第三方库方式引入项目并使用。配置方式以白鹭官方文档引入方式为准。

## API添加步骤

### 1.API库目录介绍

> API库以白鹭官方文档引入第三方库的配置方式，已生成`.d.ts`、`.js`、`.min.js`3个文件，直接将这三个文件放到同一个文件夹内（本例是`egret_4399_h5api/bin`），

> 然后使用即可。下面展示的目录结构是按官方文档的配置方式生成的完整版，实际使用中可只保留`egret_4399_h5api/bin`文件夹，其它的可删除

##### 目录结构描述

	|--egret-example                                    	// Egret案例，项目根目录
		|--libs												// Egret库文件夹
			|--egret_4399_h5api                       	    // 4399API库
				|--bin                                    	// 库文件生成文件夹
					|--egret_4399_h5api.d.ts				// TS接口头文件
					|--egret_4399_h5api.js                  // JS接口文件
					|--egret_4399_h5api.min.js              // JS压缩源码
				|--src
					|--egret_4399_h5api.js                  // JS接口源码，生成库文件之前的
				|--typings
					|--egret_4399_h5api.d.ts                // TS接口头文件源码，生成库文件之前的
				|--package.json							    // 库配置文件	
				|--tsconfig.json							// 库配置文件

### 2.项目引入

> 复制`egret_4399_h5api`文件夹，放置到`{你的游戏项目根目录}/libs`文件夹下。并在`{你的游戏项目根目录}/egretProperties.json`白鹭项目配置文件中增加4399API模块配

> 置：`{"name": "egret_4399_h5api", "path": "./libs/egret_4399_h5api/bin"}`。本示例的库文件文件夹`egret_4399_h5api`已放在了`libs`目录下了。

> 如果开发者熟悉第三方库引入规范，可将4399API库放置到其他复用文件夹中，以供开发者其他游戏使用，只需配置好4399API模块配置中的`path`地址为复用文件夹即可。

##### 目录结构描述

    |--{你的游戏项目根目录}									 // 在本示例中，即为 h5mini-2.0-egret-sample 文件夹
    	|--libs                                    			// Egret库文件夹
        	|--egret_4399_h5api                       		// 4399API库（被复制过来）
				|--bin                                    	// 库文件生成文件夹
					|--egret_4399_h5api.d.ts                // TS接口头文件
					|--egret_4399_h5api.js                  // JS接口文件
					|--egret_4399_h5api.min.js              // JS压缩源码
        	|--modules                                    	// 模块文件夹
    	|--egretProperties.json                    	    	// 白鹭项目配置文件（需要添加模块配置）

> 添加模块配置
	{
      "name": "egret_4399_h5api",
      "path": "./libs/egret_4399_h5api/bin"
    }

##### 添加后的白鹭项目配置示例

{
    "engineVersion": "5.2.13",
    "compilerVersion": "5.2.13",
    "template": {},
    "target": {
        "current": "web"
    },
    "modules": [
        {
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
            "path": "./libs/egret_4399_h5api/bin"
        }
    ]
}

### 3.游戏使用API

> 在游戏中使用`egret_4399_h5api`对象调用4399API代码。

> 在本地调试环境下，API使用将会出现异常，查看开发者工具可发现下图的警告或报错信息。请将集成4399API的项目打包文件上传到原创平台，在预览环境下进行测试。

![API调用警告及报错信息](https://i.imgur.com/pu9KEQW.png)

#### 3.1.广告API

##### -是否可以播放广告及获取剩余次数

> 返回boolean值，true为有广告资源可以播放，false为无法播放广告。

	let result = egret_4399_h5api.canPlayAd(callback)

	// 定义回调函数
	function callback(data) {
		// 做点什么
		console.log("是否可播放广告： ", data.canPlayAd, '\n', "剩余次数： ", data.remain)
	}

	if (result) {
		// 做点什么
		console.log('有广告资源可播放')
	}
	else {
		// 做点什么
		console.log('没有广告资源可播放')
	}

##### -播放全屏广告

> 播放全屏广告，并获得广告播放状态。

	egret_4399_h5api.playAd(data => {
		// 做点什么
		console.log('播放广告回调数据', data)
	});

#### 3.2.分享API

##### -调用分享

> 触发分享功能，将游戏地址分享给好友。

	egret_4399_h5api.share()

##### -是否登录

> 判断当前玩家是否已登录。

	// 返回boolean值，true为已登录，false未登录
	let result = egret_4399_h5api.isLogin()

	if (result) {
		// 做点什么
		console.log('已登录')
	}
	else {
		// 做点什么
		console.log('未登录')
	}

##### -打开用户登录面板

> 没登录就打开登录面板，有登录就返回用户信息

	egret_4399_h5api.login(callback)

	// 定义回调函数
	function callback(data) {
		// 做点什么
		console.log('用户编号：', data.uId)
		console.log('用户昵称：', data.userName)
	}

#### -根据用户编号获得用户头像地址

> 需要传入用户编号，头像大小有三种尺寸

	let userAvatar_120x120 = egret_4399_h5api.getUserAvatar(data.uId)
	let userSmallAvatar_48x48 = egret_4399_h5api.getUserSmallAvatar(data.uId)
	let userBigAvatar_200x200 = egret_4399_h5api.getUserBigAvatar(data.uId)

	// 做点什么
	console.log('用户头像地址：', userAvatar_120x120)
	console.log('用户小头像地址：', userSmallAvatar_48x48)
	console.log('用户大头像地址：', userBigAvatar_200x200)

#### 3.3.积分排行榜API

##### -展示排行榜列表面板

> 直接调用即可

egret_4399_h5api.showRanking()

##### -提交玩家分数到排行榜

> 限制最高50万分

	/**
	 * egret_4399_h5api.submitRanking(score, callback)
	 * @param { number } score 分数 限制最高50万分
	 * @param { Function } callback 回调函数
	 */
	egret_4399_h5api.submitRanking(67, data => {
		// 做点什么
		// 10000为提交成功
		if (data.code == 10000) {
			console.log('分数提交成功')
			console.log('历史最好分数：', data.history.score)
			if (data.history.rank != -1) {
				console.log('历史最好分数的排名：', data.history.rank)
			}
			// -1为未进入排行榜
			else {
				console.log('未进入排行榜')
			}
		}
		// 10001为提交失败
		else {
			console.log('分数提交失败')
		}
	}

> 返回结果data为json数据，格式如下

  	data = {
		code: 10000, 						// 10000代表提交成功，10001为提交失败
		my: { 								// 当前用户信息
			uid: 1234567, 					// 用户编号
			userName: '用户昵称'			 // 用户昵称
		},
		history: { 							// 分数提交后的历史最好成绩
			rank: -1, 						// 历史最好分数的排名 -1为未进入排行榜（排行榜只统计前500名）
			score: 0 						// 历史最好分数
		}
  	}

##### -获得排行榜排名列表

> 开发者需要根据自身游戏需求设计相应的排行榜排名列表

	/** 
	 * egret_4399_h5api.submitRanking(callback, page, step)
	 * @param { Function } callback 回调函数
	 * @param { number } page 页码 从1开始（选填，默认为1）
	 * @param { number } step 每页条数（选填，默认为10）
	 */
	egret_4399_h5api.getRanking(callback, 1, 10)

	// 定义回调函数
	function callback(data) {
		// 做点什么
		// 10000为获取成功
		if (data.code == 10000) {
			data.data.list.forEach(item => {
				if (item.rank != -1) {
					console.log('当前排名：', item.rank)
				}
				// -1为未进入排行榜
				else {
					console.log('未进入排行榜')
				}

				console.log('分数：', item.score)
				console.log('用户编号：', item.uId)
				console.log('昵称：', item.userName)
			})
		}
		// 10001为获取失败
		else {
			console.log('获取排名列表失败')
		}
	}

##### -获取当前玩家的排名

> 获取当前玩家的排名

	egret_4399_h5api.getMyRanking(callback)

	// 定义回调函数
	function callback(data) {
		// 做点什么
		// 10000为获取成功
		if (data.code == 10000) {
			console.log('当前分数：', data.data.score)

			if (data.data.rank != -1) {
				console.log('当前排名：', data.data.rank)
			}
			// -1为未进入排行榜
			else {
				console.log('未进入排行榜')
			}
		}
		// 10001为获取失败
		else {
			console.log('获取当前排名失败')
		}

		console.log('')
	}

> 返回结果data为json数据，格式如下

	data = {
		code: 10000, 					// 10000代表获取成功，10001为获取失败
		data: {
			uId: 1234567,              // 用户编号
			userName: '昵称',          // 用户昵称
			rank: 1, 			  	   // 当前的排名 -1为未进入排行榜（排行榜只统计前500名）
			score: 100 				   // 当前的分数
		}
	} 

##### -获得我排名附近的排名列表

> 获得我排名附近的排名列表

	/**
	 * egret_4399_h5api.getNearRanking(callback, step)
	 * @param { Function } callback 回调函数
	 * @param { number } step 需要条数（选填，默认为10）
	 */
	egret_4399_h5api.getNearRanking(callback, 10);

	// 定义回调函数
	function callback(data) {
		// 做点什么
		// 10000为获取成功
		if (data.code == 10000) {
			let list = data.data.list
			if (list.length) {
				for (let index = 0; index < list.length; index++) {
					let uId = list[index].uId
					let userName = list[index].userName
					let rank = list[index].rank

					console.log('编号：' + uId, '昵称：' + userName, '排名：' + rank)
				}
			}
			// 排行榜只统计前500名，当前玩家没有进入排行榜时将返回空数组[]
			else {
				console.log('未进入排行榜')
			}
		}
		// 10001为获取失败
		else {
			console.log('获取我排名附近的排名列表失败')
			console.log('')
		}
	}

> 返回结果data为json数据，格式如下

	/**
	 * 排行榜只统计前500名，当前玩家没有进入排行榜时将返回空数组[]
	 * 排行榜排名总数不足所需条数时返回当前所有排名
	 * 当前玩家的排名将尽量居中，例如：
	 * 玩家排名第3名，返回第1~10名数据
	 * 玩家排名第10名，返回第5~14名数据
	 * 玩家排名第499名，返回第490~500名数据
	 */
    data = {
		code: 10000, 							    // 10000代表获取成功，10001为获取失败
		data: {
			list: [
				{
					uId: 1234567, 				    // 用户编号
					userName: '昵称', 			    // 用户昵称
					isMe: 1, 					    // 1为当前玩家，否则为其他玩家
					rank: 1, 					    // 当前的排名
					score: 100 					    // 当前的分数
				},
				...
			]
		}
    } 

## 其它

> API使用请参考官方文档的原生js使用： http://www.4399api.com/res/h5mini/api

> 白鹭第三方库的使用方法：http://developer.egret.com/cn/github/egret-docs/extension/threes/instructions/index.html
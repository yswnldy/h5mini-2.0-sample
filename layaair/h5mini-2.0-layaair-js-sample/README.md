# LayaAir引擎游戏API使用说明

当前案例使用了LayaAir IDE 2.0.0beta5.1版本进行开发。

## API添加步骤

### 1.项目引入

> laya支持直接使用原生js，直接在`{你的游戏项目根目录}`下的`bin/index.html`页面中的<head></head>标签内加入以下代码

> `<script src="http://h.api.4399.com/h5mini-2.0/h5api-interface.php"></script>`

> 即可，如下图

![H5API地址](https://i.imgur.com/XLIsD0C.png)

### 2.游戏使用API

> 在游戏中使用`h5api`对象调用4399API代码。

> 在本地调试环境下，API使用将会出现异常，查看开发者工具可发现警告或报错信息。请将集成4399API的项目打包文件上传到原创平台，在预览环境下进行测试。

#### 2.1.广告API

##### -是否可以播放广告及获取剩余次数

> 返回boolean值，true为有广告资源可以播放，false为无法播放广告。

	let result = h5api.canPlayAd(callback)

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

	h5api.playAd(data => {
		// 做点什么
		console.log('播放广告回调数据', data)
	});

#### 2.2.分享API

##### -调用分享

> 触发分享功能，将游戏地址分享给好友。

	h5api.share()

##### -是否登录

> 判断当前玩家是否已登录。

	// 返回boolean值，true为已登录，false未登录
	let result = h5api.isLogin()

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

	h5api.login(callback)

	// 定义回调函数
	function callback(data) {
		// 做点什么
		console.log('用户编号：', data.uId)
		console.log('用户昵称：', data.userName)
	}

#### -根据用户编号获得用户头像地址

> 需要传入用户编号，头像大小有三种尺寸

	let userAvatar_120x120 = h5api.getUserAvatar(data.uId)
	let userSmallAvatar_48x48 = h5api.getUserSmallAvatar(data.uId)
	let userBigAvatar_200x200 = h5api.getUserBigAvatar(data.uId)

	// 做点什么
	console.log('用户头像地址：', userAvatar_120x120)
	console.log('用户小头像地址：', userSmallAvatar_48x48)
	console.log('用户大头像地址：', userBigAvatar_200x200)

#### 2.3.积分排行榜API

##### -展示排行榜列表面板

> 直接调用即可

h5api.showRanking()

##### -提交玩家分数到排行榜

> 限制最高50万分

	/**
	 * h5api.submitRanking(score, callback)
	 * @param { number } score 分数 限制最高50万分
	 * @param { Function } callback 回调函数
	 */
	h5api.submitRanking(67, data => {
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
	 * h5api.getRanking(callback, page, step)
	 * @param { Function } callback 回调函数
	 * @param { number } page 页码 从1开始（选填，默认为1）
	 * @param { number } step 每页条数（选填，默认为10）
	 */
	h5api.getRanking(callback, 1, 10)

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

	h5api.getMyRanking(callback)

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
	 * h5api.getNearRanking(callback, step)
	 * @param { Function } callback 回调函数
	 * @param { number } step 需要条数（选填，默认为10）
	 */
	h5api.getNearRanking(callback, 10);

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
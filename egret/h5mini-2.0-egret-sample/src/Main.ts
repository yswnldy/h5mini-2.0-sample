//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2014-present, Egret Technology.
//  All rights reserved.
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the Egret nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY EGRET AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
//  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL EGRET AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;LOSS OF USE, DATA,
//  OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//////////////////////////////////////////////////////////////////////////////////////

class Main extends egret.DisplayObjectContainer {



    public constructor() {
        super();
        this.addEventListener(egret.Event.ADDED_TO_STAGE, this.onAddToStage, this);
    }

    private onAddToStage(event: egret.Event) {

        egret.lifecycle.addLifecycleListener((context) => {
            // custom lifecycle plugin

            context.onUpdate = () => {

            }
        })

        egret.lifecycle.onPause = () => {
            egret.ticker.pause();
        }

        egret.lifecycle.onResume = () => {
            egret.ticker.resume();
        }

        this.runGame().catch(e => {
            console.log(e);
        })



    }

    private async runGame() {
        await this.loadResource()
        this.createGameScene();
        const result = await RES.getResAsync("description_json")
        this.startAnimation(result);
        await platform.login();
        const userInfo = await platform.getUserInfo();
        console.log(userInfo);

    }

    private async loadResource() {
        try {
            const loadingView = new LoadingUI();
            this.stage.addChild(loadingView);
            await RES.loadConfig("resource/default.res.json", "resource/");
            await RES.loadGroup("preload", 0, loadingView);
            this.stage.removeChild(loadingView);
        }
        catch (e) {
            console.error(e);
        }
    }

    private textfield: egret.TextField;

    /**
     * 创建游戏场景
     * Create a game scene
     */
    private createGameScene() {
        let sky = this.createBitmapByName("bg_jpg");
        this.addChild(sky);
        let stageW = this.stage.stageWidth;
        let stageH = this.stage.stageHeight;
        sky.width = stageW;
        sky.height = stageH;

        let topMask = new egret.Shape();
        topMask.graphics.beginFill(0x000000, 0.5);
        topMask.graphics.drawRect(0, 0, stageW, 172);
        topMask.graphics.endFill();
        topMask.y = 33;
        this.addChild(topMask);

        let icon = this.createBitmapByName("egret_icon_png");
        this.addChild(icon);
        icon.x = 26;
        icon.y = 33;

        let line = new egret.Shape();
        line.graphics.lineStyle(2, 0xffffff);
        line.graphics.moveTo(0, 0);
        line.graphics.lineTo(0, 117);
        line.graphics.endFill();
        line.x = 172;
        line.y = 61;
        this.addChild(line);


        let colorLabel = new egret.TextField();
        colorLabel.textColor = 0xffffff;
        colorLabel.width = stageW - 172;
        colorLabel.textAlign = "center";
        colorLabel.text = "Hello Egret";
        colorLabel.size = 24;
        colorLabel.x = 172;
        colorLabel.y = 80;
        this.addChild(colorLabel);

        let textfield = new egret.TextField();
        this.addChild(textfield);
        textfield.alpha = 0;
        textfield.width = stageW - 172;
        textfield.textAlign = egret.HorizontalAlign.CENTER;
        textfield.size = 24;
        textfield.textColor = 0xffffff;
        textfield.x = 172;
        textfield.y = 135;
        this.textfield = textfield;


        // --------------------↓↓ H5API使用示例 ↓↓----------------------------

        /**
         * 是否可以播放广告及获取剩余次数
         */
        let canPlayAd = new egret.TextField()

        this.addChild(canPlayAd)
        canPlayAd.text = "是否可以播放广告"
        canPlayAd.textAlign = egret.HorizontalAlign.CENTER
        canPlayAd.verticalAlign = egret.VerticalAlign.MIDDLE
        canPlayAd.x = 70
        canPlayAd.y = 340
        canPlayAd.width = 200
        canPlayAd.height = 60
        canPlayAd.background = true
        canPlayAd.backgroundColor = 0x4286ce
        canPlayAd.size = 24
        canPlayAd.textColor = 0xffffff
        canPlayAd.touchEnabled = true
        canPlayAd.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `获得是否可以播放广告及剩余次数`')
            // 定义回调函数
            function callback(data) {
                // 做点什么
                console.log("是否可播放广告： ", data.canPlayAd, '\n', "剩余次数： ", data.remain)
                console.log('')
            }

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                // 返回boolean值，true为有广告资源可以播放，false为无法播放广告
                let result = egret_4399_h5api.canPlayAd(callback)

                if (result) {
                    // 做点什么
                    console.log('有广告资源可播放')
                }
                else {
                    // 做点什么
                    console.log('没有广告资源可播放')
                }
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 播放全屏广告
         */
        let playAd = new egret.TextField()

        this.addChild(playAd)
        playAd.text = "播放全屏广告"
        playAd.textAlign = egret.HorizontalAlign.CENTER
        playAd.verticalAlign = egret.VerticalAlign.MIDDLE
        playAd.x = 370
        playAd.y = 340
        playAd.width = 200
        playAd.height = 60
        playAd.background = true
        playAd.backgroundColor = 0x4286ce
        playAd.size = 24
        playAd.textColor = 0xffffff
        playAd.touchEnabled = true
        playAd.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `播放全屏广告`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                // 先判断是否可以播放广告，返回boolean值，true为有广告资源可以播放，false为无法播放广告
                if (egret_4399_h5api.canPlayAd()) {
                    egret_4399_h5api.playAd(data => {
                        // 做点什么
                        console.log('播放广告回调数据', data)
                    });
                }
                else {
                    // 做点什么
                    console.log('没有广告资源可播放');
                }

                console.log('')
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 调用分享
         */
        let share = new egret.TextField()

        this.addChild(share)
        share.text = "调用分享"
        share.textAlign = egret.HorizontalAlign.CENTER
        share.verticalAlign = egret.VerticalAlign.MIDDLE
        share.x = 75
        share.y = 435
        share.width = 200
        share.height = 60
        share.background = true
        share.backgroundColor = 0x4286ce
        share.size = 24
        share.textColor = 0xffffff
        share.touchEnabled = true
        share.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `调用分享`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                egret_4399_h5api.share()
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 是否登录
         */
        let isLogin = new egret.TextField()

        this.addChild(isLogin)
        isLogin.text = "是否登录"
        isLogin.textAlign = egret.HorizontalAlign.CENTER
        isLogin.verticalAlign = egret.VerticalAlign.MIDDLE
        isLogin.x = 375
        isLogin.y = 435
        isLogin.width = 200
        isLogin.height = 60
        isLogin.background = true
        isLogin.backgroundColor = 0x4286ce
        isLogin.size = 24
        isLogin.textColor = 0xffffff
        isLogin.touchEnabled = true
        isLogin.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `是否登录`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
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
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 打开用户登录面板
         */
        let login = new egret.TextField()

        this.addChild(login)
        login.text = "打开用户登录面板";
        login.textAlign = egret.HorizontalAlign.CENTER
        login.verticalAlign = egret.VerticalAlign.MIDDLE
        login.x = 75
        login.y = 535
        login.width = 200
        login.height = 60
        login.background = true
        login.backgroundColor = 0x4286ce
        login.size = 24
        login.textColor = 0xffffff
        login.touchEnabled = true
        login.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `打开用户登录面板`')

            // 定义回调函数
            function callback(data) {
                // 做点什么
                console.log('用户编号：', data.uId)
                console.log('用户昵称：', data.userName)
                console.log('')
            }

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                // 没登录就打开登录面板，有登录有返回用户信息
                egret_4399_h5api.login(callback)
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 根据用户编号获得用户头像地址
         */
        let getUserAvatar = new egret.TextField()
        
        this.addChild(getUserAvatar)
        getUserAvatar.text = "获得用户头像地址";
        getUserAvatar.textAlign = egret.HorizontalAlign.CENTER
        getUserAvatar.verticalAlign = egret.VerticalAlign.MIDDLE
        getUserAvatar.x = 375
        getUserAvatar.y = 535
        getUserAvatar.width = 200
        getUserAvatar.height = 60
        getUserAvatar.background = true
        getUserAvatar.backgroundColor = 0x4286ce
        getUserAvatar.size = 24
        getUserAvatar.textColor = 0xffffff
        getUserAvatar.touchEnabled = true
        getUserAvatar.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `根据用户编号获得用户头像地址`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                // 调用`egret_4399_h5api.login`是为了拿到当前用户的uId
                egret_4399_h5api.login(data => {
                    // 做点什么
                    let userAvatar_120x120 = egret_4399_h5api.getUserAvatar(data.uId)
                    let userSmallAvatar_48x48 = egret_4399_h5api.getUserSmallAvatar(data.uId)
                    let userBigAvatar_200x200 = egret_4399_h5api.getUserBigAvatar(data.uId)

                    // 做点什么
                    console.log('用户头像地址：', userAvatar_120x120)
                    console.log('用户小头像地址：', userSmallAvatar_48x48)
                    console.log('用户大头像地址：', userBigAvatar_200x200)
                })

                console.log('')
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 展示排行榜列表面板
         */
        let showRanking = new egret.TextField()

        this.addChild(showRanking)
        showRanking.text = "展示排行榜列表"
        showRanking.textAlign = egret.HorizontalAlign.CENTER
        showRanking.verticalAlign = egret.VerticalAlign.MIDDLE
        showRanking.x = 75
        showRanking.y = 635
        showRanking.width = 200
        showRanking.height = 60
        showRanking.background = true
        showRanking.backgroundColor = 0x4286ce
        showRanking.size = 24
        showRanking.textColor = 0xffffff
        showRanking.touchEnabled = true
        showRanking.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `展示排行榜列表面板`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                egret_4399_h5api.showRanking()
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }

            console.log('')
        }, this)

        /**
         * 提交玩家分数到排行榜
         */
        let submitRanking = new egret.TextField()

        this.addChild(submitRanking)
        submitRanking.text = "提交玩家分数"
        submitRanking.textAlign = egret.HorizontalAlign.CENTER
        submitRanking.verticalAlign = egret.VerticalAlign.MIDDLE
        submitRanking.x = 375
        submitRanking.y = 635
        submitRanking.width = 200
        submitRanking.height = 60
        submitRanking.background = true
        submitRanking.backgroundColor = 0x4286ce
        submitRanking.size = 24
        submitRanking.textColor = 0xffffff
        submitRanking.touchEnabled = true
        submitRanking.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `提交玩家分数到排行榜`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                /**
                 * egret_4399_h5api.submitRanking(score，callback)
                 * @param { number } score 分数 限制最高50万分
                 * @param { Function } callback 回调函数
                 */
                // 假设分数为67分
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

                    console.log('')
                })
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 获得排行榜排名列表
         */
        let getRanking = new egret.TextField()

        this.addChild(getRanking)
        getRanking.text = "获取排名列表"
        getRanking.textAlign = egret.HorizontalAlign.CENTER
        getRanking.verticalAlign = egret.VerticalAlign.MIDDLE
        getRanking.x = 75
        getRanking.y = 735
        getRanking.width = 200
        getRanking.height = 60
        getRanking.background = true
        getRanking.backgroundColor = 0x4286ce
        getRanking.size = 24
        getRanking.textColor = 0xffffff
        getRanking.touchEnabled = true
        getRanking.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `获得排行榜排名列表`')

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

                console.log('')
            }

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                /**
                 * egret_4399_h5api.submitRanking(callback, page, step)
                 * @param { Function } callback 回调函数
                 * @param { number } page 页码 从1开始（选填，默认为1）
                 * @param { number } step 每页条数（选填，默认为10）
                 */
                egret_4399_h5api.getRanking(callback, 1, 10)
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 获取当前玩家的排名
         */
        let getMyRanking = new egret.TextField()

        this.addChild(getMyRanking)
        getMyRanking.text = "获取当前玩家排名"
        getMyRanking.textAlign = egret.HorizontalAlign.CENTER
        getMyRanking.verticalAlign = egret.VerticalAlign.MIDDLE
        getMyRanking.x = 375
        getMyRanking.y = 735
        getMyRanking.width = 200
        getMyRanking.height = 60
        getMyRanking.background = true
        getMyRanking.backgroundColor = 0x4286ce
        getMyRanking.size = 24
        getMyRanking.textColor = 0xffffff
        getMyRanking.touchEnabled = true
        getMyRanking.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `获取当前玩家的排名`')

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

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                egret_4399_h5api.getMyRanking(callback)
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        }, this)

        /**
         * 获得我排名附近的排名列表
         */
        let getNearRanking = new egret.TextField()

        this.addChild(getNearRanking)
        getNearRanking.text = "获取我的附近排名"
        getNearRanking.textAlign = egret.HorizontalAlign.CENTER
        getNearRanking.verticalAlign = egret.VerticalAlign.MIDDLE
        getNearRanking.x = 75
        getNearRanking.y = 835
        getNearRanking.width = 200
        getNearRanking.height = 60
        getNearRanking.background = true
        getNearRanking.backgroundColor = 0x4286ce
        getNearRanking.size = 24
        getNearRanking.textColor = 0xffffff
        getNearRanking.touchEnabled = true
        getNearRanking.addEventListener(egret.TouchEvent.TOUCH_BEGIN, () => {
            console.log('')
            console.log('调用 `获得我排名附近的排名列表`')

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

                console.log('')
            }

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('egret_4399_h5api' in window)) {
                /**
                 * egret_4399_h5api.getNearRanking(callback, step)
                 * @param { Function } callback 回调函数
                 * @param { number } step 需要条数（选填，默认为10）
                 */
                egret_4399_h5api.getNearRanking(callback, 10);
            }
            else {
                console.log('找不到 4399HTML5 API')
            }
        }, this)

        // --------------------↑↑ H5API使用示例 ↑↑----------------------------
    }

    /**
     * 根据name关键字创建一个Bitmap对象。name属性请参考resources/resource.json配置文件的内容。
     * Create a Bitmap object according to name keyword.As for the property of name please refer to the configuration file of resources/resource.json.
     */
    private createBitmapByName(name: string) {
        let result = new egret.Bitmap();
        let texture: egret.Texture = RES.getRes(name);
        result.texture = texture;
        return result;
    }

    /**
     * 描述文件加载成功，开始播放动画
     * Description file loading is successful, start to play the animation
     */
    private startAnimation(result: string[]) {
        let parser = new egret.HtmlTextParser();

        let textflowArr = result.map(text => parser.parse(text));
        let textfield = this.textfield;
        let count = -1;
        let change = () => {
            count++;
            if (count >= textflowArr.length) {
                count = 0;
            }
            let textFlow = textflowArr[count];

            // 切换描述内容
            // Switch to described content
            textfield.textFlow = textFlow;
            let tw = egret.Tween.get(textfield);
            tw.to({ "alpha": 1 }, 200);
            tw.wait(2000);
            tw.to({ "alpha": 0 }, 200);
            tw.call(change, this);
        };

        change();
    }
}
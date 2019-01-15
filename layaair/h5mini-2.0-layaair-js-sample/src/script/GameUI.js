// import GameControl from "./GameControl"
/**
 * 本示例采用非脚本的方式实现，而使用继承页面基类，实现页面逻辑。在IDE里面设置场景的Runtime属性即可和场景进行关联
 * 相比脚本方式，继承式页面类，可以直接使用页面定义的属性（通过IDE内var属性定义），比如this.tipLbll，this.scoreLbl，具有代码提示效果
 * 建议：如果是页面级的逻辑，需要频繁访问页面内多个元素，使用继承式写法，如果是独立小模块，功能单一，建议用脚本方式实现，比如子弹脚本。
 */
export default class GameUI extends Laya.Scene {
    constructor() {
        super();
        //设置单例的引用方式，方便其他类引用
        GameUI.instance = this;
        //关闭多点触控，否则就无敌了
        Laya.MouseManager.multiTouchEnabled = false;
        //加载场景文件
        this.loadScene("test/TestScene.scene");
    }

    onEnable() {
        // --------------------↓↓ H5API使用示例 ↓↓----------------------------

        /**
         * 是否可以播放广告及获取剩余次数
         */
        this.canPlayAd.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `获得是否可以播放广告及剩余次数`')
            // 定义回调函数
            function callback(data) {
                // 做点什么
                console.log("是否可播放广告： ", data.canPlayAd, '\n', "剩余次数： ", data.remain)
                console.log('')
            }

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
                // 返回boolean值，true为有广告资源可以播放，false为无法播放广告
                let result = h5api.canPlayAd(callback)

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
        })

        // /**
        //  * 播放全屏广告
        //  */
        this.playAd.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `播放全屏广告`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
                // 先判断是否可以播放广告，返回boolean值，true为有广告资源可以播放，false为无法播放广告
                if (h5api.canPlayAd()) {
                    h5api.playAd(data => {
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
        })

        // /**
        //  * 调用分享
        //  */

        this.share.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `调用分享`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
                h5api.share()
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        })

        // /**
        //  * 是否登录
        //  */

        this.isLogin.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `是否登录`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
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
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        })

        // /**
        //  * 打开用户登录面板
        //  */
        this.login.on(Laya.Event.CLICK, this, () => {
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
            if (('h5api' in window)) {
                // 没登录就打开登录面板，有登录有返回用户信息
                h5api.login(callback)
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        })

        // /**
        //  * 根据用户编号获得用户头像地址
        //  */
        this.getUserAvatar.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `根据用户编号获得用户头像地址`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
                // 调用`h5api.login`是为了拿到当前用户的uId
                h5api.login(data => {
                    // 做点什么
                    let userAvatar_120x120 = h5api.getUserAvatar(data.uId)
                    let userSmallAvatar_48x48 = h5api.getUserSmallAvatar(data.uId)
                    let userBigAvatar_200x200 = h5api.getUserBigAvatar(data.uId)

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
        })

        // /**
        //  * 展示排行榜列表面板
        //  */
        this.showRanking.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `展示排行榜列表面板`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
                h5api.showRanking()
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }

            console.log('')
        })

        // /**
        //  * 提交玩家分数到排行榜
        //  */
        this.submitRanking.on(Laya.Event.CLICK, this, () => {
            console.log('')
            console.log('调用 `提交玩家分数到排行榜`')

            // 判断是否成功引入4399HTML5 API，可不判断
            if (('h5api' in window)) {
                /**
                 * h5api.submitRanking(score，callback)
                 * @param { number } score 分数 限制最高50万分
                 * @param { Function } callback 回调函数
                 */
                // 假设分数为67分
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

                    console.log('')
                })
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        })

        // /**
        //  * 获得排行榜排名列表
        //  */
        this.getRanking.on(Laya.Event.CLICK, this, () => {
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
            if (('h5api' in window)) {
                /**
                 * h5api.submitRanking(callback, page, step)
                 * @param { Function } callback 回调函数
                 * @param { number } page 页码 从1开始（选填，默认为1）
                 * @param { number } step 每页条数（选填，默认为10）
                 */
                h5api.getRanking(callback, 1, 10)
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        })

        // /**
        //  * 获取当前玩家的排名
        //  */
        this.getMyRanking.on(Laya.Event.CLICK, this, () => {
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
            if (('h5api' in window)) {
                h5api.getMyRanking(callback)
            }
            else {
                console.log('找不到 4399HTML5 API')
                console.log('')
            }
        })

        // /**
        //  * 获得我排名附近的排名列表
        //  */
        this.getNearRanking.on(Laya.Event.CLICK, this, () => {
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
            if (('h5api' in window)) {
                /**
                 * h5api.getNearRanking(callback, step)
                 * @param { Function } callback 回调函数
                 * @param { number } step 需要条数（选填，默认为10）
                 */
                h5api.getNearRanking(callback, 10);
            }
            else {
                console.log('找不到 4399HTML5 API')
            }
        })

        // --------------------↑↑ H5API使用示例 ↑↑----------------------------
    }
}
// 自动引用H5API地址
!(function () {
    var element = document.createElement('script');
    element.setAttribute('src', 'http://h.api.4399.com/h5mini-2.0/h5api-interface.php');
    document.getElementsByTagName('head')[0].appendChild(element);
})();
/**
 * 用于白鹭引擎的API接口
 */
var egret_4399_h5api = (function () {
    var inner = {};
    /**
     * 获得是否可以播放广告及剩余次数
     *
     * @param { Function } callback           - 回调函数
     * @returns { boolean }                   - true为有广告资源可以播放，false为无法播放广告
     */
    inner.canPlayAd = function (callback) {
        return h5api.canPlayAd(callback);
    };
    /**
     * 播放全屏广告
     *
     * @param { Function } callback           - 回调函数
     */
    inner.playAd = function (callback) {
        h5api.playAd(callback);
    };
    /**
     * 调用分享
     */
    inner.share = function () {
        h5api.share();
    };
    /**
     * 是否登录
     *
     * @returns { boolean }                   - true为已登录，false为未登录
     */
    inner.isLogin = function () {
        return h5api.isLogin();
    };
    /**
     * 打开用户登录面板
     *
     * @param { Function } callback           - 回调函数
     */
    inner.login = function (callback) {
        h5api.login(callback);
    };
    /**
     * 根据用户编号获得用户头像地址
     *
     * @param { string } uid                  - 用户编号
     * @returns                               - 用户头像地址
     */
    inner.getUserAvatar = function (uid) {
        return h5api.getUserAvatar(uid);
    };
    /**
     * 根据用户编号获得用户小头像地址
     *
     * @param { string } uid                  - 用户编号
     * @returns                               - 用户小头像地址
     */
    inner.getUserSmallAvatar = function (uid) {
        return h5api.getUserSmallAvatar(uid);
    };
    /**
     * 根据用户编号获得用户大头像地址
     *
     * @param { string } uid                  - 用户编号
     * @returns                               - 用户大头像地址
     */
    inner.getUserBigAvatar = function (uid) {
        return h5api.getUserBigAvatar(uid);
    };
    /**
     * 展示排行榜列表面板
     */
    inner.showRanking = function () {
        h5api.showRanking();
    };
    /**
     * 提交玩家分数到排行榜
     *
     * @param { number } score                - 分数 限制最高50万分
     * @param { Function } callback           - 回调函数
     */
    inner.submitRanking = function (score, callback) {
        h5api.submitRanking(score, callback);
    };
    /**
     * 获得排行榜排名列表
     *
     * @param { Function} callback            - 回调函数
     * @param { number } page                 - 页码，从1开始（选填，默认为1）
     * @param { number} step                  - 每页条数（选填，默认为10）
     */
    inner.getRanking = function (callback, page, step) {
        h5api.getRanking(callback, page, step);
    };
    /**
     * 获取当前玩家的排名
     *
     * @param { Function } callback           - 回调函数
     */
    inner.getMyRanking = function (callback) {
        h5api.getMyRanking(callback);
    };
    /**
     * 获得我排名附近的排名列表
     *
     * @param { Function } callback           - 回调函数
     * @param { number } step                 - 需要条数（选填，默认为10）
     */
    inner.getNearRanking = function (callback, step) {
        h5api.getNearRanking(callback, step);
    };
    return inner;
})();

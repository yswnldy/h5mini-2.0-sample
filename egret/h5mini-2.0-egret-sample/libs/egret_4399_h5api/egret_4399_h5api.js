// 自动引用H5API地址
var element = document.createElement('script');
element.setAttribute('src', 'http://h.api.4399.com/h5mini-2.0/h5api.php');
document.getElementsByTagName('head')[0].appendChild(element);
/**
 * 用于白鹭引擎的API接口
 */
var egret_4399_h5api = (function () {
    var inner = {};
    /**
     * 设置4399进度条进度
     *
     * @param {int} num 进度条进度 0到100
     */
    inner.progress = function (num) {
        h5api.progress(num);
    };
    /**
     * 提交积分到排行榜
     *
     * @param num           分数
     * @param callback      提交完积分后的回调函数
     */
    inner.submitScore = function (num, callback) {
        h5api.submitScore(num, callback);
    };
    /**
     * 获取排行榜
     *
     * @param callback      获取到排行榜数据后的回调函数
     */
    inner.getRank = function (callback) {
        h5api.getRank(callback);
    };
    /**
     * 是否有广告资源播放
     *
     * @returns true为有广告资源可以播放，否则无法播放广告
     */
    inner.canPlayAd = function () {
        return h5api.canPlayAd();
    };
    /**
     * 播放广告
     * @param callback      广告播放状态回调
     */
    inner.playAd = function (callback) {
        return h5api.playAd(callback);
    };
    return inner;
})();

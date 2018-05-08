/**
 * H5API接口
 */
declare module egret_4399_h5api {

    /**
     * 提交积分到排行榜
     * 
     * @param num           分数
     * @param callback      提交完积分后的回调函数
     */
    function submitScore(score: number, callback: Function): void;

    /**
     * 获取排行榜
     * 
     * @param callback      获取到排行榜数据后的回调函数
     */
    function getRank(callback: Function): void;

    /**
     * 是否有广告资源播放
     * 
     * @returns true为有广告资源可以播放，否则无法播放广告
     */
    function canPlayAd(): boolean;

    /**
     * 播放广告
     * 
     * @param callback      广告播放状态的回调函数
     */
    function playAd(callback: Function): void;
}
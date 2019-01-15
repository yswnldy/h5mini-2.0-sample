/**
 * 用于白鹭引擎的API接口
 */
declare module egret_4399_h5api {
    /**
     * 获得是否可以播放广告及剩余次数
     * 
     * @param { Function } callback           - 回调函数
     * @returns { boolean }                   - true为有广告资源可以播放，false为无法播放广告
     */
    function canPlayAd(callback?: Function): boolean

    /**
     * 播放全屏广告
     * 
     * @param { Function } callback           - 回调函数
     */
    function playAd(callback: Function): void

    /**
     * 调用分享
     */
    function share(): void

    /**
     * 是否登录
     * 
     * @returns { boolean }                   - true为已登录，false为未登录
     */
    function isLogin(): boolean

    /**
     * 打开用户登录面板
     * 
     * @param { Function } callback           - 回调函数
     */
    function login(callback: Function): void

    /**
     * 根据用户编号获得用户头像地址
     * 
     * @param { string } uid                  - 用户编号
     * @returns                               - 用户头像地址
     */
    function getUserAvatar(uid: string): string

    /**
     * 根据用户编号获得用户小头像地址
     * 
     * @param { string } uid                  - 用户编号
     * @returns                               - 用户小头像地址
     */
    function getUserSmallAvatar(uid: string): string

    /**
     * 根据用户编号获得用户大头像地址
     *      
     * @param { string } uid                  - 用户编号
     * @returns                               - 用户大头像地址
     */
    function getUserBigAvatar(uid: string): string

    /**
     * 展示排行榜列表面板
     */
    function showRanking(): void

    /**
     * 提交玩家分数到排行榜
     * 
     * @param { number } score                - 分数 限制最高50万分
     * @param { Function } callback           - 回调函数
     */
    function submitRanking(score: number, callback: Function): void

    /**
     * 获得排行榜排名列表
     * 
     * @param { Function} callback            - 回调函数
     * @param { number } page                 - 页码，从1开始（选填，默认为1）
     * @param { number} step                  - 每页条数（选填，默认为10）
     */
    function getRanking(callback: Function, page: number, step: number): void

    /**
     * 获取当前玩家的排名
     * 
     * @param { Function } callback           - 回调函数
     */
    function getMyRanking(callback: Function): void

    /**
     * 获得我排名附近的排名列表
     * 
     * @param { Function } callback           - 回调函数
     * @param { number } step                 - 需要条数（选填，默认为10）
     */
    function getNearRanking(callback: Function, step: number): void
}
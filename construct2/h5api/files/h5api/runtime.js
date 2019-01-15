// ECMAScript 5 strict mode
"use strict";

assert2(cr, "cr namespace not created");
assert2(cr.plugins_, "cr.plugins_ not created");

/////////////////////////////////////
// Plugin class
// *** CHANGE THE PLUGIN ID HERE *** - must match the "id" property in edittime.js
//          vvvvvvvv
cr.plugins_.H5API = function (runtime) {
	this.runtime = runtime;
};

(function () {
	/////////////////////////////////////
	// *** CHANGE THE PLUGIN ID HERE *** - must match the "id" property in edittime.js
	//                            vvvvvvvv
	var pluginProto = cr.plugins_.H5API.prototype;

	/////////////////////////////////////
	// Object type class
	pluginProto.Type = function (plugin) {
		this.plugin = plugin;
		this.runtime = plugin.runtime;
	};

	var typeProto = pluginProto.Type.prototype;

	// called on startup for each object type
	typeProto.onCreate = function () {
		var element = document.createElement("script");
		element.setAttribute("src", "http://h.api.4399.com/h5mini-2.0/h5api-interface.php");
		document.getElementsByTagName('head')[0].appendChild(element);
	};

	/////////////////////////////////////
	// Instance class
	pluginProto.Instance = function (type) {
		this.type = type;
		this.runtime = type.runtime;
		// any other properties you need, e.g...
		// this.myValue = 0;
	};

	var instanceProto = pluginProto.Instance.prototype;

	// called whenever an instance is created
	instanceProto.onCreate = function () {
		// note the object is sealed after this call; ensure any properties you'll ever need are set on the object
		// e.g...
		// this.myValue = 0;
	};

	// called whenever an instance is destroyed
	// note the runtime may keep the object after this call for recycling; be sure
	// to release/recycle/reset any references to other objects in this function.
	instanceProto.onDestroy = function () { };

	// called when saving the full state of the game
	instanceProto.saveToJSON = function () {
		// return a Javascript object containing information about your object's state
		// note you MUST use double-quote syntax (e.g. "property": value) to prevent
		// Closure Compiler renaming and breaking the save format
		return {
			// e.g.
			//"myValue": this.myValue
		};
	};

	// called when loading the full state of the game
	instanceProto.loadFromJSON = function (o) {
		// load from the state previously saved by saveToJSON
		// 'o' provides the same object that you saved, e.g.
		// this.myValue = o["myValue"];
		// note you MUST use double-quote syntax (e.g. o["property"]) to prevent
		// Closure Compiler renaming and breaking the save format
	};

	// only called if a layout object - draw to a canvas 2D context
	instanceProto.draw = function (ctx) { };

	// only called if a layout object in WebGL mode - draw to the WebGL context
	// 'glw' is not a WebGL context, it's a wrapper - you can find its methods in GLWrap.js in the install
	// directory or just copy what other plugins do.
	instanceProto.drawGL = function (glw) { };

	// The comments around these functions ensure they are removed when exporting, since the
	// debugger code is no longer relevant after publishing.
	/**BEGIN-PREVIEWONLY**/
	instanceProto.getDebuggerValues = function (propsections) {
		// Append to propsections any debugger sections you want to appear.
		// Each section is an object with two members: "title" and "properties".
		// "properties" is an array of individual debugger properties to display
		// with their name and value, and some other optional settings.
		propsections.push({
			"title": "My debugger section",
			"properties": [
				// Each property entry can use the following values:
				// "name" (required): name of the property (must be unique within this section)
				// "value" (required): a boolean, number or string for the value
				// "html" (optional, default false): set to true to interpret the name and value
				//									 as HTML strings rather than simple plain text
				// "readonly" (optional, default false): set to true to disable editing the property

				// Example:
				// {"name": "My property", "value": this.myValue}
			]
		});
	};

	instanceProto.onDebugValueEdited = function (header, name, value) {
		// Called when a non-readonly property has been edited in the debugger. Usually you only
		// will need 'name' (the property name) and 'value', but you can also use 'header' (the
		// header title for the section) to distinguish properties with the same name.
	};
	/**END-PREVIEWONLY**/





	//////////////////////////////////////
	// Conditions
	function Cnds() { };
	/**
	 * 广告API
	 */
	// -是否可以播放广告及获取剩余次数
	Cnds.prototype.canPlayAd = function () {
		var result = canPlayAdData ? canPlayAdData.canPlayAd : false;
		console.log('Cnds canPlayAd', result, canPlayAdData);

		return result;
	};
	Cnds.prototype.canPlayAdComplete = function () {
		console.log('canPlayAdComplete');

		return true;
	};

	// -播放全屏广告
	Cnds.prototype.playAdComplete = function () {
		console.log('playAdComplete');

		return true;
	};
	Cnds.prototype.playAdCode = function (operator, code) {
		console.log('playAdCode', playAdData.code, code);

		if (playAdData.code == 10000 || playAdData.code == 10001) {
			return code == playAdData.code
		}
		else {
			return code == 10003
		}
	};


	/**
	 * 分享API
	 */
	// -是否登录
	Cnds.prototype.isLogin = function () {
		return isLoginData;
	};

	// -打开用户登录面板
	Cnds.prototype.loginComplete = function () {
		console.log('loginComplete');

		return true;
	};

	// -根据用户编号获得用户头像地址
	Cnds.prototype.getUserAvatarComplete = function () {
		console.log('getUserAvatarComplete');

		return true;
	};


	/**
	* 积分排行榜API
	*/
	// -提交玩家分数到排行榜
	Cnds.prototype.submitRankingComplete = function () {
		console.log('submitRankingComplete');

		return true;
	};
	Cnds.prototype.submitRankingCode = function (operator, code) {
		console.log('submitRankingCode', submitRankingData.code, code);

		return code == submitRankingData.code;
	};

	// -获得排行榜排名列表
	Cnds.prototype.getRankingComplete = function () {
		console.log('getRankingComplete');

		return true;
	};
	Cnds.prototype.getRankingCode = function (operator, code) {
		console.log('getRankingCode', getRankingData.code, code);

		return code == getRankingData.code;
	};

	// -获取当前玩家的排名
	Cnds.prototype.getMyRankingComplete = function () {
		console.log('getMyRankingComplete');

		return true;
	};
	Cnds.prototype.getMyRankingCode = function (operator, code) {
		console.log('getMyRankingCode', getMyRankingData.code, code);

		return code == getMyRankingData.code;
	};

	// -获得玩家排名附近的排名列表
	Cnds.prototype.getNearRankingComplete = function () {
		console.log('getNearRankingComplete');

		return true;
	};
	Cnds.prototype.getNearRankingCode = function (operator, code) {
		console.log('getNearRankingCode', getNearRankingData.code, code);

		return code == getNearRankingData.code;
	};

	// ... other conditions here ...

	pluginProto.cnds = new Cnds();





	//////////////////////////////////////
	// Actions
	function Acts() { };

	/**
	* 广告API
	*/
	// -是否可以播放广告及获取剩余次数
	var canPlayAdData;

	Acts.prototype.canPlayAd = function () {
		var self = this;

		h5api.canPlayAd(function (obj) {
			canPlayAdData = obj;
			self.runtime.trigger(cr.plugins_.H5API.prototype.cnds.canPlayAdComplete, self);
			console.log('Acts canPlayAdData', canPlayAdData);
		});
	};
	// -播放全屏广告
	var playAdData;

	Acts.prototype.playAd = function () {
		var self = this;

		h5api.playAd(function (obj) {
			playAdData = obj;
			self.runtime.trigger(cr.plugins_.H5API.prototype.cnds.playAdComplete, self);
			console.log('Acts playAdData', playAdData);
		});
	};

	/**
	* 分享API
	*/
	// -调用分享
	Acts.prototype.share = function () {
		h5api.share();
	};

	// -是否登录
	var isLoginData;

	Acts.prototype.isLogin = function () {
		isLoginData = h5api.isLogin();
	};

	// -打开用户登录面板
	var loginData;

	Acts.prototype.login = function () {
		loginData = h5api.login();

		if (loginData && loginData.uid) {
			this.runtime.trigger(cr.plugins_.H5API.prototype.cnds.loginComplete, this);
		}
	};

	// -根据用户编号获得用户头像地址
	var userAvatarData;

	Acts.prototype.getUserAvatar = function (uid) {
		userAvatarData = h5api.getUserAvatar(uid);

		this.runtime.trigger(cr.plugins_.H5API.prototype.cnds.getUserAvatarComplete, this);
	};
	Acts.prototype.getUserSmallAvatar = function (uid) {
		userAvatarData = h5api.getUserSmallAvatar(uid);

		this.runtime.trigger(cr.plugins_.H5API.prototype.cnds.getUserAvatarComplete, this);
	};
	Acts.prototype.getUserBigAvatar = function (uid) {
		userAvatarData = h5api.getUserBigAvatar(uid);

		this.runtime.trigger(cr.plugins_.H5API.prototype.cnds.getUserAvatarComplete, this);
	};

	/**
	* 积分排行榜API
	*/
	// -展示排行榜列表面板
	Acts.prototype.showRanking = function (num) {
		h5api.showRanking();
	};

	// -提交玩家分数到排行榜
	var submitRankingData = {};

	Acts.prototype.submitRanking = function (score) {
		h5api.submitRanking(score, callback);
		var self = this;

		function callback(obj) {
			if (obj.code == 10000) {
				submitRankingData.data = obj.history;
			}

			submitRankingData.code = obj.code;
			self.runtime.trigger(cr.plugins_.H5API.prototype.cnds.submitScoreComplete, self);
		}
	};

	// -获得排行榜排名列表
	var getRankingData = {};

	Acts.prototype.getRanking = function () {
		console.log('Acts getRanking', arguments)
		h5api.getRanking(callback, arguments[0], arguments[1]);
		var self = this;

		function callback(obj) {
			if (obj.code == 10000) {
				var data = obj.data.list;
				var dataStr = "";

				for (var i = 0; i < data.length; i++) {
					console.log("积分：" + data[i].score + "，排名：" + data[i].rank + "，昵称：" + data[i].userName);
					dataStr += dataStr === "" ? "" : ",";
					dataStr += "[[" + data[i].rank + "],[" + data[i].score + "],[" + data[i].userName + "]]";
				}

				//{"c2array":true,"size":[10,2,1],"data":[[["12"],[3]],[["10"],[4]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]]]}
				getRankingData.data = "{\"c2array\":true,\"size\":[" + data.length + ",3,1],\"data\":[" + dataStr + "]}";
			}
			else {
				getRankingData.data = {};
			}

			getRankingData.code = obj.code;
			self.runtime.trigger(cr.plugins_.H5API.prototype.cnds.getRankingComplete, self);
		}
	};

	// -获取当前玩家的排名
	var getMyRankingData = {};

	Acts.prototype.getMyRanking = function () {
		h5api.getMyRanking(callback);
		var self = this;

		function callback(obj) {
			getMyRankingData.data = obj.code == 10000 ? obj.data : {};
			getMyRankingData.code = obj.code;
			self.runtime.trigger(cr.plugins_.H5API.prototype.cnds.getMyRankingComplete, self);
		}
	};

	// -获得玩家排名附近的排名列表
	var getNearRankingData = {};
	Acts.prototype.getNearRanking = function () {
		h5api.getNearRanking(callback);
		var self = this;

		function callback(obj) {
			if (obj.code == 10000) {
				var data = obj.data.list;
				var dataStr = "";

				for (var i = 0; i < data.length; i++) {
					console.log("积分：" + data[i].score + "，排名：" + data[i].rank + "，昵称：" + data[i].userName);
					dataStr += dataStr === "" ? "" : ",";
					dataStr += "[[" + data[i].rank + "],[" + data[i].score + "],[" + data[i].userName + "]]";
				}

				//{"c2array":true,"size":[10,2,1],"data":[[["12"],[3]],[["10"],[4]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]],[[0],[0]]]}
				getNearRankingData.data = "{\"c2array\":true,\"size\":[" + data.length + ",3,1],\"data\":[" + dataStr + "]}";
			}
			else {
				getNearRankingData.data = {};
			}

			getNearRankingData.code = obj.code;
			self.runtime.trigger(cr.plugins_.H5API.prototype.cnds.getNearRankingComplete, self);
		}
	};

	// ... other actions here ...

	pluginProto.acts = new Acts();





	//////////////////////////////////////
	// Expressions
	function Exps() { };

	// the example expression
	/**
	* 广告API
	*/
	// 是否可以播放广告及获取剩余次数
	Exps.prototype.adRemain = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps adRemain', canPlayAdData);
		ret.set_any(canPlayAdData.remain); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// 播放全屏广告
	Exps.prototype.adState = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps adState', playAdData);
		ret.set_string(playAdData && playAdData.message); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};


	/**
	* 分享API
	*/
	// -是否登录
	Exps.prototype.isLogin = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps isLogin', isLoginData);
		ret.set_any(isLoginData); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// -打开用户登录面板
	Exps.prototype.uId = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps uId', loginData);
		ret.set_any(loginData.data.uId); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};
	Exps.prototype.userName = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps userName', loginData);
		ret.set_any(loginData.data.userName); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// -根据用户编号获得用户头像地址
	Exps.prototype.userAvatar = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps userAvatar', userAvatarData);
		ret.set_string(userAvatarData); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};


	/**
	* 积分排行榜API
	*/
	// -提交玩家分数到排行榜，返回历史最好成绩
	Exps.prototype.historyRank = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps historyRank', submitRankingData);
		if (submitRankingData.data.rank != -1) {
			ret.set_any(submitRankingData.data.rank);
		}
		else {
			ret.set_any('未进入排行榜'); // return our value
		}
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};
	Exps.prototype.historyScore = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps historyScore', submitRankingData);
		ret.set_any(submitRankingData.data.score); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// -获得排行榜排名列表
	Exps.prototype.rankingList = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps rankingList', getRankingData);
		ret.set_any(getRankingData.data); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// -获取当前玩家的排名
	Exps.prototype.myRanking = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps myRanking', getMyRankingData);
		if (getMyRankingData.data.rank != -1) {
			ret.set_any(getMyRankingData.data.rank);
		}
		else {
			ret.set_any('未进入排行榜'); // return our value
		}
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// -获得玩家排名附近的排名列表
	Exps.prototype.nearRanking = function (ret) { // 'ret' must always be the first parameter - always return the expression's result through it!
		console.log('Exps nearRanking', getNearRankingData);
		ret.set_string(getNearRankingData.data); // return our value
		// ret.set_float(0.5);			// for returning floats
		// ret.set_string("Hello");		// for ef_return_string
		// ret.set_any("woo");			// for ef_return_any, accepts either a number or string
	};

	// ... other expressions here ...

	pluginProto.exps = new Exps();

}());
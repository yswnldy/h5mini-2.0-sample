function GetPluginSettings() {
	return {
		"name": "H5API",				// as appears in 'insert object' dialog, can be changed as long as "id" stays the same
		"id": "H5API",				// this is used to identify this plugin and is saved to the project; never change it
		"version": "1.0",					// (float in x.y format) Plugin version - C2 shows compatibility warnings based on this
		"description": "4399原创平台提供的Construct 2插件",
		"author": "www.4399api.com",
		"help url": "http://www.4399api.com/res/api/html5",
		"category": "Platform specific",				// Prefer to re-use existing categories, but you can set anything here
		"type": "object",				// either "world" (appears in layout and is drawn), else "object"
		"rotatable": false,					// only used when "type" is "world".  Enables an angle property on the object.
		"flags": pf_singleglobal			// uncomment lines to enable flags...
		//	| pf_singleglobal		// exists project-wide, e.g. mouse, keyboard.  "type" must be "object".
		//	| pf_texture			// object has a single texture (e.g. tiled background)
		//	| pf_position_aces		// compare/set/get x, y...
		//	| pf_size_aces			// compare/set/get width, height...
		//	| pf_angle_aces			// compare/set/get angle (recommended that "rotatable" be set to true)
		//	| pf_appearance_aces	// compare/set/get visible, opacity...
		//	| pf_tiling				// adjusts image editor features to better suit tiled images (e.g. tiled background)
		//	| pf_animations			// enables the animations system.  See 'Sprite' for usage
		//	| pf_zorder_aces		// move to top, bottom, layer...
		//  | pf_nosize				// prevent resizing in the editor
		//	| pf_effects			// allow WebGL shader effects to be added
		//  | pf_predraw			// set for any plugin which draws and is not a sprite (i.e. does not simply draw
		// a single non-tiling image the size of the object) - required for effects to work properly
	};
};

////////////////////////////////////////
// Parameter types:
// AddNumberParam(label, description [, initial_string = "0"])			// a number
// AddStringParam(label, description [, initial_string = "\"\""])		// a string
// AddAnyTypeParam(label, description [, initial_string = "0"])			// accepts either a number or string
// AddCmpParam(label, description)										// combo with equal, not equal, less, etc.
// AddComboParamOption(text)											// (repeat before "AddComboParam" to add combo items)
// AddComboParam(label, description [, initial_selection = 0])			// a dropdown list parameter
// AddObjectParam(label, description)									// a button to click and pick an object type
// AddLayerParam(label, description)									// accepts either a layer number or name (string)
// AddLayoutParam(label, description)									// a dropdown list with all project layouts
// AddKeybParam(label, description)										// a button to click and press a key (returns a VK)
// AddAnimationParam(label, description)								// a string intended to specify an animation name
// AddAudioFileParam(label, description)								// a dropdown list with all imported project audio files





////////////////////////////////////////
// Conditions

// AddCondition(id,					// any positive integer to uniquely identify this condition
//				flags,				// (see docs) cf_none, cf_trigger, cf_fake_trigger, cf_static, cf_not_invertible,
//									// cf_deprecated, cf_incompatible_with_triggers, cf_looping
//				list_name,			// appears in event wizard list
//				category,			// category in event wizard list
//				display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//				description,		// appears in event wizard dialog when selected
//				script_name);		// corresponding runtime function name

// example				
//AddNumberParam("Number", "Enter a number to test if positive.");
//AddCondition(0, cf_none, "Is number positive", "My category", "{0} is positive", "Description for my condition!", "MyCondition");

/**
 * 广告API
 */
// -是否可以播放广告及获取剩余次数
AddCondition(0, cf_none, "H5API can play ad", "广告API", "can play ad", "是否可以播放广告", "canPlayAd");
AddCondition(1, cf_trigger, "H5API can play ad complete", "广告API", "can play ad complete", "是否可以播放广告请求是否成功", "canPlayAdComplete");
// -播放全屏广告
AddCmpParam("playAdCode", "请求返回码");
AddNumberParam("code", "需要比较的返回码，数值类型", initial_string = "10000");
AddCondition(2, cf_none, "H5API play ad, get state code", "广告API", "play ad, get state code {0} {1}", "播放全屏广告，并获得广告播放状态请求返回码", "playAdCode");
AddCondition(3, cf_trigger, "H5API play ad, get state complete", "广告API", "play ad, get state complete", "播放全屏广告，并获得广告播放状态请求是否成功", "playAdComplete");

/**
 * 分享API
 */
// -是否登录
AddCondition(4, cf_trigger, "H5API isLogin", "分享API", "is login", "判断当前玩家是否已登录", "isLogin");
// -打开用户登录面板
AddCondition(5, cf_trigger, "H5API login", "分享API", "login", "没登录就打开登录面板，有登录就返回用户信息请求是否成功", "loginComplete");
// -根据用户编号获得用户头像地址
AddCondition(6, cf_trigger, "H5API getUserAvatarComplete", "分享API", "get user avatar complete", "根据用户编号获得用户头像地址请求是否成功", "getUserAvatarComplete");

/**
 * 积分排行榜API
 */
// -提交玩家分数到排行榜
AddCmpParam("submitRankingCode", "请求返回码");
AddNumberParam("code", "需要比较的返回码，数值类型", initial_string = "10000");
AddCondition(7, cf_none, "H5API submit ranking complete code", "积分排行榜API", "submit ranking complete code {0} {1}", "积分提交请求返回码", "submitRankingCode");
AddCondition(8, cf_trigger, "H5API submit ranking complete", "积分排行榜API", "submit ranking complete", "积分提交请求是否成功", "submitRankingComplete");
// -获得排行榜排名列表
AddCmpParam("getRankingCode", "请求返回码");
AddNumberParam("code", "需要比较的返回码，数值类型", initial_string = "10000");
AddCondition(9, cf_none, "H5API get ranking complete code", "积分排行榜API", "get ranking complete code {0} {1}", "获得排行榜排名列表请求返回码", "getRankingCode");
AddCondition(10, cf_trigger, "H5API get ranking complete", "积分排行榜API", "get ranking complete", "获得排行榜排名列表请求是否成功", "getRankingComplete");
// -获取当前玩家的排名
AddCmpParam("getMyRankingCode", "请求返回码");
AddNumberParam("code", "需要比较的返回码，数值类型", initial_string = "10000");
AddCondition(11, cf_none, "H5API get my ranking complete code", "积分排行榜API", "get my ranking complete code {0} {1}", "获取当前玩家的排名请求返回码", "getMyRankingCode");
AddCondition(12, cf_trigger, "H5API get my ranking complete", "积分排行榜API", "get my ranking complete", "获取当前玩家的排名请求是否成功", "getMyRankingComplete");
// -获得玩家排名附近的排名列表
AddCmpParam("getNearRankingCode", "请求返回码");
AddNumberParam("code", "需要比较的返回码，数值类型", initial_string = "10000");
AddCondition(13, cf_none, "H5API get near ranking complete code", "积分排行榜API", "get near ranking complete code {0} {1}", "获得玩家排名附近的排名列表请求返回码", "getNearRankingCode");
AddCondition(14, cf_trigger, "H5API get near ranking complete", "积分排行榜API", "get near ranking complete", "获得玩家排名附近的排名列表请求是否成功", "getNearRankingComplete");





////////////////////////////////////////
// Actions

// AddAction(id,				// any positive integer to uniquely identify this action
//			 flags,				// (see docs) af_none, af_deprecated
//			 list_name,			// appears in event wizard list
//			 category,			// category in event wizard list
//			 display_str,		// as appears in event sheet - use {0}, {1} for parameters and also <b></b>, <i></i>
//			 description,		// appears in event wizard dialog when selected
//			 script_name);		// corresponding runtime function name

// example
/*
AddStringParam("Message", "Enter a string to alert.");
AddAction(0, af_none, "Alert", "My category", "Alert {0}", "Description for my action!", "MyAction");
*/

/**
 * 广告API
 */
// -是否可以播放广告及获取剩余次数
AddAction(0, af_none, "H5API canPlayAd", "广告API", "canPlayAd", "获取是否可播放广告", "canPlayAd");
// -播放全屏广告
AddAction(1, af_none, "H5API playAd", "广告API", "playAd", "播放全屏广告", "playAd");

/**
 * 分享API
 */
// -调用分享
AddAction(2, af_none, "H5API share", "分享API", "share", "触发分享功能，将游戏地址分享给好友", "share");
// -是否登录
AddAction(3, af_none, "H5API isLogin", "分享API", "isLogin", "判断用户是否登录", "isLogin");
// -打开用户登录面板
AddAction(4, af_none, "H5API login", "分享API", "login", "没登录就打开登录面板，有登录就返回用户信息", "login");
// -根据用户编号获得用户头像地址
AddNumberParam("编号", "输入用户编号", initial_string = "0");
AddAction(5, af_none, "H5API getUserAvatar", "分享API", "getUserAvatar({0})", "获得用户头像地址", "getUserAvatar");
AddNumberParam("编号", "输入用户编号", initial_string = "0");
AddAction(6, af_none, "H5API getUserSmallAvatar", "分享API", "getUserSmallAvatar({0})", "获得用户小头像地址", "getUserSmallAvatar");
AddNumberParam("编号", "输入用户编号", initial_string = "0");
AddAction(7, af_none, "H5API getUserBigAvatar", "分享API", "getUserBigAvatar({0})", "获得用户大头像地址", "getUserBigAvatar");

/**
 * 积分排行榜API
 */
// -展示排行榜列表面板
AddAction(7, af_none, "H5API showRanking", "积分排行榜API", "showRanking", "展示排行榜列表面板", "showRanking");
// -提交玩家分数到排行榜
AddNumberParam("分数", "玩家分数", initial_string = "0");
AddAction(8, af_none, "H5API submitRanking", "积分排行榜API", "submitRanking({0})", "提交玩家分数到排行榜", "submitRanking");
// -获得排行榜排名列表
AddNumberParam("页码", "页码，从1开始（选填，默认为1）", initial_string = "1");
AddNumberParam("每页条数", "每页条数（选填，默认为10）", initial_string = "10");
AddAction(9, af_none, "H5API getRanking", "积分排行榜API", "getRanking({0},{1})", "获得排行榜排名列表", "getRanking");
// -获取当前玩家的排名
AddAction(10, af_none, "H5API getMyRanking", "积分排行榜API", "getMyRanking", "获取当前玩家的排名", "getMyRanking");
// -获得玩家排名附近的排名列表
AddNumberParam("需要条数", "需要条数（选填，默认为10）", initial_string = "10");
AddAction(11, af_none, "H5API getNearRanking", "积分排行榜API", "getNearRanking({0})", "获得玩家排名附近的排名列表", "getNearRanking");





////////////////////////////////////////
// Expressions

// AddExpression(id,			// any positive integer to uniquely identify this expression
//				 flags,			// (see docs) ef_none, ef_deprecated, ef_return_number, ef_return_string,
//								// ef_return_any, ef_variadic_parameters (one return flag must be specified)
//				 list_name,		// currently ignored, but set as if appeared in event wizard
//				 category,		// category in expressions panel
//				 exp_name,		// the expression name after the dot, e.g. "foo" for "myobject.foo" - also the runtime function name
//				 description);	// description in expressions panel

// example
// AddExpression(0, ef_return_number, "Leet expression", "My category", "MyExpression", "Return the number 1337.");

/**
 * 广告API
 */
// 是否可以播放广告及获取剩余次数
AddExpression(0, ef_return_any, "adRemain", "广告API", "adRemain", "可播放广告剩余次数");
// -播放全屏广告
AddExpression(1, ef_return_string, "adState", "广告API", "adState", "广告播放状态");

/**
 * 分享API
 */
// -是否登录
AddExpression(2, ef_return_string, "isLogin", "分享API", "isLogin", "是否登录");
// -打开用户登录面板
AddExpression(3, ef_return_number, "uId", "分享API", "uId", "用户编号");
AddExpression(4, ef_return_string, "userName", "分享API", "userName", "用户昵称");
// -根据用户编号获得用户头像地址
AddExpression(5, ef_return_string, "userAvatar", "分享API", "userAvatar", "用户头像地址");


/**
 * 积分排行榜API
 */
// -提交玩家分数到排行榜
AddExpression(6, ef_return_any, "historyRank", "积分排行榜API", "historyRank", "提交玩家分数到排行榜成功后返回历史最好排名");
AddExpression(7, ef_return_any, "historyScore", "积分排行榜API", "historyScore", "提交玩家分数到排行榜成功后返回历史最好分数");
// -获得排行榜排名列表
AddExpression(8, ef_return_string, "rankingList", "积分排行榜API", "rankingList", "排行榜排名列表");
// -获取当前玩家的排名
AddExpression(9, ef_return_any, "myRanking", "积分排行榜API", "myRanking", "当前玩家的排名");
// -获得玩家排名附近的排名列表
AddExpression(10, ef_return_string, "nearRanking", "积分排行榜API", "nearRanking", "玩家排名附近的排名列表");





////////////////////////////////////////
ACESDone();

////////////////////////////////////////
// Array of property grid properties for this plugin
// new cr.Property(ept_integer,		name,	initial_value,	description)		// an integer value
// new cr.Property(ept_float,		name,	initial_value,	description)		// a float value
// new cr.Property(ept_text,		name,	initial_value,	description)		// a string
// new cr.Property(ept_color,		name,	initial_value,	description)		// a color dropdown
// new cr.Property(ept_font,		name,	"Arial,-16", 	description)		// a font with the given face name and size
// new cr.Property(ept_combo,		name,	"Item 1",		description, "Item 1|Item 2|Item 3")	// a dropdown list (initial_value is string of initially selected item)
// new cr.Property(ept_link,		name,	link_text,		description, "firstonly")		// has no associated value; simply calls "OnPropertyChanged" on click

var property_list = [];

// Called by IDE when a new object type is to be created
function CreateIDEObjectType() {
	return new IDEObjectType();
}

// Class representing an object type in the IDE
function IDEObjectType() {
	assert2(this instanceof arguments.callee, "Constructor called as a function");
}

// Called by IDE when a new object instance of this type is to be created
IDEObjectType.prototype.CreateInstance = function (instance) {
	return new IDEInstance(instance);
}

// Class representing an individual instance of an object in the IDE
function IDEInstance(instance, type) {
	assert2(this instanceof arguments.callee, "Constructor called as a function");

	// Save the constructor parameters
	this.instance = instance;
	this.type = type;

	// Set the default property values from the property table
	this.properties = {};

	for (var i = 0; i < property_list.length; i++)
		this.properties[property_list[i].name] = property_list[i].initial_value;

	// Plugin-specific variables
	// this.myValue = 0...
}

// Called when inserted via Insert Object Dialog for the first time
IDEInstance.prototype.OnInserted = function () {

}

// Called when double clicked in layout
IDEInstance.prototype.OnDoubleClicked = function () {

}

// Called after a property has been changed in the properties bar
IDEInstance.prototype.OnPropertyChanged = function (property_name) {

}

// For rendered objects to load fonts or textures
IDEInstance.prototype.OnRendererInit = function (renderer) {

}

// Called to draw self in the editor if a layout object
IDEInstance.prototype.Draw = function (renderer) {

}

// For rendered objects to release fonts or textures
IDEInstance.prototype.OnRendererReleased = function (renderer) {

}
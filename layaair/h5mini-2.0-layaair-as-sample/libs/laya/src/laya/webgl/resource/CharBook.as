package laya.webgl.resource {
	import laya.maths.Matrix;
	import laya.renders.Render;
	import laya.resource.Context;
	import laya.resource.Texture;
	import laya.utils.Browser;
	import laya.utils.ColorUtils;
	import laya.utils.FontInfo;
	import laya.utils.HTMLChar;
	import laya.utils.Stat;
	import laya.utils.WordText;
	import laya.webgl.canvas.WebGLContext2D;
	/**
	 * key:font
	 *    下面是各种大小的page
	 * 	   每个大小的page可以有多个
	 */
	public class CharBook {
		//config
		//public static var minTextureWidth:Boolean = true;	//texture不用pot。可以减少一点大小 这个省不了多少，而且不利于重用。
		public static var textureWidth:int = 512;			//缺省大小
		public static var cacheRenderInfoInWordText:Boolean = true;	//在wordtext中缓存解析结果
		public static var scaleFontWithCtx:Boolean = true;		//如果有缩放，则修改字体，以保证清晰度
		public static var gridSize:int = 16;		//格子单位
		public static var debug:Boolean = false; 			//显示调试用边框
		
		//private var fontPages:*= { };	//以font family为key。里面是一个以height为key的page列表
		private var fontPages:Array = [];//用数组方式保存 CharPages, 原来用Object不利于遍历
		private var fontPagesName:Array = [];//上面数组对应的字体名称。
		static public var _curFont:String;	//当前选中的font
		private var _curPage:CharPages;	//当前选中的page
		
		private var tempUV:Array = [0, 0, 1, 0, 1, 1, 0, 1];	//获得文字的纹理坐标用，避免每次都创建对象
		private var tempMat:Matrix = new Matrix();				//用来去掉context的缩放的矩阵
		private var fontScaleX:Number = 1.0;						//临时缩放。
		private var fontScaleY:Number = 1.0;
		private var _curStrPos:int = 0;		//解开一个字符串的时候用的。表示当前解到什么位置了
		private static var _emojiReg:RegExp = /(?:0\u20E3|1\u20E3|2\u20E3|3\u20E3|4\u20E3|5\u20E3|6\u20E3|7\u20E3|8\u20E3|9\u20E3|#\u20E3|\*\u20E3|\uD83C(?:\uDDE6\uD83C(?:\uDDE8|\uDDE9|\uDDEA|\uDDEB|\uDDEC|\uDDEE|\uDDF1|\uDDF2|\uDDF4|\uDDF6|\uDDF7|\uDDF8|\uDDF9|\uDDFA|\uDDFC|\uDDFD|\uDDFF)|\uDDE7\uD83C(?:\uDDE6|\uDDE7|\uDDE9|\uDDEA|\uDDEB|\uDDEC|\uDDED|\uDDEE|\uDDEF|\uDDF1|\uDDF2|\uDDF3|\uDDF4|\uDDF6|\uDDF7|\uDDF8|\uDDF9|\uDDFB|\uDDFC|\uDDFE|\uDDFF)|\uDDE8\uD83C(?:\uDDE6|\uDDE8|\uDDE9|\uDDEB|\uDDEC|\uDDED|\uDDEE|\uDDF0|\uDDF1|\uDDF2|\uDDF3|\uDDF4|\uDDF5|\uDDF7|\uDDFA|\uDDFB|\uDDFC|\uDDFD|\uDDFE|\uDDFF)|\uDDE9\uD83C(?:\uDDEA|\uDDEC|\uDDEF|\uDDF0|\uDDF2|\uDDF4|\uDDFF)|\uDDEA\uD83C(?:\uDDE6|\uDDE8|\uDDEA|\uDDEC|\uDDED|\uDDF7|\uDDF8|\uDDF9|\uDDFA)|\uDDEB\uD83C(?:\uDDEE|\uDDEF|\uDDF0|\uDDF2|\uDDF4|\uDDF7)|\uDDEC\uD83C(?:\uDDE6|\uDDE7|\uDDE9|\uDDEA|\uDDEB|\uDDEC|\uDDED|\uDDEE|\uDDF1|\uDDF2|\uDDF3|\uDDF5|\uDDF6|\uDDF7|\uDDF8|\uDDF9|\uDDFA|\uDDFC|\uDDFE)|\uDDED\uD83C(?:\uDDF0|\uDDF2|\uDDF3|\uDDF7|\uDDF9|\uDDFA)|\uDDEE\uD83C(?:\uDDE8|\uDDE9|\uDDEA|\uDDF1|\uDDF2|\uDDF3|\uDDF4|\uDDF6|\uDDF7|\uDDF8|\uDDF9)|\uDDEF\uD83C(?:\uDDEA|\uDDF2|\uDDF4|\uDDF5)|\uDDF0\uD83C(?:\uDDEA|\uDDEC|\uDDED|\uDDEE|\uDDF2|\uDDF3|\uDDF5|\uDDF7|\uDDFC|\uDDFE|\uDDFF)|\uDDF1\uD83C(?:\uDDE6|\uDDE7|\uDDE8|\uDDEE|\uDDF0|\uDDF7|\uDDF8|\uDDF9|\uDDFA|\uDDFB|\uDDFE)|\uDDF2\uD83C(?:\uDDE6|\uDDE8|\uDDE9|\uDDEA|\uDDEB|\uDDEC|\uDDED|\uDDF0|\uDDF1|\uDDF2|\uDDF3|\uDDF4|\uDDF5|\uDDF6|\uDDF7|\uDDF8|\uDDF9|\uDDFA|\uDDFB|\uDDFC|\uDDFD|\uDDFE|\uDDFF)|\uDDF3\uD83C(?:\uDDE6|\uDDE8|\uDDEA|\uDDEB|\uDDEC|\uDDEE|\uDDF1|\uDDF4|\uDDF5|\uDDF7|\uDDFA|\uDDFF)|\uDDF4\uD83C\uDDF2|\uDDF5\uD83C(?:\uDDE6|\uDDEA|\uDDEB|\uDDEC|\uDDED|\uDDF0|\uDDF1|\uDDF2|\uDDF3|\uDDF7|\uDDF8|\uDDF9|\uDDFC|\uDDFE)|\uDDF6\uD83C\uDDE6|\uDDF7\uD83C(?:\uDDEA|\uDDF4|\uDDF8|\uDDFA|\uDDFC)|\uDDF8\uD83C(?:\uDDE6|\uDDE7|\uDDE8|\uDDE9|\uDDEA|\uDDEC|\uDDED|\uDDEE|\uDDEF|\uDDF0|\uDDF1|\uDDF2|\uDDF3|\uDDF4|\uDDF7|\uDDF8|\uDDF9|\uDDFB|\uDDFD|\uDDFE|\uDDFF)|\uDDF9\uD83C(?:\uDDE6|\uDDE8|\uDDE9|\uDDEB|\uDDEC|\uDDED|\uDDEF|\uDDF0|\uDDF1|\uDDF2|\uDDF3|\uDDF4|\uDDF7|\uDDF9|\uDDFB|\uDDFC|\uDDFF)|\uDDFA\uD83C(?:\uDDE6|\uDDEC|\uDDF2|\uDDF8|\uDDFE|\uDDFF)|\uDDFB\uD83C(?:\uDDE6|\uDDE8|\uDDEA|\uDDEC|\uDDEE|\uDDF3|\uDDFA)|\uDDFC\uD83C(?:\uDDEB|\uDDF8)|\uDDFD\uD83C\uDDF0|\uDDFE\uD83C(?:\uDDEA|\uDDF9)|\uDDFF\uD83C(?:\uDDE6|\uDDF2|\uDDFC)))|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2648-\u2653\u2660\u2663\u2665\u2666\u2668\u267B\u267F\u2692-\u2694\u2696\u2697\u2699\u269B\u269C\u26A0\u26A1\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD79\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED0\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3]|\uD83E[\uDD10-\uDD18\uDD80-\uDD84\uDDC0]/g;
		public static var charbookInst:CharBook = null;	//debug
		public static var _fontMem:int = 0;		//文字本身占用的内存。不考虑map对象
		
		static private var _lastFont:String;
		static private var _lastFontSz:int = 0;
		static private var _lastCharPage:CharPages = null;
		static private var _uint32:Uint32Array = new Uint32Array(1);
		public static var trash:charPageTrash = new charPageTrash(textureWidth);
		public static var isWan1Wan:Boolean = false;
		
		public function CharBook() {
			var bugIOS:Boolean = false;//是否是有bug的ios版本
			//在微信下有时候不显示文字，所以采用canvas模式，现在测试微信好像都好了，所以去掉了。
			var miniadp:* = Laya['MiniAdpter'];
			if ( miniadp && miniadp.systemInfo && miniadp.systemInfo.system) {
				bugIOS = miniadp.systemInfo.system.toLowerCase() === 'ios 10.1.1';
			}
			if (Browser.onMiniGame /*&& !Browser.onAndroid*/ && !bugIOS ) isWan1Wan = true; //android 微信下 字边缘发黑，所以不用getImageData了
			charbookInst = this;
			CharPages.charRender = Render.isConchApp ? (new CharRender_Native()) : (new CharRender_Canvas());
		}
		
		/**
		 * 选择一个合适大小的page。 这里会考虑整体缩放。
		 * @param	fontFamily
		 * @param	fontsize		这个是原始大小，没有缩放的
		 * @return
		 */
		public function selectFont(fontFamily:String, fontsize:int):CharPages {
			var scale:Number = Math.max(fontScaleX, fontScaleY);	//取xy缩放中的大的
			var scaledFontSz:int = fontsize * scale;//取xy缩放中的大的
			var ret:CharPages;
			if (fontFamily === _lastFont && scaledFontSz === _lastFontSz) {
				ret = _lastCharPage;
			} else {
				var sz:int = CharPages.getBmpSize(fontsize) * scale;
				//每级16
				var szid:int = Math.floor(sz / gridSize);
				var key:String = fontFamily + szid;
				var fid:int = fontPagesName.indexOf(key);
				if (fid < 0) {
					var selFontPages:CharPages = new CharPages(fontFamily, sz, Render.isConchApp ? 0 : Math.ceil((fontsize / 4.0)));
					fontPages.push(selFontPages);
					fontPagesName.push(key);
					ret = selFontPages;
				} else {
					ret = fontPages[fid];
				}
				ret.selectSize(fontsize, sz);
				_lastFont = fontFamily;
				_lastFontSz = scaledFontSz;
				_lastCharPage = ret;
			}
			return ret;
		}
		
		public function isEmoji(emoji:String):Boolean {
			return _emojiReg.test(emoji);
		}
		
		/**
		 * 从string中取出一个完整的char，例如emoji的话要多个
		 * 会修改 _curStrPos
		 * TODO 由于各种文字中的组合写法，这个需要能扩展，以便支持泰文等
		 * @param	str
		 * @param	start	开始位置
		 */
		public function getNextChar(str:String):String {
			var len:int = str.length;
			var start:int = _curStrPos;
			if (start >= len)
				return null;
			
			var link:Boolean = false;	//如果是连接的话要再加一个完整字符
			var i:int = start;
			var state:int = 0; //0 初始化 1  正常 2 连续中
			for (; i < len; i++) {
				var c:int = str.charCodeAt(i);
				if ((c>>>11)==0x1b) { //可能是0b110110xx或者0b110111xx。 这都表示2个u16组成一个emoji
					if (state == 0) state = 1;
					else if (state == 1) break;	//新的字符了，要截断
					else {} 	// 连接中，继续
					i++;	//跨过一个。
				}
				else if (c === 0xfe0e || c === 0xfe0f) {	//样式控制字符
					// 继续。不改变状态
				}
				else if (c == 0x200d) {		//zero width joiner
					state = 2; 	// 继续
				}else {
					if (state == 0) state = 1;
					else if (state == 1) break;
					else if (state == 2) {
						// 继续
					}
				}
			}
			_curStrPos = i;
			return str.substring(start, i);
		}
		
		/**
		 * 检查 txts数组中有没有被释放的资源
		 * @param	txts {{ri:CharRenderInfo,...}[][]}
		 * @param	startid
		 * @return
		 */
		//TODO:coverage
		public function hasFreedText(txts:Array, startid:int):Boolean {
			if (txts && txts.length > 0) {
				for (var i:int = startid, sz:int = txts.length; i < sz; i++) {
					var pri:* = txts[i];
					if (!pri) continue;
					for (var j:int = 0, pisz:int = pri.length; j < pisz; j++) {
						var riSaved:CharRenderInfo = (pri[j] as Object).ri;
						if (riSaved.deleted || riSaved.tex.__destroyed) {
							return true;
						}
					}
				}
			}
			return false;
		}
		
		/**
		 * 参数都是直接的，不需要自己再从字符串解析
		 * @param	ctx
		 * @param	data
		 * @param	x
		 * @param	y
		 * @param	fontObj
		 * @param	color
		 * @param	strokeColor
		 * @param	lineWidth
		 * @param	textAlign
		 * @param	underLine
		 */
		public function _fast_filltext(ctx:WebGLContext2D, data:WordText, htmlchars:Vector.<HTMLChar>, x:Number, y:Number, font:FontInfo, color:int, strokeColor:int, lineWidth:int, textAlign:int, underLine:int = 0):void {
			if (data && data.length < 1) return;
			if (htmlchars && htmlchars.length < 1) return;
			
			//var st = PerfHUD.inst.now();
			_curFont = font._font;
			//
			fontScaleX = fontScaleY = 1.0;
			if (scaleFontWithCtx) {
				var sx:Number = ctx.getMatScaleX();// _curMat.getScaleX();
				var sy:Number = ctx.getMatScaleY();// _curMat.getScaleY();
				if (sx < 1e-4 || sy < 1e-1)
					return;
				if (sx > 1) fontScaleX = sx;
				if (sy > 1) fontScaleY = sy;
			}
			
			font._italic && (ctx._italicDeg = 12);
			_curPage = selectFont(font._family, font._size);
			//准备bmp
			//拷贝到texture上,得到一个gltexture和uv
			var curx:Number = x;
			var wt:WordText = data as WordText;
			var str:String = data as String;
			var strWidth:Number = 0;
			var isWT:Boolean = !htmlchars && (data is WordText);
			var isHtmlChar:Boolean = !!htmlchars;
			/**
			 * sameTexData
			 * 为了合并相同贴图的，要根据贴图来分组
			 * 下标是textureid,内容是一个vector，保存的是{isEmoji:Boolean,color:uint,ri:CharRenderInfo,x}
			 */
			var sameTexData:Array = (cacheRenderInfoInWordText && isWT) ? wt.pageChars : [];
			
			//总宽度，下面的对齐需要
			if (isWT) {
				str = wt._text;
				strWidth = wt.width;
				if (strWidth < 0) {
					strWidth = wt.width = _curPage.getWidth(str);
				}
			} else {
				strWidth = _curPage.getWidth(str);
			}
			
			//水平对齐方式
			switch (textAlign) {
			case Context.ENUM_TEXTALIGN_CENTER: 
				curx = x - strWidth / 2;
				break;
			case Context.ENUM_TEXTALIGN_RIGHT: 
				curx = x - strWidth;
				break;
			default: 
				curx = x;
			}
			
			//检查保存的数据是否有的已经被释放了
			if (wt && wt.lastGCCnt != _curPage.gcCnt) {
				wt.lastGCCnt = _curPage.gcCnt;
				if (hasFreedText(sameTexData, wt.startID)) {// || hasFreedText(sameTexDataStroke,wt.startIDStroke))) {
					sameTexData = wt.pageChars = [];
				}
			}
			
			//如果没有中间解析结果，就重新构建
			var startTexID:int = isWT ? wt.startID : 0;
			var startTexIDStroke:int = isWT ? wt.startIDStroke : 0;
			if (!sameTexData || sameTexData.length < 1) {
				var scaleky:String = null;
				if (scaleFontWithCtx) {
					CharPages.charRender.scale(Math.max(fontScaleX, 1.0), Math.max(fontScaleY, 1.0));
					if (fontScaleX > 1.0 || fontScaleY > 1.0)
						scaleky = "" + ((fontScaleX * 10) | 0) + ((fontScaleY * 10) | 0);
				}
				startTexID = -1;
				startTexIDStroke = -1;
				var stx:int = 0;
				var sty:int = 0;
				//直接解析字符串
				_curStrPos = 0;
				var curstr:String;
				if (isHtmlChar) {
					var chc:HTMLChar = htmlchars[_curStrPos++];
					curstr = chc.char;
					stx = chc.x;
					sty = chc.y;
				} else {
					curstr = getNextChar(str);
				}
				var bold:Boolean = font._bold;
				while (curstr) {
					var isEmo:Boolean = isEmoji(curstr);
					var ri:CharRenderInfo;
					ri = _curPage.getChar(curstr, lineWidth, font._size, color, strokeColor, bold, false, scaleky);
					if (!ri) {
						break;
					}
					ri.char = curstr;	//debug
					if (ri.isSpace) {
					} else {
						//分组保存
						var add:Array = sameTexData[ri.tex.id];
						if (!add) {
							sameTexData[ri.tex.id] = add = [];
							if (startTexID < 0 || startTexID > ri.tex.id)
								startTexID = ri.tex.id;
						}
						//不能直接修改ri.bmpWidth, 否则会累积缩放，所以把缩放保存到独立的变量中
						//TODO 现在stroke和文字混到一起了，color已经没法起作用了，所以下面的color其实没用了
						add.push({ri: ri, isEmoji: isEmo, x: stx, y: sty, w: ri.bmpWidth / fontScaleX, h: ri.bmpHeight / fontScaleY});
					}
					if (isHtmlChar) {
						chc = htmlchars[_curStrPos++];
						if (chc) {
							curstr = chc.char;
							stx = chc.x;
							sty = chc.y;
						} else {
							curstr = null;
						}
					} else {
						curstr = getNextChar(str);
						stx += ri.width;
					}
					
				}
				if (isWT) {
					wt.startID = startTexID;
					wt.startIDStroke = startTexIDStroke;
				}
			}
			
			//var lastUseColor:Boolean = ctx._drawTextureUseColor;
			//PerfHUD.drawTexTm += (PerfHUD.inst.now() - st);
			//_drawResortedWords(ctx,curx,sameTexDataStroke,startTexIDStroke,y);
			_drawResortedWords(ctx, curx, sameTexData, startTexID, y);
			//ctx._drawTextureUseColor = lastUseColor;
			ctx._italicDeg = 0;
		}
		
		public function fillWords(ctx:WebGLContext2D, data:Vector.<HTMLChar>, x:Number, y:Number, fontStr:String, color:String, strokeColor:String, lineWidth:int):void {
			if (!data) return;
			if (data.length <= 0) return;
			var nColor:uint = ColorUtils.create(color).numColor;
			var nStrokeColor:uint = strokeColor ? ColorUtils.create(strokeColor).numColor : 0;
			_curFont = fontStr;
			var font:FontInfo = FontInfo.Parse(fontStr);
			_fast_filltext(ctx, null, data, x, y, font, nColor, nStrokeColor, lineWidth, 0, 0);
		}
		
		/**
		 *
		 * TEST
		 * 	emoji: '💗'
		 *  arabic: 'سلام'
		 *  组合: 'ă'
		 *  泰语: 'ฏ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎'
		 *  天城文: 'कि'		 *
		 */
		public function filltext(ctx:WebGLContext2D, data:String, x:Number, y:Number, fontStr:String, color:String, strokeColor:String, lineWidth:int, textAlign:String, underLine:int = 0):void {
			if (data.length <= 0)
				return;
			//以后保存到wordtext中
			var nColor:uint = ColorUtils.create(color).numColor;
			var nStrokeColor:uint = strokeColor ? ColorUtils.create(strokeColor).numColor : 0;
			_curFont = fontStr;
			var font:FontInfo = FontInfo.Parse(fontStr);
			
			var nTextAlign:int = 0;
			switch (textAlign) {
			case 'center': 
				nTextAlign = Context.ENUM_TEXTALIGN_CENTER;
				break;
			case 'right': 
				nTextAlign = Context.ENUM_TEXTALIGN_RIGHT;
				break;
			}
			_fast_filltext(ctx, data as WordText, null, x, y, font, nColor, nStrokeColor, lineWidth, nTextAlign, underLine);
		}
		
		//TODO:coverage
		public function filltext_native(ctx:WebGLContext2D, data:String, htmlchars:Vector.<HTMLChar>, x:Number, y:Number, fontStr:String, color:String, strokeColor:String, lineWidth:int, textAlign:String, underLine:int = 0):void {
			if (data && data.length <= 0)
				return;
			//以后保存到wordtext中
			var nColor:uint = ColorUtils.create(color).numColor;
			var nStrokeColor:uint = strokeColor ? ColorUtils.create(strokeColor).numColor : 0;
			_curFont = fontStr;
			//
			fontScaleX = fontScaleY = 1.0;
			if (scaleFontWithCtx) {
				var sx:Number = ctx._curMat.getScaleX();
				var sy:Number = ctx._curMat.getScaleY();
				if (sx < 1e-4 || sy < 1e-1)
					return;
				fontScaleX = sx;
				fontScaleY = sy;
				CharPages.charRender.scale(fontScaleX, fontScaleY);
			}
			var font:FontInfo = FontInfo.Parse(fontStr);
			var fontFamily:String = font._family;
			var bold:Boolean = font._bold;
			
			if (font._italic) {
				ctx._italicDeg = 12;
			}
			
			_curPage = selectFont(fontFamily, font._size * fontScaleX);
			//准备bmp
			//拷贝到texture上,得到一个gltexture和uv
			var curx:Number = x;
			var wt:WordText = data as WordText;
			var str:String = data;
			var strWidth:Number = 0;
			var isWT:Boolean = !htmlchars && (str is WordText);
			var isHtmlChar:Boolean = !!htmlchars;
			
			/**
			 * sameTexData
			 * 为了合并相同贴图的，要根据贴图来分组
			 * 下标是textureid,内容是一个vector，保存的是{isEmoji:Boolean,color:uint,ri:CharRenderInfo,x}
			 */
			var sameTexData:Array = (cacheRenderInfoInWordText && isWT) ? wt.pageChars : [];
			
			//总宽度，下面的对齐需要
			if (isWT) {
				str = wt.toString();
				strWidth = wt.width;
				if (strWidth < 0) {
					strWidth = wt.width = _curPage.getWidth(str);
				}
			} else {
				strWidth = _curPage.getWidth(str);
			}
			
			//水平对齐方式
			switch (textAlign) {
			case 'center': 
				curx = x - strWidth / 2;
				break;
			case 'right': 
				curx = x - strWidth;
				break;
			default: 
				curx = x;
			}
			
			//检查保存的数据是否有的已经被释放了
			if (sameTexData) {
				var needRebuild:Boolean = false;
				for (var i:int = 0, sz:int = sameTexData.length; i < sz; i++) {
					var pri:* = sameTexData[i];
					if (!pri) continue;
					for (var j:int = 0, pisz:int = pri.length; j < pisz; j++) {
						var riSaved:* = pri[j];
						if (riSaved.ri.tex.__destroyed) {
							needRebuild = true;
							break;
						}
					}
					if (needRebuild) break;
				}
				if (needRebuild)
					sameTexData = wt.pageChars = [];
			}
			
			//如果没有把中间解析结果，就重新构建
			if (!sameTexData || sameTexData.length <= 0) {
				var scaleky:String = null;
				if (scaleFontWithCtx) {
					CharPages.charRender.scale(Math.max(fontScaleX, 1.0), Math.max(fontScaleY, 1.0));
					if (fontScaleX > 1.0 || fontScaleY > 1.0)
						scaleky = "" + ((fontScaleX * 10) | 0) + ((fontScaleY * 10) | 0);
				}
				
				var stx:int = 0;
				var sty:int = 0;
				//直接解析字符串
				_curStrPos = 0;
				var curstr:String;
				if (isHtmlChar) {
					var chc:HTMLChar = htmlchars[_curStrPos++];
					curstr = chc.char;
					stx = chc.x;
					sty = chc.y;
				} else {
					curstr = getNextChar(str);
				}
				bold = font._bold;
				while (curstr) {
					var isEmo:Boolean = isEmoji(curstr);
					var ri:CharRenderInfo;
					ri = _curPage.getChar(curstr, lineWidth, font._size, nColor, nStrokeColor, bold, false, scaleky);
					if (ri.isSpace) {
					} else {
						//分组保存
						var add:Array = sameTexData[ri.tex.id];
						if (!add) {
							sameTexData[ri.tex.id] = add = [];
						}
						add.push({ri: ri, isEmoji: isEmo, x: stx, y: sty, color: color, nColor: nColor});
						
					}
					
					if (isHtmlChar) {
						chc = htmlchars[_curStrPos++];
						if (chc) {
							curstr = chc.char;
							stx = chc.x;
							sty = chc.y;
						} else {
							curstr = null;
						}
					} else {
						stx += ri.width;
						curstr = getNextChar(str);
					}
				}
			}
			
			var lastUseColor:Boolean = ctx._drawTextureUseColor;
			_drawResortedWords_native(ctx, curx, sameTexData, y);
			ctx._drawTextureUseColor = lastUseColor;
			ctx._italicDeg = 0;
		}
		
		/**
		 * 画出重新按照贴图顺序分组的文字。
		 * @param	samePagesData
		 * @param  startx 保存的数据是相对位置，所以需要加上这个便宜，相对位置更灵活一些。
		 * @param y {int} 因为这个只能画在一行上所以没有必要保存y。所以这里再把y传进来
		 */
		protected function _drawResortedWords(ctx:WebGLContext2D, startx:int, samePagesData:Array, startID:int, y:int):void {
			var lastColor:uint = ctx.getFillColor();
			ctx.setFillColor(ctx.mixRGBandAlpha(0xffffff));
			
			startx -= _curPage.margin_left; 	//因为返回的uv是加上margin之后的，所以需要再减去margin才是希望的位置
			y -= _curPage.margin_top;
			
			for (var i:int = startID, sz:int = samePagesData.length; i < sz; i++) {
				var pri:Array = samePagesData[i];
				if (!pri) continue;
				var pisz:int = pri.length;
				if (pisz <= 0) continue;
				//ctx._useNewTex2DSubmit(tex, pisz * 4);
				for (var j:int = 0; j < pisz; j++) {
					var riSaved:* = pri[j];
					var ri:CharRenderInfo = riSaved.ri;
					if (ri.isSpace) continue;
					ri.touch();
					//ctx._drawTexRect(startx + riSaved.x, y + riSaved.y, riSaved.w, riSaved.h, ri.uv);
					//_drawCharRenderInfo(ctx, riSaved.ri, startx + riSaved.x, y + riSaved.y);
					ctx.drawTexAlign = true;
					ctx._drawTextureM(ri.tex.texture as Texture, startx +riSaved.x , y + riSaved.y , riSaved.w, riSaved.h, null, 1.0, ri.uv);
					if ((ctx as Object).touches) {
						(ctx as Object).touches.push(ri);
					}
				}
			}
			ctx.setFillColor(lastColor);
			//不要影响别人
			//ctx._curSubmit._key.other = -1;
		}
		
		//TODO:coverage
		protected function _drawResortedWords_native(ctx:WebGLContext2D, startx:int, samePagesData:Array, y:int):void {
			var lastcolor:uint = 0;
			for (var i:int = 0, sz:int = samePagesData.length; i < sz; i++) {
				var pri:* = samePagesData[i];
				if (!pri) continue;
				for (var j:int = 0, pisz:int = pri.length; j < pisz; j++) {
					var riSaved:* = pri[j];
					var ri:CharRenderInfo = riSaved.ri;
					if (ri.isSpace) continue;
					ctx._drawTextureUseColor = false;
					if (lastcolor != riSaved.nColor) {
						ctx.fillStyle = riSaved.color;
						lastcolor = riSaved.nColor;
					}
					ri.touch();
					_drawCharRenderInfo(ctx, riSaved.ri, startx + riSaved.x, riSaved.y + y);
				}
			}
		}
		
		/**
		 * 画出保存在ri中的文字信息。
		 * @param	ctx
		 * @param	ri
		 * @param	x
		 * @param	y
		 */
		//TODO:coverage
		protected function _drawCharRenderInfo(ctx:WebGLContext2D, ri:CharRenderInfo, x:int, y:int):void {
			//因为返回的uv是加上margin之后的，所以需要再减去margin才是希望的位置。TODO left,top应该是0把
			ctx._drawTextureM(ri.tex.texture as Texture, x - _curPage.margin_left, y - _curPage.margin_top, ri.bmpWidth, ri.bmpHeight, null, 1.0, ri.uv);
			if ((ctx as Object).touches) {
				(ctx as Object).touches.push(ri);
			}
		}
		
		/**
		 * 垃圾回收
		 */
		public function GC():void {
			var i:int = 0, sz:int = fontPages.length;
			if (sz) {
				var curCleanID:int = Stat.loopCount % sz;
				(fontPages[curCleanID] as CharPages).removeLRU();
			}
		}
	}
}

import laya.webgl.resource.CharPageTexture;

/**
 * charPageTexture的缓存管理，反正所有的贴图大小都是一致的，完全可以重复利用。
 */
class charPageTrash {
	private var pool:Array = new Array(10);
	private var poolLen:int = 0;
	private var cleanTm:Number = 0;
	public var texW:int = 0;	//CharPageTexture的宽度
	
	/**
	 *
	 * @param	w 每张贴图的宽高
	 */
	public function charPageTrash(w:int) {
		texW = w;
	}
	
	public function getAPage(gridnum:int):CharPageTexture {
		if (poolLen > 0) {
			var ret:CharPageTexture = pool[--poolLen];
			ret.setGridNum(gridnum);
			if (poolLen > 0)
				clean();	//给个clean的机会。
			return ret;
		}
		//这种情况不需要clean
		return new CharPageTexture(texW, texW, gridnum);
	}
	
	public function discardPage(p:CharPageTexture):void {
		clean();
		if (!p) return;
		p.genID++;		// 用来判断释放
		if (poolLen >= pool.length) {
			pool = pool.concat(new Array(10));
		}
		p.reset();
		pool[poolLen++] = p;
	}
	
	/**
	 * 定期清理
	 * 为了简单，只有发生 getAPage 或者 discardPage的时候才检测是否需要清理
	 */
	private function clean():void {
		var curtm:Number = Laya.stage.getFrameTm();
		if (cleanTm === 0) cleanTm = curtm;
		if (curtm - cleanTm > 30000) {	//每30秒清理一下
			for (var i:int = 0; i < poolLen; i++) {
				var p:CharPageTexture = pool[i];
				if (curtm - p._discardTm > 20000) {//超过20秒没用的删掉
					p.destroy();					//真正删除贴图
					pool[i] = pool[poolLen - 1];
					poolLen--;
					i--;	//这个还要处理，用来抵消i++
				}
			}
			cleanTm = curtm;
		}
	}
}

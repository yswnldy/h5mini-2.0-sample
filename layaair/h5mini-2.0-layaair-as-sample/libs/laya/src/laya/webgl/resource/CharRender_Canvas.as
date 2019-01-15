package laya.webgl.resource { 
	public class CharRender_Canvas extends ICharRender {
		private static var canvas:*= null;// HTMLCanvasElement;
		private static var ctx:*= null;
		private var lastScaleX:Number = 1.0;
		private var lastScaleY:Number = 1.0;
		private var needResetScale:Boolean = false;
		public function  CharRender_Canvas():void {
			if (!canvas) {
				canvas = window.document.createElement('canvas');
				canvas.width = 512;
				canvas.height = 512;
				//这个canvas是用来获取字体渲染结果的。由于不可见canvas的字体不能小于12，所以要加到body上
				//为了避免被发现，设一个在屏幕外的绝对位置。
				canvas.style.left = "-1000px";
				canvas.style.position = "absolute";        
				__JS__("document.body.appendChild(CharRender_Canvas.canvas);");
				ctx = canvas.getContext('2d');
			}
		}
		
		public override function getWidth(str:String):Number {
			if (!ctx) return 0;
			//由于大家公用一个canvas，所以需要在选中的时候做一些配置。
			if(ctx._lastFont!=CharBook._curFont){
				ctx.font = CharBook._curFont;
				ctx._lastFont = CharBook._curFont;
				//console.log('use font ' + font);
			}					
			return ctx.measureText(str).width;
		}
		
		public override function scale(sx:Number, sy:Number):void {
			if (lastScaleX != sx || lastScaleY != sy ) {
				if (needResetScale) {
					ctx.restore();
					lastScaleX = lastScaleY = 1.0;
				}
				
				ctx.save();
				needResetScale = true;
				if( !CharBook.isWan1Wan ){//Wan1wan 自己管理缩放。
					ctx.scale(sx, sy);
				}
				//ctx._lastSX = sx;
				//ctx._lastSY = sy;
				lastScaleX = sx;
				lastScaleY = sy;
			}
		}
		
		/**
		 *TODO stroke 
		 * @param	char
		 * @param	font
		 * @param	cri  修改里面的width。
		 * @return
		 */
		public override function getCharBmp( char:String, font:String, lineWidth:int, colStr:String, strokeColStr:String, cri:CharRenderInfo, margin_left:int, margin_top:int, margin_right:int, margin_bottom:int):ImageData {
			if (CharBook.isWan1Wan)
				return getCharCanvas(char, font, lineWidth, colStr, strokeColStr, cri, margin_left, margin_top, margin_right, margin_bottom);
			//ctx.save();
			//由于大家公用一个canvas，所以需要在选中的时候做一些配置。
			//跟_lastFont比较容易出错，所以比较ctx.font
			if (ctx.font !=font){// ctx._lastFont != font) {	问题：ctx.font=xx 然后ctx==xx可能返回false，例如可能会给自己加"",当字体有空格的时候
				ctx.font = font;
				ctx._lastFont = font;
				//console.log('use font ' + font);
			}			
			
			cri.width = ctx.measureText(char).width;//排版用的width是没有缩放的。后面会用矩阵缩放
			var w:int = cri.width *lastScaleX;//w h 只是clear用的。所以要缩放
			var h:int = cri.height*lastScaleY ;
			w += (margin_left + margin_right)*lastScaleX;
			h += (margin_top + margin_bottom) * lastScaleY;
			w = Math.min(w,CharRender_Canvas.canvas.width);
			h = Math.min(h,CharRender_Canvas.canvas.height);
			
			ctx.clearRect(0,0, w+1, h+1);
			//ctx.textAlign = "end";
			ctx.textBaseline = "top";
			//ctx.translate(CborderSize, CborderSize);
			//ctx.scale(xs, ys);
			if (lineWidth > 0) { 
				ctx.strokeStyle = strokeColStr;
				ctx.lineWidth = lineWidth;
				ctx.strokeText(char, margin_left, margin_top);
			}
			ctx.fillStyle = colStr;
			ctx.fillText(char, margin_left, margin_top);
		
			if ( CharBook.debug) {
				ctx.strokeStyle = '#ff0000';
				ctx.strokeRect(0, 0, w, h);
				ctx.strokeStyle = '#00ff00';
				ctx.strokeRect(margin_left, margin_top, cri.width, cri.height);//原始大小，没有缩放的
			}
			//ctx.restore();
			return ctx.getImageData( 0,0, w|0, h|0 );
		}
		
		public function getCharCanvas( char:String, font:String, lineWidth:int, colStr:String, strokeColStr:String, cri:CharRenderInfo,margin_left:int, margin_top:int, margin_right:int, margin_bottom:int):ImageData {
			//ctx.save();
			//由于大家公用一个canvas，所以需要在选中的时候做一些配置。
			//跟_lastFont比较容易出错，所以比较ctx.font
			if (ctx.font !=font){// ctx._lastFont != font) {	问题：ctx.font=xx 然后ctx==xx可能返回false，例如可能会给自己加"",当字体有空格的时候
				ctx.font = font;
				ctx._lastFont = font;
				//console.log('use font ' + font);
			}			
			
			cri.width = ctx.measureText(char).width;//排版用的width是没有缩放的。后面会用矩阵缩放
			var w:int = cri.width *lastScaleX;//w h 只是clear用的。所以要缩放
			var h:int = cri.height*lastScaleY ;
			w += (margin_left + margin_right)*lastScaleX;
			h += (margin_top + margin_bottom) * lastScaleY;
			w=Math.min(w,CharBook.textureWidth);
			h=Math.min(h,CharBook.textureWidth);
			
			//if (canvas.width != (w + 1) || canvas.height != (h + 1)) {
				canvas.width = Math.min(w + 1, CharBook.textureWidth);
				canvas.height = Math.min(h + 1,CharBook.textureWidth);
				ctx.font = font;
			//}
			needResetScale = false;
			ctx.clearRect(0, 0, w + 1, h + 1);
			ctx.save();
			ctx.translate(margin_left, margin_top);
			if (CharBook.scaleFontWithCtx) {
				//这里的缩放会导致与上面的缩放同时起作用。所以上面保护
				ctx.scale(lastScaleX, lastScaleY);
			}
			ctx.textAlign = "left";
			ctx.textBaseline = "top";
			//ctx.translate(CborderSize, CborderSize);
			//ctx.scale(xs, ys);
			if (lineWidth > 0) { 
				ctx.strokeStyle = strokeColStr;
				ctx.fillStyle = colStr;
				ctx.lineWidth = lineWidth;
				//ctx.strokeText(char, margin_left, margin_top);
				ctx.strokeText(char, 0, 0);
				ctx.fillText(char, 0, 0);
			} else {
				ctx.fillStyle = colStr;
				ctx.fillText(char, 0, 0);
			}
			if ( CharBook.debug) {
				ctx.strokeStyle = '#ff0000';
				ctx.strokeRect(0, 0, w, h);
				ctx.strokeStyle = '#00ff00';
				ctx.strokeRect(0, 0, cri.width, cri.height);//原始大小，没有缩放的
			}
			ctx.restore();
			return canvas;
		}
	}
}
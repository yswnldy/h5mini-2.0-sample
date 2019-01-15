package laya.physics {
	
	/**
	 * 2D矩形碰撞体
	 */
	public class BoxCollider extends ColliderBase {
		/**@private */
		private static var _temp:*;
		/**相对节点的x轴偏移*/
		private var _x:Number = 0;
		/**相对节点的y轴偏移*/
		private var _y:Number = 0;
		/**矩形宽度*/
		private var _width:Number = 100;
		/**矩形高度*/
		private var _height:Number = 100;
		
		override protected function getDef():* {
			if (!_shape) {
				_shape = _temp || (_temp = new window.box2d.b2PolygonShape());
				_setShape(false);
			}
			this.label = (this.label || "BoxCollider");
			return super.getDef();
		}
		
		private function _setShape(re:Boolean = true):void {
			_shape.SetAsBox(_width / 2 / Physics.PIXEL_RATIO, _height / 2 / Physics.PIXEL_RATIO, new window.box2d.b2Vec2((_width / 2 + _x) / Physics.PIXEL_RATIO, (_height / 2 + _y) / Physics.PIXEL_RATIO));
			if (re) refresh();
		}
		
		/**相对节点的x轴偏移*/
		public function get x():Number {
			return _x;
		}
		
		public function set x(value:Number):void {
			_x = value;
			if (_shape) _setShape();
		}
		
		/**相对节点的y轴偏移*/
		public function get y():Number {
			return _y;
		}
		
		public function set y(value:Number):void {
			_y = value;
			if (_shape) _setShape();
		}
		
		/**矩形宽度*/
		public function get width():Number {
			return _width;
		}
		
		public function set width(value:Number):void {
			if (value <= 0) throw "BoxCollider size cannot be less than 0";
			_width = value;
			if (_shape) _setShape();
		}
		
		/**矩形高度*/
		public function get height():Number {
			return _height;
		}
		
		public function set height(value:Number):void {
			if (value <= 0) throw "BoxCollider size cannot be less than 0";
			_height = value;
			if (_shape) _setShape();
		}
	}
}
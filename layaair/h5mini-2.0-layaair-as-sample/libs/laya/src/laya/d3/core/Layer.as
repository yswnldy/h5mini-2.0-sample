package laya.d3.core {
	import laya.d3.core.scene.Scene3D;
	
	/**
	 * @private
	 * <code>Layer</code> 类用于实现层。
	 */
	public class Layer {
		/** @private */
		public static const maxCount:int = 31;//JS中为动态位数，32或64还有符号位，所有暂时使用31
		
		/** @private */
		public var _number:int;
		/** @private */
		private var _scene:Scene3D;
		
		/** @private 蒙版值。*/
		public var _mask:int;
		
		/**名字。*/
		public var name:String;
		
		/**
		 *获取编号。
		 * @return 编号。
		 */
		public function get number():int {
			return _number;
		}
		
		/**
		 * 创建一个 <code>Layer</code> 实例。
		 */
		public function Layer(scene:Scene3D) {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			_scene = scene;
		}
	
	}
}
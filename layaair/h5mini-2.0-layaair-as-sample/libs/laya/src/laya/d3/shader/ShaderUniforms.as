package laya.d3.shader {
	
	/**
	 * @private
	 */
	public class ShaderUniforms {
		/**@private */
		private var _counter:int;
		
		/**
		 * @private
		 */
		public function get count():int {
			return _counter;
		}
		
		/**
		 * @private
		 */
		public function ShaderUniforms(superDefines:ShaderUniforms = null) {
			if (superDefines) {
				_counter = superDefines._counter;
			} else {
				_counter = 0;
			}
		}
		
		/**
		 * @private
		 */
		public function registerUniform():int {
			return _counter++;
		}
	}

}
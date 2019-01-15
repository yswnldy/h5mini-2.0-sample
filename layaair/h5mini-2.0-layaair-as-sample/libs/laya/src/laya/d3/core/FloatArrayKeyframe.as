package laya.d3.core {
	
	/**
	 * <code>KeyFrame</code> 类用于创建浮点数组关键帧实例。
	 */
	public class FloatArrayKeyframe extends Keyframe {
		public var inTangent:Float32Array;
		public var outTangent:Float32Array;
		public var value:Float32Array;
		
		/**
		 * 创建一个 <code>FloatArrayKeyFrame</code> 实例。
		 */
		public function FloatArrayKeyframe() {
		/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
		}
		
		/**
		 * 克隆。
		 * @param	destObject 克隆源。
		 */
		override public function cloneTo(destObject:*):void {
			super.cloneTo(destObject);
			var destKeyFrame:FloatArrayKeyframe = destObject as FloatArrayKeyframe;
			destKeyFrame.inTangent = inTangent.slice() as Float32Array;
			destKeyFrame.outTangent = outTangent.slice() as Float32Array;
			destKeyFrame.value = value.slice() as Float32Array;
		}
	}

}
package laya.d3.core.render {
	import laya.d3.core.BaseCamera;
	import laya.d3.core.GeometryElement;
	import laya.d3.core.Transform3D;
	import laya.d3.core.material.BaseMaterial;
	import laya.d3.core.material.RenderState;
	import laya.d3.core.scene.Scene3D;
	import laya.d3.shader.Shader3D;
	import laya.d3.shader.ShaderInstance;
	import laya.d3.shader.ShaderPass;
	import laya.utils.Stat;
	
	/**
	 * @private
	 * <code>RenderQuene</code> 类用于实现渲染队列。
	 */
	public class RenderQueue {
		/** @private [只读]*/
		public var isTransparent:Boolean;
		/** @private */
		public var elements:Array;
		/** @private */
		public var lastTransparentRenderElement:RenderElement;
		/** @private */
		public var lastTransparentBatched:Boolean;
		
		/**
		 * 创建一个 <code>RenderQuene</code> 实例。
		 */
		public function RenderQueue(isTransparent:Boolean = false) {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			this.isTransparent = isTransparent;
			elements = [];
		}
		
		/**
		 * @private
		 */
		private function _compare(left:RenderElement, right:RenderElement):int {
			var renderQueue:int = left.material.renderQueue - right.material.renderQueue;
			if (renderQueue === 0) {
				var sort:int = isTransparent ? right.render._distanceForSort - left.render._distanceForSort : left.render._distanceForSort - right.render._distanceForSort;
				return sort + left.render.sortingFudge - right.render.sortingFudge;
			} else {
				return renderQueue;
			}
		}
		
		/**
		 * @private
		 */
		private function _partitionRenderObject(left:int, right:int):int {
			var pivot:RenderElement = elements[Math.floor((right + left) / 2)];
			while (left <= right) {
				while (_compare(elements[left], pivot) < 0)
					left++;
				while (_compare(elements[right], pivot) > 0)
					right--;
				if (left < right) {
					var temp:RenderElement = elements[left];
					elements[left] = elements[right];
					elements[right] = temp;
					left++;
					right--;
				} else if (left === right) {
					left++;
					break;
				}
			}
			return left;
		}
		
		/**
		 * @private
		 */
		public function _quickSort(left:int, right:int):void {
			if (elements.length > 1) {
				var index:int = _partitionRenderObject(left, right);
				var leftIndex:int = index - 1;
				if (left < leftIndex)
					_quickSort(left, leftIndex);
				
				if (index < right)
					_quickSort(index, right);
			}
		}
		
		/**
		 * @private
		 * 渲染队列。
		 * @param	state 渲染状态。
		 */
		public function _render(context:RenderContext3D, isTarget:Boolean, customShader:Shader3D = null):void {
			var lastStateRenderState:RenderState, lastStateRender:BaseRender;
			var loopCount:int = Stat.loopCount;
			var scene:Scene3D = context.scene;
			var camera:BaseCamera = context.camera;
			for (var i:int = 0, n:int = elements.length; i < n; i++) {
				var element:RenderElement = elements[i];
				var transform:Transform3D = element._transform;
				var render:BaseRender = element.render;
				var geometry:GeometryElement = element._geometry;
				var material:BaseMaterial = element.material;
				context.renderElement = element;
				
				if (loopCount !== render._updateLoopCount) {//此处处理更新为裁剪和合并后的，可避免浪费
					render._renderUpdate(context, transform);
					render._renderUpdateWithCamera(context, transform);
					render._updateLoopCount = loopCount;
					render._updateCamera = camera;
				} else if (camera !== render._updateCamera) {
					render._renderUpdateWithCamera(context, transform);
					render._updateCamera = camera;
				}
				
				if (geometry._prepareRender(context)) {
					var renderStates:Vector.<RenderState> = material._renderStates;
					var passes:Vector.<ShaderPass> = (customShader || material._shader)._passes;
					for (var j:int = 0, m:int = passes.length; j < m; j++) {
						var shader:ShaderInstance = context.shader = passes[j].withCompile((scene._defineDatas.value) & (~material._disablePublicDefineDatas.value), render._defineDatas.value, material._defineDatas.value);
						var switchShader:Boolean = shader.bind();//纹理需要切换shader时重新绑定 其他uniform不需要
						var switchShaderLoop:Boolean = (loopCount !== shader._uploadLoopCount);
						
						var uploadScene:Boolean = (shader._uploadScene !== scene) || switchShaderLoop;
						if (uploadScene || switchShader) {
							shader.uploadUniforms(shader._sceneUniformParamsMap, scene._shaderValues, uploadScene);
							shader._uploadScene = scene;
						}
						
						var switchCamera:Boolean = shader._uploadCamera !== camera;
						var uploadSprite3D:Boolean = (switchCamera || shader._uploadRender !== render) || switchShaderLoop;
						if (uploadSprite3D || switchShader) {
							shader.uploadUniforms(shader._spriteUniformParamsMap, render._shaderValues, uploadSprite3D);
							shader._uploadRender = render;
						}
						
						var uploadCamera:Boolean = switchCamera || switchShaderLoop;
						if (uploadCamera || switchShader) {
							shader.uploadUniforms(shader._cameraUniformParamsMap, camera._shaderValues, uploadCamera);
							shader._uploadCamera = camera;
						}
						
						var uploadMaterial:Boolean = (shader._uploadMaterial !== material) || switchShaderLoop;
						if (uploadMaterial || switchShader) {
							shader.uploadUniforms(shader._materialUniformParamsMap, material._shaderValues, uploadMaterial);
							shader._uploadMaterial = material;
						}
						
						var renderState:RenderState = renderStates[j];
						if (lastStateRenderState !== renderState) {//lastStateMaterial,lastStateOwner存到全局，多摄像机还可优化
							renderState._setRenderStateBlendDepth();
							renderState._setRenderStateFrontFace(isTarget, transform);
							lastStateRenderState = renderState;
							lastStateRender = render;
						} else {
							if (lastStateRender !== render) {//TODO:是否可以用transfrom
								renderState._setRenderStateFrontFace(isTarget, transform);
								lastStateRender = render;
							}
						}
						(geometry._bufferState) && (geometry._bufferState.bind());//TODO:临时处理
						geometry._render(context);
						shader._uploadLoopCount = loopCount;
					}
				}
			}
		}
		
		/**
		 * @private
		 */
		public function clear():void {
			elements.length = 0;
			lastTransparentRenderElement = null;
			lastTransparentBatched = false;
		}
	}
}
package laya.d3.resource.models {
	import laya.d3.core.GeometryElement;
	import laya.d3.core.render.RenderContext3D;
	import laya.d3.graphics.IndexBuffer3D;
	import laya.d3.graphics.VertexBuffer3D;
	import laya.layagl.LayaGL;
	import laya.utils.Stat;
	import laya.webgl.WebGL;
	import laya.webgl.WebGLContext;
	
	/**
	 * @private
	 * <code>primitiveGeometry</code> 类用于实现简单几何体。
	 */
	public class primitiveGeometry extends GeometryElement {
		/**@private */
		public var _vertexBuffer:VertexBuffer3D;
		/**@private */
		public var _indexBuffer:IndexBuffer3D;
		
		/**
		 * 创建一个 <code>primitiveGeometry</code> 实例。
		 */
		public function primitiveGeometry() {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _render(state:RenderContext3D):void {
			var count:int = _indexBuffer.indexCount;
			LayaGL.instance.drawElements(WebGLContext.TRIANGLES, count, WebGLContext.UNSIGNED_SHORT, 0);
			Stat.drawCall++;
			Stat.trianglesFaces += count / 3;
		}
	
	}

}
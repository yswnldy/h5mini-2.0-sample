package laya.d3.resource.models {
	import laya.d3.graphics.IndexBuffer3D;
	import laya.d3.graphics.VertexBuffer3D;
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.Vertex.VertexPositionNormalTexture;
	import laya.webgl.WebGLContext;
	
	/**
	 * <code>QuadMesh</code> 类用于创建四边形。
	 */
	public class QuadMesh extends PrimitiveMesh {
		/** @private */
		private var _long:Number;
		/** @private */
		private var _width:Number;
		
		/**
		 * 返回长度
		 * @return 长
		 */
		public function get long():Number {
			return _long;
		}
		
		/**
		 * 设置长度（改变此属性会重新生成顶点和索引）
		 * @param  value 长度
		 */
		public function set long(value:Number):void {
			if (_long !== value) {
				_long = value;
				releaseResource();
				_create();
			}
		}
		
		/**
		 * 返回宽度
		 * @return 宽
		 */
		public function get width():Number {
			return _width;
		}
		
		/**
		 * 设置宽度（改变此属性会重新生成顶点和索引）
		 * @param  value 宽度
		 */
		public function set width(value:Number):void {
			if (_width !== value) {
				_width = value;
				releaseResource();
				_create();
			}
		}
		
		/**
		 * 创建一个四边形模型
		 * @param long  长
		 * @param width 宽
		 */
		public function QuadMesh(long:Number = 1, width:Number = 1) {
			super();
			_long = long;
			_width = width;
			_create();
		}
		
		/**
		 * @private
		 */
		private function _create():void {
			const vertexCount:int = 4;
			const indexCount:int = 6;
			//定义顶点数据结构
			var vertexDeclaration:VertexDeclaration = VertexPositionNormalTexture.vertexDeclaration;
			//单个顶点数据个数,总共字节数/单个字节数
			var vertexFloatStride:int = vertexDeclaration.vertexStride / 4;
			
			var halfLong:Number = _long / 2;
			var halfWidth:Number = _width / 2;
			
			var vertices:Float32Array = new Float32Array([
			
			-halfLong, halfWidth, 0, 0, 0, 1, 0, 0, halfLong, halfWidth, 0, 0, 0, 1, 1, 0, -halfLong, -halfWidth, 0, 0, 0, 1, 0, 1, halfLong, -halfWidth, 0, 0, 0, 1, 1, 1,]);
			
			var indices:Uint16Array = new Uint16Array([
			
			0, 1, 2, 3, 2, 1,]);
			
			setData(vertexDeclaration, vertices, indices);
		}
	
	}

}

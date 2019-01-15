package laya.d3.graphics {
	import laya.d3.graphics.Vertex.VertexMesh;
	import laya.d3.shader.DefineDatas;
	import laya.d3.shader.Shader3D;
	import laya.renders.Render;
	import laya.d3.shader.ShaderData;
	import laya.webgl.WebGLContext;
	
	/**
	 * @private
	 * <code>VertexDeclaration</code> 类用于生成顶点声明。
	 */
	public class VertexDeclaration {
		/**@private */
		private static var _uniqueIDCounter:int = 1;
		/**
		 * @private
		 */
		private static function _getTypeSize(format:String):int {
			switch (format) {
			case VertexElementFormat.Single: 
				return 4;
			case VertexElementFormat.Vector2: 
				return 8;
			case VertexElementFormat.Vector3: 
				return 12;
			case VertexElementFormat.Vector4: 
				return 16;
			case VertexElementFormat.Color: 
				return 4;
			case VertexElementFormat.Byte4: 
				return 4;
			case VertexElementFormat.Short2: 
				return 4;
			case VertexElementFormat.Short4: 
				return 8;
			case VertexElementFormat.NormalizedShort2: 
				return 4;
			case VertexElementFormat.NormalizedShort4: 
				return 8;
			case VertexElementFormat.HalfVector2: 
				return 4;
			case VertexElementFormat.HalfVector4: 
				return 8;
			}
			return 0;
		}
		
		/**@private */
		private var _id:int;
		/**@private */
		private var _vertexStride:int;
		/**@private */
		private var _vertexElementsDic:Object;
		/**@private */
		public var _shaderValues:ShaderData;
		/**@private */
		public var _defineDatas:DefineDatas;
		
		/**@private [只读]*/
		public var vertexElements:Array;
		
		/**
		 * 获取唯一标识ID(通常用于优化或识别)。
		 * @return 唯一标识ID
		 */
		public function get id():int {
			return _id;
		}
		
		/**
		 * @private
		 */
		public function get vertexStride():int {
			return _vertexStride;
		}
		
		/**
		 * 创建一个 <code>VertexDeclaration</code> 实例。
		 * @param	vertexStride 顶点跨度。
		 * @param	vertexElements 顶点元素集合。
		 */
		public function VertexDeclaration(vertexStride:int, vertexElements:Array) {
			_id = ++_uniqueIDCounter;
			_defineDatas = new DefineDatas();
			_vertexElementsDic = {};
			_vertexStride = vertexStride;
			this.vertexElements = vertexElements;
			var count:int = vertexElements.length;
			var maxLength:int = 0;
			for (var i:int = 0; i < count; i++)
				maxLength = Math.max(maxLength, vertexElements[i].elementUsage);
			_shaderValues = new ShaderData(null, maxLength + 1);
			
			for (var j:int = 0; j < count; j++) {
				var vertexElement:VertexElement = vertexElements[j];
				var name:int = vertexElement.elementUsage;
				_vertexElementsDic[name] = vertexElement;
				var value:Int32Array = new Int32Array(5);
				value[0] = _getTypeSize(vertexElement.elementFormat) / 4;
				value[1] = WebGLContext.FLOAT;
				value[2] = 0;//false
				value[3] = _vertexStride;
				value[4] = vertexElement.offset;
				
				_shaderValues.setAttribute(name, value);
			}
		}
		
		/**
		 * @private
		 */
		public function getVertexElementByUsage(usage:int):VertexElement {
			return _vertexElementsDic[usage];
		}
		
		/**
		 * @private
		 */
		public function unBinding():void {
		
		}
	
	}

}
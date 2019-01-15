package laya.d3.graphics {
	import laya.renders.Render;
	import laya.layagl.LayaGL;
	import laya.webgl.WebGL;
	import laya.webgl.WebGLContext;
	import laya.webgl.utils.Buffer;
	
	/**
	 * <code>VertexBuffer3D</code> 类用于创建顶点缓冲。
	 */
	public class VertexBuffer3D extends Buffer {
		/** @private */
		private var _vertexCount:int;
		/** @private */
		private var _canRead:Boolean;
		
		/** @private */
		public var _vertexDeclaration:VertexDeclaration;
		
		/**
		 * 获取顶点声明。
		 */
		public function get vertexDeclaration():VertexDeclaration {
			return _vertexDeclaration;
		}
		
		/**
		 * 获取顶点声明。
		 */
		public function set vertexDeclaration(value:VertexDeclaration):void {
			if (_vertexDeclaration !== value) {
				_vertexDeclaration = value;
				_vertexCount = value ? _byteLength / value.vertexStride : -1;
			}
		}
		
		/**
		 * 获取顶点个数。
		 *   @return	顶点个数。
		 */
		public function get vertexCount():int {
			return _vertexCount;
		}
		
		/**
		 * 获取是否可读。
		 *   @return	是否可读。
		 */
		public function get canRead():Boolean {
			return _canRead;
		}
		
		/**
		 * 创建一个 <code>VertexBuffer3D,不建议开发者使用并用VertexBuffer3D.create()代替</code> 实例。
		 * @param	vertexCount 顶点个数。
		 * @param	bufferUsage VertexBuffer3D用途类型。
		 * @param	canRead 是否可读。
		 */
		public function VertexBuffer3D(byteLength:int, bufferUsage:int, canRead:Boolean = false) {
			super();
			_vertexCount = -1;
			_bufferUsage = bufferUsage;
			_bufferType = WebGLContext.ARRAY_BUFFER;
			_canRead = canRead;
			
			_byteLength = byteLength;
			_setGPUMemory(byteLength);
			bind();
			LayaGL.instance.bufferData(_bufferType, _byteLength, _bufferUsage);
			canRead && (_buffer = new Float32Array(_byteLength / 4));
			_activeResource();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function bind():Boolean {
			if (_bindedVertexBuffer !== _glBuffer) {
				LayaGL.instance.bindBuffer(WebGLContext.ARRAY_BUFFER, _glBuffer);
				_bindedVertexBuffer = _glBuffer;
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * 设置数据。
		 * @param	data 顶点数据。
		 * @param	bufferOffset 顶点缓冲中的偏移。
		 * @param	dataStartIndex 顶点数据的偏移。
		 * @param	dataCount 顶点数据的数量。
		 */
		public function setData(data:Float32Array, bufferOffset:int = 0, dataStartIndex:int = 0, dataCount:uint = 4294967295/*uint.MAX_VALUE*/):void {
			if (dataStartIndex !== 0 || dataCount !== 4294967295/*uint.MAX_VALUE*/)
				data = new Float32Array(data.buffer, dataStartIndex * 4, dataCount);
			
			bind();
			LayaGL.instance.bufferSubData(_bufferType, bufferOffset * 4, data);
			
			if (_canRead) {
				if (bufferOffset !== 0 || dataStartIndex !== 0 || dataCount !== 4294967295/*uint.MAX_VALUE*/) {
					var maxLength:int = _buffer.length - bufferOffset;
					if (dataCount > maxLength)
						dataCount = maxLength;
					for (var i:int = 0; i < dataCount; i++)
						_buffer[bufferOffset + i] = data[i];
				} else {
					_buffer = data;
				}
			}
		}
		
		/**
		 * 获取顶点数据。
		 *   @return	顶点数据。
		 */
		public function getData():Float32Array {
			if (_canRead)
				return _buffer;
			else
				throw new Error("Can't read data from VertexBuffer with only write flag!");
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function _disposeResource():void {
			super._disposeResource();
			_buffer = null;
			_vertexDeclaration = null;
			_setGPUMemory(0);
		}
	}

}


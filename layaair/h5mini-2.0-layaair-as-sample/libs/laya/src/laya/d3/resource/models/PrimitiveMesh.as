package laya.d3.resource.models {
	import laya.d3.core.BufferState;
	import laya.d3.core.GeometryElement;
	import laya.d3.graphics.IndexBuffer3D;
	import laya.d3.graphics.Vertex.VertexMesh;
	import laya.d3.graphics.VertexBuffer3D;
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.VertexElement;
	import laya.d3.graphics.VertexElementFormat;
	import laya.d3.math.Vector3;
	import laya.webgl.WebGLContext;
	
	/**
	 * <code>PrimitiveMesh</code> 类用于创建简单网格。
	 */
	public class PrimitiveMesh extends BaseMesh {
		/** @private */
		public var _primitveGeometry:primitiveGeometry;
		
		/**
		 * 创建一个 <code>PrimitiveMesh</code> 实例。
		 */
		public function PrimitiveMesh() {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			super();
			_subMeshCount = 1;
			_primitveGeometry = new primitiveGeometry();
		}
		
		/**
		 * 获取网格顶点
		 * @return 网格顶点。
		 */
		override public function _getPositions():Vector.<Vector3> {
			var vertexBuffer:VertexBuffer3D = _primitveGeometry._vertexBuffer;
			var vertices:Vector.<Vector3> = new Vector.<Vector3>();
			
			var positionElement:VertexElement;
			var vertexElements:Array = vertexBuffer.vertexDeclaration.vertexElements;
			var j:int;
			for (j = 0; j < vertexElements.length; j++) {
				var vertexElement:VertexElement = vertexElements[j];
				if (vertexElement.elementFormat === VertexElementFormat.Vector3 && vertexElement.elementUsage === VertexMesh.MESH_POSITION0) {
					positionElement = vertexElement;
					break;
				}
			}
			
			var verticesData:Float32Array = vertexBuffer.getData();
			for (j = 0; j < verticesData.length; j += vertexBuffer.vertexDeclaration.vertexStride / 4) {
				var ofset:int = j + positionElement.offset / 4;
				var position:Vector3 = new Vector3(verticesData[ofset + 0], verticesData[ofset + 1], verticesData[ofset + 2]);
				vertices.push(position);
			}
			
			return vertices;
		}
		
		/**
		 * @private
		 */
		override public function _getSubMesh(index:int):GeometryElement {
			return (index === 0) ? _primitveGeometry : null;
		}
		
		/**
		 * 设置几何体数据。
		 * @param	vertexDeclaration 顶点声明。
		 * @param	vertices	顶点数据。
		 * @param	indices		多音数据。
		 */
		public function setData(vertexDeclaration:VertexDeclaration, vertices:Float32Array, indices:Uint16Array):void {
			(released) || (releaseResource());
			var vertexBuffer:VertexBuffer3D = new VertexBuffer3D(vertices.length * 4, WebGLContext.STATIC_DRAW, true);
			vertexBuffer.vertexDeclaration = vertexDeclaration;
			vertexBuffer.setData(vertices);
			var indexBuffer:IndexBuffer3D = new IndexBuffer3D(IndexBuffer3D.INDEXTYPE_USHORT, indices.length, WebGLContext.STATIC_DRAW, true);
			indexBuffer.setData(indices);
			
			var bufferState:BufferState = new BufferState();
			bufferState.bind();
			bufferState.applyVertexBuffer(vertexBuffer);
			bufferState.applyIndexBuffer(indexBuffer);
			bufferState.unBind();
			_primitveGeometry._applyBufferState(bufferState);
			_primitveGeometry._vertexBuffer = vertexBuffer;
			_primitveGeometry._indexBuffer = indexBuffer;
			_setGPUMemory((vertexBuffer._byteLength + indexBuffer._byteLength) * 2);//修改占用内存,upload()到GPU后CPU中和GPU中各占一份内存
			_activeResource();
			_positions = _getPositions();
			_generateBoundingObject();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function _disposeResource():void {
			_primitveGeometry.destroy();
			_setGPUMemory(0);
		}
	}
}
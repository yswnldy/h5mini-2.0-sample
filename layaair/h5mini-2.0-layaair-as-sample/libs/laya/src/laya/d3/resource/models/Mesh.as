package laya.d3.resource.models {
	import laya.d3.core.GeometryElement;
	import laya.d3.graphics.IndexBuffer3D;
	import laya.d3.graphics.Vertex.VertexMesh;
	import laya.d3.graphics.VertexBuffer3D;
	import laya.d3.graphics.VertexElement;
	import laya.d3.graphics.VertexElementFormat;
	import laya.d3.loaders.MeshReader;
	import laya.d3.math.Matrix4x4;
	import laya.d3.math.Vector3;
	import laya.d3.utils.Utils3D;
	import laya.utils.Handler;
	
	/**
	 * <code>Mesh</code> 类用于创建文件网格数据模板。
	 */
	public class Mesh extends BaseMesh {
		/** @private */
		private static var _nativeTempVector30:* = new Laya3D._physics3D.btVector3(0, 0, 0);
		/** @private */
		private static var _nativeTempVector31:* = new Laya3D._physics3D.btVector3(0, 0, 0);
		/** @private */
		private static var _nativeTempVector32:* = new Laya3D._physics3D.btVector3(0, 0, 0);
		
		/**
		 *@private
		 */
		public static function _parse(data:*, propertyParams:Object = null, constructParams:Array = null):Mesh {
			var mesh:Mesh = new Mesh();
			MeshReader.read(data as ArrayBuffer, mesh, mesh._subMeshes);
			return mesh;
		}
		
		/**
		 * 加载网格模板。
		 * @param url 模板地址。
		 * @param complete 完成回掉。
		 */
		public static function load(url:String, complete:Handler):void {
			Laya.loader.create(url, complete, null, Laya3D.MESH);
		}
		
		/** @private */
		private var _nativeTriangleMesh:*;
		
		/** @private */
		public var _subMeshes:Vector.<SubMesh>;
		/** @private */
		public var _vertexBuffers:Vector.<VertexBuffer3D>;
		/** @private */
		public var _indexBuffer:IndexBuffer3D;
		/** @private */
		public var _boneNames:Vector.<String>;
		/** @private */
		public var _inverseBindPoses:Vector.<Matrix4x4>;
		/** @private */
		public var _inverseBindPosesBuffer:ArrayBuffer;//TODO:[NATIVE]临时
		/** @private */
		public var _bindPoseIndices:Uint16Array;
		/** @private */
		public var _skinDataPathMarks:Vector.<Array>;
		/** @private */
		public var _vertexCount:int = 0;
		
		/**
		 * 获取网格的全局默认绑定动作逆矩阵。
		 * @return  网格的全局默认绑定动作逆矩阵。
		 */
		public function get inverseAbsoluteBindPoses():Vector.<Matrix4x4> {
			return _inverseBindPoses;
		}
		
		/**
		 * 获取顶点个数
		 */
		public function get vertexCount():int {
			return _vertexCount;
		}
		
		/**
		 * 创建一个 <code>Mesh</code> 实例,禁止使用。
		 * @param url 文件地址。
		 */
		public function Mesh() {
			super();
			_subMeshes = new Vector.<SubMesh>();
			_vertexBuffers = new Vector.<VertexBuffer3D>();
			_skinDataPathMarks = new Vector.<Array>();
		}
		
		/**
		 * 获取网格顶点，并产生数据
		 * @return 网格顶点。
		 */
		override public function _getPositions():Vector.<Vector3> {
			var vertices:Vector.<Vector3> = new Vector.<Vector3>();
			var i:int, j:int, vertexBuffer:VertexBuffer3D, positionElement:VertexElement, vertexElements:Array, vertexElement:VertexElement, ofset:int, verticesData:Float32Array;
			var vertexBufferCount:int = _vertexBuffers.length;
			for (i = 0; i < vertexBufferCount; i++) {
				vertexBuffer = _vertexBuffers[i];
				
				vertexElements = vertexBuffer.vertexDeclaration.vertexElements;
				for (j = 0; j < vertexElements.length; j++) {
					vertexElement = vertexElements[j];
					if (vertexElement.elementFormat === VertexElementFormat.Vector3 && vertexElement.elementUsage === VertexMesh.MESH_POSITION0) {
						positionElement = vertexElement;
						break;
					}
				}
				
				verticesData = vertexBuffer.getData();
				for (j = 0; j < verticesData.length; j += vertexBuffer.vertexDeclaration.vertexStride / 4) {
					ofset = j + positionElement.offset / 4;
					vertices.push(new Vector3(verticesData[ofset + 0], verticesData[ofset + 1], verticesData[ofset + 2]));
				}
			}
			return vertices;
		}
		
		/**
		 *@private
		 */
		public function _setSubMeshes(subMeshes:Vector.<SubMesh>):void {
			_subMeshes = subMeshes
			_subMeshCount = subMeshes.length;
			
			for (var i:int = 0; i < _subMeshCount; i++)
				subMeshes[i]._indexInMesh = i;
			_positions = _getPositions();
			_generateBoundingObject();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function _getSubMesh(index:int):GeometryElement {
			return _subMeshes[index];
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function _disposeResource():void {
			for (var i:int = 0; i < _subMeshes.length; i++)
				_subMeshes[i].dispose();
			_nativeTriangleMesh && Laya3D._physics3D.destroy(_nativeTriangleMesh);
			_indexBuffer.destroy();
			
			_subMeshes = null;
			_nativeTriangleMesh = null;
			_vertexBuffers = null;
			_indexBuffer = null;
			_boneNames = null;
			_inverseBindPoses = null;
		}
		
		/**
		 * @private
		 */
		public function _getPhysicMesh():* {
			if (!_nativeTriangleMesh) {
				var physics3D:* = Laya3D._physics3D;
				var triangleMesh:* = new physics3D.btTriangleMesh();//TODO:独立抽象btTriangleMesh,增加内存复用
				var nativePositio0:* = _nativeTempVector30;
				var nativePositio1:* = _nativeTempVector31;
				var nativePositio2:* = _nativeTempVector32;
				var positions:Vector.<Vector3> = _getPositions();//TODO:GC问题
				var indices:Uint16Array = _indexBuffer.getData();//TODO:API修改问题
				for (var i:int = 0, n:int = indices.length; i < n; i += 3) {
					var position0:Vector3 = positions[indices[i]];
					var position1:Vector3 = positions[indices[i + 1]];
					var position2:Vector3 = positions[indices[i + 2]];
					Utils3D._convertToBulletVec3(position0, nativePositio0,true);
					Utils3D._convertToBulletVec3(position1, nativePositio1,true);
					Utils3D._convertToBulletVec3(position2, nativePositio2,true);
					triangleMesh.addTriangle(nativePositio0, nativePositio1, nativePositio2, true);
				}
				_nativeTriangleMesh = triangleMesh;
			}
			return _nativeTriangleMesh;
		}
	}
}


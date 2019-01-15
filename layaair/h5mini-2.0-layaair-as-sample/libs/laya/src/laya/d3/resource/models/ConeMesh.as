package laya.d3.resource.models {
	import laya.d3.graphics.IndexBuffer3D;
	import laya.d3.graphics.VertexBuffer3D;
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.Vertex.VertexPositionNormalTexture;
	import laya.d3.math.Quaternion;
	import laya.d3.math.Vector3;
	import laya.webgl.WebGLContext;
	
	/**
	 * <code>ConeMesh</code> 类用于创建圆锥体。
	 */
	public class ConeMesh extends PrimitiveMesh {
		/** @private */
		private var _radius:Number;
		/** @private */
		private var _height:Number;
		/** @private */
		private var _slices:int;
		
		/**
		 * 返回半径
		 * @return 半径
		 */
		public function get radius():Number {
			return _radius;
		}
		
		/**
		 * 设置半径（改变此属性会重新生成顶点和索引）
		 * @param  value 半径
		 */
		public function set radius(value:Number):void {
			if (_radius !== value) {
				_radius = value;
				releaseResource();
				_create();
			}
		}
		
		/**
		 * 返回高度
		 * @return 高度
		 */
		public function get height():Number {
			return _height;
		}
		
		/**
		 * 设置高度（改变此属性会重新生成顶点和索引）
		 * @param  value 高度
		 */
		public function set height(value:Number):void {
			if (_height !== value) {
				_height = value;
				releaseResource();
				_create();
			}
		}
		
		/**
		 * 获取宽度分段
		 * @return 宽度分段
		 */
		public function get slices():int {
			return _slices;
		}
		
		/**
		 * 设置宽度分段（改变此属性会重新生成顶点和索引）
		 * @param  value 宽度分段
		 */
		public function set slices(value:int):void {
			if (_slices !== value) {
				_slices = value;
				releaseResource();
				_create();
			}
		}
		
		/**
		 * 创建一个圆锥体模型
		 * @param radius 半径
		 * @param height 高度
		 * @param slices 分段数
		 */
		public function ConeMesh(radius:Number = 0.5, height:Number = 1, slices:int = 32) {
			super();
			_radius = radius;
			_height = height;
			_slices = slices;
			_create();
		}
		
		/**
		 * @private
		 */
		private function _create():void {
			//(this._released) || (dispose());//如果已存在，则释放资源
			var vertexCount:int = (_slices + 1 + 1) + (_slices + 1) * 2;
			var indexCount:int = 6 * _slices + 3 * _slices;
			
			//定义顶点数据结构
			var vertexDeclaration:VertexDeclaration = VertexPositionNormalTexture.vertexDeclaration;
			//单个顶点数据个数,总共字节数/单个字节数
			var vertexFloatStride:int = vertexDeclaration.vertexStride / 4;
			//顶点
			var vertices:Float32Array = new Float32Array(vertexCount * vertexFloatStride);
			//顶点索引
			var indices:Uint16Array = new Uint16Array(indexCount);
			
			var sliceAngle:Number = (Math.PI * 2.0) / _slices;
			
			var halfHeight:Number = _height / 2;
			var curAngle:Number = 0;
			var verticeCount:Number = 0;
			
			var posX:Number = 0;
			var posY:Number = 0;
			var posZ:Number = 0;
			
			var normal:Vector3 = new Vector3();
			var downV3:Vector3 = new Vector3(0, -1, 0);
			var upPoint:Vector3 = new Vector3(0, halfHeight, 0);
			var downPoint:Vector3 = new Vector3();
			var v3:Vector3 = new Vector3();
			var q4:Quaternion = new Quaternion();
			var rotateAxis:Vector3 = new Vector3();
			var rotateRadius:Number;
			
			var vc:int = 0;
			var ic:int = 0;
			
			//壁
			for (var rv:int = 0; rv <= _slices; rv++) {
				curAngle = rv * sliceAngle;
				posX = Math.cos(curAngle + Math.PI) * _radius;
				posY = halfHeight;
				posZ = Math.sin(curAngle + Math.PI) * _radius;
				
				//pos
				vertices[vc++] = 0;
				vertices[vc + (_slices + 1) * 8 - 1] = posX;
				vertices[vc++] = posY;
				vertices[vc + (_slices + 1) * 8 - 1] = -posY;
				vertices[vc++] = 0;
				vertices[vc + (_slices + 1) * 8 - 1] = posZ;
				
				normal.x = posX;
				normal.y = 0;
				normal.z = posZ;
				downPoint.x = posX;
				downPoint.y = -posY;
				downPoint.z = posZ;
				Vector3.subtract(downPoint, upPoint, v3);
				Vector3.normalize(v3, v3);
				rotateRadius = Math.acos(Vector3.dot(downV3, v3));
				Vector3.cross(downV3, v3, rotateAxis);
				Vector3.normalize(rotateAxis, rotateAxis);
				Quaternion.createFromAxisAngle(rotateAxis, rotateRadius, q4);
				Vector3.normalize(normal, normal);
				Vector3.transformQuat(normal, q4, normal);
				Vector3.normalize(normal, normal);
				//normal
				vertices[vc++] = normal.x;
				vertices[vc + (_slices + 1) * 8 - 1] = normal.x;
				vertices[vc++] = normal.y;
				vertices[vc + (_slices + 1) * 8 - 1] = normal.y;
				vertices[vc++] = normal.z;
				vertices[vc + (_slices + 1) * 8 - 1] = normal.z;
				//uv    
				vertices[vc++] = 1 - rv * 1 / _slices;
				vertices[vc + (_slices + 1) * 8 - 1] = 1 - rv * 1 / _slices;
				vertices[vc++] = 0;
				vertices[vc + (_slices + 1) * 8 - 1] = 1;
				
			}
			
			vc += (_slices + 1) * 8;
			
			for (var ri:int = 0; ri < _slices; ri++) {
				indices[ic++] = ri + verticeCount + (_slices + 1);
				indices[ic++] = ri + verticeCount + 1;
				indices[ic++] = ri + verticeCount;
				
				indices[ic++] = ri + verticeCount + (_slices + 1);
				indices[ic++] = ri + verticeCount + (_slices + 1) + 1;
				indices[ic++] = ri + verticeCount + 1;
				
			}
			
			verticeCount += 2 * (_slices + 1);
			
			//底
			for (var bv:int = 0; bv <= _slices; bv++) {
				if (bv === 0) {
					//pos
					vertices[vc++] = 0;
					vertices[vc++] = -halfHeight;
					vertices[vc++] = 0;
					//normal
					vertices[vc++] = 0;
					vertices[vc++] = -1;
					vertices[vc++] = 0;
					//uv
					vertices[vc++] = 0.5;
					vertices[vc++] = 0.5;
				}
				
				curAngle = bv * sliceAngle;
				posX = Math.cos(curAngle + Math.PI) * _radius;
				posY = -halfHeight;
				posZ = Math.sin(curAngle + Math.PI) * _radius;
				
				//pos
				vertices[vc++] = posX;
				vertices[vc++] = posY;
				vertices[vc++] = posZ;
				//normal
				vertices[vc++] = 0;
				vertices[vc++] = -1;
				vertices[vc++] = 0;
				//uv
				vertices[vc++] = 0.5 + Math.cos(curAngle) * 0.5;
				vertices[vc++] = 0.5 + Math.sin(curAngle) * 0.5;
				
			}
			
			for (var bi:int = 0; bi < _slices; bi++) {
				indices[ic++] = 0 + verticeCount;
				indices[ic++] = bi + 2 + verticeCount;
				indices[ic++] = bi + 1 + verticeCount;
			}
			
			verticeCount += _slices + 1 + 1;
			setData(vertexDeclaration, vertices, indices);
		}
	}
}
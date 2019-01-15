package laya.d3.graphics.Vertex {
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.VertexElement;
	import laya.d3.graphics.VertexElementFormat;
	import laya.d3.math.Vector2;
	import laya.d3.math.Vector3;
	import laya.d3.math.Vector4;
	
	/**
	 * <code>VertexPositionNormalTexture</code> 类用于创建位置、法线、纹理顶点结构。
	 */
	public class VertexPositionNTBTextureSkin extends VertexMesh {
		
		private static const _vertexDeclaration:VertexDeclaration = new VertexDeclaration( 88, [
		new VertexElement(0, VertexElementFormat.Vector3, VertexMesh.MESH_POSITION0),
		new VertexElement(12, VertexElementFormat.Vector3, VertexMesh.MESH_NORMAL0),
		new VertexElement(24, VertexElementFormat.Vector3, VertexMesh.MESH_TANGENT0),
		new VertexElement(36, VertexElementFormat.Vector3, VertexMesh.MESH_BINORMAL0),
		new VertexElement(48, VertexElementFormat.Vector2, VertexMesh.MESH_TEXTURECOORDINATE0),
		new VertexElement(56, VertexElementFormat.Vector4, VertexMesh.MESH_BLENDWEIGHT0),
		new VertexElement(72, VertexElementFormat.Vector4, VertexMesh.MESH_BLENDINDICES0)]);
		
		public static function get vertexDeclaration():VertexDeclaration
		{
			return _vertexDeclaration;
		}
		
		private var _position:Vector3;
		private var _normal:Vector3;
		private var _textureCoordinate:Vector2;
		
		public function get position():Vector3 {
			return _position;
		}
		
		public function get normal():Vector3 {
			return _normal;
		}
		
		public function get textureCoordinate():Vector2 {
			return _textureCoordinate;
		}
		
		override public function get vertexDeclaration():VertexDeclaration {
			return _vertexDeclaration;
		}
		
		public function VertexPositionNTBTextureSkin(position:Vector3, normal:Vector3, textureCoordinate:Vector2) {
			_position = position;
			_normal = normal;
			_textureCoordinate = textureCoordinate;
		}
	
	}

}
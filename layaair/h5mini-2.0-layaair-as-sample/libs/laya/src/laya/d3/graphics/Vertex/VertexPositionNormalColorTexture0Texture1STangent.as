package laya.d3.graphics.Vertex {
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.VertexElement;
	import laya.d3.graphics.VertexElementFormat;
	import laya.d3.math.Vector2;
	import laya.d3.math.Vector3;
	import laya.d3.math.Vector4;
	
	/**
	 * <code>VertexPositionNormalColorTextureTangent</code> 类用于创建位置、法线、颜色、纹理、切线顶点结构。
	 */
	public class VertexPositionNormalColorTexture0Texture1STangent extends VertexMesh {
		
		private static const _vertexDeclaration:VertexDeclaration = new VertexDeclaration( 72, [
		new VertexElement(0, VertexElementFormat.Vector3, VertexMesh.MESH_POSITION0),
		new VertexElement(12, VertexElementFormat.Vector3, VertexMesh.MESH_NORMAL0),
		new VertexElement(24, VertexElementFormat.Vector4, VertexMesh.MESH_COLOR0),
		new VertexElement(40, VertexElementFormat.Vector2, VertexMesh.MESH_TEXTURECOORDINATE0),
		new VertexElement(48, VertexElementFormat.Vector2, VertexMesh.MESH_TEXTURECOORDINATE1),
		new VertexElement(56, VertexElementFormat.Vector4, VertexMesh.MESH_TANGENT0)]);
		
		public static function get vertexDeclaration():VertexDeclaration
		{
			return _vertexDeclaration;
		}
		
		private var _position:Vector3;
		private var _normal:Vector3;
		private var _color:Vector4;
		private var _textureCoordinate0:Vector2;
		private var _textureCoordinate1:Vector2;
		private var _tangent:Vector3;
		
		public function get position():Vector3 {
			return _position;
		}
		
		public function get normal():Vector3 {
			return _normal;
		}
		
		public function get color():Vector4 {
			return _color;
		}
		
		public function get textureCoordinate0():Vector2 {
			return _textureCoordinate0;
		}
		
		public function get textureCoordinate1():Vector2 {
			return _textureCoordinate1;
		}
		
		public function get tangent():Vector3 {
			return _tangent;
		}
		
		override public function get vertexDeclaration():VertexDeclaration {
			return _vertexDeclaration;
		}
		
		public function VertexPositionNormalColorTexture0Texture1STangent(position:Vector3, normal:Vector3, color:Vector4, textureCoordinate0:Vector2, textureCoordinate1:Vector2, tangent:Vector3):void {
			_position = position;
			_normal = normal;
			_color = color;
			_textureCoordinate0 = textureCoordinate0;
			_textureCoordinate1 = textureCoordinate1;
			_tangent = tangent;
		}
	
	}

}
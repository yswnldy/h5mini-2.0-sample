package laya.d3.graphics.Vertex 
{
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.VertexElement;
	import laya.d3.graphics.VertexElementFormat;
	import laya.d3.math.Vector3;
	import laya.d3.math.Vector4;
	
	public class VertexPositionNormalSTangent extends VertexMesh 
	{
		
		private static const _vertexDeclaration:VertexDeclaration = new VertexDeclaration( 40, [
		new VertexElement(0, VertexElementFormat.Vector3, VertexMesh.MESH_POSITION0),
		new VertexElement(12, VertexElementFormat.Vector3, VertexMesh.MESH_NORMAL0),
		new VertexElement(24, VertexElementFormat.Vector4, VertexMesh.MESH_TANGENT0)]);
		
		/* INTERFACE laya.d3.graphics.IVertex */
		public static function get vertexDeclaration():VertexDeclaration 
		{
			return _vertexDeclaration;
		}
		
		private var _position:Vector3;
		private var _normal:Vector3;
		private var _tangent:Vector3;
		
		public function get position():Vector3
		{
			return _position;
		}
		
		public function get normal():Vector3
		{
			return _normal;
		}
		
		public function get tangent():Vector3
		{
			return _tangent;
		}
		
		override public function get vertexDeclaration():VertexDeclaration
		{
			return _vertexDeclaration;
		}
		
		public function VertexPositionNormalSTangent(position:Vector3, normal:Vector3, tangent:Vector3) 
		{
			_position = position;
			_normal = normal;
			_tangent = tangent;
		}
		
	}

}
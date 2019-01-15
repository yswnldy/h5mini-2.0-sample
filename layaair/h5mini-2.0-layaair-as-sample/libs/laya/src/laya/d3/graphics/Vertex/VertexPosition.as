package laya.d3.graphics.Vertex 
{
	import laya.d3.graphics.VertexDeclaration;
	import laya.d3.graphics.VertexElement;
	import laya.d3.graphics.VertexElementFormat;
	import laya.d3.math.Vector3;
	public class VertexPosition extends VertexMesh 
	{
		private static const _vertexDeclaration:VertexDeclaration = new VertexDeclaration( 12, [
		new VertexElement(0, VertexElementFormat.Vector3, VertexMesh.MESH_POSITION0)]);
		
		/* INTERFACE laya.d3.graphics.IVertex */
		public static function get vertexDeclaration():VertexDeclaration 
		{
			return _vertexDeclaration;
		}
		
		private var _position:Vector3;
		
		public function get position():Vector3
		{
			return _position;
		}
		
		override public function get vertexDeclaration():VertexDeclaration {
			return _vertexDeclaration;
		}
		
		public function VertexPosition(position:Vector3) 
		{
			_position = position;
		}
	}
}
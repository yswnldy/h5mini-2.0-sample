package laya.d3.graphics.Vertex {
	import laya.d3.graphics.IVertex;
	import laya.d3.graphics.VertexDeclaration;
	
	/**
	 * ...
	 * @author ...
	 */
	public class VertexMesh implements IVertex {		
		public static const MESH_POSITION0:int = 0;
		public static const MESH_COLOR0:int = 1;
		public static const MESH_TEXTURECOORDINATE0:int = 2;
		public static const MESH_NORMAL0:int = 3;
		public static const MESH_BINORMAL0:int = 4;
		public static const MESH_TANGENT0:int = 5;
		public static const MESH_BLENDINDICES0:int = 6;
		public static const MESH_BLENDWEIGHT0:int = 7;
		public static const MESH_TEXTURECOORDINATE1:int = 8;
		
		/* INTERFACE laya.d3.graphics.IVertex */
		public function get vertexDeclaration():VertexDeclaration {
			return null;
		}
		
		public function VertexMesh() {
		
		}
	
	}

}
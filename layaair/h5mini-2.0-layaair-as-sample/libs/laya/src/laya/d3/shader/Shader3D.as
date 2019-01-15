package laya.d3.shader {
	import laya.d3.core.RenderableSprite3D;
	import laya.d3.core.SkinnedMeshSprite3D;
	import laya.d3.core.material.BaseMaterial;
	import laya.renders.Render;
	import laya.utils.Browser;
	import laya.webgl.WebGL;
	import laya.webgl.WebGLContext;
	import laya.webgl.shader.Shader;
	import laya.webgl.utils.ShaderCompile;
	
	/**
	 * @private
	 * <code>Shader3D</code> 类用于创建Shader3D。
	 */
	public class Shader3D {
		/**shader变量提交周期，自定义。*/
		public static const PERIOD_CUSTOM:int = 0;
		/**shader变量提交周期，逐材质。*/
		public static const PERIOD_MATERIAL:int = 1;
		/**shader变量提交周期，逐精灵和相机，注：因为精灵包含MVP矩阵，为复合属性，所以摄像机发生变化时也应提交。*/
		public static const PERIOD_SPRITE:int = 2;
		/**shader变量提交周期，逐相机。*/
		public static const PERIOD_CAMERA:int = 3;
		/**shader变量提交周期，逐场景。*/
		public static const PERIOD_SCENE:int = 4;
		
		/**@private */
		public static var SHADERDEFINE_HIGHPRECISION:int;
		
		/**@private */
		private static var _publicCounter:int = 0;
		/**@private */
		private static var _globleDefines:Array = [];
		
		/**@private */
		public static var _preCompileShader:Object = {};
		
		/**是否开启调试模式。 */
		public static var debugMode:Boolean = false;
		
		public static function addInclude(fileName:String, txt:String):void {
			ShaderCompile.addInclude(fileName, txt);
		}
		
		/**
		 * @private
		 */
		public static function registerPublicDefine(name:String):int {
			var value:int = Math.pow(2, _publicCounter++);//TODO:超界处理
			_globleDefines[value] = name;
			return value;
		}
		
		/**
		 * 编译shader。
		 * @param	name Shader名称。
		 * @param	publicDefine 公共宏定义值。
		 * @param	spriteDefine 精灵宏定义值。
		 * @param	materialDefine 材质宏定义值。
		 */
		public static function compileShader(name:String, passIndex:int, publicDefine:int, spriteDefine:int, materialDefine:int):void {
			var shader:Shader3D = Shader3D.find(name);
			if (shader) {
				var pass:ShaderPass = shader._passes[passIndex];
				if (pass) {
					if (WebGL.shaderHighPrecision)//部分低端移动设备不支持高精度shader,所以如果在PC端或高端移动设备输出的宏定义值需做判断移除高精度宏定义
						pass.withCompile(publicDefine, spriteDefine, materialDefine);
					else
						pass.withCompile(publicDefine - Shader3D.SHADERDEFINE_HIGHPRECISION, spriteDefine, materialDefine);
				} else {
					console.warn("Shader3D: unknown shader passIndex.");
				}
			} else {
				console.warn("Shader3D: unknown shader name.");
			}
		}
		
		/**
		 * 添加预编译shader文件，主要是处理宏定义
		 * @param	nameID,一般是特殊宏+shaderNameID*0.0002组成的一个浮点数当做唯一标识
		 * @param	vs
		 * @param	ps
		 */
		public static function add(name:String, attributeMap:Object, uniformMap:Object, spriteDefines:ShaderDefines = null, materialDefines:ShaderDefines = null):Shader3D {
			return Shader3D._preCompileShader[name] = new Shader3D(name, attributeMap, uniformMap, ShaderCompile.includes, spriteDefines, materialDefines);
		}
		
		/**
		 * 获取ShaderCompile3D。
		 * @param	name
		 * @return ShaderCompile3D。
		 */
		public static function find(name:String):Shader3D {
			return Shader3D._preCompileShader[name];
		}
		
		
		
		/**@private */
		public var _name:String;
		/**@private */
		public var _attributeMap:Object;
		/**@private */
		public var _uniformMap:Object;
		/**@private */
		public var _publicDefines:Array;
		/**@private */
		public var _publicDefinesMap:Object;
		/**@private */
		public var _spriteDefines:Array;
		/**@private */
		public var _spriteDefinesMap:Object;
		/**@private */
		public var _materialDefines:Array;
		/**@private */
		public var _materialDefinesMap:Object;
		/**@private */
		public var _passes:Vector.<ShaderPass>;
		
		/**
		 * @private
		 */
		public function Shader3D(name:String, attributeMap:Object, uniformMap:Object, includeFiles:*, spriteDefines:ShaderDefines = null, materialDefines:ShaderDefines = null) {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			_name = name;
			
			_publicDefines = [];
			_publicDefinesMap = {};
			_spriteDefines = [];
			_spriteDefinesMap = {};
			_materialDefines = [];
			_materialDefinesMap = {};
			_addDefines(_publicDefines, _publicDefinesMap, _globleDefines);
			(spriteDefines) && (_addDefines(_spriteDefines, _spriteDefinesMap, spriteDefines.defines));
			(materialDefines) && (_addDefines(_materialDefines, _materialDefinesMap, materialDefines.defines));
			_passes = new Vector.<ShaderPass>();
			
			_attributeMap = attributeMap;
			_uniformMap = uniformMap;
		}
		
		/**
		 * @private
		 */
		private function _addDefines(defines:Array, definesMap:Object, supportDefines:Array):void {
			for (var k:String in supportDefines) {
				var name:String = supportDefines[k];
				var i:int = parseInt(k);
				defines[i] = name;
				definesMap[name] = i;
			}
		}
		
		/**
		 * @private
		 */
		public function addShaderPass(vs:String, ps:String):void {
			_passes.push(new ShaderPass(this, vs, ps));
		}
		
		/**
		 * 通过名称获取宏定义值。
		 * @param	name 名称。
		 * @return 宏定义值。
		 */
		public function getMaterialDefineByName(name:String):int {
			return _materialDefinesMap[name];
		}
	}

}

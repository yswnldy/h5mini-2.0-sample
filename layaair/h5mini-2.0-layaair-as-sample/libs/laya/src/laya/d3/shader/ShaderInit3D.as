package laya.d3.shader {
	import laya.d3.core.BaseCamera;
	import laya.d3.core.RenderableSprite3D;
	import laya.d3.core.SkinnedMeshSprite3D;
	import laya.d3.core.Sprite3D;
	import laya.d3.core.material.BaseMaterial;
	import laya.d3.core.material.BlinnPhongMaterial;
	import laya.d3.core.material.EffectMaterial;
	import laya.d3.core.material.ExtendTerrainMaterial;
	import laya.d3.core.material.PBRSpecularMaterial;
	import laya.d3.core.material.PBRStandardMaterial;
	import laya.d3.core.material.SkyBoxMaterial;
	import laya.d3.core.material.SkyProceduralMaterial;
	import laya.d3.core.material.TerrainMaterial;
	import laya.d3.core.material.UnlitMaterial;
	import laya.d3.core.material.WaterPrimaryMaterial;
	import laya.d3.core.particleShuriKen.ShuriKenParticle3D;
	import laya.d3.core.particleShuriKen.ShurikenParticleMaterial;
	import laya.d3.core.pixelLine.PixelLineMaterial;
	import laya.d3.core.scene.Scene3D;
	import laya.d3.core.trail.TrailMaterial;
	import laya.d3.core.trail.TrailSprite3D;
	import laya.d3.core.trail.VertexTrail;
	import laya.d3.graphics.Vertex.VertexMesh;
	import laya.d3.graphics.Vertex.VertexPositionTerrain;
	import laya.d3.graphics.Vertex.VertexShuriKenParticle;
	
	/**
	 * @private
	 * <code>ShaderInit</code> 类用于初始化内置Shader。
	 */
	public class ShaderInit3D {
		/**
		 * 创建一个 <code>ShaderInit</code> 实例。
		 */
		public function ShaderInit3D() {
		}
		
		/**
		 * @private
		 */
		public static function __init__():void {
			Shader3D.SHADERDEFINE_HIGHPRECISION = Shader3D.registerPublicDefine("HIGHPRECISION");
			Scene3D.SHADERDEFINE_FOG=Shader3D.registerPublicDefine("FOG");
			Scene3D.SHADERDEFINE_DIRECTIONLIGHT=Shader3D.registerPublicDefine("DIRECTIONLIGHT");
			Scene3D.SHADERDEFINE_POINTLIGHT=Shader3D.registerPublicDefine("POINTLIGHT");
			Scene3D.SHADERDEFINE_SPOTLIGHT=Shader3D.registerPublicDefine("SPOTLIGHT");
			Scene3D.SHADERDEFINE_CAST_SHADOW= Shader3D.registerPublicDefine("CASTSHADOW");
			Scene3D.SHADERDEFINE_SHADOW_PSSM1= Shader3D.registerPublicDefine("SHADOWMAP_PSSM1");
			Scene3D.SHADERDEFINE_SHADOW_PSSM2= Shader3D.registerPublicDefine("SHADOWMAP_PSSM2");
			Scene3D.SHADERDEFINE_SHADOW_PSSM3= Shader3D.registerPublicDefine("SHADOWMAP_PSSM3");
			Scene3D.SHADERDEFINE_SHADOW_PCF_NO=Shader3D.registerPublicDefine("SHADOWMAP_PCF_NO");
			Scene3D.SHADERDEFINE_SHADOW_PCF1= Shader3D.registerPublicDefine("SHADOWMAP_PCF1");
			Scene3D.SHADERDEFINE_SHADOW_PCF2=Shader3D.registerPublicDefine("SHADOWMAP_PCF2");
			Scene3D.SHADERDEFINE_SHADOW_PCF3=Shader3D.registerPublicDefine("SHADOWMAP_PCF3");
			Scene3D.SHADERDEFINE_REFLECTMAP=Shader3D.registerPublicDefine("REFLECTMAP");
			
			
			Shader3D.addInclude("Lighting.glsl", __INCLUDESTR__("files/Lighting.glsl"));
			Shader3D.addInclude("ShadowHelper.glsl", __INCLUDESTR__("files/ShadowHelper.glsl"));
			Shader3D.addInclude("BRDF.glsl", __INCLUDESTR__("files/PBRLibs/BRDF.glsl"));
			Shader3D.addInclude("PBRUtils.glsl", __INCLUDESTR__("files/PBRLibs/PBRUtils.glsl"));
			Shader3D.addInclude("PBRStandardLighting.glsl", __INCLUDESTR__("files/PBRLibs/PBRStandardLighting.glsl"));
			Shader3D.addInclude("PBRSpecularLighting.glsl", __INCLUDESTR__("files/PBRLibs/PBRSpecularLighting.glsl"));
			
			var vs:String, ps:String;
			var attributeMap:Object = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Color': VertexMesh.MESH_COLOR0, 
				'a_Normal': VertexMesh.MESH_NORMAL0, 
				'a_Texcoord0': VertexMesh.MESH_TEXTURECOORDINATE0, 
				'a_Texcoord1': VertexMesh.MESH_TEXTURECOORDINATE1, 
				'a_BoneWeights': VertexMesh.MESH_BLENDWEIGHT0, 
				'a_BoneIndices': VertexMesh.MESH_BLENDINDICES0, 
				'a_Tangent0': VertexMesh.MESH_TANGENT0};
			var uniformMap:Object = {
				'u_Bones': [SkinnedMeshSprite3D.BONES, Shader3D.PERIOD_CUSTOM], 
				'u_DiffuseTexture': [BlinnPhongMaterial.ALBEDOTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_SpecularTexture': [BlinnPhongMaterial.SPECULARTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_NormalTexture': [BlinnPhongMaterial.NORMALTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_AlphaTestValue': [BaseMaterial.ALPHATESTVALUE, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseColor': [BlinnPhongMaterial.ALBEDOCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_MaterialSpecular': [BlinnPhongMaterial.MATERIALSPECULAR, Shader3D.PERIOD_MATERIAL], 
				'u_Shininess': [BlinnPhongMaterial.SHININESS, Shader3D.PERIOD_MATERIAL], 
				'u_TilingOffset': [BlinnPhongMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				
				'u_WorldMat': [Sprite3D.WORLDMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_LightmapScaleOffset': [RenderableSprite3D.LIGHTMAPSCALEOFFSET, Shader3D.PERIOD_SPRITE], 
				'u_LightMap': [RenderableSprite3D.LIGHTMAP, Shader3D.PERIOD_SPRITE],
				
				'u_CameraPos': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA], 
				
				'u_ReflectTexture': [Scene3D.REFLECTIONTEXTURE, Shader3D.PERIOD_SCENE], 
				'u_ReflectIntensity': [Scene3D.REFLETIONINTENSITY, Shader3D.PERIOD_SCENE], 
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Color': [Scene3D.LIGHTDIRCOLOR, Shader3D.PERIOD_SCENE],
				'u_DirectionLight.Direction': [Scene3D.LIGHTDIRECTION, Shader3D.PERIOD_SCENE],  
				'u_PointLight.Position': [Scene3D.POINTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Range': [Scene3D.POINTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Color': [Scene3D.POINTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Position': [Scene3D.SPOTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Direction': [Scene3D.SPOTLIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Range': [Scene3D.SPOTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Spot': [Scene3D.SPOTLIGHTSPOTANGLE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Color': [Scene3D.SPOTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				'u_AmbientColor': [Scene3D.AMBIENTCOLOR, Shader3D.PERIOD_SCENE],
				'u_shadowMap1': [Scene3D.SHADOWMAPTEXTURE1, Shader3D.PERIOD_SCENE], 
				'u_shadowMap2': [Scene3D.SHADOWMAPTEXTURE2, Shader3D.PERIOD_SCENE], 
				'u_shadowMap3': [Scene3D.SHADOWMAPTEXTURE3, Shader3D.PERIOD_SCENE], 
				'u_shadowPSSMDistance': [Scene3D.SHADOWDISTANCE, Shader3D.PERIOD_SCENE], 
				'u_lightShadowVP': [Scene3D.SHADOWLIGHTVIEWPROJECT, Shader3D.PERIOD_SCENE], 
				'u_shadowPCFoffset': [Scene3D.SHADOWMAPPCFOFFSET, Shader3D.PERIOD_SCENE]};
			
			vs = __INCLUDESTR__("files/Mesh-BlinnPhong.vs");
			ps = __INCLUDESTR__("files/Mesh-BlinnPhong.ps");
			var shader:Shader3D = Shader3D.add("BLINNPHONG", attributeMap, uniformMap,SkinnedMeshSprite3D.shaderDefines,BlinnPhongMaterial.shaderDefines);
			shader.addShaderPass(vs,ps);
			
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Color': VertexMesh.MESH_COLOR0};
			uniformMap = {
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE],
				'u_Color': [PixelLineMaterial.COLOR, Shader3D.PERIOD_MATERIAL]
			};
			vs = __INCLUDESTR__("files/line.vs");
			ps = __INCLUDESTR__("files/line.ps");
			shader = Shader3D.add("LineShader", attributeMap, uniformMap);
			shader.addShaderPass(vs,ps);
			
			//PBRStandard
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Normal': VertexMesh.MESH_NORMAL0,
				'a_Tangent0': VertexMesh.MESH_TANGENT0,
				'a_Texcoord0': VertexMesh.MESH_TEXTURECOORDINATE0,
				'a_BoneWeights': VertexMesh.MESH_BLENDWEIGHT0, 
				'a_BoneIndices': VertexMesh.MESH_BLENDINDICES0
			};
			uniformMap = {
				'u_Bones': [SkinnedMeshSprite3D.BONES, Shader3D.PERIOD_CUSTOM], 
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_WorldMat': [Sprite3D.WORLDMATRIX, Shader3D.PERIOD_SPRITE],
				'u_CameraPos': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA], 
				'u_AlphaTestValue': [BaseMaterial.ALPHATESTVALUE, Shader3D.PERIOD_MATERIAL], 
				'u_AlbedoColor': [PBRStandardMaterial.ALBEDOCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_EmissionColor': [PBRStandardMaterial.EMISSIONCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_AlbedoTexture': [PBRStandardMaterial.ALBEDOTEXTURE, Shader3D.PERIOD_MATERIAL],
				'u_NormalTexture': [PBRStandardMaterial.NORMALTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_ParallaxTexture': [PBRStandardMaterial.PARALLAXTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_MetallicGlossTexture': [PBRStandardMaterial.METALLICGLOSSTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_OcclusionTexture': [PBRStandardMaterial.OCCLUSIONTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_EmissionTexture': [PBRStandardMaterial.EMISSIONTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_metallic': [PBRStandardMaterial.METALLIC, Shader3D.PERIOD_MATERIAL], 
				'u_smoothness': [PBRStandardMaterial.SMOOTHNESS, Shader3D.PERIOD_MATERIAL],
				'u_smoothnessScale': [PBRStandardMaterial.SMOOTHNESSSCALE, Shader3D.PERIOD_MATERIAL],
				'u_occlusionStrength': [PBRStandardMaterial.OCCLUSIONSTRENGTH, Shader3D.PERIOD_MATERIAL],
				'u_normalScale': [PBRStandardMaterial.NORMALSCALE, Shader3D.PERIOD_MATERIAL],
				'u_parallaxScale': [PBRStandardMaterial.PARALLAXSCALE, Shader3D.PERIOD_MATERIAL],
				'u_TilingOffset': [PBRStandardMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				'u_DirectionLight.Direction': [Scene3D.LIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Color': [Scene3D.LIGHTDIRCOLOR, Shader3D.PERIOD_SCENE],
				
				'u_PointLightMatrix': [Scene3D.POINTLIGHTMATRIX, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Position': [Scene3D.POINTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Range': [Scene3D.POINTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Color': [Scene3D.POINTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				
				//'u_SpotLightMatrix': [Scene3D.SPOTLIGHTMATRIX, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Position': [Scene3D.SPOTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Direction': [Scene3D.SPOTLIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Range': [Scene3D.SPOTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.SpotAngle': [Scene3D.SPOTLIGHTSPOTANGLE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Color': [Scene3D.SPOTLIGHTCOLOR, Shader3D.PERIOD_SCENE],
				
				'u_RangeTexture': [Scene3D.RANGEATTENUATIONTEXTURE, Shader3D.PERIOD_SCENE],
				//'u_AngleTexture': [Scene3D.ANGLEATTENUATIONTEXTURE, Shader3D.PERIOD_SCENE],
				
				'u_ReflectTexture': [Scene3D.REFLECTIONTEXTURE, Shader3D.PERIOD_SCENE], 
				'u_ReflectIntensity': [Scene3D.REFLETIONINTENSITY, Shader3D.PERIOD_SCENE], 
				'u_AmbientColor': [Scene3D.AMBIENTCOLOR, Shader3D.PERIOD_SCENE],
				'u_shadowMap1': [Scene3D.SHADOWMAPTEXTURE1, Shader3D.PERIOD_SCENE], 
				'u_shadowMap2': [Scene3D.SHADOWMAPTEXTURE2, Shader3D.PERIOD_SCENE], 
				'u_shadowMap3': [Scene3D.SHADOWMAPTEXTURE3, Shader3D.PERIOD_SCENE], 
				'u_shadowPSSMDistance': [Scene3D.SHADOWDISTANCE, Shader3D.PERIOD_SCENE], 
				'u_lightShadowVP': [Scene3D.SHADOWLIGHTVIEWPROJECT, Shader3D.PERIOD_SCENE], 
				'u_shadowPCFoffset': [Scene3D.SHADOWMAPPCFOFFSET, Shader3D.PERIOD_SCENE],
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE]
			};
			vs = __INCLUDESTR__("files/PBRStandard.vs");
			ps = __INCLUDESTR__("files/PBRStandard.ps");
			shader = Shader3D.add("PBRStandard", attributeMap, uniformMap, SkinnedMeshSprite3D.shaderDefines, PBRStandardMaterial.shaderDefines);
			shader.addShaderPass(vs,ps);
			
			//PBRSpecular
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Normal': VertexMesh.MESH_NORMAL0,
				'a_Tangent0': VertexMesh.MESH_TANGENT0,
				'a_Texcoord0': VertexMesh.MESH_TEXTURECOORDINATE0,
				'a_BoneWeights': VertexMesh.MESH_BLENDWEIGHT0, 
				'a_BoneIndices': VertexMesh.MESH_BLENDINDICES0
			};
			uniformMap = {
				'u_Bones': [SkinnedMeshSprite3D.BONES, Shader3D.PERIOD_CUSTOM], 
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_WorldMat': [Sprite3D.WORLDMATRIX, Shader3D.PERIOD_SPRITE],
				'u_CameraPos': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA], 
				'u_AlphaTestValue': [BaseMaterial.ALPHATESTVALUE, Shader3D.PERIOD_MATERIAL], 
				'u_AlbedoColor': [PBRSpecularMaterial.ALBEDOCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_SpecularColor': [PBRSpecularMaterial.SPECULARCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_EmissionColor': [PBRSpecularMaterial.EMISSIONCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_AlbedoTexture': [PBRSpecularMaterial.ALBEDOTEXTURE, Shader3D.PERIOD_MATERIAL],
				'u_NormalTexture': [PBRSpecularMaterial.NORMALTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_ParallaxTexture': [PBRSpecularMaterial.PARALLAXTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_SpecularTexture': [PBRSpecularMaterial.SPECULARTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_OcclusionTexture': [PBRSpecularMaterial.OCCLUSIONTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_EmissionTexture': [PBRSpecularMaterial.EMISSIONTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_smoothness': [PBRSpecularMaterial.SMOOTHNESS, Shader3D.PERIOD_MATERIAL],
				'u_smoothnessScale': [PBRSpecularMaterial.SMOOTHNESSSCALE, Shader3D.PERIOD_MATERIAL],
				'u_occlusionStrength': [PBRSpecularMaterial.OCCLUSIONSTRENGTH, Shader3D.PERIOD_MATERIAL],
				'u_normalScale': [PBRSpecularMaterial.NORMALSCALE, Shader3D.PERIOD_MATERIAL],
				'u_parallaxScale': [PBRSpecularMaterial.PARALLAXSCALE, Shader3D.PERIOD_MATERIAL],
				'u_TilingOffset': [PBRSpecularMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				'u_DirectionLight.Direction': [Scene3D.LIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Color': [Scene3D.LIGHTDIRCOLOR, Shader3D.PERIOD_SCENE],
				
				'u_PointLightMatrix': [Scene3D.POINTLIGHTMATRIX, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Position': [Scene3D.POINTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Range': [Scene3D.POINTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Color': [Scene3D.POINTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				
				//'u_SpotLightMatrix': [Scene3D.SPOTLIGHTMATRIX, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Position': [Scene3D.SPOTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Direction': [Scene3D.SPOTLIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Range': [Scene3D.SPOTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.SpotAngle': [Scene3D.SPOTLIGHTSPOTANGLE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Color': [Scene3D.SPOTLIGHTCOLOR, Shader3D.PERIOD_SCENE],
				
				'u_RangeTexture': [Scene3D.RANGEATTENUATIONTEXTURE, Shader3D.PERIOD_SCENE],
				//'u_AngleTexture': [Scene3D.ANGLEATTENUATIONTEXTURE, Shader3D.PERIOD_SCENE],
				
				'u_ReflectTexture': [Scene3D.REFLECTIONTEXTURE, Shader3D.PERIOD_SCENE], 
				'u_ReflectIntensity': [Scene3D.REFLETIONINTENSITY, Shader3D.PERIOD_SCENE],
				'u_AmbientColor': [Scene3D.AMBIENTCOLOR, Shader3D.PERIOD_SCENE],
				'u_shadowMap1': [Scene3D.SHADOWMAPTEXTURE1, Shader3D.PERIOD_SCENE], 
				'u_shadowMap2': [Scene3D.SHADOWMAPTEXTURE2, Shader3D.PERIOD_SCENE], 
				'u_shadowMap3': [Scene3D.SHADOWMAPTEXTURE3, Shader3D.PERIOD_SCENE], 
				'u_shadowPSSMDistance': [Scene3D.SHADOWDISTANCE, Shader3D.PERIOD_SCENE], 
				'u_lightShadowVP': [Scene3D.SHADOWLIGHTVIEWPROJECT, Shader3D.PERIOD_SCENE], 
				'u_shadowPCFoffset': [Scene3D.SHADOWMAPPCFOFFSET, Shader3D.PERIOD_SCENE],
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE]
			};
			vs = __INCLUDESTR__("files/PBRSpecular.vs");
			ps = __INCLUDESTR__("files/PBRSpecular.ps");
			shader = Shader3D.add("PBRSpecular", attributeMap, uniformMap,SkinnedMeshSprite3D.shaderDefines,PBRSpecularMaterial.shaderDefines);
			shader.addShaderPass(vs, ps);
			
			//unlit
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Color': VertexMesh.MESH_COLOR0, 
				'a_Texcoord0': VertexMesh.MESH_TEXTURECOORDINATE0, 
				'a_BoneWeights': VertexMesh.MESH_BLENDWEIGHT0, 
				'a_BoneIndices': VertexMesh.MESH_BLENDINDICES0
			};
			uniformMap = {
				'u_Bones': [SkinnedMeshSprite3D.BONES, Shader3D.PERIOD_CUSTOM], 
				'u_AlbedoTexture': [UnlitMaterial.ALBEDOTEXTURE, Shader3D.PERIOD_MATERIAL],
				'u_AlbedoColor': [UnlitMaterial.ALBEDOCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_TilingOffset': [UnlitMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				'u_AlphaTestValue': [BaseMaterial.ALPHATESTVALUE, Shader3D.PERIOD_MATERIAL], 
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE]
			};
			vs = __INCLUDESTR__("files/Unlit.vs");
			ps = __INCLUDESTR__("files/Unlit.ps");
			shader = Shader3D.add("Unlit", attributeMap, uniformMap,SkinnedMeshSprite3D.shaderDefines,UnlitMaterial.shaderDefines);
			shader.addShaderPass(vs, ps);
			
			//meshEffect
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Texcoord0': VertexMesh.MESH_TEXTURECOORDINATE0, 
				'a_BoneWeights': VertexMesh.MESH_BLENDWEIGHT0, 
				'a_BoneIndices': VertexMesh.MESH_BLENDINDICES0
			};
			uniformMap = {
				'u_Bones': [SkinnedMeshSprite3D.BONES, Shader3D.PERIOD_CUSTOM], 
				'u_AlbedoTexture': [EffectMaterial.MAINTEXTURE, Shader3D.PERIOD_MATERIAL],
				'u_AlbedoColor': [EffectMaterial.TINTCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_TilingOffset': [EffectMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				'u_AlphaTestValue': [BaseMaterial.ALPHATESTVALUE, Shader3D.PERIOD_MATERIAL], 
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE]
			};
			vs = __INCLUDESTR__("files/Effect.vs");
			ps = __INCLUDESTR__("files/Effect.ps");
			shader = Shader3D.add("Effect", attributeMap, uniformMap,SkinnedMeshSprite3D.shaderDefines,EffectMaterial.shaderDefines);
			shader.addShaderPass(vs,ps);
			
			//ShurikenParticle
			attributeMap = {
				'a_CornerTextureCoordinate': VertexShuriKenParticle.PARTICLE_CORNERTEXTURECOORDINATE0, 
				'a_MeshPosition': VertexShuriKenParticle.PARTICLE_POSITION0,
				'a_MeshColor': VertexShuriKenParticle.PARTICLE_COLOR0, 
				'a_MeshTextureCoordinate': VertexShuriKenParticle.PARTICLE_TEXTURECOORDINATE0,
				'a_ShapePositionStartLifeTime': VertexShuriKenParticle.PARTICLE_SHAPEPOSITIONSTARTLIFETIME, 
				'a_DirectionTime': VertexShuriKenParticle.PARTICLE_DIRECTIONTIME, 
				'a_StartColor': VertexShuriKenParticle.PARTICLE_STARTCOLOR0, 
				'a_EndColor': VertexShuriKenParticle.PARTICLE_ENDCOLOR0, 
				'a_StartSize': VertexShuriKenParticle.PARTICLE_STARTSIZE, 
				'a_StartRotation0': VertexShuriKenParticle.PARTICLE_STARTROTATION, 
				'a_StartSpeed': VertexShuriKenParticle.PARTICLE_STARTSPEED, 
				'a_Random0': VertexShuriKenParticle.PARTICLE_RANDOM0, 
				'a_Random1': VertexShuriKenParticle.PARTICLE_RANDOM1, 
				'a_SimulationWorldPostion': VertexShuriKenParticle.PARTICLE_SIMULATIONWORLDPOSTION,
				'a_SimulationWorldRotation': VertexShuriKenParticle.PARTICLE_SIMULATIONWORLDROTATION};
			uniformMap = {
				'u_Tintcolor': [ShurikenParticleMaterial.TINTCOLOR, Shader3D.PERIOD_MATERIAL], 
				'u_TilingOffset': [ShurikenParticleMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				'u_texture': [ShurikenParticleMaterial.DIFFUSETEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_WorldPosition': [ShuriKenParticle3D.WORLDPOSITION, Shader3D.PERIOD_SPRITE], 
				'u_WorldRotation': [ShuriKenParticle3D.WORLDROTATION, Shader3D.PERIOD_SPRITE], 
				'u_PositionScale': [ShuriKenParticle3D.POSITIONSCALE, Shader3D.PERIOD_SPRITE], 
				'u_SizeScale': [ShuriKenParticle3D.SIZESCALE, Shader3D.PERIOD_SPRITE], 
				'u_ScalingMode': [ShuriKenParticle3D.SCALINGMODE, Shader3D.PERIOD_SPRITE], 
				'u_Gravity': [ShuriKenParticle3D.GRAVITY, Shader3D.PERIOD_SPRITE], 
				'u_ThreeDStartRotation': [ShuriKenParticle3D.THREEDSTARTROTATION, Shader3D.PERIOD_SPRITE], 
				'u_StretchedBillboardLengthScale': [ShuriKenParticle3D.STRETCHEDBILLBOARDLENGTHSCALE, Shader3D.PERIOD_SPRITE], 
				'u_StretchedBillboardSpeedScale': [ShuriKenParticle3D.STRETCHEDBILLBOARDSPEEDSCALE, Shader3D.PERIOD_SPRITE], 
				'u_SimulationSpace': [ShuriKenParticle3D.SIMULATIONSPACE, Shader3D.PERIOD_SPRITE], 
				'u_CurrentTime': [ShuriKenParticle3D.CURRENTTIME, Shader3D.PERIOD_SPRITE], 
				'u_ColorOverLifeGradientAlphas': [ShuriKenParticle3D.COLOROVERLIFEGRADIENTALPHAS, Shader3D.PERIOD_SPRITE], 
				'u_ColorOverLifeGradientColors': [ShuriKenParticle3D.COLOROVERLIFEGRADIENTCOLORS, Shader3D.PERIOD_SPRITE], 
				'u_MaxColorOverLifeGradientAlphas': [ShuriKenParticle3D.MAXCOLOROVERLIFEGRADIENTALPHAS, Shader3D.PERIOD_SPRITE], 
				'u_MaxColorOverLifeGradientColors': [ShuriKenParticle3D.MAXCOLOROVERLIFEGRADIENTCOLORS, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityConst': [ShuriKenParticle3D.VOLVELOCITYCONST, Shader3D.PERIOD_SPRITE],
				'u_VOLVelocityGradientX': [ShuriKenParticle3D.VOLVELOCITYGRADIENTX, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityGradientY': [ShuriKenParticle3D.VOLVELOCITYGRADIENTY, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityGradientZ': [ShuriKenParticle3D.VOLVELOCITYGRADIENTZ, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityConstMax': [ShuriKenParticle3D.VOLVELOCITYCONSTMAX, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityGradientMaxX': [ShuriKenParticle3D.VOLVELOCITYGRADIENTXMAX, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityGradientMaxY': [ShuriKenParticle3D.VOLVELOCITYGRADIENTYMAX, Shader3D.PERIOD_SPRITE], 
				'u_VOLVelocityGradientMaxZ': [ShuriKenParticle3D.VOLVELOCITYGRADIENTZMAX, Shader3D.PERIOD_SPRITE], 
				'u_VOLSpaceType': [ShuriKenParticle3D.VOLSPACETYPE, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradient': [ShuriKenParticle3D.SOLSIZEGRADIENT, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientX': [ShuriKenParticle3D.SOLSIZEGRADIENTX, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientY': [ShuriKenParticle3D.SOLSIZEGRADIENTY, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientZ': [ShuriKenParticle3D.SOLSizeGradientZ, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientMax': [ShuriKenParticle3D.SOLSizeGradientMax, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientMaxX': [ShuriKenParticle3D.SOLSIZEGRADIENTXMAX, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientMaxY': [ShuriKenParticle3D.SOLSIZEGRADIENTYMAX, Shader3D.PERIOD_SPRITE], 
				'u_SOLSizeGradientMaxZ': [ShuriKenParticle3D.SOLSizeGradientZMAX, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityConst': [ShuriKenParticle3D.ROLANGULARVELOCITYCONST, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityConstSeprarate': [ShuriKenParticle3D.ROLANGULARVELOCITYCONSTSEPRARATE, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradient': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENT, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientX': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTX, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientY': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTY, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientZ': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTZ, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityConstMax': [ShuriKenParticle3D.ROLANGULARVELOCITYCONSTMAX, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityConstMaxSeprarate': [ShuriKenParticle3D.ROLANGULARVELOCITYCONSTMAXSEPRARATE, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientMax': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTMAX, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientMaxX': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTXMAX, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientMaxY': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTYMAX, Shader3D.PERIOD_SPRITE], 
				'u_ROLAngularVelocityGradientMaxZ': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTZMAX, Shader3D.PERIOD_SPRITE],
				'u_ROLAngularVelocityGradientMaxW': [ShuriKenParticle3D.ROLANGULARVELOCITYGRADIENTWMAX, Shader3D.PERIOD_SPRITE], 
				'u_TSACycles': [ShuriKenParticle3D.TEXTURESHEETANIMATIONCYCLES, Shader3D.PERIOD_SPRITE], 
				'u_TSASubUVLength': [ShuriKenParticle3D.TEXTURESHEETANIMATIONSUBUVLENGTH, Shader3D.PERIOD_SPRITE], 
				'u_TSAGradientUVs': [ShuriKenParticle3D.TEXTURESHEETANIMATIONGRADIENTUVS, Shader3D.PERIOD_SPRITE], 
				'u_TSAMaxGradientUVs': [ShuriKenParticle3D.TEXTURESHEETANIMATIONGRADIENTMAXUVS, Shader3D.PERIOD_SPRITE], 
				'u_CameraPosition': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA], 
				'u_CameraDirection': [BaseCamera.CAMERADIRECTION, Shader3D.PERIOD_CAMERA], 
				'u_CameraUp': [BaseCamera.CAMERAUP, Shader3D.PERIOD_CAMERA], 
				'u_View': [BaseCamera.VIEWMATRIX, Shader3D.PERIOD_CAMERA], 
				'u_Projection': [BaseCamera.PROJECTMATRIX, Shader3D.PERIOD_CAMERA],
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE]};
			vs = __INCLUDESTR__("files/ParticleShuriKen.vs");
			ps = __INCLUDESTR__("files/ParticleShuriKen.ps");
			shader = Shader3D.add("PARTICLESHURIKEN", attributeMap, uniformMap,ShuriKenParticle3D.shaderDefines,ShurikenParticleMaterial.shaderDefines);
			shader.addShaderPass(vs,ps);
			
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0};
			uniformMap = {
				'u_TintColor': [SkyBoxMaterial.TINTCOLOR, Shader3D.PERIOD_MATERIAL],
				'u_Exposure': [SkyBoxMaterial.EXPOSURE, Shader3D.PERIOD_MATERIAL],
				'u_Rotation': [SkyBoxMaterial.ROTATION, Shader3D.PERIOD_MATERIAL], 
				'u_CubeTexture': [SkyBoxMaterial.TEXTURECUBE, Shader3D.PERIOD_MATERIAL], 
				'u_MvpMatrix': [BaseCamera.VPMATRIX_NO_TRANSLATE, Shader3D.PERIOD_CAMERA]};//TODO:优化
			vs = __INCLUDESTR__("files/SkyBox.vs");
			ps = __INCLUDESTR__("files/SkyBox.ps");
			shader =Shader3D.add("SkyBox", attributeMap, uniformMap);
			shader.addShaderPass(vs, ps);
			
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0};
			uniformMap = {
				'u_SunSize': [SkyProceduralMaterial.SUNSIZE, Shader3D.PERIOD_MATERIAL], 
				'u_SunSizeConvergence': [SkyProceduralMaterial.SUNSIZECONVERGENCE, Shader3D.PERIOD_MATERIAL], 
				'u_AtmosphereThickness': [SkyProceduralMaterial.ATMOSPHERETHICKNESS, Shader3D.PERIOD_MATERIAL], 
				'u_SkyTint': [SkyProceduralMaterial.SKYTINT, Shader3D.PERIOD_MATERIAL],
				'u_GroundTint': [SkyProceduralMaterial.GROUNDTINT, Shader3D.PERIOD_MATERIAL],
				'u_Exposure': [SkyProceduralMaterial.EXPOSURE, Shader3D.PERIOD_MATERIAL],
				'u_MvpMatrix': [BaseCamera.VPMATRIX_NO_TRANSLATE, Shader3D.PERIOD_CAMERA],//TODO:优化
				'u_DirectionLight.Direction': [Scene3D.LIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Color': [Scene3D.LIGHTDIRCOLOR, Shader3D.PERIOD_SCENE]
			};
			vs = __INCLUDESTR__("files/SkyBoxProcedural.vs");
			ps = __INCLUDESTR__("files/SkyBoxProcedural.ps");
			shader =Shader3D.add("SkyBoxProcedural", attributeMap, uniformMap,null,SkyProceduralMaterial.shaderDefines);
			shader.addShaderPass(vs,ps);
			
			//terrain的shader
			attributeMap = {
				'a_Position': VertexPositionTerrain.TERRAIN_POSITION0, 
				'a_Normal': VertexPositionTerrain.TERRAIN_NORMAL0, 
				'a_Texcoord0': VertexPositionTerrain.TERRAIN_TEXTURECOORDINATE0, 
				'a_Texcoord1': VertexPositionTerrain.TERRAIN_TEXTURECOORDINATE1};
			uniformMap = {
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_WorldMat': [Sprite3D.WORLDMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_LightmapScaleOffset': [RenderableSprite3D.LIGHTMAPSCALEOFFSET, Shader3D.PERIOD_SPRITE], 
				'u_LightMap': [RenderableSprite3D.LIGHTMAP, Shader3D.PERIOD_SPRITE], 
				'u_SplatAlphaTexture': [TerrainMaterial.SPLATALPHATEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_NormalTexture': [TerrainMaterial.NORMALTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture1': [TerrainMaterial.DIFFUSETEXTURE1, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture2': [TerrainMaterial.DIFFUSETEXTURE2, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture3': [TerrainMaterial.DIFFUSETEXTURE3, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture4': [TerrainMaterial.DIFFUSETEXTURE4, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScale1': [TerrainMaterial.DIFFUSESCALE1, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScale2': [TerrainMaterial.DIFFUSESCALE2, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScale3': [TerrainMaterial.DIFFUSESCALE3, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScale4': [TerrainMaterial.DIFFUSESCALE4, Shader3D.PERIOD_MATERIAL], 
				'u_MaterialDiffuse': [TerrainMaterial.MATERIALDIFFUSE, Shader3D.PERIOD_MATERIAL], 
				'u_MaterialAmbient': [TerrainMaterial.MATERIALAMBIENT, Shader3D.PERIOD_MATERIAL], 
				'u_MaterialSpecular': [TerrainMaterial.MATERIALSPECULAR, Shader3D.PERIOD_MATERIAL], 
				'u_CameraPos': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA], 
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Direction': [Scene3D.LIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Diffuse': [Scene3D.LIGHTDIRCOLOR, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Position': [Scene3D.POINTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Range': [Scene3D.POINTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Attenuation': [Scene3D.POINTLIGHTATTENUATION, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Diffuse': [Scene3D.POINTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Position': [Scene3D.SPOTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Direction': [Scene3D.SPOTLIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Range': [Scene3D.SPOTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Spot': [Scene3D.SPOTLIGHTSPOTANGLE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Diffuse': [Scene3D.SPOTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				'u_AmbientColor': [Scene3D.AMBIENTCOLOR, Shader3D.PERIOD_SCENE],
				'u_shadowMap1': [Scene3D.SHADOWMAPTEXTURE1, Shader3D.PERIOD_SCENE], 
				'u_shadowMap2': [Scene3D.SHADOWMAPTEXTURE2, Shader3D.PERIOD_SCENE], 
				'u_shadowMap3': [Scene3D.SHADOWMAPTEXTURE3, Shader3D.PERIOD_SCENE], 
				'u_shadowPSSMDistance': [Scene3D.SHADOWDISTANCE, Shader3D.PERIOD_SCENE], 
				'u_lightShadowVP': [Scene3D.SHADOWLIGHTVIEWPROJECT, Shader3D.PERIOD_SCENE], 
				'u_shadowPCFoffset': [Scene3D.SHADOWMAPPCFOFFSET, Shader3D.PERIOD_SCENE]};
			
			vs = __INCLUDESTR__("files/Terrain.vs");
			ps = __INCLUDESTR__("files/Terrain.ps");
			shader = Shader3D.add("Terrain", attributeMap, uniformMap, RenderableSprite3D.shaderDefines, TerrainMaterial.shaderDefines);
			shader.addShaderPass(vs,ps);
			
			//extendTerrain的shader
			 attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Normal': VertexMesh.MESH_NORMAL0, 
				'a_Texcoord0': VertexMesh.MESH_TEXTURECOORDINATE0
			};
             uniformMap = {
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_WorldMat': [Sprite3D.WORLDMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_CameraPos': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA], 
				'u_LightmapScaleOffset': [RenderableSprite3D.LIGHTMAPSCALEOFFSET, Shader3D.PERIOD_SPRITE], 
				'u_LightMap': [RenderableSprite3D.LIGHTMAP, Shader3D.PERIOD_SPRITE], 
				'u_SplatAlphaTexture': [ExtendTerrainMaterial.SPLATALPHATEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture1': [ExtendTerrainMaterial.DIFFUSETEXTURE1, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture2': [ExtendTerrainMaterial.DIFFUSETEXTURE2, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture3': [ExtendTerrainMaterial.DIFFUSETEXTURE3, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture4': [ExtendTerrainMaterial.DIFFUSETEXTURE4, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseTexture5': [ExtendTerrainMaterial.DIFFUSETEXTURE5, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScaleOffset1': [ExtendTerrainMaterial.DIFFUSESCALEOFFSET1, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScaleOffset2': [ExtendTerrainMaterial.DIFFUSESCALEOFFSET2, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScaleOffset3': [ExtendTerrainMaterial.DIFFUSESCALEOFFSET3, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScaleOffset4': [ExtendTerrainMaterial.DIFFUSESCALEOFFSET4, Shader3D.PERIOD_MATERIAL], 
				'u_DiffuseScaleOffset5': [ExtendTerrainMaterial.DIFFUSESCALEOFFSET5, Shader3D.PERIOD_MATERIAL], 
				'u_FogStart': [Scene3D.FOGSTART, Shader3D.PERIOD_SCENE], 
				'u_FogRange': [Scene3D.FOGRANGE, Shader3D.PERIOD_SCENE], 
				'u_FogColor': [Scene3D.FOGCOLOR, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Direction': [Scene3D.LIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_DirectionLight.Color': [Scene3D.LIGHTDIRCOLOR, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Position': [Scene3D.POINTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Range': [Scene3D.POINTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Attenuation': [Scene3D.POINTLIGHTATTENUATION, Shader3D.PERIOD_SCENE], 
				'u_PointLight.Color': [Scene3D.POINTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Position': [Scene3D.SPOTLIGHTPOS, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Direction': [Scene3D.SPOTLIGHTDIRECTION, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Range': [Scene3D.SPOTLIGHTRANGE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Spot': [Scene3D.SPOTLIGHTSPOTANGLE, Shader3D.PERIOD_SCENE], 
				'u_SpotLight.Color': [Scene3D.SPOTLIGHTCOLOR, Shader3D.PERIOD_SCENE], 
				'u_AmbientColor': [Scene3D.AMBIENTCOLOR, Shader3D.PERIOD_SCENE],
				'u_shadowMap1': [Scene3D.SHADOWMAPTEXTURE1, Shader3D.PERIOD_SCENE], 
				'u_shadowMap2': [Scene3D.SHADOWMAPTEXTURE2, Shader3D.PERIOD_SCENE], 
				'u_shadowMap3': [Scene3D.SHADOWMAPTEXTURE3, Shader3D.PERIOD_SCENE], 
				'u_shadowPSSMDistance': [Scene3D.SHADOWDISTANCE, Shader3D.PERIOD_SCENE], 
				'u_lightShadowVP': [Scene3D.SHADOWLIGHTVIEWPROJECT, Shader3D.PERIOD_SCENE], 
				'u_shadowPCFoffset': [Scene3D.SHADOWMAPPCFOFFSET, Shader3D.PERIOD_SCENE]
			};
            vs = __INCLUDESTR__("files/extendTerrain.vs");
            ps = __INCLUDESTR__("files/extendTerrain.ps");
			shader = Shader3D.add("ExtendTerrain", attributeMap, uniformMap,RenderableSprite3D.shaderDefines,ExtendTerrainMaterial.shaderDefines);
			shader.addShaderPass(vs, ps);
			
			//Trail
			attributeMap = {
				'a_Position'    : VertexTrail.TRAIL_POSITION0,
				'a_OffsetVector': VertexTrail.TRAIL_OFFSETVECTOR,
				'a_Texcoord0X'  : VertexTrail.TRAIL_TEXTURECOORDINATE0X,
				'a_Texcoord0Y'  : VertexTrail.TRAIL_TEXTURECOORDINATE0Y,
				'a_BirthTime'   : VertexTrail.TRAIL_TIME0
			};
			uniformMap = {
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_VMatrix': [BaseCamera.VIEWMATRIX, Shader3D.PERIOD_CAMERA],
				'u_PMatrix': [BaseCamera.PROJECTMATRIX, Shader3D.PERIOD_CAMERA],
				'u_TilingOffset': [TrailMaterial.TILINGOFFSET, Shader3D.PERIOD_MATERIAL],
				'u_MainTexture': [TrailMaterial.MAINTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_MainColor': [TrailMaterial.TINTCOLOR, Shader3D.PERIOD_MATERIAL],
				'u_CurTime' : [TrailSprite3D.CURTIME, Shader3D.PERIOD_SPRITE],
				'u_LifeTime' : [TrailSprite3D.LIFETIME, Shader3D.PERIOD_SPRITE],
				'u_WidthCurve' : [TrailSprite3D.WIDTHCURVE, Shader3D.PERIOD_SPRITE],
				'u_WidthCurveKeyLength' : [TrailSprite3D.WIDTHCURVEKEYLENGTH, Shader3D.PERIOD_SPRITE],
				'u_GradientColorkey' : [TrailSprite3D.GRADIENTCOLORKEY, Shader3D.PERIOD_SPRITE],
				'u_GradientAlphakey' : [TrailSprite3D.GRADIENTALPHAKEY, Shader3D.PERIOD_SPRITE]
			};
			
            vs = __INCLUDESTR__("files/Trail.vs");
            ps = __INCLUDESTR__("files/Trail.ps");
            shader = Shader3D.add("Trail", attributeMap, uniformMap, TrailSprite3D.shaderDefines, TrailMaterial.shaderDefines);
			shader.addShaderPass(vs, ps);
			
			//WaterPrimary
			attributeMap = {
				'a_Position': VertexMesh.MESH_POSITION0, 
				'a_Normal': VertexMesh.MESH_NORMAL0,
				'a_Tangent0': VertexMesh.MESH_TANGENT0
			};
			uniformMap = {
				'u_MvpMatrix': [Sprite3D.MVPMATRIX, Shader3D.PERIOD_SPRITE], 
				'u_WorldMat': [Sprite3D.WORLDMATRIX, Shader3D.PERIOD_SPRITE],
				'u_CameraPos': [BaseCamera.CAMERAPOS, Shader3D.PERIOD_CAMERA],
				'u_Time': [Scene3D.TIME, Shader3D.PERIOD_SCENE], 
				'u_MainTexture': [WaterPrimaryMaterial.MAINTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_NormalTexture': [WaterPrimaryMaterial.NORMALTEXTURE, Shader3D.PERIOD_MATERIAL], 
				'u_HorizonColor': [WaterPrimaryMaterial.HORIZONCOLOR, Shader3D.PERIOD_MATERIAL],
				'u_WaveScale' : [WaterPrimaryMaterial.WAVESCALE, Shader3D.PERIOD_MATERIAL],
				'u_WaveSpeed' : [WaterPrimaryMaterial.WAVESPEED, Shader3D.PERIOD_MATERIAL]
			};
			vs = __INCLUDESTR__("files/WaterPrimary.vs");
			ps = __INCLUDESTR__("files/WaterPrimary.ps");
			shader = Shader3D.add("WaterPrimary", attributeMap, uniformMap, null, WaterPrimaryMaterial.shaderDefines);
			shader.addShaderPass(vs, ps);
		}
	}
}
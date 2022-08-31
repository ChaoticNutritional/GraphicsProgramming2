Shader "Custom/VertToSurface"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.5
        _Intensity("Glow Intensity", Range(0,1)) = 0.1
        _SecondaryTex("Image" , 2D) = "red" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _SecondaryTex;

        struct vertexInput 
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 tangent : TANGENT;
        };

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
            float4 inVert;
        };


        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        float _Intensity;
        

        void vertify(inout vertexInput v, out Input o)
        {
            //o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
            o.worldPos = v.vertex.xyz;
            o.inVert = v.vertex;
        }

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
           // o.Albedo = smoothstep(-1, 1,sin(_Time.x * (c.rgb + IN.worldPos))) * _Intensity;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = (_Metallic * IN.worldPos)/10;
            o.Smoothness = (_Glossiness * -IN.worldPos)/10;
            o.Alpha = c.a;
            o.Emission = smoothstep(-1, 1, sin(IN.worldPos)) * _Intensity;
            
        }
        ENDCG
    }
    FallBack "Diffuse"
}

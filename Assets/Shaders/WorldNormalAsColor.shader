Shader "Unlit/Zero2Shaders/WorldNormalAsColor"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                //use the NORMAL semantic to get the normal attribute 
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                //use TEXCOORD0 interpolator to interpolate normal to fragment shader
                float3 worldNormal : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //https://docs.unity3d.com/Manual/SL-BuiltinFunctions.html

                //transform object normal to world
                o.worldNormal = UnityObjectToWorldNormal(v.normal);

                //pass normal along
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //transform world normal to visible range

                //use world normal as a color
                float3 norm = i.worldNormal * 0.5f + 0.5f;

                return float4(norm, 1.0f);
            }
            ENDCG
        }
    }
}

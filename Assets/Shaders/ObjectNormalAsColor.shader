Shader "Unlit/Zero2Shaders/ObjectNormalAsColor"
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
                //use interpolator TEXCOORD0 to interpolate the normal to the fragment
                float3 objectNormal : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //pass the normal along
                o.objectNormal = v.normal;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // transform the normal to a visible range 
                float3 norm = i.objectNormal;
                norm *= 0.5f;
                norm += 0.5f;
                //use normal as a color
                return float4(norm, 1.0);

            }
            ENDCG
        }
    }
}

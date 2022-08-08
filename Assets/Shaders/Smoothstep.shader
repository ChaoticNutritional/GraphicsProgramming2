Shader "Unlit/Zero2Shaders/Step"
{
    Properties
    {
        _LowerEdge("Low Edge", Range(0,1)) = 0
        _UpperEdge("Upper Edge", Range(0,1)) = 1
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            static const float PI = 3.14159265f;
            static const float PI_2 = PI*2;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float _LowerEdge;
            float _UpperEdge;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //smoothstep function as color
                return smoothstep(_LowerEdge, _UpperEdge, i.uv.y);
            }
            ENDCG
        }
    }
}

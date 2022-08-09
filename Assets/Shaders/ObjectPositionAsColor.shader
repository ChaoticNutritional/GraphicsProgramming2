Shader "Unlit/Zero2Shaders/ObjectPositionAsColor"
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
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 objectPosition : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.objectPosition = v.vertex.xyz; //passes the position to the frag shader
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use object position as a color
                return float4(i.objectPosition, 1.0);
            }
            ENDCG
        }
    }
}

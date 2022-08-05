Shader "Unlit/Zero2Shaders/UVAsColor"
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
                //use the TEXCOORD0 semantic to get the UV0 attribute 
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                //Use the TEXCOORD0 interpolator to pass the uv to the fragment shader
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //pass uv along

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use uv as a color
            }
            ENDCG
        }
    }
}

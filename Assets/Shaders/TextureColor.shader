Shader "Unlit/Zero2Shaders/TextureColor"
{
    //pass a texture as a uniform property
    Properties
    {
    }

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
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //Apply the automatic texture scale and offset to the uv

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture using the hlsl function and the uv coordinate from the mesh
            }
            ENDCG
        }
    }
}

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
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                //use interpolator TEXCOORD0 to interpolate the normal to the fragment
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //pass the normal along

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // transform the normal to a visible range 

                //use normal as a color

            }
            ENDCG
        }
    }
}

Shader "Unlit/Zero2Shaders/ParameterColor"
{
    //Add uniform property to the inspector
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
                float4 position : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            //declare the uniform in the shader

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.position);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // use the property as color
            }

            ENDCG
        }
    }
}

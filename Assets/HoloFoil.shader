Shader "Unlit/HoloFoil"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _FoilSample("Foil Texture", 2D) = "white" {}
        _Scale("Zoom", Range(.1,2)) = 1
        _Intensity("Holo Intenisty", float) = 1
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
                float3 viewDir : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _FoilSample;
            float _Scale;
            float _Intensity;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.viewDir = WorldSpaceViewDir(v.vertex);
                return o;
            }

            float3 Plasma(float2 uv)
            {
                uv = uv * _Scale - _Scale / 2;
                float xWave = sin(uv.x); //horizontal sine wave
                float yWave = sin(uv.y); //veritcal sine wave
                float xyWave = sin(uv.x + uv.y); //diagonal sine wave

                float ring = sin(sqrt(uv.x * uv.x + uv.y * uv.y)) * 2; // rings

                float result = xWave + yWave + xyWave + ring;
                float c1 = sin(result * UNITY_PI);
                float c2 = cos(result * UNITY_PI);
                float c3 = sin(result);
                
                return float3(c1, c2, c3);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 foil = tex2D(_FoilSample, i.uv) * 4;
                float2 newUV = i.viewDir.xy + foil.rg;
                float3 plasma = Plasma(newUV) * _Intensity;
                fixed4 col = tex2D(_MainTex, i.uv);

                return fixed4(col.rgb + (col.rgb * plasma.rgb), 1);
            }
            ENDCG
        }
    }
}

Shader "Unlit/Zero2Shaders/GradientNoise"
{
    Properties
    {
        _ScaleAndOffset("Noise Scale and Offset", Vector) = (4, 4, 0, 0)
        _Octaves("Noise Octaves", Int) = 4
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
            
            float random(float2 v)
            {
                return frac(sin(dot(v.xy, float2(12.9898, 78.233))) * 43758.5453123);
            }


            //a static variable of an 4 unit slength array of float 2's'
            //one for each grid direction
            static const float2 s_dirs[4] = { 
                float2(0.0, 0.0),
                float2(1.0, 0.0),    
                float2(0.0, 1.0),
                float2(1.0, 1.0)
            };

            float2 randomDir(float2 v)
            {
                return float2(random(v), random(v * 2.0f)) * 2.0f - 1.0f;
            }

            float gradientNoise(float2 v)
            {
                //get the whole number component to find out which grid cell we are in
                float2 i = floor(v);

                //which part of the grid cell we are in
                float2 f = frac(v);

                //an interpolator to find where we are in that that cell in value betwen 0 and 1
                float2 s = smoothstep(0.0f, 1.0f, f);

                //gets 4 random directions
                float2 randDir0 = randomDir(i + s_dirs[0]);
                float2 randDir1 = randomDir(i + s_dirs[1]);
                float2 randDir2 = randomDir(i + s_dirs[2]);
                float2 randDir3 = randomDir(i + s_dirs[3]);

                //gets cell based position relative to the grid around us
                float2 cellPosition0 = f - s_dirs[0];
                float2 cellPosition1 = f - s_dirs[1];
                float2 cellPosition2 = f - s_dirs[2];
                float2 cellPosition3 = f - s_dirs[3];

                //take dot product of each of those directions and store them in a variable
                //the projection of our random direction onto our current cell position
                float p0 = dot(randDir0, cellPosition0);
                float p1 = dot(randDir1, cellPosition1);
                float p2 = dot(randDir2, cellPosition2);
                float p3 = dot(randDir3, cellPosition3);

                //returns the gradient we want by linearly interpolating between these floats
                //multiple lerps
                //lerp between point 1 and point 2 by s's X value
                //lerp between point 3 and point 4 by s's X value
                //lerp between those two lerps by s's Y value
                return lerp(lerp(p0, p1, s.x), lerp(p2, p3, s.x), s.y);
            }

            int _Octaves;
            float4 _ScaleAndOffset;

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use noise as color

                float2 v = i.uv * _ScaleAndOffset.xy + _ScaleAndOffset.zw;
                float n = 0.0f;
                //frequency which will be doubled everytime we adjust the Octaves
                float freq = 1.0f;
                float amplitude = 1.0f;

                for (int i = 0; i < _Octaves; i++)
                {
                    //as we add octaves we double the requency of the noise we're sampling
                    //we multiply this by the amplitude which will diminish the effectiveness of each octave
                    //the more we add, the less the octave of sample means
                    n += gradientNoise(v * freq) * amplitude;
                    freq *= 2.0f;
                    amplitude *= 0.5f;
                }
                
                return n * 0.5f + 0.5f;

                //return gradientNoise(i.uv * 30) * 0.5f + 0.5f;
            }
            ENDCG
        }
    }
}

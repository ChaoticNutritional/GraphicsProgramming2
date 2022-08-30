            float random(float2 v)
            {
                return frac(sin(dot(v.xy, float2(12.9898, 78.233))) * 43758.5453123);
            }


            //a static variable of an 4 unit length array of float 2's'
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

//gives it a name and in this case, nesting location
Shader "Unlit/Zero2Shaders/SolidColor"
{
    SubShader
    {   
        //what render pass this is attached to
        Tags { "RenderType"="Opaque" }

        //LOD = level of detail. this is standard
        LOD 100

        Pass
        {
            CGPROGRAM
            //Written in HLSL

            //1. declare vertex and fragment programs. preprocessing stage
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc" //package within unity that allows us to transpose vertex information to gameobject information


            //-------VERTEX PROGRAMS--------
            struct appdata //pulls in all the attributes of vertices
            {
                float4 position : POSITION;
            };

            struct v2f //v2f = "vertex to fragment"
            {
                //the vertex variable reflects the vertex's position in clip space
                float4 vertex : SV_POSITION;
            };

            //returns object of type v2f. 
            //Essentially returns the set of interpolator data that the fragment stage can use
            v2f vert(appdata v) //input takes the vertex attributes stored in these appdata structs
            {
                //in here it gets copied and interpolated for each fragment that makes up the triangle
                v2f o; //initialize a variable "o" for output
                o.vertex = UnityObjectToClipPos(v.position);
                return o;
            }


            //------FRAGMENT PROGRAMS--------

            //can return a float4 or fixed4. we're using fixed4 for now
            fixed4 frag(v2f i) : SV_Target //intakes a v2f object
            {
                //each v2f object has its own interpolated value from the v2f function
                return float4(1.0, 0.0, 0.0, 1.0);
            }






            //Gets compiled down and transcoded into whatever machine code or binary shader code
            //for whatever graphics api code you're using

            ENDCG
        }
    }
}

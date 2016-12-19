struct GeometryShaderInput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR0;
	nointerpolation float4 edgeData : COLOR1;
};

struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR0;
	nointerpolation float4 edgeData : COLOR1;
};

[maxvertexcount(3)]
void main(triangle GeometryShaderInput input[3], inout TriangleStream <PixelShaderInput> output)
{
	for (uint i = 0; i < 3; i++)
	{
		PixelShaderInput element;
		element.pos = input[i].pos;
		element.color = input[i].color;
		element.edgeData = input[i].edgeData / 2.0f;
		output.Append(element);
	}
}
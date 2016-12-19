// A constant buffer that stores the three basic column-major matrices for composing geometry.
cbuffer ModelViewProjectionConstantBuffer : register(b0)
{
	matrix model;
	matrix view;
	matrix projection;
};

// Per-vertex data used as input to the vertex shader.
struct VertexShaderInput
{
	float3 pos : POSITION;
	float3 color : COLOR0;
};

// Per-pixel color data passed through the pixel shader.
struct GeometryShaderInput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR0;
	nointerpolation float4 edgeData : COLOR1;
};

// Simple shader to do vertex processing on the GPU.
GeometryShaderInput main(VertexShaderInput input)
{
	GeometryShaderInput output;
	float4 pos = float4(input.pos, 1.0f);

	// Transform the vertex position into projected space.
	pos = mul(pos, model);
	pos = mul(pos, view);
	pos = mul(pos, projection);
	output.pos = pos;

	// Pass the color through without modification.
	output.color = input.color;
	output.edgeData = float4(input.color, 0.0f);

	return output;
}

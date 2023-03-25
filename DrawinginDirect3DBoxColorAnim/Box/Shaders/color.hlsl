//***************************************************************************************
// color.hlsl by Frank Luna (C) 2015 All Rights Reserved.
//
// Transforms and colors geometry.
//***************************************************************************************

cbuffer cbPerObject : register(b0)
{
	float4x4 gWorldViewProj; 
	float gTime;
	float4 gPulseColor;
};

struct VertexIn
{
	float3 PosL  : POSITION;
    float4 Color : COLOR;
};

struct VertexOut
{
	float4 PosH  : SV_POSITION;
    float4 Color : COLOR;
};

VertexOut VS(VertexIn vin)
{
	VertexOut vout;
	
	// Transform to homogeneous clip space.
	vout.PosH = mul(float4(vin.PosL, 1.0f), gWorldViewProj);
	
	// Just pass vertex color into the pixel shader.
    vout.Color = vin.Color;
    
    return vout;
}

float4 PS(VertexOut pin) : SV_Target
{
	const float pi = 3.1415926;

	// 시간에 따른 색상 변화 효과를 위한 셰이더 코드
	// float4 SmoothColor = pin.Color;
	// SmoothColor.x = smoothstep(0, 1, sin(gTime));

	// 픽셀 셰이더가 보간된 정점 색상과 상수 버퍼를 통해 주어진 gPulseColor 색상 사이에서 매끄럽게 진동하는 색상을 출력
	float s = 0.5 * sin(2 * gTime - 0.25f * pi) + 0.5f; // 0 ~ 1 값
	float4 c = lerp(pin.Color, gPulseColor, s);

	return c;
}



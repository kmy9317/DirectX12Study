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

	// �ð��� ���� ���� ��ȭ ȿ���� ���� ���̴� �ڵ�
	// float4 SmoothColor = pin.Color;
	// SmoothColor.x = smoothstep(0, 1, sin(gTime));

	// �ȼ� ���̴��� ������ ���� ����� ��� ���۸� ���� �־��� gPulseColor ���� ���̿��� �Ų����� �����ϴ� ������ ���
	float s = 0.5 * sin(2 * gTime - 0.25f * pi) + 0.5f; // 0 ~ 1 ��
	float4 c = lerp(pin.Color, gPulseColor, s);

	return c;
}


#include <iostream>
using namespace std;


#include <windows.h>
#include <DirectXMath.h>
#include <DirectXPackedVector.h>
using namespace DirectX;
using namespace PackedVector;

ostream& XM_CALLCONV operator<<(ostream& os, FXMVECTOR v)
{
	XMFLOAT4 dest;
	XMStoreFloat4(&dest, v);

	os << "(" << dest.x << ", " << dest.y << ", " << dest.z << ", " << dest.w << ")";
	return os;
}

int main()
{
	cout.setf(ios_base::boolalpha);

	if (!XMVerifyCPUSupport())
	{
		cout << "Not Support DirectXMath!" << endl;
		return 0;
	}

	XMVECTOR n = XMVectorSet(1.f, 0.f, 0.f, 0.f);
	XMVECTOR u = XMVectorSet(1.f, 2.f, 3.f, 0.f);
	XMVECTOR v = XMVectorSet(-2.f, 1.f, -3.f, 0.f);
	XMVECTOR w = XMVectorSet(0.707f, 0.707f, 0.f, 0.f);

	XMVECTOR a = n + u;
	XMVECTOR s = XMVector3Dot(u, v);
	XMVECTOR e = XMVector3Cross(u, v);
	XMVECTOR projW;
	XMVECTOR perpW;
	XMVector3ComponentsFromNormal(&projW, &perpW, w, n);
	XMVECTOR angleVec = XMVector2AngleBetweenVectors(projW, perpW);
	float angleRadians = XMVectorGetX(angleVec);
	float angleDegrees = XMConvertToDegrees(angleRadians);

	cout << projW << endl;
	cout << perpW << endl;
	cout << angleVec << endl;
	cout << angleRadians << endl;
	cout << angleDegrees << endl;

	XMMATRIX

}
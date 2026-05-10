# DirectX12Study

Frank Luna의 *Introduction to 3D Game Programming with DirectX 12* 를 기반으로 한
[인프런 「언리얼 3D MMORPG Part 2」](https://www.inflearn.com/course/%EC%96%B8%EB%A6%AC%EC%96%BC-3d-mmorpg-2/dashboard?cid=326418)
강의의 DirectX 학습 파트를 따라가며 작성한 클론 프로젝트입니다.
실시간 렌더링 파이프라인의 구조와 셰이더 단계, GPU 자원 관리 방식을 학습하는 것이 목적입니다.

---

## 📋 프로젝트 개요

| 항목 | 내용 |
|------|------|
| 목적 | DirectX 12 렌더링 파이프라인 학습 |
| API | DirectX 12 (Direct3D 12) |
| 언어 | C++ / HLSL |
| 빌드 환경 | Visual Studio 2019, Windows 10 SDK |
| 플랫폼 | Windows (Win32 / x64) |
| 학습 기간 | 2023.03 ~ 2023.05 |

---

## 📚 학습 내용

각 폴더는 하나의 주제를 다루는 독립 솔루션으로 구성되어 있습니다.

| 폴더 | 주제 | 학습한 핵심 개념 |
|------|------|------------------|
| `DrawinginDirect3DBoxColorAnim` | 기본 렌더링 | 디바이스/스왑체인 초기화, Root Signature, PSO, Constant Buffer, MVP 변환 |
| `DrawingLandAndWaves` | 동적 지오메트리 | 절차적 메시 생성, 동적 Vertex Buffer 갱신, Upload/Default Buffer 차이 |
| `Lighting` | 조명 | Directional / Point / Spot Light, Material 상수 버퍼, 시간 기반 라이트 강도 변화 |
| `FlareWhirling` | 텍스처 매핑 | DDS 텍스처 로딩, 샘플러 상태, UV 변환 행렬, 다중 텍스처 합성 |
| `OutlineEffectWithComputeShader` | 후처리 | Compute Shader, Sobel 엣지 검출, 오프스크린 렌더 타겟, UAV / SRV 상태 전환 |
| `Tessellation` | 곡면 세분화 | Hull / Domain Shader, 카메라 거리 기반 LOD, 변위(displacement) |
| `InstancingAndFrustumCulling` | 최적화 | Structured Buffer 인스턴싱, `BoundingFrustum` 기반 CPU 컬링, 텍스처 배열 |

---

## 🧩 공통 프레임워크에서 익힌 패턴

- **D3DApp 베이스 클래스 상속 구조** — 윈도우/디바이스/스왑체인 초기화와 메시지 루프를 분리
- **Frame Resource 패턴** — `gNumFrameResources = 3`으로 CPU-GPU 비동기 처리, Fence로 동기화
- **RenderItem / RenderLayer 추상화** — 그리기 단위와 PSO 그룹을 분리해 드로우 호출을 단순화
- **상수 버퍼 계층 분리** — `PassConstants` (프레임 공통) / `ObjectConstants` (오브젝트별) / `MaterialConstants` (머티리얼별)
- **Descriptor Heap 관리** — CBV/SRV/UAV, RTV, DSV 힙을 용도별로 분리해서 사용
- **`UploadBuffer<T>` 템플릿** — 상수 버퍼와 동적 버퍼를 같은 인터페이스로 다루는 헬퍼 활용

---

## 🎨 다뤄본 셰이더 단계

| 단계 | 사용 예시 |
|------|----------|
| Vertex Shader (VS) | 모든 프로젝트 — 정점 변환, 인스턴스 데이터 페치 |
| Hull Shader (HS) | Tessellation — 거리 기반 테셀레이션 팩터 계산 |
| Domain Shader (DS) | Tessellation — 쌍선형 보간 후 변위 적용 |
| Pixel Shader (PS) | 모든 프로젝트 — 조명 계산, 텍스처 샘플링 |
| Compute Shader (CS) | Outline 후처리 — Sobel 필터 (16×16 스레드 그룹) |

---

## 🛠️ 사용 기술

- DirectX 12 (Direct3D 12, DXGI)
- HLSL (Shader Model 5.1)
- DirectXMath
- Windows SDK
- Microsoft `d3dx12.h` 헬퍼

---

## 📂 참고

코드 전반의 베이스 프레임워크(`Common/`)는 Frank Luna 책의 공식 샘플을 기반으로 하며,
학습 과정에서 강의에 따라 일부를 직접 작성·수정했습니다.

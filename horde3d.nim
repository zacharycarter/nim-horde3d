# 
# *************************************************************************************************
#
# Horde3D
#   Next-Generation Graphics Engine
# --------------------------------------
# Copyright (C) 2006-2009 Nicolas Schulz
#
# This software is distributed under the terms of the Eclipse Public License v1.0.
# A copy of the license may be obtained at: http://www.eclipse.org/legal/epl-v10.html
#
# 
# *************************************************************************************************

{.deadCodeElim: on.}

when defined(Linux):
  const libName = "libHorde3D.so"

type
  H3DRes* = cint
  H3DNode* = cint

  H3DOptions* {.size: sizeof(cint), pure.} = enum 
    MaxLogLevel = 1, MaxNumMessages, TrilinearFiltering, MaxAnisotropy, 
    TexCompression, SRGBLinearization, LoadTextures, FastAnimation, 
    ShadowMapSize, SampleCount, WireframeMode, DebugViewMode, DumpFailedShaders, 
    GatherTimeStats

  H3DStats* {.size: sizeof(cint), pure.} = enum 
    TriCount = 100, BatchCount, LightPassCount, FrameTime, AnimationTime, 
    GeoUpdateTime, ParticleSimTime, FwdLightsGPUTime, DefLightsGPUTime, 
    ShadowsGPUTime, ParticleGPUTime, TextureVMem, GeometryVMem

  H3DResTypes* {.size: sizeof(cint), pure.} = enum 
    Undefined = 0, SceneGraph, Geometry, Animation, Material, Code, Shader, 
    Texture, ParticleEffect, Pipeline

  H3DResFlags* {.size: sizeof(cint), pure.} = enum 
    NoQuery = 1, NoTexCompression = 2, NoTexMipmaps = 4, TexCubemap = 8, 
    TexDynamic = 16, TexRenderable = 32, TexSRGB = 64

  H3DFormats* {.size: sizeof(cint), pure.} = enum 
    Unknown = 0, TEX_BGRA8, TEX_DXT1, TEX_DXT3, TEX_DXT5, TEX_RGBA16F, 
    TEX_RGBA32F

  H3DGeoRes* {.size: sizeof(cint), pure.} = enum 
    GeometryElem = 200, GeoIndexCountI, GeoVertexCountI, GeoIndices16I, 
    GeoIndexStream, GeoVertPosStream, GeoVertTanStream, GeoVertStaticStream

  H3DAnimRes* {.size: sizeof(cint), pure.} = enum 
    EntityElem = 300, EntFrameCountI

  H3DMatRes* {.size: sizeof(cint), pure.} = enum 
    MaterialElem = 400, SamplerElem, UniformElem, MatClassStr, MatLinkI, 
    MatShaderI, SampNameStr, SampTexResI, UnifNameStr, UnifValueF4

  H3DShaderRes* {.size: sizeof(cint), pure.} = enum 
    ContextElem = 600, SamplerElem, UniformElem, ContNameStr, SampNameStr, 
    SampDefTexResI, UnifNameStr, UnifSizeI, UnifDefValueF4

  H3DTexRes* {.size: sizeof(cint), pure.} = enum 
    TextureElem = 700, ImageElem, TexFormatI, TexSliceCountI, ImgWidthI, 
    ImgHeightI, ImgPixelStream, TexNativeRefI

  H3DPartEffRes* {.size: sizeof(cint), pure.} = enum 
    ParticleElem = 800, ChanMoveVelElem, ChanRotVelElem, ChanSizeElem, 
    ChanColRElem, ChanColGElem, ChanColBElem, ChanColAElem, PartLifeMinF, 
    PartLifeMaxF, ChanStartMinF, ChanStartMaxF, ChanEndRateF, ChanDragElem

  H3DPipeRes* {.size: sizeof(cint), pure.} = enum 
    StageElem = 900, StageNameStr, StageActivationI

  H3DNodeTypes* {.size: sizeof(cint), pure.} = enum 
    Undefined = 0, Group, Model, Mesh, Joint, Light, Camera, Emitter

  H3DNodeFlags* {.size: sizeof(cint), pure.} = enum 
    NoDraw = 1, NoCastShadow = 2, NoRayQuery = 4, Inactive = 7

  H3DNodeParams* {.size: sizeof(cint), pure.} = enum 
    NameStr = 1, AttachmentStr

  H3DModel* {.size: sizeof(cint), pure.} = enum 
    GeoResI = 200, SWSkinningI, LodDist1F, LodDist2F, LodDist3F, LodDist4F, 
    AnimCountI

  H3DMesh* {.size: sizeof(cint), pure.} = enum 
    MatResI = 300, BatchStartI, BatchCountI, VertRStartI, VertREndI, LodLevelI

  H3DJoint* {.size: sizeof(cint), pure.} = enum 
    JointIndexI = 400

  H3DLight* {.size: sizeof(cint), pure.} = enum 
    MatResI = 500, RadiusF, FovF, ColorF3, ColorMultiplierF, ShadowMapCountI, 
    ShadowSplitLambdaF, ShadowMapBiasF, LightingContextStr, ShadowContextStr

  H3DCamera* {.size: sizeof(cint), pure.} = enum 
    PipeResI = 600, OutTexResI, OutBufIndexI, LeftPlaneF, RightPlaneF, 
    BottomPlaneF, TopPlaneF, NearPlaneF, FarPlaneF, ViewportXI, ViewportYI, 
    ViewportWidthI, ViewportHeightI, OrthoI, OccCullingI

  H3DEmitter* {.size: sizeof(cint), pure.} = enum 
    MatResI = 700, PartEffResI, MaxCountI, RespawnCountI, DelayF, EmissionRateF, 
    SpreadAngleF, ForceF3

  H3DModelUpdateFlags* {.size: sizeof(cint), pure.} = enum 
    Animation = 1, Geometry = 2

const H3DRootNode*: H3DNode = cint(1)

proc h3dGetVersionString*(): cstring {.importc: "h3dGetVersionString", 
                                       dynlib: libName.}

proc h3dCheckExtension*(extensionName: cstring): bool {.
    importc: "h3dCheckExtension", dynlib: libName.}

proc h3dGetError*(): bool {.importc: "h3dGetError", dynlib: libName.}

proc h3dInit*(): bool {.importc: "h3dInit", dynlib: libName.}

proc h3dRelease*() {.importc: "h3dRelease", dynlib: libName.}

proc h3dRender*(cameraNode: H3DNode) {.importc: "h3dRender", dynlib: libName.}

proc h3dFinalizeFrame*() {.importc: "h3dFinalizeFrame", dynlib: libName.}

proc h3dClear*() {.importc: "h3dClear", dynlib: libName.}

proc h3dGetMessage*(level: ptr cint; time: ptr cfloat): cstring {.
    importc: "h3dGetMessage", dynlib: libName.}

proc h3dGetOption*(param: H3DOptions): cfloat {.importc: "h3dGetOption", 
    dynlib: libName.}

proc h3dSetOption*(param: H3DOptions; value: cfloat): bool {.
    importc: "h3dSetOption", dynlib: libName.}

proc h3dGetStat*(param: H3DStats; reset: bool): cfloat {.importc: "h3dGetStat", 
    dynlib: libName.}

proc h3dShowOverlays*(verts: ptr cfloat; vertCount: cint; colR: cfloat; 
                      colG: cfloat; colB: cfloat; colA: cfloat; 
                      materialRes: H3DRes; flags: cint) {.
    importc: "h3dShowOverlays", dynlib: libName.}

proc h3dClearOverlays*() {.importc: "h3dClearOverlays", dynlib: libName.}

proc h3dGetResType*(res: H3DRes): cint {.importc: "h3dGetResType", 
    dynlib: libName.}

proc h3dGetResName*(res: H3DRes): cstring {.importc: "h3dGetResName", 
    dynlib: libName.}

proc h3dGetNextResource*(`type`: H3DResTypes; start: H3DRes): H3DRes {.
    importc: "h3dGetNextResource", dynlib: libName.}

proc h3dFindResource*(`type`: H3DResTypes; name: cstring): H3DRes {.
    importc: "h3dFindResource", dynlib: libName.}

proc h3dAddResource*(`type`: H3DResTypes; name: cstring; flags: cint): H3DRes {.
    importc: "h3dAddResource", dynlib: libName.}

proc h3dCloneResource*(sourceRes: H3DRes; name: cstring): H3DRes {.
    importc: "h3dCloneResource", dynlib: libName.}

proc h3dRemoveResource*(res: H3DRes): cint {.importc: "h3dRemoveResource", 
    dynlib: libName.}

proc h3dIsResLoaded*(res: H3DRes): bool {.importc: "h3dIsResLoaded", 
    dynlib: libName.}

proc h3dLoadResource*(res: H3DRes; data: cstring; size: cint): bool {.
    importc: "h3dLoadResource", dynlib: libName.}

proc h3dUnloadResource*(res: H3DRes) {.importc: "h3dUnloadResource", 
                                       dynlib: libName.}

proc h3dGetResElemCount*(res: H3DRes; elem: cint): cint {.
    importc: "h3dGetResElemCount", dynlib: libName.}

proc h3dFindResElem*(res: H3DRes; elem: cint; param: cint; value: cstring): cint {.
    importc: "h3dFindResElem", dynlib: libName.}

proc h3dGetResParamI*(res: H3DRes; elem: cint; elemIdx: cint; param: cint): cint {.
    importc: "h3dGetResParamI", dynlib: libName.}

proc h3dSetResParamI*(res: H3DRes; elem: cint; elemIdx: cint; param: cint; 
                      value: cint) {.importc: "h3dSetResParamI", dynlib: libName.}

proc h3dGetResParamF*(res: H3DRes; elem: cint; elemIdx: cint; param: cint; 
                      compIdx: cint): cfloat {.importc: "h3dGetResParamF", 
    dynlib: libName.}

proc h3dSetResParamF*(res: H3DRes; elem: cint; elemIdx: cint; param: cint; 
                      compIdx: cint; value: cfloat) {.
    importc: "h3dSetResParamF", dynlib: libName.}

proc h3dGetResParamStr*(res: H3DRes; elem: cint; elemIdx: cint; param: cint): cstring {.
    importc: "h3dGetResParamStr", dynlib: libName.}

proc h3dSetResParamStr*(res: H3DRes; elem: cint; elemIdx: cint; param: cint; 
                        value: cstring) {.importc: "h3dSetResParamStr", 
    dynlib: libName.}

proc h3dMapResStream*(res: H3DRes; elem: cint; elemIdx: cint; stream: cint; 
                      read: bool; write: bool): pointer {.
    importc: "h3dMapResStream", dynlib: libName.}

proc h3dUnmapResStream*(res: H3DRes) {.importc: "h3dUnmapResStream", 
                                       dynlib: libName.}

proc h3dQueryUnloadedResource*(index: cint): H3DRes {.
    importc: "h3dQueryUnloadedResource", dynlib: libName.}

proc h3dReleaseUnusedResources*() {.importc: "h3dReleaseUnusedResources", 
                                    dynlib: libName.}

proc h3dCreateTexture*(name: cstring; width: cint; height: cint; fmt: cint; 
                       flags: cint): H3DRes {.importc: "h3dCreateTexture", 
    dynlib: libName.}

proc h3dSetShaderPreambles*(vertPreamble: cstring; fragPreamble: cstring) {.
    importc: "h3dSetShaderPreambles", dynlib: libName.}

proc h3dSetMaterialUniform*(materialRes: H3DRes; name: cstring; a: cfloat; 
                            b: cfloat; c: cfloat; d: cfloat): bool {.
    importc: "h3dSetMaterialUniform", dynlib: libName.}

proc h3dResizePipelineBuffers*(pipeRes: H3DRes; width: cint; height: cint) {.
    importc: "h3dResizePipelineBuffers", dynlib: libName.}

proc h3dGetRenderTargetData*(pipelineRes: H3DRes; targetName: cstring; 
                             bufIndex: cint; width: ptr cint; height: ptr cint; 
                             compCount: ptr cint; dataBuffer: pointer; 
                             bufferSize: cint): bool {.
    importc: "h3dGetRenderTargetData", dynlib: libName.}

proc h3dGetNodeType*(node: H3DNode): cint {.importc: "h3dGetNodeType", 
    dynlib: libName.}

proc h3dGetNodeParent*(node: H3DNode): H3DNode {.importc: "h3dGetNodeParent", 
    dynlib: libName.}

proc h3dSetNodeParent*(node: H3DNode; parent: H3DNode): bool {.
    importc: "h3dSetNodeParent", dynlib: libName.}

proc h3dGetNodeChild*(node: H3DNode; index: cint): H3DNode {.
    importc: "h3dGetNodeChild", dynlib: libName.}

proc h3dAddNodes*(parent: H3DNode; sceneGraphRes: H3DRes): H3DNode {.
    importc: "h3dAddNodes", dynlib: libName.}

proc h3dRemoveNode*(node: H3DNode) {.importc: "h3dRemoveNode", dynlib: libName.}

proc h3dCheckNodeTransFlag*(node: H3DNode; reset: bool): bool {.
    importc: "h3dCheckNodeTransFlag", dynlib: libName.}

proc h3dGetNodeTransform*(node: H3DNode; tx: ptr cfloat; ty: ptr cfloat; 
                          tz: ptr cfloat; rx: ptr cfloat; ry: ptr cfloat; 
                          rz: ptr cfloat; sx: ptr cfloat; sy: ptr cfloat; 
                          sz: ptr cfloat) {.importc: "h3dGetNodeTransform", 
    dynlib: libName.}

proc h3dSetNodeTransform*(node: H3DNode; tx: cfloat; ty: cfloat; tz: cfloat; 
                          rx: cfloat; ry: cfloat; rz: cfloat; sx: cfloat; 
                          sy: cfloat; sz: cfloat) {.
    importc: "h3dSetNodeTransform", dynlib: libName.}

proc h3dGetNodeTransMats*(node: H3DNode; relMat: ptr ptr cfloat; 
                          absMat: ptr ptr cfloat) {.
    importc: "h3dGetNodeTransMats", dynlib: libName.}

proc h3dSetNodeTransMat*(node: H3DNode; mat4x4: ptr cfloat) {.
    importc: "h3dSetNodeTransMat", dynlib: libName.}

proc h3dGetNodeParamI*(node: H3DNode; param: cint): cint {.
    importc: "h3dGetNodeParamI", dynlib: libName.}

proc h3dSetNodeParamI*(node: H3DNode; param: cint; value: cint) {.
    importc: "h3dSetNodeParamI", dynlib: libName.}

proc h3dGetNodeParamF*(node: H3DNode; param: cint; compIdx: cint): cfloat {.
    importc: "h3dGetNodeParamF", dynlib: libName.}

proc h3dSetNodeParamF*(node: H3DNode; param: cint; compIdx: cint; value: cfloat) {.
    importc: "h3dSetNodeParamF", dynlib: libName.}

proc h3dGetNodeParamStr*(node: H3DNode; param: cint): cstring {.
    importc: "h3dGetNodeParamStr", dynlib: libName.}

proc h3dSetNodeParamStr*(node: H3DNode; param: cint; value: cstring) {.
    importc: "h3dSetNodeParamStr", dynlib: libName.}

proc h3dGetNodeFlags*(node: H3DNode): cint {.importc: "h3dGetNodeFlags", 
    dynlib: libName.}

proc h3dSetNodeFlags*(node: H3DNode; flags: cint; recursive: bool) {.
    importc: "h3dSetNodeFlags", dynlib: libName.}

proc h3dGetNodeAABB*(node: H3DNode; minX: ptr cfloat; minY: ptr cfloat; 
                     minZ: ptr cfloat; maxX: ptr cfloat; maxY: ptr cfloat; 
                     maxZ: ptr cfloat) {.importc: "h3dGetNodeAABB", 
    dynlib: libName.}

proc h3dFindNodes*(startNode: H3DNode; name: cstring; `type`: cint): cint {.
    importc: "h3dFindNodes", dynlib: libName.}

proc h3dGetNodeFindResult*(index: cint): H3DNode {.
    importc: "h3dGetNodeFindResult", dynlib: libName.}

proc h3dSetNodeUniforms*(node: H3DNode; uniformData: ptr cfloat; count: cint) {.
    importc: "h3dSetNodeUniforms", dynlib: libName.}

proc h3dCastRay*(node: H3DNode; ox: cfloat; oy: cfloat; oz: cfloat; dx: cfloat; 
                 dy: cfloat; dz: cfloat; numNearest: cint): cint {.
    importc: "h3dCastRay", dynlib: libName.}

proc h3dGetCastRayResult*(index: cint; node: ptr H3DNode; distance: ptr cfloat; 
                          intersection: ptr cfloat): bool {.
    importc: "h3dGetCastRayResult", dynlib: libName.}

proc h3dCheckNodeVisibility*(node: H3DNode; cameraNode: H3DNode; 
                             checkOcclusion: bool; calcLod: bool): cint {.
    importc: "h3dCheckNodeVisibility", dynlib: libName.}

proc h3dAddGroupNode*(parent: H3DNode; name: cstring): H3DNode {.
    importc: "h3dAddGroupNode", dynlib: libName.}

proc h3dAddModelNode*(parent: H3DNode; name: cstring; geometryRes: H3DRes): H3DNode {.
    importc: "h3dAddModelNode", dynlib: libName.}

proc h3dSetupModelAnimStage*(modelNode: H3DNode; stage: cint; 
                             animationRes: H3DRes; layer: cint; 
                             startNode: cstring; additive: bool) {.
    importc: "h3dSetupModelAnimStage", dynlib: libName.}

proc h3dGetModelAnimParams*(modelNode: H3DNode; stage: cint; time: ptr cfloat; 
                            weight: ptr cfloat) {.
    importc: "h3dGetModelAnimParams", dynlib: libName.}

proc h3dSetModelAnimParams*(modelNode: H3DNode; stage: cint; time: cfloat; 
                            weight: cfloat) {.importc: "h3dSetModelAnimParams", 
    dynlib: libName.}

proc h3dSetModelMorpher*(modelNode: H3DNode; target: cstring; weight: cfloat): bool {.
    importc: "h3dSetModelMorpher", dynlib: libName.}

proc h3dUpdateModel*(modelNode: H3DNode; flags: cint) {.
    importc: "h3dUpdateModel", dynlib: libName.}

proc h3dAddMeshNode*(parent: H3DNode; name: cstring; materialRes: H3DRes; 
                     batchStart: cint; batchCount: cint; vertRStart: cint; 
                     vertREnd: cint): H3DNode {.importc: "h3dAddMeshNode", 
    dynlib: libName.}

proc h3dAddJointNode*(parent: H3DNode; name: cstring; jointIndex: cint): H3DNode {.
    importc: "h3dAddJointNode", dynlib: libName.}

proc h3dAddLightNode*(parent: H3DNode; name: cstring; materialRes: H3DRes; 
                      lightingContext: cstring; shadowContext: cstring): H3DNode {.
    importc: "h3dAddLightNode", dynlib: libName.}

proc h3dAddCameraNode*(parent: H3DNode; name: cstring; pipelineRes: H3DRes): H3DNode {.
    importc: "h3dAddCameraNode", dynlib: libName.}

proc h3dSetupCameraView*(cameraNode: H3DNode; fov: cfloat; aspect: cfloat; 
                         nearDist: cfloat; farDist: cfloat) {.
    importc: "h3dSetupCameraView", dynlib: libName.}

proc h3dGetCameraProjMat*(cameraNode: H3DNode; projMat: ptr cfloat) {.
    importc: "h3dGetCameraProjMat", dynlib: libName.}

proc h3dSetCameraProjMat*(cameraNode: H3DNode; projMat: ptr cfloat) {.
    importc: "h3dSetCameraProjMat", dynlib: libName.}

proc h3dAddEmitterNode*(parent: H3DNode; name: cstring; materialRes: H3DRes; 
                        particleEffectRes: H3DRes; maxParticleCount: cint; 
                        respawnCount: cint): H3DNode {.
    importc: "h3dAddEmitterNode", dynlib: libName.}

proc h3dUpdateEmitter*(emitterNode: H3DNode; timeDelta: cfloat) {.
    importc: "h3dUpdateEmitter", dynlib: libName.}

proc h3dHasEmitterFinished*(emitterNode: H3DNode): bool {.
    importc: "h3dHasEmitterFinished", dynlib: libName.}
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
  const libHorde3DUtils* = "libHorde3DUtils.so"

import 
  horde3d

const H3DUTMaxStatMode*: cint = 2

proc h3dutFreeMem*(`ptr`: cstringArray) {.importc: "h3dutFreeMem", 
    dynlib: libHorde3DUtils.}

proc h3dutDumpMessages*(): bool {.importc: "h3dutDumpMessages", 
                                  dynlib: libHorde3DUtils.}

proc h3dutGetResourcePath*(`type`: cint): cstring {.
    importc: "h3dutGetResourcePath", dynlib: libHorde3DUtils.}

proc h3dutSetResourcePath*(`type`: cint; path: cstring) {.
    importc: "h3dutSetResourcePath", dynlib: libHorde3DUtils.}

proc h3dutLoadResourcesFromDisk*(contentDir: cstring): bool {.
    importc: "h3dutLoadResourcesFromDisk", dynlib: libHorde3DUtils.}

proc h3dutCreateGeometryRes*(name: cstring; numVertices: cint; 
                             numTriangleIndices: cint; posData: ptr cfloat; 
                             indexData: ptr cuint; normalData: ptr cshort; 
                             tangentData: ptr cshort; bitangentData: ptr cshort; 
                             texData1: ptr cfloat; texData2: ptr cfloat): H3DRes {.
    importc: "h3dutCreateGeometryRes", dynlib: libHorde3DUtils.}

proc h3dutCreateTGAImage*(pixels: ptr cuchar; width: cint; height: cint; 
                          bpp: cint; outData: cstringArray; outSize: ptr cint): bool {.
    importc: "h3dutCreateTGAImage", dynlib: libHorde3DUtils.}

proc h3dutScreenshot*(filename: cstring): bool {.importc: "h3dutScreenshot", 
    dynlib: libHorde3DUtils.}

proc h3dutPickRay*(cameraNode: H3DNode; nwx: cfloat; nwy: cfloat; 
                   ox: ptr cfloat; oy: ptr cfloat; oz: ptr cfloat; 
                   dx: ptr cfloat; dy: ptr cfloat; dz: ptr cfloat) {.
    importc: "h3dutPickRay", dynlib: libHorde3DUtils.}

proc h3dutPickNode*(cameraNode: H3DNode; nwx: cfloat; nwy: cfloat): H3DNode {.
    importc: "h3dutPickNode", dynlib: libHorde3DUtils.}

proc h3dutShowText*(text: cstring; x: cfloat; y: cfloat; size: cfloat; 
                    colR: cfloat; colG: cfloat; colB: cfloat; 
                    fontMaterialRes: H3DRes) {.importc: "h3dutShowText", 
    dynlib: libHorde3DUtils.}

proc h3dutShowFrameStats*(fontMaterialRes: H3DRes; panelMaterialRes: H3DRes; 
                          mode: cint) {.importc: "h3dutShowFrameStats", 
                                        dynlib: libHorde3DUtils.}
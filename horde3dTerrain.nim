# 
# *************************************************************************************************
#
# Horde3D Terrain Extension
# --------------------------------------------------------
# Copyright (C) 2006-2009 Nicolas Schulz and Volker Wiendl
#
# This software is distributed under the terms of the Eclipse Public License v1.0.
# A copy of the license may be obtained at: http://www.eclipse.org/legal/epl-v10.html
#
# 
# *************************************************************************************************

 {.deadCodeElim: on.}
const 
  libHorde3D* = "libHorde3D.so"


import 
  horde3d


var H3DEXT_NodeType_Terrain* {.importc: "H3DEXT_NodeType_Terrain", 
                               dynlib: libHorde3D.}: cint

type 
  H3DEXTTerrain* {.size: sizeof(cint).} = enum 
    HeightTexResI = 10000, MatResI, MeshQualityF, SkirtHeightF, BlockSizeI



proc h3dextAddTerrainNode*(parent: H3DNode; name: cstring; heightMapRes: H3DRes; 
                           materialRes: H3DRes): H3DNode {.
    importc: "h3dextAddTerrainNode", dynlib: libHorde3D.}

proc h3dextCreateTerrainGeoRes*(node: H3DNode; resName: cstring; 
                                meshQuality: cfloat): H3DRes {.
    importc: "h3dextCreateTerrainGeoRes", dynlib: libHorde3D.}
# About
This is a Horde3D wrapper for nim. Nearly same as https://github.com/fowlmouth/horde3d but with some advantages:
- All names remain the same as in Horde3D header files (compare `H3DMatRes.SamplerElem` against fowlmouth's `H3DMatRes.Mat_SamplerElem`). To avoid ambiguity `{.pure.}` pragma on enums is used. That means that you have to always be explicit with Horde3D enums, like this: `H3DMatRes.SamplerElem` (`SamplerElem` is not allowed).
- This project is more up-to-date and is built against Horde3D 1.0.0 beta 5.

# License
MIT. Do whatever you want.

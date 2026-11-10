# Architecture

```text
Camera -> FPGA RGB stream -> grayscale/threshold -> resize/feature accelerator
                                                   |
                                                   v
                         host Python face encoder -> enrollment database
                                                   |
                                                   v
                                    identity + confidence overlay
```

The `rtl/face_preprocess.v` block is deliberately small and synthesizable. It consumes one RGB888 pixel per valid clock, emits a grayscale pixel and a threshold flag, and preserves end-of-frame signaling with `in_last`. The software pipeline currently runs face detection and embedding on the host; the FPGA front-end can be integrated by replacing `preprocess()` with a camera/FPGA transport adapter.

## Hardware integration

1. Stream camera pixels into `in_r`, `in_g`, `in_b` and assert `in_valid`.
2. Assert `in_last` on the final pixel of each frame.
3. Connect `out_gray` to a resize or CNN accelerator.
4. Use the host application for enrollment and identity matching until a hardware embedding accelerator is added.

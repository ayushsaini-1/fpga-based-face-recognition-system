# FPGA-Based Face Recognition System

A hardware/software reference implementation for real-time face recognition. The FPGA front-end performs streaming RGB-to-grayscale conversion and threshold preprocessing; the host application handles face embeddings, enrollment, and camera recognition.

## Repository layout

- `rtl/face_preprocess.v` - synthesizable RGB888 streaming preprocessor
- `rtl/tb_face_preprocess.v` - Icarus Verilog smoke-test bench
- `software/face_recognition_system.py` - enrollment and live recognition CLI
- `docs/architecture.md` - data path and hardware integration notes
- `docs/verification.md` - setup and verification instructions

## Quick start

```sh
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
python software/face_recognition_system.py enroll Alice photos/alice.jpg
python software/face_recognition_system.py run
```

Press `q` to exit the camera window. The recognition database is written to `data/encodings.pkl`; keep personal images and generated data out of version control.

## RTL test

With Icarus Verilog installed:

```sh
make test-rtl
```

The current design is a clean integration baseline: FPGA preprocessing is implemented in RTL, while face embeddings and identity matching remain on the host. A board-specific camera interface and CNN/embedding accelerator can be connected to the documented stream interface next.
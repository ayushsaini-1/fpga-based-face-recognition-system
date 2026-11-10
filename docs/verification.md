# Verification

Run the RTL smoke test with:

```sh
make test-rtl
```

The testbench checks reset behavior, valid propagation, grayscale conversion, threshold output, and frame-end propagation. For software setup:

```sh
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
python software/face_recognition_system.py enroll Alice photos/alice.jpg
python software/face_recognition_system.py run
```

Press `q` to stop the camera application. Do not commit the generated `data/encodings.pkl` file or personal photographs.

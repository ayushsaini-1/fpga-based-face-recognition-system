IVERILOG ?= iverilog
VVP ?= vvp

.PHONY: test-rtl

test-rtl:
	mkdir -p build
	$(IVERILOG) -g2012 -o build/tb_face_preprocess rtl/face_preprocess.v rtl/tb_face_preprocess.v
	$(VVP) build/tb_face_preprocess

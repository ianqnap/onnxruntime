#!/bin/bash

# The script is to generate all supported versions of onnx models which will be tested by onnx_test_runner
# in the end of ci build pipeline. The purpose is to make sure latest onnxruntime has no regressions. Note
# that the order of installation must be onnx123, onnx130, onnx141, onnx150 and onnxtip since we want
# to keep the tip of master on script exit for onnx backend test which is also a part of build pipeline.
# One possible improvement here is to keep the models saved to some public storage instead of generating
# on the fly every time.

set -e
PYTHON_VER=$1
version2tag=(1.2.3-onnx123
             1.3.0-onnx130
             1.4.1-onnx141
             1.5.0-onnx150
             1.6.0-onnx160)
for v2t in ${version2tag[*]}; do
  onnx_version="$(cut -d'-' -f1<<<${v2t})"
  onnx_tag="$(cut -d'-' -f2<<<${v2t})"
  if [ -z ${lastest_onnx_version+x} ]; then
    echo "first pass";
  else
    echo "deleting old onnx-${lastest_onnx_version}";
    python${PYTHON_VER} -m pip uninstall -y onnx
  fi
  python${PYTHON_VER} -m pip install onnx=$onnx_version
  mkdir -p /data/onnx/${onnx_tag}
  backend-test-tools generate-data -o /data/onnx/$onnx_tag
done

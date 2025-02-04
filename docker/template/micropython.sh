#!/bin/bash
export MICROPYPATH=./pysrc/device/firmware/:./pysrc/device/modules/:./pysrc/live
/micropython/ports/unix/build-standard/micropython $*
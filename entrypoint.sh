#!/bin/bash
service mjpgstreamer start
service RepetierServer start
exec "$@"

docker run -it --rm \
  --privileged \
   -v "$(pwd)/example:/root/example" \
  --pid=host \
  ebpf:v1

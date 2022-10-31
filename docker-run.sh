docker run -it --rm \
  --name ghmac \
  --privileged \
   -v "$(pwd)/example:/root/example" \
  --pid=host \
  ebpf:v1

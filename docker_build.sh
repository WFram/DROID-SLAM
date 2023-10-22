docker image build \
    --cpuset-cpus="0-7" \
    -t droid:latest \
    -f Dockerfile \
    .
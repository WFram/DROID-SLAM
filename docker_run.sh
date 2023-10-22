IMAGE_NAME="droid:latest"
CONTAINER_NAME="droid"

docker run \
    --rm \
    --name "$CONTAINER_NAME" \
    -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e HOME=$HOME \
    --net=host \
    -e DISPLAY=$DISPLAY \
    -w $(pwd) \
    -v $HOME:$HOME \
    -v /media:/media \
    --ipc host \
    --gpus all \
    --device=/dev/dri:/dev/dri \
    "$IMAGE_NAME" \
    bash
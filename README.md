# Zappa deployment with Docker


## Examples

### Pytorch Deployer run:

``` bash
docker run --rm -v "$PROJECT_DIR":/"$APP_DIR" \
-e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" -e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
-e stage="$STAGE" -e cmd="$CMD" -e arg="$ARG" gautamborg/zappa_deployer_pytorch:latest
```

### Pytorch Development server run:

``` bash
docker run -it --rm -p 5000:5000 -v "$PROJECT_DIR":"/$APP_DIR" gautamborg/zappa_developer_pytorch:latest
```

### Build Deployer:

``` bash
docker build -f Dockerfile.zappa_deployer_pytorch -t gautamborg/zappa_deployer_pytorch:latest .
```

### Build Developer:

```bash
docker build -f Dockerfile.zappa_developer_pytorch -t gautamborg/zappa_developer_pytorch:latest .
```

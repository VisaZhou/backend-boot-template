# 当脚本中的任一命令返回非零退出状态时立即终止执行。
set -e
# 在执行命令前打印命令及其参数，方便调试。
set -x

# 从.env文件中读取环境变量,只能在shell脚本中使用，不会自动传递到 docker build
source .env

# 登录阿里云的镜像仓库
echo "$REPOSITORY_PASSWORD" | docker login --username="$REPOSITORY_USERNAME" "$REPOSITORY_URL" --password-stdin

# 本地构建镜像，传递ARG参数
docker build \
  --build-arg REPOSITORY_URL="$REPOSITORY_URL" \
  --build-arg REPOSITORY_NAMESPACE="$REPOSITORY_NAMESPACE" \
  --build-arg PROJECT_VERSION="$PROJECT_VERSION" \
  --build-arg PROJECT_PORT="$PROJECT_PORT" \
  -t backend-boot-template:"$PROJECT_VERSION" .

# 上传前需要先打tag，将本地镜像标记为阿里云镜像仓库地址
docker tag backend-boot-template:"$PROJECT_VERSION" "$REPOSITORY_URL"/"$REPOSITORY_NAMESPACE"/backend-boot-template:"$PROJECT_VERSION"

# 上传镜像到阿里云的镜像仓库
docker push "$REPOSITORY_URL"/"$REPOSITORY_NAMESPACE"/backend-boot-template:"$PROJECT_VERSION"
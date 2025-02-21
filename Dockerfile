# 使用 OpenJDK 23 的官方基础镜像，这里使用 slim 版本，体积较小。
ARG REPOSITORY_URL
ARG REPOSITORY_NAMESPACE
FROM ${REPOSITORY_URL}/${REPOSITORY_NAMESPACE}/openjdk:23-jdk-slim

# 设置容器内的工作目录，后续操作会在此目录下执行。
WORKDIR /app

# 将当前项目目录（包含 mvnw 和 pom.xml 等文件）复制到 Docker 容器的 /app 目录。这样 Docker 容器中就能访问到 Maven Wrapper 和项目的源代码。
COPY . /app

# 在容器中执行 Maven 构建命令，构建项目并生成 JAR 文件。-DskipTests 参数会跳过测试，以加速构建过程。
RUN ./mvnw clean package -DskipTestsdoc

# 将构建好的 JAR 文件从 target 目录复制到容器的 /app 目录，并命名为 app.jar。
ARG PROJECT_VERSION
COPY target/backend-boot-template-${PROJECT_VERSION}-SNAPSHOT.jar app.jar

# 容器启动时运行的命令
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# 暴露容器的端口
ARG PROJECT_PORT
EXPOSE ${PROJECT_PORT}
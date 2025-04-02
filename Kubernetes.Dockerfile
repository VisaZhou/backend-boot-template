ARG REPOSITORY_URL
ARG REPOSITORY_NAMESPACE
# 使用 OpenJDK 23 的官方基础镜像，这里使用 slim 版本，体积较小。
FROM ${REPOSITORY_URL}/${REPOSITORY_NAMESPACE}/openjdk:23-jdk-slim  AS builder

# 设置容器内的工作目录，后续操作会在此目录下执行。
WORKDIR /app

# 将当前项目目录（包含 mvnw 和 pom.xml 等文件）复制到 Docker 容器的 /app 目录。这样 Docker 容器中就能访问到 Maven Wrapper 和项目的源代码。
COPY . /app

# 在容器中执行 Maven 构建命令，构建项目并生成 JAR 文件。
# -s 参数指定 Maven 使用 项目根目录的 settings.xml 文件作为配置文件。
# -Drevision=${PROJECT_VERSION} 用于设置项目版本号，对应于 pom.xml 中的 <version> 标签。
ARG PROJECT_VERSION
RUN ./mvnw clean package -Drevision=${PROJECT_VERSION} -s /app/settings.xml -X


FROM ${REPOSITORY_URL}/${REPOSITORY_NAMESPACE}/openjdk:23-jdk-slim
WORKDIR /app

# 将 builder 阶段构建好的 JAR 文件复制到容器的 /app 目录，并命名为 app.jar，builder阶段使用绝对路径。
ARG PROJECT_VERSION
COPY --from=builder /app/target/backend-boot-template-${PROJECT_VERSION}-SNAPSHOT.jar app.jar

# 容器启动时运行的命令
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# 暴露容器的端口
ARG PROJECT_PORT
EXPOSE ${PROJECT_PORT}
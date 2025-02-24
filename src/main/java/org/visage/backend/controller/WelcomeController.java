package org.visage.backend.controller;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class WelcomeController {

    @GetMapping("/getVersion")
    public String hello() {
        // 加载项目根目录下的 .env 文件
        Dotenv dotenv = Dotenv.load();
        // 读取 .env 文件中的变量
        String projectVersion = dotenv.get("PROJECT_VERSION");
        // 控制台打印，测试集群副本
        System.out.println("version: " + projectVersion);
        return "version：".concat(projectVersion);
    }
}

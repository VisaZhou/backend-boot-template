package org.visage.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class WelcomeController {

    @GetMapping("/getPodName")
    public String getPodName() {
        // 获取当前 Pod 名称
        String podName = System.getenv("HOSTNAME");
        return "Handled by Pod: " + podName;
    }
}

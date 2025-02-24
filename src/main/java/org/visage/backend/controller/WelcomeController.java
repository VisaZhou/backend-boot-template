package org.visage.backend.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class WelcomeController {

    @GetMapping("/getVersion")
    public String hello() {
        return "version：0.0.2";
    }
}

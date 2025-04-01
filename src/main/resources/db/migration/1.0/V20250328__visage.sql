CREATE TABLE `base_user`
(
    `id`             int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `uuid`           varchar(32)  DEFAULT NULL COMMENT 'uuid',
    `id_card`        varchar(64)  DEFAULT NULL COMMENT '证件号码',
    `id_card_type`   tinyint(4) DEFAULT NULL COMMENT '证件类型 1是身份证2香港3澳门4台湾5外籍',
    `sex`            tinyint(4) DEFAULT NULL COMMENT '性别 1男2女',
    `name`           varchar(32)  DEFAULT NULL COMMENT '姓名',
    `avatar`         varchar(255) DEFAULT NULL COMMENT '头像',
    `mobile`         varchar(32)  DEFAULT NULL COMMENT '手机号',
    `is_delete`      tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
    `created_time`   datetime     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `created_by`     int(10) unsigned DEFAULT NULL COMMENT '创建者 id',
    `modified_time`  datetime     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `modified_by`    int(10) unsigned DEFAULT NULL COMMENT '修改者 id',
    `request_id`     varchar(64)  DEFAULT NULL COMMENT '请求唯一标识',
    `event_id`       varchar(64)  DEFAULT NULL COMMENT '事件唯一标识',
    PRIMARY KEY (`id`) USING BTREE,
    KEY              `idx_uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58790 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
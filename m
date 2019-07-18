Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BCF6D4E8
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfGRToT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:44:19 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47443 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRToT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:19 -0400
Received: by mail-pg1-f202.google.com with SMTP id o19so17211295pgl.14
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xp3ecTtNAHqJkdcWL6adDos1ABQx+LyNLUf8CfzP0Ig=;
        b=ZlLOIpnLCtfHaZx6w871GqzN0rpps3Lcq5JfjC1eRGjrwwwT5MxgvWqb/P6BEB35rN
         zjxPUJQZ3aSvZ17nsDDa7y7D4Rk9VKu3Zqyd+kd51m7JC5rRPU5hsdYPvUgykxlHNGzJ
         stYJhevSns6B/W8PpwVW6GtgWwh8+JkYOS4jQqSua2bj35/ah25HZl79HTFfNe6cJKQ5
         AOB0IWe9NS2YSAwRfZxJjrN/3nRAGYo78ymvz8oI0VR/0ecse4yaWVwzqQPaY2a/qscP
         xk3tvF2NeIHGjXxbTP+ctWRTmyULD18sKhH0bI3SN79JVKy1EyuNQRoDlXvLksAvOX8r
         OEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xp3ecTtNAHqJkdcWL6adDos1ABQx+LyNLUf8CfzP0Ig=;
        b=K+V6tR+aBoHbjgKuATOSqJ59abCaaQNbSaWYrQ1EvmBs1TT7E71hfwhPgo4keiS6DP
         0LgCSSA29acAQzl3AlXPtKbFhfBlOpvyJ6nv9RYm7Xs8tKJY/uIut0VJIQtcx/uyOsb5
         bGPC16qwrBTmBFjhv7i2KG+TSuXmMUtFbba78Q2K3qWvbrgefe1wLEaspRbmH2oN0Exp
         wr/rgxxnekEEKjXd6d+X/2z8jbU7RC9qMbp1gWlPvaknwWZiD4DuIoZLAvRYsoL4MuGM
         hLkOzPHM64YgYiE8AZk6FZg6e7EbrLKM2N/Va6B0pn2DKaRjxVTMMDt90HP2skeeWp/m
         ihdg==
X-Gm-Message-State: APjAAAU/Jb6sQp3n8WXsnNnKrrYNoADD/rYklGCmu0f1FPQ8rozZl4/t
        LsWp7Bi6V2oU+6CHNQNCSj2OAC8kJdnrQTg7GhWSNg==
X-Google-Smtp-Source: APXvYqw6iv/IkO8z0G/6fsZ5m4780ywOZ7ifZyLtWG+ULLe0N+2yN/cFvlzzHlJh4YbfOFXsbIXh+DnY8DhO9Ne4F9C3sQ==
X-Received: by 2002:a63:204b:: with SMTP id r11mr9630785pgm.121.1563479058516;
 Thu, 18 Jul 2019 12:44:18 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:46 -0700
Message-Id: <20190718194415.108476-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 00/29] security: Add kernel lockdown functionality
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Minor changes to the previous set, other than a significant rework of
the "Ignore acpi_rsdp kernel param" patch to deal with the early parsing
of that parameter under certain circumstances.



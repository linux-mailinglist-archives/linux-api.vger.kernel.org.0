Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8998A339DBE
	for <lists+linux-api@lfdr.de>; Sat, 13 Mar 2021 12:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhCMLWy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Mar 2021 06:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCMLWr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Mar 2021 06:22:47 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45DC061574;
        Sat, 13 Mar 2021 03:22:47 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t85so3594477pfc.13;
        Sat, 13 Mar 2021 03:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ipwZXAeOkj4x/w6D+qXjWim/b+Oj74nRcEbuiSOjy2A=;
        b=X+/KGn/n4GB+i9z/vQ0kSa6ozRfBkh3x20YHoMt+pm+fF3WOyyFkQQpXJFOp6Ja35z
         buRy3Cx0mQvlNp31+en/oHTHdyBESn5GCiVGkSnyQqzrH8JA0EUb0aphY9W8TKCmrrWF
         AvgD6rHuRxOHoTiVfSHABN3NQdJQ0Tq+h/7hBxHcosCZrt/zPVeIgk2v++k9HvgpsAjM
         uN8Na6VAljva7gEL6/zX6uQXZYTskyyY4tBxac/7tpnFABpnBaa4fVfvu7rb3JMBBgfZ
         S7V7CDhxKALJsBJR0xRRR5snvuasi8pBsGTkmxOGCoZhC5zPYV5HbIVwHLC+pU9GYHzT
         abbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ipwZXAeOkj4x/w6D+qXjWim/b+Oj74nRcEbuiSOjy2A=;
        b=Tmlskbfn3AKH503NMzgxjBuNsLtpU0w+FNwEDNr+UtGV+oQQUHPWY454LlmtBadFb5
         kP+T4WWEYdRHAYH9io7k+1yA8gZb4/erEg0rmMc69N7jeu8FOAXNt3hjj8omWKfPKUC2
         TVBpTu66h3+tpNroS4r3A0jZZmAwpPIeXQrKmSVOuXE3B9q92y17G8T5v+ZpZB5C61ql
         5pkMSJj4+hGia3uWLs3M497yaru6BTO9PuhhpGZvhJRzUu6xOOn9vV3p24SDVtvISBgX
         x9P7B0GGou55v8OaS2zbB6/iCn29m/J67Fjiy3j7OJud24C897tvIymeHZiQjqhkT8nu
         wR2g==
X-Gm-Message-State: AOAM530Va2keaPEa8QL/wbBuKTweV6/e5HRfEcyo2C2jUgXrJcGwIBJo
        yTcvAkMfn/AJgn81PwePn3+fKNQnBys=
X-Google-Smtp-Source: ABdhPJxfLUj00FSS3KjGuLTUWUTs4zKTPAhm4qM/Uws9lD43riAS9VQI8ne9jOjWH3kFdv7EeYvq9w==
X-Received: by 2002:aa7:9614:0:b029:1fa:e77b:722 with SMTP id q20-20020aa796140000b02901fae77b0722mr2640647pfg.2.1615634567304;
        Sat, 13 Mar 2021 03:22:47 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id gw20sm4877763pjb.3.2021.03.13.03.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 03:22:46 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] lightnvm: remove duplicate include in lightnvm.h
Date:   Sat, 13 Mar 2021 03:22:41 -0800
Message-Id: <20210313112241.366786-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/ioctl.h' included in 'lightnvm.h' is duplicated.
It is also included in the 33th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 include/uapi/linux/lightnvm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
index ead2e72e5c88..2745afd9b8fa 100644
--- a/include/uapi/linux/lightnvm.h
+++ b/include/uapi/linux/lightnvm.h
@@ -22,7 +22,6 @@
 
 #ifdef __KERNEL__
 #include <linux/const.h>
-#include <linux/ioctl.h>
 #else /* __KERNEL__ */
 #include <stdio.h>
 #include <sys/ioctl.h>
-- 
2.25.1


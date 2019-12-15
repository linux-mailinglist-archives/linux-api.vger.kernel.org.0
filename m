Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BC11F82A
	for <lists+linux-api@lfdr.de>; Sun, 15 Dec 2019 15:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfLOO1i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 15 Dec 2019 09:27:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45535 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfLOO1i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Dec 2019 09:27:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so3846381ljc.12;
        Sun, 15 Dec 2019 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XRp3pZs8wQVKkEk3e51ElNHpt3EnjsV2sv/mTLc39w=;
        b=otAGr1f3hVHkqU6CE5I0EZFlKY2Z5IHefi4taVXx1kmWF0N7qr6gMTMFY1nwLoCMkj
         UErO0GbndIh2nLywEdYhykczrhagXkhz8xWtgZqW4ahoqPn5KCIu4ZFYo7zVLPDu7U3T
         auvJ0+u1eVvcqZ2O0Bf1HLcunU3M2PpFasDPP73iJryV1QUGBq1IOxcBDw2gQCQUAOo8
         DYIBTHPhO4yv6intO0CwHSt/RtIB4qryPOGEj/Ewdqdfz89NuMKM9C5ehWAv4oZy0ex1
         lY8+yNEO1BMX5kAbCuT0NtTY6vMPc9h3LkhJaoOshy699gY0sofe2ImRIZJh4NeRt2AH
         Qnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XRp3pZs8wQVKkEk3e51ElNHpt3EnjsV2sv/mTLc39w=;
        b=KgjtjhcsiImUPRDu36YLu645hW2Fud3pRnfr210r1lbDvyc8zdpZD7sx5avAxgfDdK
         i+6IHjHr5c4ukCocbSU0Nr9CZmtKv4IvwfH+8P9adDtBnBaUuBuEU3TShTJKy2L5HT/r
         k/Tyj52i1oXzumdzRvAJMV5hFvdS98OWhQ5mwD1Zit3w747P+YiJKbtYxiIg0lBjJZQi
         unuegFalFyFkaCr7sT/+zWOIHfpzG2+uihuV1kNFJ6p0wz1bRef8t+HAl5hspXssyNVj
         SYZqvlpRNHc0rSmSc86peRpQO74rg/s/sPHREIKZPKkf1bWzesrkQkwiQyce6LC+bd3H
         8WXg==
X-Gm-Message-State: APjAAAUwTST2eRxJI5c4qzmICifkJUwEeF5lIZEr+w0MTe1g3pvWaZ0X
        NUXzNqr15WyjVB/QChkt+K91jBn7RvM=
X-Google-Smtp-Source: APXvYqzZ8SA4fZhXYsUcqQRAh3duNgo1STYZnWJPrdrQcSTVMf6CWFbelTeD2VIkOK6+Jcs4gDcuiw==
X-Received: by 2002:a2e:b056:: with SMTP id d22mr16557226ljl.73.1576420055631;
        Sun, 15 Dec 2019 06:27:35 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id d11sm7172902lfj.3.2019.12.15.06.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 06:27:35 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-api@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v6 2/2] platform/x86: asus_wmi: Set throttle thermal policy to default
Date:   Sun, 15 Dec 2019 16:27:24 +0200
Message-Id: <20191215142724.13986-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191215142527.13780-1-leonmaxx@gmail.com>
References: <20191215142527.13780-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

ASUS TUF FX705DY/FX505DY starts in silent mode and under heavy
CPU load it overheats and drops CPU frequency to 399MHz and stays
at it until reboot [1]. Set throttle thermal policy to default
to avoid overheating and throttlig.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=203733

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f10ec9d745e5..469f1a852719 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1780,6 +1780,15 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 	return 0;
 }
 
+static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
+{
+	if (!asus->throttle_thermal_policy_available)
+		return 0;
+
+	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+	return throttle_thermal_policy_write(asus);
+}
+
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
@@ -2548,6 +2557,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 	err = throttle_thermal_policy_check_present(asus);
 	if (err)
 		goto fail_throttle_thermal_policy;
+	else
+		throttle_thermal_policy_set_default(asus);
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
-- 
2.24.0


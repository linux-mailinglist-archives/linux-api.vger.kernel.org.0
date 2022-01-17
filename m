Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9624D490BDB
	for <lists+linux-api@lfdr.de>; Mon, 17 Jan 2022 16:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbiAQP4e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jan 2022 10:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbiAQP4c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jan 2022 10:56:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9FC06173F
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 07:56:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c66so21340237wma.5
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAEFbpvN98ptmknkKWl0O8Ur86W+dj9ENZyY+Bs86R0=;
        b=R8t67VZFO1HmMGwZdmiWdCI77MtFkggjVAOUfJdmvVBjfSveEvCbzvA5UJ5rIDDNRL
         zRD3XKbZOaQJTs+DLOjBtyT09CdCloFMpIcVlIcaPrR0URZ6l2qenVfs/nYEiGf9cDDP
         sHkjHQkD+KBy4FlyH5qP2gJu7ikwmLErNC4j6yGVTYzZS0iY0rv9X/ITiH8OSC0m4+2O
         I2+IQc/bvYEgzVBPu+wEHfpOH6wQk2nQEjYWPgEfNFlYC7ASaTfigk7oSQD5sZa1L5oY
         2KlRFgLpbTJ0dMSs8w+S8OxEuSi2wJEsAbnBKQncMeS2GpvGrsbNl/ZTyFSWd3s2cvvA
         M3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAEFbpvN98ptmknkKWl0O8Ur86W+dj9ENZyY+Bs86R0=;
        b=C56Tb2YLirKS49YD8dJ/4ux0NAOiF7OD3I6kXj/0PyLpQ2kA8TMUrPAaTX1XKHmj4l
         3G8/a1LeyUMLzDrtNjyE6PQ5O22LUa3Ue4H0sI58qXhHm1NnpIRSG8jIQZl0XiTz/2uM
         ebyCQTZ68bP6SJoAyLMUNsdwTrtxcihajobXHuVi8BvhX74wsM3pxdFHgyteZreWgTfr
         4vMCQeaa6I1J6FkSUyF7PwEh7YsaibPDds6XVpfPvnZ6Si6sGm+BDxFCaGWcHSqPRMle
         y2PV0F+TfM6X5jUw+3Age2V2ZJu0QKDUvEes9CoInw7FbH5+snzJdBc7lq8Ef8ACAzrg
         eJHw==
X-Gm-Message-State: AOAM531rm83IwHtzJKK0HT/E8mBHt/AUNcrFu0FtLP8Qv+N3ZL7iRAth
        R3KbDniQFAc8kWh8GXJc1O7NXw==
X-Google-Smtp-Source: ABdhPJxssGRFtEfBg+qs3azsypjah1T2IIm3nCOdTDeyxCScEhd8CcnlYtS3APqaq+oljHqWGZ9SUg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr20285440wrl.64.1642434990194;
        Mon, 17 Jan 2022 07:56:30 -0800 (PST)
Received: from localhost.localdomain (hst-221-60.medicom.bg. [84.238.221.60])
        by smtp.gmail.com with ESMTPSA id i82sm15542900wma.23.2022.01.17.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:29 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 4/6] venus: hfi_platform: Correct supported compressed format
Date:   Mon, 17 Jan 2022 17:55:57 +0200
Message-Id: <20220117155559.234026-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In multistream mode HFI supports TP10_UBWC on output2. Correct this
in supported formats capabilities list.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_platform_v4.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi_platform_v6.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
index 3f7f5277a50e..e3f0a90a567b 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform_v4.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
@@ -55,7 +55,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_VP8,
@@ -106,7 +106,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_MPEG2,
diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v6.c b/drivers/media/platform/qcom/venus/hfi_platform_v6.c
index c10618e44f5d..4e8af645f8b9 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v6.c
@@ -55,7 +55,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_VP8,
@@ -106,7 +106,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_MPEG2,
-- 
2.25.1


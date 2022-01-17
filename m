Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7A490BDF
	for <lists+linux-api@lfdr.de>; Mon, 17 Jan 2022 16:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbiAQP4g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jan 2022 10:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiAQP4d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jan 2022 10:56:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD39C06173F
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 07:56:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so656881wme.0
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgKGUZV9Ow5lTkYXyL6TgBgt5kr++QVKt0rnOqG3iUs=;
        b=hPKEO6RbEwtanUyhH29rvXKo7a1lDWirpsEPcwqroYORwk+SWdfHWYOXwGMT8nZI6y
         1vVWcA91VsvtCa37CzG6TguLIZEU1BCUS9vbcN1YBZ60OgrWdL67IDUi9aoQH63yK3a4
         FX+cYYf3/dryh3+4w8aHRaXMiklOxdeu/wF8cw1FjWUiJtk/dy4jajBQp9F/wvMV3DGj
         M7K5H/o/nQLx3B3Kqb6dEKDvDdanuvbwLm+x0vvxU+FLZ9nRQiW+IzGRQFPZZ0m1FhJC
         hq/nD44am+dUSAAc4k+POFiojdxs9Wgkr5V1AxF1HrQzVebKwZa9MadF+6aatbKZVC8v
         qG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgKGUZV9Ow5lTkYXyL6TgBgt5kr++QVKt0rnOqG3iUs=;
        b=AyKDeyFjnbor9lsYV2NJEAxIWq1MXAYXMAGIbAD7LCnUmaKD/ILikrdyv3yXveuMMa
         2sILkc2v35Yy19keX6hyxwZT5j8PmxVp+S3OYuXzmVnyoRC82AVnDBckMxN/d5HBCkS5
         VNneTpurET0iLc23Tj6986zBiut1iFyJ7xi3G3DAUvD0aeiBN+wbCcRnF7v5bvlHI9mQ
         n8ccTrG9/xnqwheppNIZfPRDSD3OccGXENHgshPWu4Q3qMiSra0QLAjKhw+nE/33OLJl
         VOC55c5LQmAXwhoFVoA9wrsPjK4gEuJZgUNBAXt9WyGWOZXjEPL8roRAWqY87zhlpJus
         GI7g==
X-Gm-Message-State: AOAM531OZaEkCLr1TSxeNQGyy0i7r3+kodIzyWzkE+ER06cif0S5ceNw
        gK7E7hBP+2/lqD/gslpETbSkwQ==
X-Google-Smtp-Source: ABdhPJzr/7XZi6aFKSP/M/VHidCWixLwsc5ZmN0nt/bU2gTkObXMHon4UFpIO4YvoQL8GzsP2aNqSQ==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr19767924wrt.445.1642434992091;
        Mon, 17 Jan 2022 07:56:32 -0800 (PST)
Received: from localhost.localdomain (hst-221-60.medicom.bg. [84.238.221.60])
        by smtp.gmail.com with ESMTPSA id i82sm15542900wma.23.2022.01.17.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:31 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 6/6] venus: vdec: Use output resolution on reconfigure
Date:   Mon, 17 Jan 2022 17:55:59 +0200
Message-Id: <20220117155559.234026-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When recalculate output buffer size we have to take into account
the output resolution from the firmware received during event change
notification.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index c8261c6cb0fb..76716ceb3e18 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -701,8 +701,8 @@ static int vdec_output_conf(struct venus_inst *inst)
 	struct venus_core *core = inst->core;
 	struct hfi_enable en = { .enable = 1 };
 	struct hfi_buffer_requirements bufreq;
-	u32 width = inst->out_width;
-	u32 height = inst->out_height;
+	u32 width = inst->width;
+	u32 height = inst->height;
 	u32 out_fmt, out2_fmt;
 	bool ubwc = false;
 	u32 ptype;
-- 
2.25.1


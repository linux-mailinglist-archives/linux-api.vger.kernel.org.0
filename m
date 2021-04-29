Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348BF36E93C
	for <lists+linux-api@lfdr.de>; Thu, 29 Apr 2021 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhD2K7N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Apr 2021 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbhD2K7L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Apr 2021 06:59:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BA3C06138E
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 03:58:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so66450968wrr.2
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYGJrgcD3VZ6SXpUQWlC7sPvB5W5iGe6cdJ7Wlftem4=;
        b=ADIoes40mv9HPIIbqdGFoDHMemrLKFIIoekd16bjNbrdN0jTPOABBHL6aVDrZtbFQu
         7yk3Ot02f5nje4Dfdavqy/n6jXkmJhVsKKM6ODhMiL4XHbz18aF6X0PQo9i6ImbgrUyD
         OjgKTI+8ledcS6TazyTztiodS79qw9g4xLDhe69oI54YQ33KjU2eGgHAXnqiXBDxJDja
         lTDSTikmPZZFnJLmwdgeHTAuOzpg6iUEsfE5yipAg1HwUKST/Iud/WqweIL2UAP4Ih7C
         P2s0cC/MdYNPRPMR19Z782MZ2QXyr0NLZjHVfHlld6ZW9Vn3zqkRax4EK4gJaM0rJfOX
         4uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYGJrgcD3VZ6SXpUQWlC7sPvB5W5iGe6cdJ7Wlftem4=;
        b=njNpKgNdGOHjBqEp9q1OuDbn99Sgz5Gbu0d7dGFcn6Mb9J8qIh2c/V/ZNwRNaYamXm
         VxBWaax5gfssjlUU4GZ3jhd3BIzpxHRKin/sxJYnh5LL7MMck4IgjW33rFfJk0Z9J+jw
         c++CiIjuCV9E0UFrCvw+9eIf7k9RSCJ/AsOl/5DSCSfr7xqMJJIr9VhgY5Gin+IHheNq
         253wOtFDkPfq3js5dOQAsebFa4wHTEYiWBhxBiv/EB2l/7aWq30P/hM2bI2D0zH8BkVG
         GdxNTHPKVWrg47gNJaaHTLklJYOQTmaSV9eSTmoN0Eau7DUugRw6UeYsdA//vG8rEhPA
         2GMA==
X-Gm-Message-State: AOAM531PuHNez86DEOc8Gt5ebAiblFZFHNop0eG0ODpq7L2IWlgOezQ3
        CA1Nkh9vBZEbsxrndyi6gD9/2w==
X-Google-Smtp-Source: ABdhPJxs4frVcC9W4IjKEh3ILkFuHPl45eBX5Yb/vr2WGh+ggar5ciZCQHRNii0ISDvr/1UlX1nB3g==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr164098wry.203.1619693902137;
        Thu, 29 Apr 2021 03:58:22 -0700 (PDT)
Received: from localhost.localdomain (hst-221-29.medicom.bg. [84.238.221.29])
        by smtp.gmail.com with ESMTPSA id a9sm3372903wmj.1.2021.04.29.03.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:58:21 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 2/3] venus: Add a handling of QC8C compressed format
Date:   Thu, 29 Apr 2021 13:58:14 +0300
Message-Id: <20210429105815.2790770-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds QC8C compressed pixel format in the Venus driver, and
make it enumeratable from v4l2 clients.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 9b8ff76e3c43..3a0b07d237a5 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -561,6 +561,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV12;
 	case V4L2_PIX_FMT_NV21:
 		return HFI_COLOR_FORMAT_NV21;
+	case V4L2_PIX_FMT_QC8C:
+		return HFI_COLOR_FORMAT_NV12_UBWC;
 	default:
 		break;
 	}
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 5e5584fc21e9..d4cc51fc019c 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -31,6 +31,10 @@
  */
 static const struct venus_format vdec_formats[] = {
 	{
+		.pixfmt = V4L2_PIX_FMT_QC8C,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	}, {
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -696,7 +700,13 @@ static int vdec_output_conf(struct venus_inst *inst)
 	inst->output2_buf_size =
 			venus_helper_get_framesz_raw(out2_fmt, width, height);
 
-	if (is_ubwc_fmt(out_fmt)) {
+	if (is_ubwc_fmt(out_fmt) && is_ubwc_fmt(out2_fmt)) {
+		inst->output2_buf_size = 0;
+		inst->opb_buftype = HFI_BUFFER_OUTPUT;
+		inst->opb_fmt = out_fmt;
+		inst->dpb_buftype = 0;
+		inst->dpb_fmt = 0;
+	} else if (is_ubwc_fmt(out_fmt)) {
 		inst->opb_buftype = HFI_BUFFER_OUTPUT2;
 		inst->opb_fmt = out2_fmt;
 		inst->dpb_buftype = HFI_BUFFER_OUTPUT;
-- 
2.25.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B13BD6F2
	for <lists+linux-api@lfdr.de>; Tue,  6 Jul 2021 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhGFMsw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Jul 2021 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbhGFMsl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Jul 2021 08:48:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E7DC0225A7
        for <linux-api@vger.kernel.org>; Tue,  6 Jul 2021 05:41:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n33so5984007wms.1
        for <linux-api@vger.kernel.org>; Tue, 06 Jul 2021 05:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRu/rrECnrx/6rDYLkqHGSqwS0EdaL46bywJDkHS8nI=;
        b=A/Mi8xG/jIlYJ+6yfkfZ/NNXm7mu7DHNJaeqjA+dLchP0zt4JrHU9eIL3h+/nvEr79
         T1rC+ILs46rmaj89/17s9Bg+OsODYSOuDRDNtkcF6rFcBoW3uKNU9YiyG2DL79HEwatj
         7d4EVG1bqR3Dxi8vxrTYFK9aBpJIqLS1+Zi2HeiO1KXQOXJvx8P7gZm3I1ekA/rGBMn+
         Rq8KoRCf9vd7rZk/4eWP5MBLWASDB77A1UsDSsoo7eeAnIfH6MV8UTStV1FvV9X4bb+J
         nSHPdPYcWYbHd6lO57Bgi8cZuUSWvN5fk7B+JkXC7f+6W7u+rPkQ3pqYxNp0JKRPUKbK
         Mmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRu/rrECnrx/6rDYLkqHGSqwS0EdaL46bywJDkHS8nI=;
        b=Zpwb5mEBt3cH3mSJoyV6nNMK+8cm6liIu/7A0AJbXnbWYruJ4E/hFw4Y8U5BmbLagN
         zlM0aD9GcGcuayBu9JIEIUcq/PGqrVItdP3+5jFD+Mog+iGaJhuO0L7MMju0KBpPuuty
         xolEkR6240oxjX/kEUP+HUaoSLcPW5jzjI28nSoDJWm2v+zBHvzwPftuFnryFjVkdLAG
         7pRYRpPH1NLFyRa6IebNH4i16x0HddCXS2j1CpIfxmZqdxnhG/lWrVelhQHPPj0RQCBO
         AyUrg/i3VuItvtqcE7mLaF5a2hY4FGhfJyFkhWLyPEce/C6bqf/RXKDzmnaau6AQ3dNu
         QdCQ==
X-Gm-Message-State: AOAM532LufZvQiDTk9Funn8bo2Tx8G0jUez4BRbbyQnHfn6toHPKjT/r
        gcbwdMmNLjtFkZQ9xIOQj49gVg==
X-Google-Smtp-Source: ABdhPJykZRhTNi+DMbVdlg1f9P6ncOKxO5R4KfG+BCmqTv5c10YAQ66qYsZy3VvRGb57i2RhvlqoLw==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr168794wmn.185.1625575270808;
        Tue, 06 Jul 2021 05:41:10 -0700 (PDT)
Received: from localhost.localdomain (hst-221-27.medicom.bg. [84.238.221.27])
        by smtp.gmail.com with ESMTPSA id n18sm2585979wms.3.2021.07.06.05.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:41:10 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 5/5] venus: Add a handling of QC10C compressed format
Date:   Tue,  6 Jul 2021 15:40:34 +0300
Message-Id: <20210706124034.773503-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds QC10C compressed pixel format in the Venus driver, and
make it possible to discover from v4l2 clients.

Note: The QC10C format shouldn't be possible to discpver by the
client if the decoded bitstream is not 10-bits.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 23 ++-------------------
 drivers/media/platform/qcom/venus/vdec.c    | 19 ++++++++++++++---
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 49d720fd9a9d..b48bf52481ba 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -563,6 +563,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV21;
 	case V4L2_PIX_FMT_QC08C:
 		return HFI_COLOR_FORMAT_NV12_UBWC;
+	case V4L2_PIX_FMT_QC10C:
+		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
 	default:
 		break;
 	}
@@ -1675,27 +1677,6 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 	if (!caps)
 		return -EINVAL;
 
-	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
-	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
-		found_ubwc =
-			find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
-					   HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
-		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
-					   HFI_COLOR_FORMAT_NV12);
-		if (found_ubwc && found) {
-			/*
-			 * Hard-code DPB buffers to be 10bit UBWC and decoder
-			 * output buffers in 8bit NV12 until V4L2 is able to
-			 * expose compressed/tiled formats to applications.
-			 */
-			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
-			*out2_fmt = HFI_COLOR_FORMAT_NV12;
-			return 0;
-		}
-
-		return -EINVAL;
-	}
-
 	if (ubwc) {
 		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
 		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 989a75dc5bf0..c4d5bde860d7 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -35,6 +35,10 @@ static const struct venus_format vdec_formats[] = {
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	}, {
+		.pixfmt = V4L2_PIX_FMT_QC10C,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},{
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -114,6 +118,10 @@ find_format(struct venus_inst *inst, u32 pixfmt, u32 type)
 	    !venus_helper_check_format(inst, fmt[i].pixfmt))
 		return NULL;
 
+	if (V4L2_TYPE_IS_CAPTURE(type) && fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
+	    !(inst->bit_depth == VIDC_BITDEPTH_10))
+		return NULL;
+
 	return &fmt[i];
 }
 
@@ -133,11 +141,16 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
 		if (fmt[i].type != type)
 			continue;
 
-		if (V4L2_TYPE_IS_OUTPUT(type))
+		if (V4L2_TYPE_IS_OUTPUT(type)) {
 			valid = venus_helper_check_codec(inst, fmt[i].pixfmt);
-		else if (V4L2_TYPE_IS_CAPTURE(type))
+		} else if (V4L2_TYPE_IS_CAPTURE(type)) {
 			valid = venus_helper_check_format(inst, fmt[i].pixfmt);
 
+			if (fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
+			    !(inst->bit_depth == VIDC_BITDEPTH_10))
+				valid = false;
+		}
+
 		if (k == index && valid)
 			break;
 		if (valid)
@@ -1496,7 +1509,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
 static void vdec_inst_init(struct venus_inst *inst)
 {
 	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
-	inst->fmt_out = &vdec_formats[7];
+	inst->fmt_out = &vdec_formats[8];
 	inst->fmt_cap = &vdec_formats[0];
 	inst->width = frame_width_min(inst);
 	inst->height = ALIGN(frame_height_min(inst), 32);
-- 
2.25.1


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8D63BD6E2
	for <lists+linux-api@lfdr.de>; Tue,  6 Jul 2021 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhGFMsl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Jul 2021 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbhGFMsk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Jul 2021 08:48:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE69C08E89B
        for <linux-api@vger.kernel.org>; Tue,  6 Jul 2021 05:41:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t6so15977226wrm.9
        for <linux-api@vger.kernel.org>; Tue, 06 Jul 2021 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecjW3cRWAEIfndFoVo8BkYktDhdK0gMxQVqk7QqJZj0=;
        b=SM3N6mKrFJk7cd4eql+zVJ3BOe/UnA9Das8uViuXyhODKR80MNDJFZJanZStMVvJpk
         r8RRG9bUGR1fFTOmLpQbRBoumGQC63LBe2A1RnHZoQnxbQhymxtxikH2NVZsoY4MaoA9
         sqyoZI627kQEc0sc/LrSo29XoLeoUrg028GTSrOlw9tfX7gjq6hAKf3isu4cP5toBchM
         5AN5ISa/BOazTUMWYHirDsLIC7eNeorzOt/SWbILOMMlg7hnhp5+81/P/0pSPtK5SKxq
         ODvrrGe6PEMpclgZrIonMs0i5Y39dLbCAkx9ztnrSgXORgpVNrOtjp/Rt2BphRhv1/C8
         pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecjW3cRWAEIfndFoVo8BkYktDhdK0gMxQVqk7QqJZj0=;
        b=tuazvLbXoOVcXcnkHzRGnV/Pc+eXKiTdhCwNwk/U6NI7ICqssaoQ9RUQozzwTIOEMy
         ot6CLVCaJgWLVaiogiWkLazcBAIsZEpV4gkj8WGPrGLUvkP5MsAwrwJmCaJAI+kSFeft
         CJF7rtvEeKEUkJfGdRNcQXY4dpXt2vCtHfdyWNgMNWr/txAcE8qKoY2aRQM0lnpN3Mn+
         EoU+GUeku9IFo4BOD1IVz31+EZP5S42u0cHoozHHFPejXn4QB/VvkSVPRW9dqiutUmaa
         phsWsA2v3pW2Wd1QAt603bft1ha5N34SA9XrpQl7pfVruYcCfarAXo4XRJgFeZMl7RZl
         jxoQ==
X-Gm-Message-State: AOAM5338CVNbgtwv+bDtqW/tBL8XhIAmSECqPYRcf3hDtb7FWg1q/7k+
        GQZxN+9hoWLGRmb8jWKFrcUiVw==
X-Google-Smtp-Source: ABdhPJwimNP2WfDoa6FlJCyZjVgGRPFEyTLn9bh2f/+WRtNo2XT4WmA1hzhXwhjQrEswGe5ddxMdOQ==
X-Received: by 2002:a5d:530f:: with SMTP id e15mr21151955wrv.217.1625575268875;
        Tue, 06 Jul 2021 05:41:08 -0700 (PDT)
Received: from localhost.localdomain (hst-221-27.medicom.bg. [84.238.221.27])
        by smtp.gmail.com with ESMTPSA id n18sm2585979wms.3.2021.07.06.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:41:08 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 3/5] venus: Add a handling of QC08C compressed format
Date:   Tue,  6 Jul 2021 15:40:32 +0300
Message-Id: <20210706124034.773503-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds QC08C compressed pixel format in the Venus driver, and
make it possible to discover from v4l2 clients.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 48da88d21ccd..49d720fd9a9d 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -561,6 +561,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV12;
 	case V4L2_PIX_FMT_NV21:
 		return HFI_COLOR_FORMAT_NV21;
+	case V4L2_PIX_FMT_QC08C:
+		return HFI_COLOR_FORMAT_NV12_UBWC;
 	default:
 		break;
 	}
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 198e47eb63f4..989a75dc5bf0 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -31,6 +31,10 @@
  */
 static const struct venus_format vdec_formats[] = {
 	{
+		.pixfmt = V4L2_PIX_FMT_QC08C,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	}, {
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -106,6 +110,10 @@ find_format(struct venus_inst *inst, u32 pixfmt, u32 type)
 	    !venus_helper_check_codec(inst, fmt[i].pixfmt))
 		return NULL;
 
+	if (V4L2_TYPE_IS_CAPTURE(type) &&
+	    !venus_helper_check_format(inst, fmt[i].pixfmt))
+		return NULL;
+
 	return &fmt[i];
 }
 
@@ -124,8 +132,12 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
 
 		if (fmt[i].type != type)
 			continue;
-		valid = type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE ||
-			venus_helper_check_codec(inst, fmt[i].pixfmt);
+
+		if (V4L2_TYPE_IS_OUTPUT(type))
+			valid = venus_helper_check_codec(inst, fmt[i].pixfmt);
+		else if (V4L2_TYPE_IS_CAPTURE(type))
+			valid = venus_helper_check_format(inst, fmt[i].pixfmt);
+
 		if (k == index && valid)
 			break;
 		if (valid)
@@ -1484,7 +1496,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
 static void vdec_inst_init(struct venus_inst *inst)
 {
 	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
-	inst->fmt_out = &vdec_formats[6];
+	inst->fmt_out = &vdec_formats[7];
 	inst->fmt_cap = &vdec_formats[0];
 	inst->width = frame_width_min(inst);
 	inst->height = ALIGN(frame_height_min(inst), 32);
-- 
2.25.1


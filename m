Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29075490BEB
	for <lists+linux-api@lfdr.de>; Mon, 17 Jan 2022 16:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiAQP4b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jan 2022 10:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbiAQP4a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jan 2022 10:56:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD6C06174E
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 07:56:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k5so12239045wmj.3
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 07:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqfCOsJJeq7IcCNYO2ZlgBvYhrdH5GFyJuz369ymuIc=;
        b=DSF1gkNeQSuUqMQxP5iUYajJ7w/rOCri//LZWbLAA0cnvcOFNQ+hODNTnVPmaqVt7M
         IVtS5PKLr3lxUB8xSl4AJe9Bnd9Xw7xEyQJxnWnaKabVB7DvT54VYwn4HjHUaOG21JOK
         rP0PkXgl8e56CTul6K4rh3a4IYj25W32xfL+mIvEuY/Q0Sck02ghpfzyepnmzlB/66TL
         0Vmve7pjdnCXxl47Eax7xJkY11jxpto09heWzKnw2Bf42ZSSk4zu+Rf/eEq3e+hWt4My
         TgN6U3FRaIeiYRDx0LzNAF6TCn4xW84c6rkgG08568Yefs9PniutpNbwBmXC1NQxNMGN
         7TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqfCOsJJeq7IcCNYO2ZlgBvYhrdH5GFyJuz369ymuIc=;
        b=BbQEJZpscERRMEOACx9Hi5M3eMxn6wtnrJuepy+USvc3xyEQH6Tp36ILFWlJrck6zF
         eTjCqGdizKuH9LfjitB/2D+HJ4ewIibGiKmWSpR9qAvDJXI8bt+Fdf4fVnc1Zo7NPmgR
         c5oWoV1wfkUnyqu88iOWoQn9QyrbSAnxIc8I4b47BCefWS6PFSjYkXPw0T9VD74XGJCS
         EfMTALqZObYu9/7FagU2g6Ii0WNvDHZxvoM1vDRb4V3/iQTR3I+Tvxn2SKc47bZaSA0f
         47decDVLTPfgt3BjnYVvtVA8RxzChP+re1Pp52ywOMikYrU3/4DeAQyWDZsuQNbXucPv
         TazQ==
X-Gm-Message-State: AOAM533ViZnSYk0+byCGEHtIs06ROdsGNDuLhnHZiwtCKkXe0fes8fc8
        inX1/OZIItUA4366/gCnqyppEw==
X-Google-Smtp-Source: ABdhPJxB5FGOm56NaILRrSD2XTX0NwqN/GJFwx4nLmFqOJTvGj9mtxXt+CyR64HNpF1mwOUpzwiwCg==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr20272179wro.556.1642434987101;
        Mon, 17 Jan 2022 07:56:27 -0800 (PST)
Received: from localhost.localdomain (hst-221-60.medicom.bg. [84.238.221.60])
        by smtp.gmail.com with ESMTPSA id i82sm15542900wma.23.2022.01.17.07.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:26 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 1/6] v4l: Add Qualcomm custom compressed pixel formats
Date:   Mon, 17 Jan 2022 17:55:54 +0200
Message-Id: <20220117155559.234026-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add custom Qualcomm raw compressed pixel formats. They are
used in Qualcomm SoCs to optimize the interconnect bandwidth.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/v4l/pixfmt-reserved.rst             | 19 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  2 ++
 include/uapi/linux/videodev2.h                |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 2f2133b4cd9c..929bd0dc0ba3 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -245,6 +245,25 @@ please make a proposal on the linux-media mailing list.
       - Non-compressed, tiled two-planar format used by Mediatek MT8183.
 	This is an opaque intermediate format and the MDP3 hardware can be
 	used to convert it to other formats.
+    * .. _V4L2-PIX-FMT-QC08C:
+
+      - ``V4L2_PIX_FMT_QC08C``
+      - 'QC08C'
+      - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
+        It is an opaque intermediate format. The used compression is lossless
+        and it is used by various multimedia hardware blocks like GPU, display
+        controllers, ISP and video accelerators.
+        It contains four planes for progressive video and eight planes for
+        interlaced video.
+    * .. _V4L2-PIX-FMT-QC10C:
+
+      - ``V4L2_PIX_FMT_QC10C``
+      - 'QC10C'
+      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
+        It is an opaque intermediate format. The used compression is lossless
+        and it is used by various multimedia hardware blocks like GPU, display
+        controllers, ISP and video accelerators.
+        It contains four planes for progressive video.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 9ac557b8e146..1b6462f9ad7e 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1437,6 +1437,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_SE401:	descr = "GSPCA SE401"; break;
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
+		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
+		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index df8b9c486ba1..e710903185bd 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -744,6 +744,8 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
+#define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
+#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.25.1


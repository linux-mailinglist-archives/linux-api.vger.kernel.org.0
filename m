Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4D3BD6E5
	for <lists+linux-api@lfdr.de>; Tue,  6 Jul 2021 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbhGFMsm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Jul 2021 08:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbhGFMsk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Jul 2021 08:48:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BCC05BD3A
        for <linux-api@vger.kernel.org>; Tue,  6 Jul 2021 05:41:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n33so5983875wms.1
        for <linux-api@vger.kernel.org>; Tue, 06 Jul 2021 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SyzOju9StSJiRZ9iNcKKAv9UQxdJlfQPJ4E1Oc7MQ0=;
        b=URrdGVCp9ySEpG+9Y+/25CGI7NcB4VqFscKTYtl081JVonpaKzsZeph7TlfLu7uG7n
         YBcSaDrY0AIUjvtCmGY6Luge6RIu0OZr4R5uLW9ArPDJpE67OJD2vVpSEEar70C3Ga/l
         TPLR9DiyOI0AcCNJhUAPJFEj1MXNMsMskNSzySORWA4liooFpd+/3MaaCyNoCqb4aVB9
         3i7REh4Vop83cgFqpgS7gUxxeEe295iNAlnjHQcnrGlD7zqk5y33tvO1tpHB/cVJaKkI
         cmx9r9NhXoWPGxeF61POe3OvY3aC1OgadR6cv4u+xDXym7iOYHTtoBX8Af1ao6LNeEgJ
         44xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SyzOju9StSJiRZ9iNcKKAv9UQxdJlfQPJ4E1Oc7MQ0=;
        b=ObSW0oL5bCaIZS1D5pI5oskDmwjq1vq9gETHK3N0olr7v0fHDsgKOWcXNG5vz4g6Kw
         PkgZ4x+uxuU493QPLOQr1itGMnFapPo2Z9GdWBoCZunYcWQn/IDBai6zwbNliaCJKu++
         oYEMOFgltZzDX/nYt8vzGaiAt07YZmsORi5nSJnBV0wiB7hbyhwDEAJ9Exglgn8WbxZW
         DHo13l6vzFxLZZCGH8aOMTreCxcg1z559BglNJY894Hpg4ueis+QUUAYH3bGNFkw0OML
         ymlt2RCRMDClKEHIBYJftRZCK4ARaQoiRvuEwx1rt8msFEiJuIPgG6y+AerH6aJX7H10
         dsHA==
X-Gm-Message-State: AOAM531YwlS75lyPEcfC0iI6Gqe0RKRAT+oIUcg+jnjaF6Yw7ojxxY6I
        Ghm/Ub+UnIfW14GK0w9L8/8LPg==
X-Google-Smtp-Source: ABdhPJxZm69w2Xf+Og+odhinBhnz8eUA9o6MMxtf/sCdqPU7XNaTYUAeDleb3GUX1eY/hqcmzQhPNg==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr20480595wmp.165.1625575267353;
        Tue, 06 Jul 2021 05:41:07 -0700 (PDT)
Received: from localhost.localdomain (hst-221-27.medicom.bg. [84.238.221.27])
        by smtp.gmail.com with ESMTPSA id n18sm2585979wms.3.2021.07.06.05.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:41:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 1/5] v4l: Add Qualcomm custom compressed pixel formats
Date:   Tue,  6 Jul 2021 15:40:30 +0300
Message-Id: <20210706124034.773503-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add custom Qualcomm raw compressed pixel formats. They are
used in Qualcomm SoCs to optimize the interconnect bandwidth.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/v4l/pixfmt-reserved.rst              | 18 ++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c           |  2 ++
 include/uapi/linux/videodev2.h                 |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 0b879c0da713..136e9832db0c 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -260,6 +260,24 @@ please make a proposal on the linux-media mailing list.
 	of tiles, resulting in 32-aligned resolutions for the luminance plane
 	and 16-aligned resolutions for the chrominance plane (with 2x2
 	subsampling).
+    * .. _V4L2-PIX-FMT-QC08C:
+
+      - ``V4L2_PIX_FMT_QC08C``
+      - 'QC08C'
+      - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
+	The used compression is lossless and it is used by various multimedia
+	hardware blocks like GPU, display controllers, ISP and video accelerators.
+	It contains four planes for progressive video and eight planes for
+	interlaced video.
+    * .. _V4L2-PIX-FMT-QC10C:
+
+      - ``V4L2_PIX_FMT_QC10C``
+      - 'QC10C'
+      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
+	The used compression is lossless and it is used by various multimedia
+	hardware blocks like GPU, display controllers, ISP and video.
+	It contains four planes for progressive video and eight planes for
+	interlaced video.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 05d5db3d85e5..76d4e4ac18e8 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1416,6 +1416,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
 		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
+		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
+		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 9260791b8438..dc1b714ccf6b 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -737,6 +737,8 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
+#define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
+#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.25.1


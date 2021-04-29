Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26B336E939
	for <lists+linux-api@lfdr.de>; Thu, 29 Apr 2021 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbhD2K7N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Apr 2021 06:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbhD2K7K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Apr 2021 06:59:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EB2C06138D
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 03:58:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k14so16497897wrv.5
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBXsu4hoUYVEN5DNp1Kv5q5f0FvqemBCsQCdEh5XBkc=;
        b=ySv6XmAm+iC7pw2L7aHI8nQI+7E7BOcbBzQ6MllFX9piRQF3WBxMNgc91BcQzStqOi
         OBaZ3syju5vPQmmoH6Of9wZOmgB2tpPW48/DkjKv5ZAZf+srv6/EgcRDgyhEKpqM/ymo
         GR6GByYgtM7wvpM9c3R0WmX+H6BPJ/1icbtwD/ZTv9u5Ajy8V0BjGhPjI/96b5fKRQZd
         x/UXUjevLcL5qkWeOYtKlk3cF9qRuQTVBQ1l9Rmrt6+b2B0K4kUCw3rf/JaXLU+it4pe
         KVAbg7gFpbFljqSc2ulL0ZZSZuFbaF0SK0TV3+y8W+z7waamShaXc9VL5r/NVzsx0nMB
         Wewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBXsu4hoUYVEN5DNp1Kv5q5f0FvqemBCsQCdEh5XBkc=;
        b=aofQjgH0A4hKQuLpQdZeg/qV2s5sgxveSYW55rvATzrShBTsALs0ORh+Jqhty5tOd3
         2qW3kqBO0UTR1mmHCwZ3OWBG7jV8hZEgRYdi8iOowuQRxMW0qUOWAHIAVilU2hBqHsW0
         43yIie//aOZB6XN0fURGg4ibQvLTubdamZeTmjqthiJm0lxfwgUls5mFa4RY2fQ1zikK
         Uc39Tf1B5pazUzsSX0GrEap6GuXbKRgUDLyZgWFQCouEq+e3y0bYNJQaThmGU3VBQcKA
         YMU5TKlAFEJoUFAt9rupAErca/rpnrNoqErz9OJz9SqO6DDGnmWBGPWU98xYyXT2VhAq
         Hp4g==
X-Gm-Message-State: AOAM5323D0yRNZUG+VHz/sZ/CcNJfjYNII3Pq4ik3Rfg9fptKBSIFhBc
        XTs83Pm9CCjxbjkTPkFLaRvxvoyFqZBIPN43
X-Google-Smtp-Source: ABdhPJy4cMsMQ7Q6k/nhH6/7CT/fOMZhRWoaFkUowy2RsJo3l0IuB8hcnYOXvuVVw3zVTZI7XDablQ==
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr24404406wrr.248.1619693901308;
        Thu, 29 Apr 2021 03:58:21 -0700 (PDT)
Received: from localhost.localdomain (hst-221-29.medicom.bg. [84.238.221.29])
        by smtp.gmail.com with ESMTPSA id a9sm3372903wmj.1.2021.04.29.03.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:58:21 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 1/3] v4l: Add Qualcomm custom compressed pixel formats
Date:   Thu, 29 Apr 2021 13:58:13 +0300
Message-Id: <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Here we add custom Qualcomm raw compressed pixel formats. They are
used in Qualcomm SoCs to optimaize the interconnect bandwidth.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../userspace-api/media/v4l/pixfmt-reserved.rst      | 12 ++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                 |  2 ++
 include/uapi/linux/videodev2.h                       |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 0b879c0da713..30b9cef4cbf0 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -260,6 +260,18 @@ please make a proposal on the linux-media mailing list.
 	of tiles, resulting in 32-aligned resolutions for the luminance plane
 	and 16-aligned resolutions for the chrominance plane (with 2x2
 	subsampling).
+    * .. _V4L2-PIX-FMT-QC8C:
+
+      - ``V4L2_PIX_FMT_QC8C``
+      - 'QC8C'
+      - Compressed Macro-tile 8Bit YUV420 format used by Qualcomm platforms.
+	The compression is lossless. It contains four planes.
+    * .. _V4L2-PIX-FMT-QC10C:
+
+      - ``V4L2_PIX_FMT_QC10C``
+      - 'QC10C'
+      - Compressed Macro-tile 10Bit YUV420 format used by Qualcomm platforms.
+	The compression is lossless. It contains four planes.
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 6a5d1c6d11d6..33ee12b97aa0 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1455,6 +1455,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
 		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
+		case V4L2_PIX_FMT_QC8C:		descr = "QCOM Compressed 8bit Format"; break;
+		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10bit Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 311a01cc5775..c57628a16cf4 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -737,6 +737,8 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
+#define V4L2_PIX_FMT_QC8C     v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
+#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compresed */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.25.1


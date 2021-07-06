Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A0C3BD7E8
	for <lists+linux-api@lfdr.de>; Tue,  6 Jul 2021 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGFNlY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Jul 2021 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhGFNlX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Jul 2021 09:41:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C74C061760
        for <linux-api@vger.kernel.org>; Tue,  6 Jul 2021 06:38:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q190so20118861qkd.2
        for <linux-api@vger.kernel.org>; Tue, 06 Jul 2021 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BQJ4p9EQHxAoYgqbLRt1z8LzPtz3Jt8BkFZ87p5TbKU=;
        b=uLlReflxVpjp0HiKbvSmwmpFdz9MYoPuTD9tUKcLRdVctMTDxGIolfM3hqbM7Cn0dU
         yzulwRFYQvkO2SHkOq1agTbAzxXzt210np8n9AhqYDFP8oswMhlLEjvRjFSaZb94XZM6
         qF/BvJwsw2+7USDFDFSNLZfNzqm1uRRz69mMQn6t6rYyW5NxnrM9KDBE2hiDN3IMCiP8
         gKaiZViNMHqAM0rT3KW2LxxqHpQfD/5Rvrd0S3+Y76hpNWJliFvnOuSbskHuzPAbJbQc
         A8Zr3C4kDcSdPKTYo+1OSHM91OxiNayDWOcbrjxnszW9PvQ2cgxkyDKE+T/EEQBVwP9x
         NE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BQJ4p9EQHxAoYgqbLRt1z8LzPtz3Jt8BkFZ87p5TbKU=;
        b=APLJopF5bcwGotQtT4OEVYDrW//HNAKpF8g8l4jHdcH4zYg4Rgl75I0jV4GkoYdeLk
         icX3Gdmyd+AeBzJds+FACy0MsiS/BSkiPlGFmowIydHIqj05ObyGYduAkOAhQOVoZeBA
         3pEx2QvuabG7rFkFtVDxBgFqlrehAIyWD7T8QIzzN4Og15+OYOsd61oHzpYkIniAbXvs
         Wk72W5t/8G+GbpdF2tvmhzrCoINRq9omNVfLZIrmBYmQ4/it0ZiCeVfTz5QCQYc6X5Zs
         0Aoc+vOP+7C83e+XVtPQ8uRcSLyw6++lekvQ9jYtNzuekSObnz2InkLOxKSsh/GjOVD9
         PBbA==
X-Gm-Message-State: AOAM531W7mXOVFjfH6Dc8WQtdW6RJhBNb43Dr2CtGrhmnHwZOblI9dCL
        WQjypBYNWG1+b9myE0mzbi0r0Q==
X-Google-Smtp-Source: ABdhPJyiYmBZc2we5I5PgpHelpQNvnMtzr2LVFUwHLCvoAb2jGXx0BJN7rsdEoa1ytfiEKrcv+kPOw==
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr2856183qkl.51.1625578724478;
        Tue, 06 Jul 2021 06:38:44 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id a190sm6695589qkf.9.2021.07.06.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 06:38:44 -0700 (PDT)
Message-ID: <6ade1e0219056fe17339a3acf4a8ecec85b7c699.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/5] v4l: Add Qualcomm custom compressed pixel formats
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Tue, 06 Jul 2021 09:38:42 -0400
In-Reply-To: <20210706124034.773503-2-stanimir.varbanov@linaro.org>
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
         <20210706124034.773503-2-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Le mardi 06 juillet 2021 à 15:40 +0300, Stanimir Varbanov a écrit :
> Add custom Qualcomm raw compressed pixel formats. They are
> used in Qualcomm SoCs to optimize the interconnect bandwidth.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../media/v4l/pixfmt-reserved.rst              | 18 ++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c           |  2 ++
>  include/uapi/linux/videodev2.h                 |  2 ++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 0b879c0da713..136e9832db0c 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -260,6 +260,24 @@ please make a proposal on the linux-media mailing list.
>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>  	subsampling).
> +    * .. _V4L2-PIX-FMT-QC08C:
> +
> +      - ``V4L2_PIX_FMT_QC08C``
> +      - 'QC08C'
> +      - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
> +	The used compression is lossless and it is used by various multimedia
> +	hardware blocks like GPU, display controllers, ISP and video accelerators.
> +	It contains four planes for progressive video and eight planes for
> +	interlaced video.

nit: Considering we are not yet adopting DRM modifiers, perhaps we could cross-
reference the documentation, or at least document which DRM format/modifier pair
this will match too on the other side of the kernel domain fence ? This is of
course just for integrator convenience.

> +    * .. _V4L2-PIX-FMT-QC10C:
> +
> +      - ``V4L2_PIX_FMT_QC10C``
> +      - 'QC10C'
> +      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
> +	The used compression is lossless and it is used by various multimedia
> +	hardware blocks like GPU, display controllers, ISP and video.
> +	It contains four planes for progressive video and eight planes for
> +	interlaced video.
>  
>  .. raw:: latex
>  
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 05d5db3d85e5..76d4e4ac18e8 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1416,6 +1416,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
> +		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
> +		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 9260791b8438..dc1b714ccf6b 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -737,6 +737,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
> +#define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
> +#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */



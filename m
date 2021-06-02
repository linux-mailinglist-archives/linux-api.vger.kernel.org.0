Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D823985DB
	for <lists+linux-api@lfdr.de>; Wed,  2 Jun 2021 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFBKGE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Jun 2021 06:06:04 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:38343 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhFBKGD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Jun 2021 06:06:03 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id oNcOlUDKLIpGyoNcRlPBJN; Wed, 02 Jun 2021 11:57:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622627820; bh=o41WLaP7K9Ber/4bd6VGg+8ZM1PW3MiRSh0W1KbUCOk=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=SGv5frsB7pvM+PURkFnBHe/BFi1IVBEkK4MOp+RmgavyOtT8gTEklk+fP4IHdY0tM
         BK8EviL3facQMoqzGKvTkuM4B777iYnyEv9KK0EDNJbHLVaE7QBY3Ke2kH5Wj7nl8a
         Jc/7sMtvgVhe5nIo841ct2OMMY3bhgeIdUUgLHw6YvzN81+RqU82fAI9rauRFVP7Kr
         2Pdd1jELDLpDF2QUGm01rzHwbVqSCcIFYbkKrY+rsn9aVLkt0lnZpU0zg9twuvXeZ1
         VZn2rxc7ozPBYuqTN4HrsKR7Zt6+gYnthUwdTICXya1m3mW3bEkvGIagzmx42UC6m2
         f9umxUUrvmUjw==
Subject: Re: [PATCH 1/3] v4l: Add Qualcomm custom compressed pixel formats
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
 <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <b58061ff-aeb1-c48b-ea53-2366997bd825@xs4all.nl>
Date:   Wed, 2 Jun 2021 11:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKvvLw7/MuvI6bs3ne9b4IhqQv5rX5CSY7J79/FOlYwCMnNIk9aVt22JmskRG5aF5sBQ6kUC+WrgjxvqR+a7cfg3RaIlk20mrNhEjttbpPgWlu0b2+GU
 qa5ABhIhu6ZR8G01RgRuRFn8Sd31I8E1UuAO4i4JeupKWB+RzzEfx+HsEKjtQdfcJtYoCWduh0deuahYpw3wiywMq/7I0dgvKH8CRnqzVwrfoZQHZFOWaW2B
 s2fv8/qsJK43lrpzbl8Ny//Mlvyx1j9sLKkfLGFwJexoAQhPugjXlZjSECZ6CCSJpidY1fw6WhCVjWqiSxAOK2Bwaw1/xR7MbabBChdPmXmRBGK1xuUbbanC
 s3Cjqu77hNRlaOvS9lh6buGAt6mK4yNtfg3q2Ofl48Znw6t+WZo=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29/04/2021 12:58, Stanimir Varbanov wrote:
> Here we add custom Qualcomm raw compressed pixel formats. They are
> used in Qualcomm SoCs to optimaize the interconnect bandwidth.

optimize

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../userspace-api/media/v4l/pixfmt-reserved.rst      | 12 ++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                 |  2 ++
>  include/uapi/linux/videodev2.h                       |  2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 0b879c0da713..30b9cef4cbf0 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -260,6 +260,18 @@ please make a proposal on the linux-media mailing list.
>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>  	subsampling).
> +    * .. _V4L2-PIX-FMT-QC8C:
> +
> +      - ``V4L2_PIX_FMT_QC8C``
> +      - 'QC8C'
> +      - Compressed Macro-tile 8Bit YUV420 format used by Qualcomm platforms.

8Bit -> 8-bit

> +	The compression is lossless. It contains four planes.
> +    * .. _V4L2-PIX-FMT-QC10C:
> +
> +      - ``V4L2_PIX_FMT_QC10C``
> +      - 'QC10C'
> +      - Compressed Macro-tile 10Bit YUV420 format used by Qualcomm platforms.

10Bit -> 10-bit

> +	The compression is lossless. It contains four planes.

What is not clear from this description is if these formats are opaque, i.e. the
only way to decompress is through hardware, or if they can be decompressed in
software. If so, a reference to Qualcomm documentation would be useful. See e.g.
the V4L2_PIX_FMT_MT21C description (that's an opaque format).

>  
>  .. raw:: latex
>  
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 6a5d1c6d11d6..33ee12b97aa0 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1455,6 +1455,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
> +		case V4L2_PIX_FMT_QC8C:		descr = "QCOM Compressed 8bit Format"; break;
> +		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10bit Format"; break;

8bit -> 8-bit
10bit -> 10-bit

(similar to the other descriptions)

>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 311a01cc5775..c57628a16cf4 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -737,6 +737,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
> +#define V4L2_PIX_FMT_QC8C     v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
> +#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compresed */

compresed -> compressed

>  
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
> 

Regards,

	Hans

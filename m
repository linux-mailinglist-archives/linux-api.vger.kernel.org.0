Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B603B3D8B92
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 12:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhG1KQN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 06:16:13 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:45907 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhG1KQM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 06:16:12 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 8gUnmHE1pXTlc8gUomT1hI; Wed, 28 Jul 2021 12:09:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1627466942; bh=B9otj4mTwZ5yKZQb2cJmJ4bo3dRknjXAAxnwqgQ/oWo=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=W63fDKPAKLsy0R/GF7TqR95zO8o7BaLi6mpz8W+BdwmA3HMNinM9YlgYC1RlGHj2p
         eme+YFub0PJIWH6/88EhJ5BFyx0lcakW4CenKdCYGPyZAu9OpzRZQ3PN6tiatth9hG
         OioWMk1c4pVWadGXJupc1739lA47sxxu95JScP+QDwADHdGpor7KucvVjpgYkwK0QZ
         kjbF502F+NMYfzoke5wC9zQUji96TKuukklpBs/VxmyyTPAAmiXLXiwY42uW0oIIAy
         QUVmFVDzmZXeoWrdJPbEptT0XB190muGKII2o/PwrMDBbehdzjoKoWvfVrxJVXwaw6
         h88phcQKrh0nQ==
Subject: Re: [PATCH v2 1/5] v4l: Add Qualcomm custom compressed pixel formats
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
 <20210706124034.773503-2-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <d7d9cfe3-86b6-f17c-7742-e0965c8b9899@xs4all.nl>
Date:   Wed, 28 Jul 2021 12:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706124034.773503-2-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfE71IJhejUAZuBMqYXPw0GBAeILn9m7yIuoKU5vAq78VYvV2PoYuhCUMmByWYdvWTzyEe1zFpEsvlOgfU2ZRXrrFW6sqh59a52nrSo8PP7IBa+EZfL5a
 FQzJ9WwNYZxCesTwNbh3/M2uggWmY+s65Cm4KgZ25i3G7XK2mNWGHOBnlyWZorO3r6gyRKCLsAd4UXLBXttUODQQLvjiypMqUYhnxK7KF6GUDT449zV+PYoo
 6FbXRaXoON+cztIP8cWF9XaBPO68ZT4nj7pm743MI1FTh9zDvbbg331G80hTi/uapAnFN7I60c+sOLgwG2rCvm2ZUwOR187Wnw2jwUPUeYZTzF2KaFxcJ7I7
 8DR8EhK/AiS2hS3uoySjBXAa6Mqm9fIB09Ti2Syogh4Q+05veIa4aFpUMJDttSUsU0BHLHvXDzaVKvjliyLugcDbQthtObN78Dk2DYlmGvp5s1WwOcI=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 06/07/2021 14:40, Stanimir Varbanov wrote:
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
> +    * .. _V4L2-PIX-FMT-QC10C:
> +
> +      - ``V4L2_PIX_FMT_QC10C``
> +      - 'QC10C'
> +      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
> +	The used compression is lossless and it is used by various multimedia
> +	hardware blocks like GPU, display controllers, ISP and video.
> +	It contains four planes for progressive video and eight planes for
> +	interlaced video.

These two formats are opaque formats? Or is it something that userspace can
decode as well with the help of a datasheet or something similar?

If it is opaque (as I expect it is), then please add the phrase:
'It is an opaque intermediate format.'

Regards,

	Hans

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
> 


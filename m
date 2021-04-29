Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A07136F064
	for <lists+linux-api@lfdr.de>; Thu, 29 Apr 2021 21:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhD2TYe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Apr 2021 15:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239539AbhD2TL0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Apr 2021 15:11:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1058C06138B
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 12:10:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f12so49965803qtf.2
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ltkj3GwXMNWaqEgIRsYEcolYZKDxC8Ql9gepvrB9Q24=;
        b=TaBriJpTEbcq6utoehleZ+bDiikQrmpNSJk00MCJpyDMZLKOyVSneUzbn7CH4f/qn3
         FE1yimgmQ0EwoN8URvM9nU5Uvda1kkFueNohCj18W7thbi5clbQhHBwE3hQzUgPp2fJB
         +YvpPQTKoOeAx+4wu1ZyUrXd/xHbqG6PZTZrE4k1/hg2zTSqMVaysYRKZY29qGUbpo00
         xtHnnxqdp5jV/qFiADbiy6m9EHcrePboNKaCsSdRdB7pMQzuqaqt9xoqUyEm+YTh8LM7
         dOAa10WdrQiqJdkNPsoDoz+umXwoXcx66oHDICInmvjRXr4/sLOWjeQOwGQVr+F9lm5f
         QEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ltkj3GwXMNWaqEgIRsYEcolYZKDxC8Ql9gepvrB9Q24=;
        b=go86Fd/LPIJtxBq/Gk73Zlvn3pdRacC8zq4Xdrwf29TVEVxe4oqm3FntIRWNTpj0rM
         MmFqIsbab/nC2I33RJZ9JO8svS+yeQHsoaQlnxCvnR1eNNGgs6Mwi/ZJ4LjAddYR3fPo
         1FIRtcpcX7uMv3O2EB944SB1/yI40skSVIGSbr/dogLRgMR97gL7clNL5bIKyXAoXRTe
         3Uzdt2Jmn9MDHIL7MrGUihV0sjI+1JuIsrueD89KhxTCgvTw3oRbQ6mWKgpeSFgqaO1z
         wr04CtBxfiON9edS/Q0NGTHFitdMp4SNjSZo0CmiDCRCflOGzhs0dTkq9k1pzLCiNT+s
         Dlmg==
X-Gm-Message-State: AOAM532yfPakMvbt8f+Dl6yEVUEduIpEK+s5cSTOte7xVmLmgeLR+DzA
        q7+yBb1HXZyXMXz8kWYV2JwHbA==
X-Google-Smtp-Source: ABdhPJwZc2TDsodYdDvwl5OmNVUqcCm1bJyFDAHw3Z1GnVU7wF1KEyZShesHOjlg0t2Qjj5w0p+z7A==
X-Received: by 2002:ac8:7774:: with SMTP id h20mr901414qtu.79.1619723438687;
        Thu, 29 Apr 2021 12:10:38 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id r81sm2824049qka.82.2021.04.29.12.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:10:37 -0700 (PDT)
Message-ID: <d54b1bb7956e1e3bea47fde1216084c7f2eae87e.camel@ndufresne.ca>
Subject: Re: [PATCH 1/3] v4l: Add Qualcomm custom compressed pixel formats
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Thu, 29 Apr 2021 15:10:36 -0400
In-Reply-To: <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
         <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Le jeudi 29 avril 2021 à 13:58 +0300, Stanimir Varbanov a écrit :
> Here we add custom Qualcomm raw compressed pixel formats. They are
> used in Qualcomm SoCs to optimaize the interconnect bandwidth.

Wasn't reviewing, just skimming the lists, but s/optimaize/optimize/

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../userspace-api/media/v4l/pixfmt-reserved.rst      | 12 ++++++++++++
>  drivers/media/v4l2-core/v4l2-ioctl.c                 |  2 ++
>  include/uapi/linux/videodev2.h                       |  2 ++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 0b879c0da713..30b9cef4cbf0 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -260,6 +260,18 @@ please make a proposal on the linux-media mailing list.
>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>  	subsampling).
> +    * .. _V4L2-PIX-FMT-QC8C:
> +
> +      - ``V4L2_PIX_FMT_QC8C``
> +      - 'QC8C'
> +      - Compressed Macro-tile 8Bit YUV420 format used by Qualcomm platforms.
> +	The compression is lossless. It contains four planes.

Would be nice to document if the bytesperline is meaningful or not. Basically,
what information need to be carried to other drivers ?

> +    * .. _V4L2-PIX-FMT-QC10C:
> +
> +      - ``V4L2_PIX_FMT_QC10C``
> +      - 'QC10C'
> +      - Compressed Macro-tile 10Bit YUV420 format used by Qualcomm platforms.
> +	The compression is lossless. It contains four planes.
>  
> 
> 
> 
> 
> 
> 
> 
>  .. raw:: latex
>  
> 
> 
> 
> 
> 
> 
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 6a5d1c6d11d6..33ee12b97aa0 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1455,6 +1455,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
> +		case V4L2_PIX_FMT_QC8C:		descr = "QCOM Compressed 8bit Format"; break;
> +		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10bit Format"; break;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 311a01cc5775..c57628a16cf4 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -737,6 +737,8 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
> +#define V4L2_PIX_FMT_QC8C     v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
> +#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compresed */
>  
> 
> 
> 
> 
> 
> 
> 
>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */



Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34683985D1
	for <lists+linux-api@lfdr.de>; Wed,  2 Jun 2021 12:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFBKEU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Jun 2021 06:04:20 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:48695 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhFBKET (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Jun 2021 06:04:19 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 06:04:19 EDT
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id oNgmlUEuUIpGyoNgplPC4v; Wed, 02 Jun 2021 12:01:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622628091; bh=/QoizLPSJePeB4Gpm1NI058wdS+DU0b8RstN2od348s=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=mH7dGeU1bQOm8jhFRwt0LWrsIjBL8VGBOKq3A3Suy79B4LClqtrPlH5poj9pEpd60
         BucSHkUBaYh+GpLZGMF+Q8y7ogv9HdwhMCoRCp8z0bcvII5SAFQytMed3ZulZJ8tDN
         nWjV5K/9zYDom01k0IL/4yyLqfqA5YDElJG6fsGEdBDxAkeGLrsXoLrHQNqpyUXoq/
         b0JJtk8WVG4s+wgvVnTSl7/IlDRprclJk2gz+SH8nCZxNTpFePD3SoKvOjZQDUWfdd
         rAfzXmBCMunRf1LF0PmFtlU/Z+GCgz/yCc9tUQ0dqbt9Rnq/qPdURWwQNnnOYphhs4
         RQabwTieu6BEA==
Subject: Re: [PATCH 3/3] venus: Add a handling of QC10C compressed format
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
 <20210429105815.2790770-4-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <37d5e58c-ce5b-07f8-396f-662258a9b229@xs4all.nl>
Date:   Wed, 2 Jun 2021 12:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429105815.2790770-4-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGuxLyx2fCMs3/3q3zvDQWlvGij9NX8sf5r/BcoO418azIXlnvl+XcZ6McUBStFeN6j+Mby/6xRVhlaGhrs32Ib55chiPxWSSQj6q/YH4edzOLEFMsVv
 iDi3e8jMaYp29sWg8UGtS/9JFJXpe0e131/MSmp1gTSb7MkHPH/KXxY4AjtsbYRXyv5nFser0W/bTzOtLqdh0OU8mTYGgMsBzxSEBLaZfUI09DWa0CkQXaZV
 yjohLoyiwhT3D7E2EC/dmDo6rZdIm/A7+daEX4DgoM3MoT3VEipCxF1PypPKhxQw93fHrfyeCYiPKABc0pE8pbMOU/zskYMMGNjM7xwRZYYf0AcaQnbkeZlE
 IDGJFcnd0WrJwlgBuT50NBgCOF/PtmtuhHSS80e9dlHWO8wStiE=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29/04/2021 12:58, Stanimir Varbanov wrote:
> This adds QC10C compressed pixel format in the Venus driver, and
> make it enumeratable from v4l2 clients.

enumeratable -> possible to discover

(or possibly 'enumerable', but I prefer the phrase suggested above)

> 
> Note: The QC10C format shouldn't be possible to enumerate by the
> client if the decoded bitstream is not 10bits. This is not

10bits -> 10-bits

> implemented in this patch yet.

Obvious question: will this be done in a later patch that is being
prepared? Would it be better to wait until such a patch is available?

Regards,

	Hans

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 2 ++
>  drivers/media/platform/qcom/venus/vdec.c    | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 3a0b07d237a5..58bf2e0654ce 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -563,6 +563,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
>  		return HFI_COLOR_FORMAT_NV21;
>  	case V4L2_PIX_FMT_QC8C:
>  		return HFI_COLOR_FORMAT_NV12_UBWC;
> +	case V4L2_PIX_FMT_QC10C:
> +		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index d4cc51fc019c..7ad8cd66b8bc 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -35,6 +35,10 @@ static const struct venus_format vdec_formats[] = {
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>  	}, {
> +		.pixfmt = V4L2_PIX_FMT_QC10C,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +	},{
>  		.pixfmt = V4L2_PIX_FMT_NV12,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> @@ -1508,7 +1512,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
>  static void vdec_inst_init(struct venus_inst *inst)
>  {
>  	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
> -	inst->fmt_out = &vdec_formats[6];
> +	inst->fmt_out = &vdec_formats[8];
>  	inst->fmt_cap = &vdec_formats[0];
>  	inst->width = frame_width_min(inst);
>  	inst->height = ALIGN(frame_height_min(inst), 32);
> 


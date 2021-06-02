Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6C3985D9
	for <lists+linux-api@lfdr.de>; Wed,  2 Jun 2021 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFBKFx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Jun 2021 06:05:53 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:38343 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230482AbhFBKFw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Jun 2021 06:05:52 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id oNezlUEHIIpGyoNf3lPBjw; Wed, 02 Jun 2021 11:59:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622627981; bh=FWzRnbfqVvfgcr0ooi3vW4RiJLyjwwJA8ILaGIqTI3Q=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=CLtcCRE1R3/NSScca0v4qXC2CqpStwOyQA9voG5JquNyBg62QYQtd0dye+bbpGnrc
         Qh+lNcAxc4MRD1I8kiTZ9ldFxCATbHELv6a8Hnk5gxO+OUhevZj4y/ZtmuThxcYYMR
         +slGq1SXqZOa+CEtzVGJVCcXfKDEeuBHKT/iN8LKDUbM2Z1G3rikDe7tF9fblPyYWX
         2qM+DvdIU8U/y1aRiAUD8W8S9l+wmzPowh/JL7a54JL9l4761/kfZDbzVhkwRsmHrE
         fMZfS17GSfaAFc4ZfyaPiWmLHHUZWaWPEwzIB4vX+sh52x2tq8pRST10y0G5r6YMQ4
         4JBjHvdJQLVvw==
Subject: Re: [PATCH 2/3] venus: Add a handling of QC8C compressed format
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
 <20210429105815.2790770-3-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <d2960304-f119-aff2-3be7-9b50ad67a650@xs4all.nl>
Date:   Wed, 2 Jun 2021 11:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429105815.2790770-3-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKjA6GTJ/+QFuKZ3BFX6a3PWHnRPUSN6SwngD065rvxRykgTC48HDu4i3Er643lTGFixpzLY7OLrvy0Ykn/hPj0T+Eyx2GGeB9NzkPY7jijGlXBlvsNh
 MP8iJ9EAIRsTXrlSFI++QNR+cj+a+BeMqpjB7ouHr6gOm/XO7bXT+gM7JIbSxQ88nypUSOTFPmyyXV1RjKYDvcYx8d1x2Ykm8kryzZCHmjkN31+ApWK0eqP2
 Gu54viWeQVgUdjFQI8ESUrzniK1p7nKu3ZdNATRpOM9lP1KIYDK+3HqWO+jhAluI6GD9LY9SssFUNtvZwqpZDCmvOmitbQz7WjxOSJYBNLheJ9p10ekG2hVl
 SIocdwNS9fTuvVz6eAq7gGEUkUJth48YjAdk+TAUAN6PZRiWKIc=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29/04/2021 12:58, Stanimir Varbanov wrote:
> This adds QC8C compressed pixel format in the Venus driver, and
> make it enumeratable from v4l2 clients.

enumeratable -> possible to discover

(or possibly 'enumerable', but I prefer the phrase suggested above)

Regards,

	Hans

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c |  2 ++
>  drivers/media/platform/qcom/venus/vdec.c    | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 9b8ff76e3c43..3a0b07d237a5 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -561,6 +561,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
>  		return HFI_COLOR_FORMAT_NV12;
>  	case V4L2_PIX_FMT_NV21:
>  		return HFI_COLOR_FORMAT_NV21;
> +	case V4L2_PIX_FMT_QC8C:
> +		return HFI_COLOR_FORMAT_NV12_UBWC;
>  	default:
>  		break;
>  	}
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 5e5584fc21e9..d4cc51fc019c 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -31,6 +31,10 @@
>   */
>  static const struct venus_format vdec_formats[] = {
>  	{
> +		.pixfmt = V4L2_PIX_FMT_QC8C,
> +		.num_planes = 1,
> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +	}, {
>  		.pixfmt = V4L2_PIX_FMT_NV12,
>  		.num_planes = 1,
>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> @@ -696,7 +700,13 @@ static int vdec_output_conf(struct venus_inst *inst)
>  	inst->output2_buf_size =
>  			venus_helper_get_framesz_raw(out2_fmt, width, height);
>  
> -	if (is_ubwc_fmt(out_fmt)) {
> +	if (is_ubwc_fmt(out_fmt) && is_ubwc_fmt(out2_fmt)) {
> +		inst->output2_buf_size = 0;
> +		inst->opb_buftype = HFI_BUFFER_OUTPUT;
> +		inst->opb_fmt = out_fmt;
> +		inst->dpb_buftype = 0;
> +		inst->dpb_fmt = 0;
> +	} else if (is_ubwc_fmt(out_fmt)) {
>  		inst->opb_buftype = HFI_BUFFER_OUTPUT2;
>  		inst->opb_fmt = out2_fmt;
>  		inst->dpb_buftype = HFI_BUFFER_OUTPUT;
> 


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879B54B9EB8
	for <lists+linux-api@lfdr.de>; Thu, 17 Feb 2022 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiBQLeS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Feb 2022 06:34:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiBQLeR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 Feb 2022 06:34:17 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB12722D0
        for <linux-api@vger.kernel.org>; Thu, 17 Feb 2022 03:34:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so6462701ejc.9
        for <linux-api@vger.kernel.org>; Thu, 17 Feb 2022 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LIJbkcpxWhEu+HDqv6mv/542M4vTfuWftkC1BaPuPbU=;
        b=TbT4HVYGoCKKxlNKiPmpU3SWwZu5CDTjF38mWAh6T0DazaZgHk+5lHNO40yFFoCoTJ
         IhX5v53CL1y0eY6Bdqq1t2Zih8HsaZ0p9WiMQHisl/7D5UNkZv20RitrLquvOEsp7uZ8
         2UOrYUbwo+MkwjM2gosoNiJxw+R7zAXFc42lLSMGTafO8g3dSGIgRFgCj0kPS5WGaJmq
         OGUcbMkoR6mS7EZ9CLLKNKC4g+4cwCCWM2lYGVH8WGBInhQkswKz3DmFM6AnpiEF4tr8
         WalK7TefoPlqQBGrhd9NNSP8YyvXhC6UAYqJ2+qziFFn8PPn+bfEI9C2KIcYA2gBPfKA
         5dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LIJbkcpxWhEu+HDqv6mv/542M4vTfuWftkC1BaPuPbU=;
        b=VRHeStxrMqHlC3E8h5eRp9Qn3WHnb/8WZIraMaJvtnmdCdJVY/smCJBT+TlI24z5Kb
         B84r03g5ziEKoMQKECqNpBfw0Q6g+2NUW1yMoCwZad+9Ks39l0jA2RqPRRuu2I8RytVO
         +kfRlKsR0YBEWd5cT8AIo276TdNgmiOYpaDf5waI1UjNJbrHhTD/fTUgBNVpiuQqChY3
         1QQAPeiSQDgAtRe8f6DqUnv6H+hSZV3R6gOC1Uz6LJnceyWa58HWsW67Ql7LT12j+oyG
         l8eo4jWSp0vHB30jKP/UjRzioZen2WaZ4aLOsPxLDjWZOBJKLnGPT4FjWeJM9qoJnPVE
         30OA==
X-Gm-Message-State: AOAM532GHWx3zM3UAKMHEa4iey+ypEZUyo4l6Q0QmFkElerjgT4khDpm
        GXIFuS7bxXZESoMNF0JmIVCDgQ==
X-Google-Smtp-Source: ABdhPJw4Erll/uCqjzTBT96QBBylhZa1svkxPBZvtY01p3v7Q1PQeyr8NcLtaKJsoJkrerC/ucp6eA==
X-Received: by 2002:a17:906:b57:b0:6ce:e31a:524 with SMTP id v23-20020a1709060b5700b006cee31a0524mr1969824ejg.290.1645097640461;
        Thu, 17 Feb 2022 03:34:00 -0800 (PST)
Received: from [192.168.1.9] (hst-221-75.medicom.bg. [84.238.221.75])
        by smtp.googlemail.com with ESMTPSA id u4sm1076625ejn.216.2022.02.17.03.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:33:59 -0800 (PST)
Message-ID: <55dbdf8b-290c-85ff-235e-9e5649540b6e@linaro.org>
Date:   Thu, 17 Feb 2022 13:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/6] venus: Add a handling of QC10C compressed format
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
 <20220117155559.234026-6-stanimir.varbanov@linaro.org>
 <4e1cc50854da4075fc7ebf71e24aa8372905c668.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <4e1cc50854da4075fc7ebf71e24aa8372905c668.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 2/16/22 18:20, Nicolas Dufresne wrote:
> Le lundi 17 janvier 2022 à 17:55 +0200, Stanimir Varbanov a écrit :
>> This adds QC10C compressed pixel format in the Venus driver, and
>> make it possible to discover from v4l2 clients.
>>
>> Note: The QC10C format shouldn't be possible to discpver by the
> 
> discpver -> discover
> 
> It is not super clear though, did you mean to say that it won't be enumerated
> after the header have been parsed ?

The opposite. It will be enumerable by the client only after parsing the
header.

> 
>> client if the decoded bitstream is not 10-bits.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/helpers.c | 26 ++++-----------------
>>  drivers/media/platform/qcom/venus/vdec.c    | 19 ++++++++++++---
>>  2 files changed, 20 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
>> index adbfa4fbe139..69a9a9471a27 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -594,6 +594,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
>>  		return HFI_COLOR_FORMAT_NV21;
>>  	case V4L2_PIX_FMT_QC08C:
>>  		return HFI_COLOR_FORMAT_NV12_UBWC;
>> +	case V4L2_PIX_FMT_QC10C:
>> +		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
>>  	default:
>>  		break;
>>  	}
>> @@ -1176,7 +1178,8 @@ int venus_helper_set_format_constraints(struct venus_inst *inst)
>>  	if (!IS_V6(inst->core))
>>  		return 0;
>>  
>> -	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC)
>> +	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC ||
>> +	    inst->opb_fmt == HFI_COLOR_FORMAT_YUV420_TP10_UBWC)
>>  		return 0;
>>  
>>  	pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
>> @@ -1747,27 +1750,6 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>>  	if (!caps)
>>  		return -EINVAL;
>>  
>> -	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
>> -	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
>> -		found_ubwc =
>> -			find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
>> -					   HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
>> -		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
>> -					   HFI_COLOR_FORMAT_NV12);
>> -		if (found_ubwc && found) {
>> -			/*
>> -			 * Hard-code DPB buffers to be 10bit UBWC and decoder
>> -			 * output buffers in 8bit NV12 until V4L2 is able to
>> -			 * expose compressed/tiled formats to applications.
>> -			 */
>> -			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
>> -			*out2_fmt = HFI_COLOR_FORMAT_NV12;
>> -			return 0;
>> -		}
>> -
>> -		return -EINVAL;
>> -	}
>> -
>>  	if (ubwc) {
>>  		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
>>  		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index eb02e45a512b..c8261c6cb0fb 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -35,6 +35,10 @@ static const struct venus_format vdec_formats[] = {
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>>  	}, {
>> +		.pixfmt = V4L2_PIX_FMT_QC10C,
>> +		.num_planes = 1,
>> +		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> +	},{
>>  		.pixfmt = V4L2_PIX_FMT_NV12,
>>  		.num_planes = 1,
>>  		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> @@ -114,6 +118,10 @@ find_format(struct venus_inst *inst, u32 pixfmt, u32 type)
>>  	    !venus_helper_check_format(inst, fmt[i].pixfmt))
>>  		return NULL;
>>  
>> +	if (V4L2_TYPE_IS_CAPTURE(type) && fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
>> +	    !(inst->bit_depth == VIDC_BITDEPTH_10))
>> +		return NULL;
>> +
>>  	return &fmt[i];
>>  }
>>  
>> @@ -133,11 +141,16 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
>>  		if (fmt[i].type != type)
>>  			continue;
>>  
>> -		if (V4L2_TYPE_IS_OUTPUT(type))
>> +		if (V4L2_TYPE_IS_OUTPUT(type)) {
>>  			valid = venus_helper_check_codec(inst, fmt[i].pixfmt);
>> -		else if (V4L2_TYPE_IS_CAPTURE(type))
>> +		} else if (V4L2_TYPE_IS_CAPTURE(type)) {
>>  			valid = venus_helper_check_format(inst, fmt[i].pixfmt);
>>  
>> +			if (fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
>> +			    !(inst->bit_depth == VIDC_BITDEPTH_10))
>> +				valid = false;
>> +		}
>> +
>>  		if (k == index && valid)
>>  			break;
>>  		if (valid)
>> @@ -1537,7 +1550,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
>>  static void vdec_inst_init(struct venus_inst *inst)
>>  {
>>  	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
>> -	inst->fmt_out = &vdec_formats[7];
>> +	inst->fmt_out = &vdec_formats[8];
>>  	inst->fmt_cap = &vdec_formats[0];
>>  	inst->width = frame_width_min(inst);
>>  	inst->height = ALIGN(frame_height_min(inst), 32);
> 

-- 
regards,
Stan

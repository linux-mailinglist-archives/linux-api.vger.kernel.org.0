Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E2398A73
	for <lists+linux-api@lfdr.de>; Wed,  2 Jun 2021 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFBNa4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Jun 2021 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFBNaz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Jun 2021 09:30:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D7C061756
        for <linux-api@vger.kernel.org>; Wed,  2 Jun 2021 06:29:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ba2so1206105edb.2
        for <linux-api@vger.kernel.org>; Wed, 02 Jun 2021 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZONPVevPrQ8kgbLjTG/JbKJkdCcwfXG19PWEk0gLLz8=;
        b=Pu00urgWpWIirMQ/SnHIyILnSmFYl5efJUfM/avAHQoV3zciv3sBvGrz7KcB1nBokf
         zwNvbSkdBvO49VNx5q2Zj81dNtjrqU0Mz+qPuJkdsJo78RVM8/dV2qHIfxaYpVJlYDbg
         dgz5Hs352CDX5gEp4NB0OXazoWWv8JXoqsGS76P4ZbjazJVoqRKLaEoIB6Vy5jZdh+vc
         WnHc25WuYaTkqfkm6ar44Z9TEw3TMPZL2w7RLyfBAeO4Am+XtJrB/06/Sllg5A+DYzXl
         XBFNCZkaz3FVB3cqym2YDeY+sVuAx2b0E2SWqoSZrZc+BohhpYlCDIKa9JMAGyjCiFNy
         74NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZONPVevPrQ8kgbLjTG/JbKJkdCcwfXG19PWEk0gLLz8=;
        b=iV4W1eZ157+SFcMhMalyTmDh6AjU60ip+at1FXfA6NV+1gA/X04ESYx4Hmt2nDa9cr
         r9QFHs65PJtWJGwv5cinUVNwu3eNf4QcWN+CXpTlqltZ1e7LtcI1E2+DkaKWOXlX7KKN
         8GSwUlqU7HHI58PoCLE86YdWgleRk8KeXmT/WKVtc9Hr0c1GwVZXXDhlxCYlP7tNHv9W
         5CO9IHYY1dnmu+CDH5hW3F7u3BXyUdWdy92T1VU2PCpYzZPvOiPDo7JIfayrp+/dDGbu
         kGGfupShBYP3mTu89GnxD6oNgVoyRIwoc6iehRYLmMgiZc1a7XE6WEoJ6evc22LSVdzx
         jyaA==
X-Gm-Message-State: AOAM530/ZhUxPlnUc0RLM5OvFKciI+HGAESFH9aZPHeGLj8vAmzE4QuM
        jUAI7tdN7ZMEW3v9DIgheeZw1A==
X-Google-Smtp-Source: ABdhPJywkRCY1c6rYh5cyHIY/U67rtIChrhtM3oBEa7Sqq51T+PU5O6ZFcrUf1JWHwutz6QUObW9Mg==
X-Received: by 2002:aa7:cc97:: with SMTP id p23mr38160427edt.372.1622640550284;
        Wed, 02 Jun 2021 06:29:10 -0700 (PDT)
Received: from [192.168.1.28] (hst-221-100.medicom.bg. [84.238.221.100])
        by smtp.googlemail.com with ESMTPSA id b22sm1337371eds.71.2021.06.02.06.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 06:29:09 -0700 (PDT)
Subject: Re: [PATCH 1/3] v4l: Add Qualcomm custom compressed pixel formats
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
 <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
 <b58061ff-aeb1-c48b-ea53-2366997bd825@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <7a8a3b86-0c0a-f190-b6e7-d83d7d6b6433@linaro.org>
Date:   Wed, 2 Jun 2021 16:29:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b58061ff-aeb1-c48b-ea53-2366997bd825@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 6/2/21 12:56 PM, Hans Verkuil wrote:
> On 29/04/2021 12:58, Stanimir Varbanov wrote:
>> Here we add custom Qualcomm raw compressed pixel formats. They are
>> used in Qualcomm SoCs to optimaize the interconnect bandwidth.
> 
> optimize
> 
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../userspace-api/media/v4l/pixfmt-reserved.rst      | 12 ++++++++++++
>>  drivers/media/v4l2-core/v4l2-ioctl.c                 |  2 ++
>>  include/uapi/linux/videodev2.h                       |  2 ++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> index 0b879c0da713..30b9cef4cbf0 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> @@ -260,6 +260,18 @@ please make a proposal on the linux-media mailing list.
>>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>>  	subsampling).
>> +    * .. _V4L2-PIX-FMT-QC8C:
>> +
>> +      - ``V4L2_PIX_FMT_QC8C``
>> +      - 'QC8C'
>> +      - Compressed Macro-tile 8Bit YUV420 format used by Qualcomm platforms.
> 
> 8Bit -> 8-bit
> 
>> +	The compression is lossless. It contains four planes.
>> +    * .. _V4L2-PIX-FMT-QC10C:
>> +
>> +      - ``V4L2_PIX_FMT_QC10C``
>> +      - 'QC10C'
>> +      - Compressed Macro-tile 10Bit YUV420 format used by Qualcomm platforms.
> 
> 10Bit -> 10-bit
> 
>> +	The compression is lossless. It contains four planes.
> 
> What is not clear from this description is if these formats are opaque, i.e. the
> only way to decompress is through hardware, or if they can be decompressed in
> software. If so, a reference to Qualcomm documentation would be useful. See e.g.
> the V4L2_PIX_FMT_MT21C description (that's an opaque format).

Yes, the formats are opaque and can be decompressed by hardware blocks
only. I'll clear that in v2. Thanks for the review.

-- 
regards,
Stan

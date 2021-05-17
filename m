Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A833839D3
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhEQQab (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242142AbhEQQaP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 12:30:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6652AC08EB03
        for <linux-api@vger.kernel.org>; Mon, 17 May 2021 08:13:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lg14so9728205ejb.9
        for <linux-api@vger.kernel.org>; Mon, 17 May 2021 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=usbkl3eSbLJY48dNZ3F0WFUOcTmkoTvft5/B7CL2sSU=;
        b=kEuT1N5/kO7rAdEgl1j8JLVDuUgyk4mkEmZFl/+L8PvOtZmcdeETEi8LQMF8goxorE
         FHnZ92LpD8DQrwHOQnBY0OJtFifqJVScvJBJMt7TI/clMG9wx1CsJjBQx5H0QwNpwNqz
         MGfJd0FotdiakdxcCi9xYYnEwCAN2u0wOhxTnXByh1if0GaLk0sx0poV3LInQt1k+l8T
         YULNsLltGxmiW6JJkLVGH4BUgIznFMaEjApb9esqcBXB3UeNl8GhX9YL3Yf/61VvVBEQ
         3/0oV9tncPFMDubvXrNbDEVU9mMc9AvFU3gIfELO3i7hr2vxS/xIirAA+Ma1oZ+/A3ZB
         woog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=usbkl3eSbLJY48dNZ3F0WFUOcTmkoTvft5/B7CL2sSU=;
        b=I2ZvFU/4KhJ8wiFKM61Bapi0/HCEShfND+Wh7zuu2ZMiIv5Mk5HS0syH+yA7yglj/4
         IgSpzS5aEQJ5J+ItCUZsAjqV+4Hd7ORJaWDa+LeVut6Z0HndSoICbZOoiEvQuXcCUxoE
         gjZP+AOUY/Uyb48YFdPlYmwuqVcgpjriN6585bdS6mnHLi8oVt2kJD1m/eP3Z7Q9cSGa
         a2qonq2IK3Hj3QS/iqRNEbPXVsoY9YDWo37u7c85QrabqJ8nxmTx37L6l5AFbJGa6xee
         Vl1q1qLZa7wJLW3q1IBJ9XLjHqICVwqMLXcVY9wKZd+hajArFoeVzW58P5UN1DUEfcF3
         ysbQ==
X-Gm-Message-State: AOAM531ilngdLrfZkXuFoixq+SvaFLvOsTwRDVSmpkzTEwEyTwOK3BKF
        c0jrHL6Oi0H63UrHuynN3RYekMfSBMWewpAz
X-Google-Smtp-Source: ABdhPJyz6c2G3oG+zPca9fjjDDqPHFgaRlOjr19GzNPtmUAVMbqQGJd82kvv2LT1kvF53lvygb3s8Q==
X-Received: by 2002:a17:906:2559:: with SMTP id j25mr423050ejb.42.1621264386090;
        Mon, 17 May 2021 08:13:06 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id z4sm11175002edc.1.2021.05.17.08.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 08:13:05 -0700 (PDT)
Subject: Re: [PATCH 1/3] v4l: Add Qualcomm custom compressed pixel formats
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
 <20210429105815.2790770-2-stanimir.varbanov@linaro.org>
 <d54b1bb7956e1e3bea47fde1216084c7f2eae87e.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <892effb7-7a29-e016-c903-1a9bee6e9881@linaro.org>
Date:   Mon, 17 May 2021 18:13:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d54b1bb7956e1e3bea47fde1216084c7f2eae87e.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 4/29/21 10:10 PM, Nicolas Dufresne wrote:
> Le jeudi 29 avril 2021 à 13:58 +0300, Stanimir Varbanov a écrit :
>> Here we add custom Qualcomm raw compressed pixel formats. They are
>> used in Qualcomm SoCs to optimaize the interconnect bandwidth.
> 
> Wasn't reviewing, just skimming the lists, but s/optimaize/optimize/
> 
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../userspace-api/media/v4l/pixfmt-reserved.rst      | 12 ++++++++++++
>>  drivers/media/v4l2-core/v4l2-ioctl.c                 |  2 ++
>>  include/uapi/linux/videodev2.h                       |  2 ++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> index 0b879c0da713..30b9cef4cbf0 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> @@ -260,6 +260,18 @@ please make a proposal on the linux-media mailing list.
>>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>>  	subsampling).
>> +    * .. _V4L2-PIX-FMT-QC8C:
>> +
>> +      - ``V4L2_PIX_FMT_QC8C``
>> +      - 'QC8C'
>> +      - Compressed Macro-tile 8Bit YUV420 format used by Qualcomm platforms.
>> +	The compression is lossless. It contains four planes.
> 
> Would be nice to document if the bytesperline is meaningful or not. Basically,
> what information need to be carried to other drivers ?

I don't think that bytesperline has some valuable information, the
important thing is the size of the memory buffer and it should be used
to negotiate between v4l2 and drm for example. The layout of the buffer
can be seen at [1].

[1]
https://android.googlesource.com/kernel/msm/+/android-msm-bullhead-3.10-marshmallow-dr/include/media/msm_media_info.h

-- 
regards,
Stan

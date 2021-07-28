Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CE3D8B8A
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhG1KPD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 06:15:03 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:45115 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229574AbhG1KPD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 06:15:03 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 06:15:02 EDT
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 8gWJmHEqjXTlc8gWKmT208; Wed, 28 Jul 2021 12:10:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1627467036; bh=gv8gmye/9ejk6XOGeVbL9s71qQDTUOTdDlu2qtRLqUE=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=k9gzyL8QPN82OIoSOnkqTO3P1FA26kdk/w7/EG+uWFHHFilBjKhjppCTt3pWMolUA
         w0byJWjA0Uu9xfnhc5n4PxwAih66ZATAIxAqjCIy9bbJ1gWAJZfngN2d1u2dzrynAs
         mXBd8jIZYIp5/vwniZlHLlN+mJpczQkduR9GFbKjDeI89IDZTDkAh9AnkFPw0VjrTy
         NUEOwlc4EVogEsINNaB6h/qb+Fjnu0/0+991a4YVXHAdSV0LIheDJFGUeZxzbnfQrn
         O9BPL6yN8yGwjzPbMRdje+6wRskwZhyyE1HNIjKLlL7ZK+Zc56UWia8dPPxsvmRx6F
         APLvHc4iuS+9g==
Subject: Re: [PATCH v2 1/5] v4l: Add Qualcomm custom compressed pixel formats
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
 <20210706124034.773503-2-stanimir.varbanov@linaro.org>
 <d7d9cfe3-86b6-f17c-7742-e0965c8b9899@xs4all.nl>
Message-ID: <e0b26ee1-3109-06fe-5283-ac978fc768de@xs4all.nl>
Date:   Wed, 28 Jul 2021 12:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d7d9cfe3-86b6-f17c-7742-e0965c8b9899@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDvZ5nhQJvKrzG4QZpUQrVT7I5AOEVCdLv6eMbiwL98lMzvkK6GhBWJJ3zgl9UFhE/1D//2hrhxuexYEsLtbJwwmrDr1z9hdCxIrFn2fWD1000gMW6PN
 k74wDbljbFkqxrNpOwUKA0c6qcTt09xRYkqTSfs1uyt4jXpkqFSXZ+jSuAPDTULKsFo/gckTGWpW/uGuopVqT0IVDYWzetCnzLHNwfSbd6hUWQlEziRwWm4G
 efMqqoZQGaURi6XOVwat43RjrRwYnD//LLLM7+CRy2KOHCKuWxzOn/BolawDpzpHow6Xm0pHB8dmJzg9VQpEYHgXHgkZ9F3xQAwJCBNxaXNiPZLO+EHUHOUc
 BZ4xUTZ2ZTquNWdHFfreiQGA1AhZ1s66tMiu/yoDMiIyzwdLq5msWU2g117v2PVgcC0MLrW25Dn4fzEQdCmSVuBp9AnaoDXmwetihdEAmEjxwMBQ3u4=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 28/07/2021 12:09, Hans Verkuil wrote:
> On 06/07/2021 14:40, Stanimir Varbanov wrote:
>> Add custom Qualcomm raw compressed pixel formats. They are
>> used in Qualcomm SoCs to optimize the interconnect bandwidth.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../media/v4l/pixfmt-reserved.rst              | 18 ++++++++++++++++++
>>  drivers/media/v4l2-core/v4l2-ioctl.c           |  2 ++
>>  include/uapi/linux/videodev2.h                 |  2 ++
>>  3 files changed, 22 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> index 0b879c0da713..136e9832db0c 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
>> @@ -260,6 +260,24 @@ please make a proposal on the linux-media mailing list.
>>  	of tiles, resulting in 32-aligned resolutions for the luminance plane
>>  	and 16-aligned resolutions for the chrominance plane (with 2x2
>>  	subsampling).
>> +    * .. _V4L2-PIX-FMT-QC08C:
>> +
>> +      - ``V4L2_PIX_FMT_QC08C``
>> +      - 'QC08C'
>> +      - Compressed Macro-tile 8-Bit YUV420 format used by Qualcomm platforms.
>> +	The used compression is lossless and it is used by various multimedia
>> +	hardware blocks like GPU, display controllers, ISP and video accelerators.
>> +	It contains four planes for progressive video and eight planes for
>> +	interlaced video.
>> +    * .. _V4L2-PIX-FMT-QC10C:
>> +
>> +      - ``V4L2_PIX_FMT_QC10C``
>> +      - 'QC10C'
>> +      - Compressed Macro-tile 10-Bit YUV420 format used by Qualcomm platforms.
>> +	The used compression is lossless and it is used by various multimedia
>> +	hardware blocks like GPU, display controllers, ISP and video.
>> +	It contains four planes for progressive video and eight planes for
>> +	interlaced video.
> 
> These two formats are opaque formats? Or is it something that userspace can
> decode as well with the help of a datasheet or something similar?
> 
> If it is opaque (as I expect it is), then please add the phrase:
> 'It is an opaque intermediate format.'

If it is not an opaque format, then add a reference to QCom documentation that
describes it (even if it is only available under NDA).

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>  
>>  .. raw:: latex
>>  
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index 05d5db3d85e5..76d4e4ac18e8 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1416,6 +1416,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
>>  		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>>  		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
>> +		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
>> +		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
>>  		default:
>>  			if (fmt->description[0])
>>  				return;
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 9260791b8438..dc1b714ccf6b 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -737,6 +737,8 @@ struct v4l2_pix_format {
>>  #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
>>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
>>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
>> +#define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
>> +#define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
>>  
>>  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
>>  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
>>
> 


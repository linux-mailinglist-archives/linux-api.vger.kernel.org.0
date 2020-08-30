Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3AC256AFB
	for <lists+linux-api@lfdr.de>; Sun, 30 Aug 2020 03:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgH3BA3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 29 Aug 2020 21:00:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35308 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgH3BA1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 29 Aug 2020 21:00:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id g29so2330111pgl.2;
        Sat, 29 Aug 2020 18:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4x9Y37hGo7dYMbHIwPQnyQub3kar4dZzeiDIibRQ0Z0=;
        b=DlSooqYJBqWiGlEggg1P8ytwz531RIRNJ6FCBZyacsPYnvjCBeaAlNwnnw70nEl+uz
         nmFX66Ej2P8O7/+OsgNkSgeiGYOv9mevgGa0BJ17wQswbM5c/lU8T5/hKPngTo2vTWmx
         q/spO8PCkf7DqhbW8qoNA3xSpeK2LCKK4McmO6PInWITYwL9fRHb8GeHVrEac6d9dOQI
         1HPrrV2HhXXAlSpgKqIvCCFQiF76+sR84UFeKUfOuzfmDuIc4aomzHlmJpe2ifCnPnbN
         PVs/EPutrz+q69F+ZGXjmSTPSGauMTNVuAktwk/oaeh3ISnxaBrjU9+JSXFGYD+zffMZ
         UDbA==
X-Gm-Message-State: AOAM530HH1agX7z0qLXCBZwi0ZMFVtwH9hRxXXrhmdglKqMTIR0tg1rt
        KDBoTy6cxMpQrfPfC00QqO8xOKhKsU4=
X-Google-Smtp-Source: ABdhPJywUsXxxHLzlNySajXEDKXm3bSoyUhsQ213Vz8vJbMsGZtiz7tobg71wwlz9DfUm0Goq/pUIA==
X-Received: by 2002:aa7:8b0c:: with SMTP id f12mr4556707pfd.58.1598749226303;
        Sat, 29 Aug 2020 18:00:26 -0700 (PDT)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c143sm3891930pfb.84.2020.08.29.18.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 18:00:25 -0700 (PDT)
Subject: Re: [PATCH v2] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
To:     Khazhismel Kumykov <khazhy@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
References: <20200824221034.2170308-1-khazhy@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <e50a4ff6-39fb-6ba0-40ab-d348fbf5567f@acm.org>
Date:   Sat, 29 Aug 2020 18:00:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824221034.2170308-1-khazhy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-08-24 15:10, Khazhismel Kumykov wrote:
> CAP_SYS_ADMIN is too broad, and ionice fits into CAP_SYS_NICE's grouping.
> 
> Retain CAP_SYS_ADMIN permission for backwards compatibility.
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  block/ioprio.c                  | 2 +-
>  include/uapi/linux/capability.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> v2: fix embarrassing logic mistake
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 77bcab11dce5..276496246fe9 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -69,7 +69,7 @@ int ioprio_check_cap(int ioprio)
>  
>  	switch (class) {
>  		case IOPRIO_CLASS_RT:
> -			if (!capable(CAP_SYS_ADMIN))
> +			if (!capable(CAP_SYS_NICE) && !capable(CAP_SYS_ADMIN))
>  				return -EPERM;
>  			/* fall through */
>  			/* rt has prio field too */
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 395dd0df8d08..c6ca33034147 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -288,6 +288,8 @@ struct vfs_ns_cap_data {
>     processes and setting the scheduling algorithm used by another
>     process. */
>  /* Allow setting cpu affinity on other processes */
> +/* Allow setting realtime ioprio class */
> +/* Allow setting ioprio class on other processes */
>  
>  #define CAP_SYS_NICE         23

From https://www.kernel.org/doc/man-pages/linux-api-ml.html:
"all Linux kernel patches that change userspace interfaces should be CCed
to linux-api@vger.kernel.org"

So I have added the linux-api mailing list to the Cc-list. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

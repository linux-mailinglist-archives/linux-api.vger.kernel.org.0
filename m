Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467DF2CBD0E
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 13:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgLBMd5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 07:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLBMd5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Dec 2020 07:33:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843DC0613CF;
        Wed,  2 Dec 2020 04:33:16 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so7519094wme.0;
        Wed, 02 Dec 2020 04:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rIn6QWz2xudVpAq7uZ7Rf4V3ACEBYHTmdt8ipDUu0MQ=;
        b=la+tWiJvvIroO80Y6slUiKrzpYqcz5PXM8WrpHg+YMFLLgRGXVzlxwzKvQrc3gMPRX
         PLNmW2b0PhBJhyevb7fByo9VkIbX40RgaYrdnL6LKvn/fXhO2XAd0H242R7wnmZ0VqYi
         PffNnMgSgQVS+Ju2qZQYh20g3C+sbEG8u1NJb4Vm1KVF1kKeJ0TP8r/DcA6GMv3JRgFj
         bnNLjSR8WUN0yOaq1YeFTBi1KUb7lJHXdtv+B2rAns+7S5drWTArv8I4hztt2TF0nksC
         QqnZi/ViWZhgWeq2tTaIaPKVtdt/57VcID4zYt7MHRYVm0eGuV5ekm3qDuVFDEXTLWEP
         Kfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rIn6QWz2xudVpAq7uZ7Rf4V3ACEBYHTmdt8ipDUu0MQ=;
        b=GjVfArbDuP0e11on4KYtfdhFZS0NnknFO2lmW/fyQlIl4rMVNb7bC+tFLlnx02CyOB
         PIqu7x2FEwxMMT7cl7/g8bsFHc964JrnV0yKuVWJa4ECVJuhAKbWZczYC/PfZC4W8hx3
         Q5tRsph9zXaElSAtmFn0y3YoITeG9ReySoRbgyVfXC+COJwkjdkUz2QpAc7UxLOA+NxW
         wWoLa47eBG0zAl7CNqlfZHqopVQZiqDnx9e/NrqahHnjRn90xC1MtdzpgjvWD0g8lJV9
         uR+SeiCU4GSTU2U95aotAf3PX0r3Xs9FHxmpoWgp3nifYv0xHHofGxwHrhOPPM9JoWVO
         4Kkg==
X-Gm-Message-State: AOAM531fT38glfpEgiLwIbuv8n+Bndm2t5hU2PqqWEqDs8RVDBtH8oB7
        RalcJ51Jzbk3fB0wbu9/6lXJMA1h0nLlFJmY
X-Google-Smtp-Source: ABdhPJzm7lTbbL0RMIe+sSxgF1+aJlnOtxvKJJAJJu115+v9PVuiu/kmKy/ZQy2+DlGYIcegJS1ZMw==
X-Received: by 2002:a1c:6002:: with SMTP id u2mr2985322wmb.29.1606912395093;
        Wed, 02 Dec 2020 04:33:15 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id o2sm1922153wrq.37.2020.12.02.04.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 04:33:14 -0800 (PST)
Subject: Re: [PATCH -V6 RESEND 2/3] NOT kernel/man-pages:
 man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
References: <20201202084234.15797-1-ying.huang@intel.com>
 <20201202084234.15797-3-ying.huang@intel.com>
From:   "Alejandro Colomar (mailing lists; readonly)" 
        <alx.mailinglists@gmail.com>
Message-ID: <48e758d7-9961-e28e-26f5-3bb381d36309@gmail.com>
Date:   Wed, 2 Dec 2020 13:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202084234.15797-3-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Huang Ying,

Please see a few fixes below.

Michael, as always, some question for you too ;)

Thanks,

Alex

On 12/2/20 9:42 AM, Huang Ying wrote:
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  man2/set_mempolicy.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
> index 68011eecb..3754b3e12 100644
> --- a/man2/set_mempolicy.2
> +++ b/man2/set_mempolicy.2
> @@ -113,6 +113,12 @@ A nonempty
>  .I nodemask
>  specifies node IDs that are relative to the set of
>  node IDs allowed by the process's current cpuset.
> +.TP
> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"

I'd prefer it to be in alphabetical order (rather than just adding at
the bottom).

That way, when lists grow, it's easier to find things.

> +Enable the Linux kernel NUMA balancing for the task if it is supported
> +by kernel.

I'd s/Linux kernel/kernel/ when it doesn't specifically refer to the
Linux kernel to differentiate it from other kernels.  It only adds noise
(IMHO).  mtk?

wfix:

... supported by _the_ kernel.

> +If the flag isn't supported by Linux kernel, return -1 and errno is

wfix:

If the flag isn't supported by _the_ kernel, ...

> +set to EINVAL.

errno and EINVAL should use .I and .B respectively

>  .PP
>  .I nodemask
>  points to a bit mask of node IDs that contains up to
> @@ -293,6 +299,9 @@ argument specified both
>  .B MPOL_F_STATIC_NODES
>  and
>  .BR MPOL_F_RELATIVE_NODES .
> +Or, the
> +.B MPOL_F_NUMA_BALANCING
> +isn't supported by the Linux kernel.
>  .TP
>  .B ENOMEM
>  Insufficient kernel memory was available.
> 

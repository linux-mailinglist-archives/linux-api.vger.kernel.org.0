Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417F812833F
	for <lists+linux-api@lfdr.de>; Fri, 20 Dec 2019 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLTU1c (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Dec 2019 15:27:32 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44558 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfLTU1b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Dec 2019 15:27:31 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so8993287iln.11
        for <linux-api@vger.kernel.org>; Fri, 20 Dec 2019 12:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D1SJczs5OobQ9Df2mEOacwQMvUzUbeBa9AkergSZXuI=;
        b=IE307yu3ftSov1F4ih7GB6/67XqFmBJ1PwtAh1/9ssCmm6ggaMfsIF/NTbLnAnAixR
         XgYFgjswMAqMtAvO96cBYru28/I0cnkxIXfwi1/bhfk9YL+UlyMI42pnpB5Tp7GPF4W8
         zICee0Uvo8lL1lPXwKEppLZIPAa0X5amUX10M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D1SJczs5OobQ9Df2mEOacwQMvUzUbeBa9AkergSZXuI=;
        b=jjYkRGIFX5PLt3uduP91expCnzEnXmc280S+c/uHQYeS7InqOVj6tl9W6gUyEPme1X
         HdXiaWadxiL2ptn0klZMYTU/6n5FPa1Pt2oVVmiOAAYYDDthANehSySbI8IMhc8kmK+z
         UPbCVlH01OiWjnuYbu365maXJUo0LpfxEBiEedEF7ArS8xsLArJkxlJRf4gBrHvkH51S
         n/Mw7lAi1VjZhYcKnxqbDVrDb4p8Z6nZqZTZCPpATOuVjckpSJYkMeIg7TzZWyXs1eyu
         fq/+aK4XBeavf7qqrbj6lRCABs7a9mvzNEj3kykX1IRRGPqBf/UcfAGMz1TbIP6e4vE9
         XZdA==
X-Gm-Message-State: APjAAAUSWIKOVlM/Pw2735DuRBxoPYWOIZG4CukEPr7IUR3Y5Nf3Exme
        SetevKQ1kBwSzlfcb6BF64MvGQ==
X-Google-Smtp-Source: APXvYqysSUNgALof7EqvMhLmF0d7gdQSPuiwO3d4+9A5hDzIdYjHY4ErZI1ScVEFfEtm2j5aatuEGQ==
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr13483130ils.54.1576873650928;
        Fri, 20 Dec 2019 12:27:30 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t17sm5277223ilb.29.2019.12.20.12.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 12:27:30 -0800 (PST)
Subject: Re: [PATCH for 5.5 2/2] rseq/selftests: Clarify rseq_prepare_unload()
 helper requirements
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, stable@vger.kernel.org,
        Florian Weimer <fw@deneb.enyo.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191220201207.17389-1-mathieu.desnoyers@efficios.com>
 <20191220201207.17389-2-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2ad7d561-2cbc-09c2-2806-97c3be3727e2@linuxfoundation.org>
Date:   Fri, 20 Dec 2019 13:27:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220201207.17389-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mathieu,

On 12/20/19 1:12 PM, Mathieu Desnoyers wrote:
> The rseq.h UAPI now documents that the rseq_cs field must be cleared
> before reclaiming memory that contains the targeted struct rseq_cs, but
> also that the rseq_cs field must be cleared before reclaiming memory of
> the code pointed to by the rseq_cs start_ip and post_commit_offset
> fields.
> 
> While we can expect that use of dlclose(3) will typically unmap
> both struct rseq_cs and its associated code at once, nothing would
> theoretically prevent a JIT from reclaiming the code without
> reclaiming the struct rseq_cs, which would erroneously allow the
> kernel to consider new code which is not a rseq critical section
> as a rseq critical section following a code reclaim.
> 
> Suggested-by: Florian Weimer <fw@deneb.enyo.de>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Florian Weimer <fw@deneb.enyo.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>   tools/testing/selftests/rseq/rseq.h | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index d40d60e7499e..15cbd51d0818 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -149,11 +149,13 @@ static inline void rseq_clear_rseq_cs(void)
>   /*
>    * rseq_prepare_unload() should be invoked by each thread executing a rseq
>    * critical section at least once between their last critical section and
> - * library unload of the library defining the rseq critical section
> - * (struct rseq_cs). This also applies to use of rseq in code generated by
> - * JIT: rseq_prepare_unload() should be invoked at least once by each
> - * thread executing a rseq critical section before reclaim of the memory
> - * holding the struct rseq_cs.
> + * library unload of the library defining the rseq critical section (struct
> + * rseq_cs) or the code refered to by the struct rseq_cs start_ip and

Nit: referred instead of refered

> + * post_commit_offset fields. This also applies to use of rseq in code
> + * generated by JIT: rseq_prepare_unload() should be invoked at least once by
> + * each thread executing a rseq critical section before reclaim of the memory
> + * holding the struct rseq_cs or reclaim of the code pointed to by struct
> + * rseq_cs start_ip and post_commit_offset fields.
>    */
>   static inline void rseq_prepare_unload(void)
>   {
> 

thanks,
-- Shuah

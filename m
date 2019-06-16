Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C847625
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFPRny (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 13:43:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52976 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfFPRny (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 13:43:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so6932440wms.2;
        Sun, 16 Jun 2019 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=que2swj0V47qMw6o/7WuGeIOPLMG0y81yFWSWpROV4I=;
        b=sr2VHyKHuKA0dnTZCgPBIHaROyB60v/TFp3jvmeh9zHh4UdGBiZEj6s2Da59R/KTCi
         zRkmUMxYcdl6nG36OxJI1Xa3QzD8MYrUxbPhvJ1HBWHK1cXUyTBogO1g7Lmrr/yYs7ur
         P7vFT5ydVUqCb0Et6dUrutZ/TckfzLNxTJ8PPD8TrpNurkHcy09YDW2Xi9SA4qhYr7JO
         LsvSObG99o64reQkzeEo4okgkdOwj0igpsavL21HkCQHLs2AJGSXttlaJcaQvtHbnwE5
         fEnsOLPcQY/78BLWOebWOvv4PECbWxlK9PSmVBML9VyNc+59nZYhqIRBY2KZahJ7YjKK
         ju7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=que2swj0V47qMw6o/7WuGeIOPLMG0y81yFWSWpROV4I=;
        b=s1zkw4hczp+iE7TbVwGUTPU5DdVEyVUyaNrjnu0Nggrx+2ybZ2TVPYpm2ATym51cIH
         MNg/NbDVC8zZUGXL3kB4IYoCOOxpQHwI6nSHsxXqkxVl8SO5CsMF+qeaBbZJVCaVnYAx
         APoH3AjTjlqjqlqdBeo1jri4eib6JT4lvICNQExCxF0t0ES2mK8bscDpy2iK78nzCPNl
         EgNTztseqV66tuv5D4AowJN/bufYRAISr2BpZPBkwxJvGVxn20WIQ3Ke6i75MuEzYgVY
         vPyUPpq2twy7tQJNd8yDz4JD9CwSylwC0GzfzI1NXisurwW5mksy74u2zT3OILTKkM+Y
         2ugQ==
X-Gm-Message-State: APjAAAXE4G3JyMsdFD2OKOTmPMqH6lvsD4p6bOIfbnaziOj9vER8mZQt
        ruOAHRXh2kFd5ODy5oyVozA=
X-Google-Smtp-Source: APXvYqxuP6NBzLcQgq1Gfqfr/NPBip/sbjxzKzIOOw08EaRxZGa9wPyF1gU8Tar4EBtrnXvdhRX4FQ==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr16663973wmi.50.1560707032125;
        Sun, 16 Jun 2019 10:43:52 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a81sm14875836wmh.3.2019.06.16.10.43.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 10:43:51 -0700 (PDT)
Subject: Re: [PATCHv4 06/28] timerfd/timens: Take into account ns clock
 offsets
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-7-dima@arista.com>
 <alpine.DEB.2.21.1906141534090.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <bf28eefd-390b-5209-09c1-db9874030369@gmail.com>
Date:   Sun, 16 Jun 2019 18:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141534090.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/14/19 2:37 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
>> ---
>>  fs/timerfd.c                   |  3 +++
>>  include/linux/time_namespace.h | 18 ++++++++++++++++++
>>  kernel/time_namespace.c        | 27 +++++++++++++++++++++++++++
>>  3 files changed, 48 insertions(+)
> 
> Again, please split that into:
> 
>    1) Introduce the new function
> 
>    2) Make use of it

Will do

> 
>> diff --git a/fs/timerfd.c b/fs/timerfd.c
>> index 6a6fc8aa1de7..9b0c2f65e7e8 100644
>> --- a/fs/timerfd.c
>> +++ b/fs/timerfd.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/syscalls.h>
>>  #include <linux/compat.h>
>>  #include <linux/rcupdate.h>
>> +#include <linux/time_namespace.h>
>>  
>>  struct timerfd_ctx {
>>  	union {
>> @@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
>>  	}
>>  
>>  	if (texp != 0) {
>> +		if (flags & TFD_TIMER_ABSTIME)
>> +			texp = timens_ktime_to_host(clockid, texp);
>>  		if (isalarm(ctx)) {
>>  			if (flags & TFD_TIMER_ABSTIME)
>>  				alarm_start(&ctx->t.alarm, texp);
>> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
>> index 1dda8af6b9fe..d32b55fad953 100644
>> --- a/include/linux/time_namespace.h
>> +++ b/include/linux/time_namespace.h
>> @@ -56,6 +56,19 @@ static inline void timens_add_boottime(struct timespec64 *ts)
>>                  *ts = timespec64_add(*ts, ns_offsets->boottime);
>>  }
>>  
>> +ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
>> +				struct timens_offsets *offsets);
>> +static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
>> +{
>> +	struct timens_offsets *offsets = current->nsproxy->time_ns->offsets;
>> +
>> +	if (!offsets) /* fast-path for the root time namespace */
> 
> Can you please avoid tail comments. They break the reading flow. Aside of
> that I don't see the value of documenting the obvious.
> 
>> +ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim, struct timens_offsets *ns_offsets)
> 
> Please line break the arguments
> 
> ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
> 				struct timens_offsets *ns_offsets)

Sure

> 
>> +{
>> +	ktime_t koff;
>> +
>> +	switch (clockid) {
>> +	case CLOCK_MONOTONIC:
>> +		koff = timespec64_to_ktime(ns_offsets->monotonic);
>> +		break;
>> +	case CLOCK_BOOTTIME:
>> +	case CLOCK_BOOTTIME_ALARM:
>> +		koff = timespec64_to_ktime(ns_offsets->boottime);
>> +		break;
>> +	default:
>> +		return tim;
>> +	}
>> +
>> +	/* tim - off has to be in [0, KTIME_MAX) */
> 
> Please be more elaborate why the below conditions can happen at all.
> 
>> +	if (tim < koff)
>> +		tim = 0;
>> +	else if (KTIME_MAX - tim < -koff)
>> +		tim = KTIME_MAX;
>> +	else
>> +		tim = ktime_sub(tim, koff);

Thanks,
          Dmitry

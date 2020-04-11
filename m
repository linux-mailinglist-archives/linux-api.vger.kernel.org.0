Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040991A4F64
	for <lists+linux-api@lfdr.de>; Sat, 11 Apr 2020 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDKKcu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Apr 2020 06:32:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36719 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgDKKcu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 11 Apr 2020 06:32:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id a201so4686215wme.1;
        Sat, 11 Apr 2020 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WdIuarudhiqt4aMHRps4LXkdxiszDOW6zJdoJ0Jp18c=;
        b=DA9/J+4ieeGwggLN5Ee4Fvbbby2FOQhYeUbEOPOV2mBW2NeHycGt+WGnUvxBP1/D4Z
         nCZBC+lZ2ffPgfYUGKGvmXKCuHC9AoOc7mouN9QlgmOiXptmA57Ukh8N0zeoX9M2hljV
         EC4X/Pe2C1yiAnpOD6xFTWLMHEz3U5DNc9r0hmKhfMYfklfx7Dw9H/37H1dIk5OEVDvC
         JHjed1S/enFI9m1GnUXHO1b2m+VgKHYObKpPunlYyIWtIVlSHH/aW67Eh0xSaqsZauN8
         nQZmHH2rdf6T9hjTi+w7FUY8Q7bHHUZw2rDHXvaLOOU/83rsgo64t8MIA0Dra/8jNdtq
         3tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WdIuarudhiqt4aMHRps4LXkdxiszDOW6zJdoJ0Jp18c=;
        b=rgksrdPyjOmE9KBCwtLmMVr6893TqhoSwReyNjIo5LSjz/dxiz8PeTo6jyZVk3ABoI
         IzHKeYNldu0s0bu0qH5v4ylNOv3aJr+V7t89XEr+YotfyofXcXxKl6pUFb+1fUbCnTgJ
         xhvFkAkXuoe/IB+IQtBW/jIN2ycvYsPCw1Gl/LTVaVaRpm4UOocVv8xI/7T0LYj1LbDl
         kWoXONdwwXTwbkQatzFAWVaIQDwzqdtqOnFDLAv46Dh7qZX9xRs2uIZ1+g0UTav5ZMS7
         ZTy+28LozSDqLLB0a6p6G6O2efcEO0dmCduHdeDxYI13hU7B0Lu6q/SRCEJc0DGRK8UN
         /yJA==
X-Gm-Message-State: AGi0PuavfeqBtgVnqfVNxOf1+N6+mQPV9H0oJQRg3vul/pIepxeHC0eL
        m2gVfzjIjfvsbnKK+M9kFBg=
X-Google-Smtp-Source: APiQypKqOpI74EL5EsVJwXDYHUK7zs9WNPm239eIssJuuYnBjC0n5TMf3YfJqRy8Ty+CysR3SP6ZBw==
X-Received: by 2002:a05:600c:24e:: with SMTP id 14mr9047328wmj.62.1586601168695;
        Sat, 11 Apr 2020 03:32:48 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id i129sm6569053wmi.20.2020.04.11.03.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 03:32:48 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH] timens: show clock symbolic names in
 /proc/pid/timens_offsets
To:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200411065209.622679-1-avagin@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <afd9a489-bea7-c34c-14c2-405b536deb0d@gmail.com>
Date:   Sat, 11 Apr 2020 12:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200411065209.622679-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Andrei,

On 4/11/20 8:52 AM, Andrei Vagin wrote:
> Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> names.
> 
> Now the content of these files looks like this:
> $ cat /proc/5362/timens_offsets
> monotonic	   9504000	         0
> boottime	   3456000	         0
> 
> For setting offsets, both representations of clocks can be used.
> 
> As for compatibility, it is acceptable to change things as long as
> userspace doesn't care. The format of timens_offsets files is very
> new and there are no userspace tools that rely on this format.
> 
> But three projects crun, util-linux and criu rely on the interface of
> setting time offsets and this is why we need to continue supporting the
> clock IDs in this case.

Thanks very much for this patch, which I've tested. So:

Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
Tested-by: Michael Kerrisk <mtk.manpages@gmail.com>

But, I do have one small suggestion below.

> Fixes: 04a8682a71be ("fs/proc: Introduce /proc/pid/timens_offsets")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  fs/proc/base.c          | 14 +++++++++++++-
>  kernel/time/namespace.c | 15 ++++++++++++++-
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6042b646ab27..572898dd16a0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1573,6 +1573,7 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
>  	noffsets = 0;
>  	for (pos = kbuf; pos; pos = next_line) {
>  		struct proc_timens_offset *off = &offsets[noffsets];
> +		char clock[10];
>  		int err;
>  
>  		/* Find the end of line and ensure we don't look past it */
> @@ -1584,10 +1585,21 @@ static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
>  				next_line = NULL;
>  		}
>  
> -		err = sscanf(pos, "%u %lld %lu", &off->clockid,
> +		err = sscanf(pos, "%9s %lld %lu", clock,
>  				&off->val.tv_sec, &off->val.tv_nsec);
>  		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
>  			goto out;
> +
> +		clock[sizeof(clock) - 1] = 0;
> +		if (strcmp(clock, "monotonic") == 0 ||
> +		    strcmp(clock, __stringify(CLOCK_MONOTONIC)) == 0)
> +			off->clockid = CLOCK_MONOTONIC;
> +		else if (strcmp(clock, "boottime") == 0 ||
> +			 strcmp(clock, __stringify(CLOCK_BOOTTIME)) == 0)
> +			off->clockid = CLOCK_BOOTTIME;
> +		else
> +			goto out;
> +
>  		noffsets++;
>  		if (noffsets == ARRAY_SIZE(offsets)) {
>  			if (next_line)
> diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
> index e6ba064ce773..8127d2647064 100644
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -338,7 +338,20 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
>  
>  static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
>  {
> -	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
> +	char *clock;
> +
> +	switch (clockid) {
> +	case CLOCK_BOOTTIME:
> +		clock = "boottime";
> +		break;
> +	case CLOCK_MONOTONIC:
> +		clock = "monotonic";
> +		break;
> +	default:
> +		clock = "unknown";
> +		break;
> +	}

As things stand, there is to my eye an excessive amount of white space
in the output produced by this line:

> +	seq_printf(m, "%s\t%10lld\t%10ld\n", clock, ts->tv_sec, ts->tv_nsec);

Can I suggest instead something like:

	seq_printf(m, "%-16s %10lld %9ld\n", clock, ts->tv_sec, ts->tv_nsec);

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

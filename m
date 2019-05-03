Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810B612854
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 09:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfECHAd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 03:00:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42688 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfECHAd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 May 2019 03:00:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so2117754pfw.9;
        Fri, 03 May 2019 00:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0sykfU7Ea9XxNMJm1MRxI/96wJyYinYUgK+BZ094Mv4=;
        b=iHc4UY1MQPuGed2yqq0ZsPlkDgvrz8Lwh8gccJCY9Xm/BMVYx6E+Y9c2TspYTVJgat
         E6HLkDkT4bhGnsgD1Bh43SSi53cIrBgia4zBLACg6XTE2yJE/osRPQoYywJzWwtXZkt1
         DN2m+BSfORtpUWrYwMobfMSh6j0n+4GReFibEzqV66dkJCE6cxoEpWVEW2zpsK8cq+Wn
         53ehPTf29WCVnXoepYicLQsY4DPh2eX83IK2TntG1SQjjlkXF+dkUZE+ijEohdlFEAoV
         9Q6WQ4Pdbewsh6h8deoL2b6bwSUqpiL/NnTxtfWfVb42NPm4ryJNQETVvHECiwHVRMa9
         8Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0sykfU7Ea9XxNMJm1MRxI/96wJyYinYUgK+BZ094Mv4=;
        b=WPLY26h4PgeJwqKL9yATsKfCBXko43RQ8P4PMxc6F3RNqIjsJ5Pyq64lkngqZ8PThR
         So9lu4EbOHu1IswZ7cQlQyvmmDFeZnYPgzxkyMiTVo40H/6zvI3aTHkiJ9y502772nV0
         yP4CN8/uAH9P1Lr+7J6dskbA97G18TJrC/3MyTrjJd5Tgzqdp/sqW2xITbNR7TSxvwUJ
         lE97tVmySDx4LJVHDobY6DN3h0guwN9XlgqEupFmmhIZA0O30cS/cyMYADTd3RjByGP7
         Yc29wlw7/vE77UYQk1UGPwmaslwuaRY08q3Rr4BIwZRd1xxqYbPURqcu8YUqNW0gWXrw
         +gfg==
X-Gm-Message-State: APjAAAXXYbmeo9xSoCUEKkBZG/i30+7Xk9ZccFoFm22HYe4QgNEZFWJt
        iBX5GKZ7zyS7TddBv8SioyA=
X-Google-Smtp-Source: APXvYqx8uehs/75SjUl0wUd4zpNUlwvyVEoIpO4Ze8VJYXLuw5yJCUFntJP+2nrg41Wn3/YSTUI87Q==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr4367006pgs.24.1556866832257;
        Fri, 03 May 2019 00:00:32 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id d15sm1565028pfr.179.2019.05.03.00.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:00:31 -0700 (PDT)
Date:   Fri, 3 May 2019 00:00:29 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv3 05/27] timerfd/timens: Take into account ns clock
 offsets
Message-ID: <20190503070028.GA7984@gmail.com>
References: <20190425161416.26600-1-dima@arista.com>
 <20190425161416.26600-6-dima@arista.com>
 <alpine.DEB.2.21.1904252207170.1768@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904252207170.1768@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

Thank you for the review.  I read your comments. All of them look
reasonable. I'm sorry that you had to comment a lot. Will fix in the
next version.

Thanks,
Andrei

On Thu, Apr 25, 2019 at 11:28:24PM +0200, Thomas Gleixner wrote:
> On Thu, 25 Apr 2019, Dmitry Safonov wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> > 
> > Make timerfd respect timens offsets.
> > Provide a helper timens_ktime_to_host() that is useful to wire up
> > timens to different kernel subsystems.
> 
> Yet another changelog which lacks meat.
> 
> > @@ -179,6 +180,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
> >  	htmode = (flags & TFD_TIMER_ABSTIME) ?
> >  		HRTIMER_MODE_ABS: HRTIMER_MODE_REL;
> >  
> > +	htmode |= HRTIMER_MODE_NS;
> 
> Without looking further this time. My gut reaction is that this is
> wrong. Name space adjustment is only valid for absolute timers not for
> relative timers.
> 
> Aside of that the name sucks. MODE_NS is really not intuitive. It could be
> NanoSeconds or whatever and quite some time(r) functions have a _ns element
> already. Please look for something more inuitive and clearly related to
> namespaces. We are not short of letters.
> 
> >  	texp = timespec64_to_ktime(ktmr->it_value);
> >  	ctx->expired = 0;
> >  	ctx->ticks = 0;
> > @@ -197,9 +200,10 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
> >  
> >  	if (texp != 0) {
> >  		if (isalarm(ctx)) {
> > -			if (flags & TFD_TIMER_ABSTIME)
> > +			if (flags & TFD_TIMER_ABSTIME) {
> > +				texp = timens_ktime_to_host(clockid, texp);
> 
> You are not serious about that inline function here? It's huge and
> pointless bloat because the only time affected here is boot time, but the
> compiler does not know that.
> 
> >  				alarm_start(&ctx->t.alarm, texp);
> 
> Make that:
> 
>    alarm_start_namespace(.....)
> 
> and that does:
> 
> void alarm_start_namespace(struct alarm *alarm, ktime_t expires)
> {
> 	if (alarm->type == ALARM_BOOTTIME)
> 		expires = timens_sub_boottime(expires);
> 	alarm_start(alarm, expires);
> }
> 
> Hmm?
> 
> > -			else
> > +			} else
> >  				alarm_start_relative(&ctx->t.alarm, texp);
> >  		} else {
> >  			hrtimer_start(&ctx->t.tmr, texp, htmode);
> > diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
> > index 2e8957eac4d4..4b9c89c797ee 100644
> > --- a/include/linux/hrtimer.h
> > +++ b/include/linux/hrtimer.h
> > @@ -38,6 +38,7 @@ enum hrtimer_mode {
> >  	HRTIMER_MODE_REL	= 0x01,
> >  	HRTIMER_MODE_PINNED	= 0x02,
> >  	HRTIMER_MODE_SOFT	= 0x04,
> > +	HRTIMER_MODE_NS		= 0x08,
> >  
> >  	HRTIMER_MODE_ABS_PINNED = HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
> >  	HRTIMER_MODE_REL_PINNED = HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
> > diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> > index 5f0da6858b10..988414f7f791 100644
> > --- a/include/linux/time_namespace.h
> > +++ b/include/linux/time_namespace.h
> > @@ -56,6 +56,41 @@ static inline void timens_add_boottime(struct timespec64 *ts)
> >                  *ts = timespec64_add(*ts, ns_offsets->monotonic_boottime_offset);
> >  }
> >  
> > +static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
> > +{
> > +	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> > +	struct timespec64 *offset;
> > +	ktime_t koff;
> > +
> > +	if (!ns_offsets)
> > +		return tim;
> > +
> > +	switch (clockid) {
> > +		case CLOCK_MONOTONIC:
> > +		case CLOCK_MONOTONIC_RAW:
> > +		case CLOCK_MONOTONIC_COARSE:
> 
> What's the point of COARSE and RAW? Neither of them can be used to arm
> timers.
> 
> > +			offset = &ns_offsets->monotonic_time_offset;
> > +			break;
> > +		case CLOCK_BOOTTIME:
> > +		case CLOCK_BOOTTIME_ALARM:
> > +			offset = &ns_offsets->monotonic_boottime_offset;
> > +			break;
> > +		default:
> > +			return tim;
> > +	}
> > +
> > +	koff = timespec64_to_ktime(*offset);
> 
> What about storing both the timespec and the ktime_t representation?
> 
> > +	if (tim < koff)
> > +		tim = 0;
> > +	else if (KTIME_MAX - tim < -koff)
> > +		tim = KTIME_MAX;
> 
> Blink!?! This is completely nonobvious and you're going to stare at it in
> disbelief half a year from now. Comments exist for a reason.
> 
> > +	else
> > +		tim = ktime_sub(tim, koff);
> > +
> > +	return tim;
> 
> This whole thing is way too large for inlining.
> 
> Please create a function which does the magic substraction, something like
> ktime_sub_namespace_offset() and invoke it from the proper places, i.e. the
> alarmtimer one.
> 
> > @@ -1069,6 +1070,8 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
> >  
> >  	if (mode & HRTIMER_MODE_REL)
> >  		tim = ktime_add_safe(tim, base->get_time());
> > +	else if (mode & HRTIMER_MODE_NS)
> > +		tim = timens_ktime_to_host(base->clockid, tim);
> 
> You can do the same as for alarmtime above:
> 
> hrtimer_start_namespace(struct hrtimer *timer, ktime_t tim,
> 			const enum hrtimer_mode mode)
> {
> 	if (mode & HRTIMER_MODE_ABS) {
> 		switch(timer->base->clockid) {
> 		case CLOCK_MONOTONIC:
> 			tim = timens_sub_monotonic(tim);
> 			break;
> 		case CLOCK_BOOTTIME:
> 			tim = timens_sub_boottime(tim);
> 			break;
> 		}
> 	}
> 	hrtimer_start(timer, tim, mode);
> }
> 
> Thanks,
> 
> 	tglx

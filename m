Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF7D6035
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfJNKcJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 06:32:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbfJNKcI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 06:32:08 -0400
Received: from [212.86.36.32] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iJxdv-0001ho-5b; Mon, 14 Oct 2019 10:31:59 +0000
Date:   Mon, 14 Oct 2019 12:31:58 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Kellner <christian@kellner.me>
Cc:     jannh@google.com, aarcange@redhat.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, elena.reshetova@intel.com, guro@fb.com,
        ldv@altlinux.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
Message-ID: <20191014103157.h2wph2ujjidsrhyw@wittgenstein>
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
 <20191012101922.24168-1-christian.brauner@ubuntu.com>
 <20191012102119.qq2adlnxjxrkslca@wittgenstein>
 <abc477fb3bd8fbf7b4d7e53d079dd1d8902e54af.camel@kellner.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abc477fb3bd8fbf7b4d7e53d079dd1d8902e54af.camel@kellner.me>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 14, 2019 at 11:43:01AM +0200, Christian Kellner wrote:
> On Sat, 2019-10-12 at 12:21 +0200, Christian Brauner wrote:
> > I think this might be more what we want.
> Yep, indeed.
> 
> > I tried to think of cases where the first entry of Pid is not
> > identical
> > to the first entry of NSpid but I came up with none. Maybe you do,
> > Jann?
> Yeah, I don't think that can be the case. By looking at the source of
> 'pid_nr_ns(pid, ns)' a non-zero return means that a) 'pid' valid, ie.
> non-null and b) 'ns' is in the pid namespace hierarchy of 'pid' (at
> pid->level, i.e. "pid->numbers[ns->level].ns == ns").
> 
> > Christian, this is just a quick stab I took. Feel free to pick this
> > up as a template.
> Thanks! I slightly re-worked it, with the reasoning above in mind, to
> get rid of one of the branches:

Thanks!

> 
> +#ifdef CONFIG_PID_NS
> +	seq_put_decimal_ull(m, "\nNSpid:\t", nr);
> +	if (nr) {
> +		int i;
> +
> +		/* If nr is non-zero it means that 'pid' is valid and that
> +		 * ns, i.e. the pid namespace associated with the procfs
> +		 * instance, is in the pid namespace hierarchy of pid.
> +		 * Start at one level below and print all descending pids.
> +		 */
> +		for (i = ns->level + 1; i <= pid->level; i++) {
> +			ns = pid->numbers[i].ns;

I'm not a fan of overriding the "ns" pointer. It's not a huge deal but
it's rather subtle.

> +			seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
> +		}
> +	}
> +#endif
> 
> But I now just realized that with the very same reasoning, if nr is
> non-zero, we don't need to redo all the checks and can just do:
> 
> for (i = ns->level + 1; i <= pid->level; i++)
> 	seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
> 
> If this sounds good to you I resend the patches with the change above.

You could probably do:

#ifdef CONFIG_PID_NS
seq_put_decimal_ull(m, "\nNSpid:\t", nr);
for (i = ns->level + 1; i <= pid->level && nr; i++)
	seq_put_decimal_ull(m, "\t", pid->numbers[i].nr);
#endif

Christian

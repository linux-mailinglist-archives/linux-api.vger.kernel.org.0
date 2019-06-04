Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AEA34323
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfFDJ2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 4 Jun 2019 05:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfFDJ2U (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 4 Jun 2019 05:28:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BDF231628E3;
        Tue,  4 Jun 2019 09:28:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACB5D60C68;
        Tue,  4 Jun 2019 09:28:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190603144331.16760-1-christian@brauner.io>
References: <20190603144331.16760-1-christian@brauner.io>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        jannh@google.com, keescook@chromium.org, fweimer@redhat.com,
        oleg@redhat.com, arnd@arndb.de,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fork: add clone3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4019.1559640492.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 04 Jun 2019 10:28:12 +0100
Message-ID: <4020.1559640492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 04 Jun 2019 09:28:19 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> +#include <linux/compiler_types.h>

I suspect you don't want to include that directly.

Also, to avoid bloating linux/sched/task.h yet further, maybe put this in
linux/sched/clone.h?

> -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> +extern long _do_fork(struct kernel_clone_args *kargs);
>  extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);

Maybe these could move into linux/sched/clone.h too.

> +#define CLONE_MAX ~0U

Can you add a comment summarising the meaning?

> +	u64 clone_flags = args->flags;
> +	int __user *child_tidptr = args->child_tid;
> +	unsigned long tls = args->tls;
> +	unsigned long stack_start = args->stack;
> +	unsigned long stack_size = args->stack_size;

Some of these are only used once, so it's probably not worth sticking them in
local variables.

> -		if (clone_flags &
> -		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
> -			return ERR_PTR(-EINVAL);

Did this error check get lost?  I can see part of it further on, but the check
on CLONE_PARENT_SETTID is absent.

> +	int __user *parent_tidptr = args->parent_tid;

There's only one usage remaining after this patch, so a local var doesn't gain
a lot.

>  pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
>  {
> -	return _do_fork(flags|CLONE_VM|CLONE_UNTRACED, (unsigned long)fn,
> -		(unsigned long)arg, NULL, NULL, 0);
> +	struct kernel_clone_args args = {
> +		.flags = ((flags | CLONE_VM | CLONE_UNTRACED) & ~CSIGNAL),
> +		.exit_signal = (flags & CSIGNAL),

Kernel threads can have exit signals?

> +static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> +				     struct clone_args __user *uargs,
> +				     size_t size)

I would make this "noinline".  If it gets inlined, local variable "args" may
still be on the stack when _do_fork() gets called.

David

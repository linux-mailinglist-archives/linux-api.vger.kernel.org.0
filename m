Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3AF2E163
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 17:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE2PnW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 11:43:22 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:48665 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfE2PnW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 29 May 2019 11:43:22 -0400
Received: from [2a01:e35:39f2:1220:9dd7:c176:119b:4c9d] (helo=opteyam2)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1hW0iU-000B3I-RX; Wed, 29 May 2019 17:42:15 +0200
Message-ID: <1058006e0df4b52b3e53c7b3202c04140899aeb5.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Christian Brauner <christian@brauner.io>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        jannh@google.com
Cc:     fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Date:   Wed, 29 May 2019 17:42:14 +0200
In-Reply-To: <20190529152237.10719-1-christian@brauner.io>
References: <20190529152237.10719-1-christian@brauner.io>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:9dd7:c176:119b:4c9d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on ou.quest-ce.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham version=3.3.2
Subject: Re: [PATCH v1 1/2] fork: add clone3
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Le mercredi 29 mai 2019 à 17:22 +0200, Christian Brauner a écrit :
> This adds the clone3 system call.
> 
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b4cba953040a..6bc3e3d17150 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2472,7 +2475,96 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>  		 unsigned long, tls)
>  #endif
>  {
> -	return _do_fork(clone_flags, newsp, 0, parent_tidptr, child_tidptr, tls);
> +	struct kernel_clone_args args = {
> +		.flags = clone_flags,
> +		.stack = newsp,
> +		.pidfd = parent_tidptr,
> +		.parent_tidptr = parent_tidptr,
> +		.tls = tls,
> +		.child_tidptr = child_tidptr,
> +	};
> +
> +	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
> +	if ((clone_flags & CLONE_PIDFD) && (clone_flags & CLONE_PARENT_SETTID))
> +		return -EINVAL;
> +
> +	return _do_fork(&args);
> +}
> +
> +static bool clone3_flags_valid(u64 flags)
> +{
> +	if (flags & CLONE_DETACHED)
> +		return false;
> +
> +	if (flags & ~CLONE_MAX)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> +				     struct clone_args __user *uargs,
> +				     size_t size)
> +{
> +	struct clone_args args;
> +
> +	if (unlikely(size > PAGE_SIZE))
> +		return -E2BIG;
> +
> +	if (unlikely(size < sizeof(struct clone_args)))
> +		return -EINVAL;
> +
> +	if (unlikely(!access_ok(uargs, size)))
> +		return -EFAULT;
> +
> +	if (size > sizeof(struct clone_args)) {
> +		unsigned char __user *addr;
> +		unsigned char __user *end;
> +		unsigned char val;
> +
> +		addr = (void __user *)uargs + sizeof(struct clone_args);
> +		end = (void __user *)uargs + size;
> +
> +		for (; addr < end; addr++) {
> +			if (get_user(val, addr))
> +				return -EFAULT;
> +			if (val)
> +				return -E2BIG;

Should be -EINVAL: having something after the structure should be
handled just like an invalid flags, while still allowing future
userspace program to probe for support for newer feature.

> +		}
> +
> +		size = sizeof(struct clone_args);
> +	}
> +
> +	if (copy_from_user(&args, uargs, size))
> +		return -EFAULT;
> +
> +	if (!clone3_flags_valid(args.flags))
> +		return -EINVAL;
> +
> +	memset(kargs, 0, sizeof(*kargs));
> +
> +	kargs->flags = args.flags;
> +	kargs->child_tidptr = u64_to_user_ptr(args.child_tidptr);
> +	kargs->parent_tidptr = u64_to_user_ptr(args.parent_tidptr);
> +	kargs->pidfd = u64_to_user_ptr(args.pidfd);
> +	kargs->stack = args.stack;
> +	kargs->stack_size = args.stack_size;
> +	kargs->tls = args.tls;
> +
> +	return 0;
> +}
> +
> +SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
> +{
> +	int err;
> +
> +	struct kernel_clone_args kargs;
> +
> +	err = copy_clone_args_from_user(&kargs, uargs, size);
> +	if (err)
> +		return err;
> +
> +	return _do_fork(&kargs);
>  }
>  #endif
>  

Regards.

-- 
Yann Droneaud
OPTEYA



Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440B8221085
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGOPKt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 11:10:49 -0400
Received: from mail.efficios.com ([167.114.26.124]:33036 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOPKt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 11:10:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 297E9282A2C;
        Wed, 15 Jul 2020 11:10:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eAMrPv55LEB4; Wed, 15 Jul 2020 11:10:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B0D2F282A2B;
        Wed, 15 Jul 2020 11:10:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B0D2F282A2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594825847;
        bh=SctVcPNmslTOc86Tm94H7ggOs/a7Wx9cOJwtOT91ncE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YM9KXWaeX7Xikgpzro4vQXB3qMXm3V9DlQb+TkBLyd1I3SI5zX38nDzu22/N3zL22
         uVa0BXL54duFmPzt0T15RJZsGayzCpfc8MqTXtdvawLOfWuwI844BAknRRvgEX/Yyz
         fSiG93YBpELK0N5QnO9WjsuH6aTmTyEXjPNSLciETofz+/Q8IGK7MqzEFXEK7Dmd6L
         JAjzlTP1RqBXbEStIuBS5E0c1jwPx6Djthg+DZmkPSmRZ/BcQHWyPdNuGIr/dhpUEX
         HnngR15sWcQbo5+uq5O2FM7GejPZEJmaRXEcF+9WErfzidb+muvsOUxPgWmk0EHo1g
         mL+ZihE/7D+Lw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id au-qH3VqYuEi; Wed, 15 Jul 2020 11:10:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9E120282A2A;
        Wed, 15 Jul 2020 11:10:47 -0400 (EDT)
Date:   Wed, 15 Jul 2020 11:10:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>, carlos <carlos@redhat.com>
Message-ID: <1944484270.14303.1594825847550.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200715123323.vrmblagnvkdp4pyy@wittgenstein>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <20200715113849.yy6amhynxya64arv@wittgenstein> <20200715123323.vrmblagnvkdp4pyy@wittgenstein>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: OB1R3J+UYJJ3D4knQb9LWwNhbf2dCQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 15, 2020, at 8:33 AM, Christian Brauner christian.brauner@ubuntu.com wrote:
[...]
> 
> So here's a very free-wheeling draft of roughly what I had in mind. Not
> even compile-tested just to illustrate what I'd change and sorry if that
> code will make you sob in your hands:
> 
[...]
> +	/*
> +	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, user_size should be
> +	 * statically initialized to offsetof(struct rseq, end).
> +	 */
> +	__u32 user_size;
> +	/*
> +	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, if the kernel supports
> +	 * extensible struct rseq ABI, the kernel_size field is populated by
> +	 * the kernel to the minimum between user_size and the offset of the
> +	 * "end" field within the struct rseq supported by the kernel on
> +	 * successful registration. Should be initialized to 0.
> +	 */
> +	__u32 kernel_size;

Moving from __u16 to __u32 for both fields don't achieve much, and increase
the size of struct rseq (excluding padding) from 24 bytes to 28 bytes.

Note that the struct rseq alignment is 32 bytes. At 24 bytes, it leaves room
for exactly one 8 bytes pointer, which can be useful for future extensions.
If the size is increased to 28 bytes or more, then we're done and cannot
add a pointer.

> +	__u32 active_size;

This additional field takes the very last bytes of padding we have in the
current layout.

> } __attribute__((aligned(4 * sizeof(__u64))));
> 
> +#define RSEQ_SIZE_VER0 24 /* sizeof first published struct */

This is incorrect. The sizeof(struct_rseq) with its 32 bytes alignment is 32,
not 24. The padding at the end of the structure is considered as part of its
size, but we cannot rely on its content being zero-initialized based on the
C standard.

> +#define RSEQ_SIZE_VER1 32 /* sizeof second published struct */
> +#define RSEQ_SIZE_LATEST RSEQ_SIZE_VER1 /* sizeof last published struct */
> +

[...]

> @@ -349,10 +363,58 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> rseq_len,
> 	 * ensure the provided rseq is properly aligned and valid.
> 	 */
> 	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
> -	    rseq_len != sizeof(*rseq))
> +	    rseq_len < RSEQ_SIZE_VER0)

This could perhaps be changed for future kernels, but will break for existing
kernels as soon as rseq_len is increased. This is something we should have
planned for in the initial implementation of the system call, but here we are.

How do you envision that userspace would handle this failure from older kernels ?
Try again with a second system call passing RSEQ_SIZE_VER0 as argument ?

> 		return -EINVAL;
> 	if (!access_ok(rseq, rseq_len))
> 		return -EFAULT;
> +
> +	/* Handle extensible struct rseq ABI. */
> +	ret = get_user(tls_flags, &rseq->flags);
> +	if (ret)
> +		return ret;
> +	if (tls_flags & RSEQ_TLS_FLAG_SIZE) {
> +		u32 user_size, kernel_size, active_size;
> +
> +		/* Can probably be made nicer by using check_zeroed_user(). */
> +		ret = get_user(user_size, &rseq->user_size);
> +		if (ret)
> +			return ret;
> +		if (user_size != 0)
> +			return -EINVAL;
> +
> +		ret = get_user(active_size, &rseq->active_size);
> +		if (ret)
> +			return ret;
> +		if (active_size != 0)
> +			return -EINVAL;
> +
> +		ret = get_user(active_size, &rseq->kernel_size);

I guess you mean kernel_size here.

> +		if (ret)
> +			return ret;
> +		if (kernel_size != 0)
> +			return -EINVAL;
> +
> +		/* Calculate the useable size. */
> +		active_size = min_t(u32, rseq_len, RSEQ_SIZE_LATEST);

Where is the rseq_len supposed to come from in userspace ? Should it be
that the code doing the registration uses sizeof(struct rseq), or offsetof(struct rseq, end),
or should it read the content of __rseq_abi.user_size ?

> +		ret = put_user(active_size, &rseq->active_size);
> +		if (ret)
> +			return ret;
> +
> +		/* Let other users know what userspace used to register. */
> +		ret = put_user(rseq_len, &rseq->user_size);
> +		if (ret)
> +			return -EFAULT;
> +
> +		/* Let other users know what size the kernel supports. */

I am not sure what those 3 __u32 fields (user_size, kernel_size, and active_size),
plus use of the rseq_len syscall parameter, accomplish which was not accomplished
by my __u16 user_size + kernel_size approach ? If anything, it seems to make support
of older kernels which do not support an extended rseq_len parameter more complex.

Thanks,

Mathieu


> +		ret = put_user(RSEQ_SIZE_LATEST, &rseq->kernel_size);
> +		if (ret)
> +			return -EFAULT;
> +
> +		current->rseq_size = active_size;
> +	} else {
> +		current->rseq_size = RSEQ_SIZE_VER0;
> +	}
> +
> 	current->rseq = rseq;
> 	current->rseq_sig = sig;
> 	/*
> --
> 2.27.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

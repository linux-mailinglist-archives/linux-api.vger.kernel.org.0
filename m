Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2922111D
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGOPd0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 11:33:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51208 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGOPdZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 11:33:25 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvjPO-0000OV-7h; Wed, 15 Jul 2020 15:33:22 +0000
Date:   Wed, 15 Jul 2020 17:33:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>, carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
Message-ID: <20200715153321.km46syojmvqne5md@wittgenstein>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
 <20200715113849.yy6amhynxya64arv@wittgenstein>
 <20200715123323.vrmblagnvkdp4pyy@wittgenstein>
 <1944484270.14303.1594825847550.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1944484270.14303.1594825847550.JavaMail.zimbra@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 15, 2020 at 11:10:47AM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 15, 2020, at 8:33 AM, Christian Brauner christian.brauner@ubuntu.com wrote:
> [...]
> > 
> > So here's a very free-wheeling draft of roughly what I had in mind. Not
> > even compile-tested just to illustrate what I'd change and sorry if that
> > code will make you sob in your hands:
> > 
> [...]
> > +	/*
> > +	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, user_size should be
> > +	 * statically initialized to offsetof(struct rseq, end).
> > +	 */
> > +	__u32 user_size;
> > +	/*
> > +	 * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, if the kernel supports
> > +	 * extensible struct rseq ABI, the kernel_size field is populated by
> > +	 * the kernel to the minimum between user_size and the offset of the
> > +	 * "end" field within the struct rseq supported by the kernel on
> > +	 * successful registration. Should be initialized to 0.
> > +	 */
> > +	__u32 kernel_size;
> 
> Moving from __u16 to __u32 for both fields don't achieve much, and increase
> the size of struct rseq (excluding padding) from 24 bytes to 28 bytes.
> 
> Note that the struct rseq alignment is 32 bytes. At 24 bytes, it leaves room
> for exactly one 8 bytes pointer, which can be useful for future extensions.
> If the size is increased to 28 bytes or more, then we're done and cannot
> add a pointer.
> 
> > +	__u32 active_size;
> 
> This additional field takes the very last bytes of padding we have in the
> current layout.
> 
> > } __attribute__((aligned(4 * sizeof(__u64))));
> > 
> > +#define RSEQ_SIZE_VER0 24 /* sizeof first published struct */
> 
> This is incorrect. The sizeof(struct_rseq) with its 32 bytes alignment is 32,
> not 24. The padding at the end of the structure is considered as part of its
> size, but we cannot rely on its content being zero-initialized based on the
> C standard.
> 
> > +#define RSEQ_SIZE_VER1 32 /* sizeof second published struct */
> > +#define RSEQ_SIZE_LATEST RSEQ_SIZE_VER1 /* sizeof last published struct */
> > +
> 
> [...]
> 
> > @@ -349,10 +363,58 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> > rseq_len,
> > 	 * ensure the provided rseq is properly aligned and valid.
> > 	 */
> > 	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
> > -	    rseq_len != sizeof(*rseq))
> > +	    rseq_len < RSEQ_SIZE_VER0)
> 
> This could perhaps be changed for future kernels, but will break for existing
> kernels as soon as rseq_len is increased. This is something we should have
> planned for in the initial implementation of the system call, but here we are.
> 
> How do you envision that userspace would handle this failure from older kernels ?
> Try again with a second system call passing RSEQ_SIZE_VER0 as argument ?
> 
> > 		return -EINVAL;
> > 	if (!access_ok(rseq, rseq_len))
> > 		return -EFAULT;
> > +
> > +	/* Handle extensible struct rseq ABI. */
> > +	ret = get_user(tls_flags, &rseq->flags);
> > +	if (ret)
> > +		return ret;
> > +	if (tls_flags & RSEQ_TLS_FLAG_SIZE) {
> > +		u32 user_size, kernel_size, active_size;
> > +
> > +		/* Can probably be made nicer by using check_zeroed_user(). */
> > +		ret = get_user(user_size, &rseq->user_size);
> > +		if (ret)
> > +			return ret;
> > +		if (user_size != 0)
> > +			return -EINVAL;
> > +
> > +		ret = get_user(active_size, &rseq->active_size);
> > +		if (ret)
> > +			return ret;
> > +		if (active_size != 0)
> > +			return -EINVAL;
> > +
> > +		ret = get_user(active_size, &rseq->kernel_size);
> 
> I guess you mean kernel_size here.
> 
> > +		if (ret)
> > +			return ret;
> > +		if (kernel_size != 0)
> > +			return -EINVAL;
> > +
> > +		/* Calculate the useable size. */
> > +		active_size = min_t(u32, rseq_len, RSEQ_SIZE_LATEST);
> 
> Where is the rseq_len supposed to come from in userspace ? Should it be
> that the code doing the registration uses sizeof(struct rseq), or offsetof(struct rseq, end),
> or should it read the content of __rseq_abi.user_size ?
> 
> > +		ret = put_user(active_size, &rseq->active_size);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Let other users know what userspace used to register. */
> > +		ret = put_user(rseq_len, &rseq->user_size);
> > +		if (ret)
> > +			return -EFAULT;
> > +
> > +		/* Let other users know what size the kernel supports. */
> 
> I am not sure what those 3 __u32 fields (user_size, kernel_size, and active_size),
> plus use of the rseq_len syscall parameter, accomplish which was not accomplished
> by my __u16 user_size + kernel_size approach ? If anything, it seems to make support
> of older kernels which do not support an extended rseq_len parameter more complex.

Yeah, fair point. I really just sketched this.
It seemed to me that what you might want to expose all three sizes in
some form, i.e.  the size the kernel knows about, the size that
userspace knows about and the size in use. The advantage of exposing the
size the kernel itself knows about and the size that userspace knows
about is that you can infer the used size and you don't loose any
information. When you only register the kernel used size and the size
userspace knows about you can't necessarily infer what size the kernel
supports. But I suppose there's no obvious case where this is needed rn.

Thanks!
Christian

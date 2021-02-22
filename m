Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403E8321CDD
	for <lists+linux-api@lfdr.de>; Mon, 22 Feb 2021 17:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhBVQ0D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Feb 2021 11:26:03 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50954 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBVQZx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Feb 2021 11:25:53 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 967FB72C8B3;
        Mon, 22 Feb 2021 19:25:05 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 86F107CC89C; Mon, 22 Feb 2021 19:25:05 +0300 (MSK)
Date:   Mon, 22 Feb 2021 19:25:05 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir@google.com,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Message-ID: <20210222162505.GB1325@altlinux.org>
References: <20210222100443.4155938-1-figiel@google.com>
 <20210222115726.GA30843@altlinux.org>
 <1510231959.29418.1614005590596.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1510231959.29418.1614005590596.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 22, 2021 at 09:53:10AM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 22, 2021, at 6:57 AM, Dmitry V. Levin ldv@altlinux.org wrote:
> > On Mon, Feb 22, 2021 at 11:04:43AM +0100, Piotr Figiel wrote:
[...]
> >> +#ifdef CONFIG_RSEQ
> >> +static long ptrace_get_rseq_configuration(struct task_struct *task,
> >> +					  unsigned long size, void __user *data)
> >> +{
> >> +	struct ptrace_rseq_configuration conf = {
> >> +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> >> +		.signature = task->rseq_sig,
> >> +	};
> >> +
> >> +	size = min_t(unsigned long, size, sizeof(conf));
> >> +	if (copy_to_user(data, &conf, size))
> >> +		return -EFAULT;
> >> +	return size;
> >> +}
> >> +#endif
> > 
> > From API perspective I suggest for such interfaces to return the amount of
> > data that could have been written if there was enough room specified, e.g.
> > in this case it's sizeof(conf) instead of size.
> 
> Looking at the ptrace(2) man page:
> 
> RETURN VALUE
>        On success, the PTRACE_PEEK* requests return the  requested  data  (but
>        see NOTES), the PTRACE_SECCOMP_GET_FILTER request returns the number of
>        instructions in the BPF program, and other requests return zero.

PTRACE_GET_SYSCALL_INFO returns "the number of bytes available to be
written by the kernel".

It's written in the "DESCRIPTION" section, needs to be mirrored
to "RETURN VALUE" section, thanks for reporting the inconsistency.

>        On error, all requests return  -1,  and  errno  is  set  appropriately.
>        Since  the  value  returned by a successful PTRACE_PEEK* request may be
>        -1, the caller must clear errno before the call, and then check it  af‐
>        terward to determine whether or not an error occurred.
> 
> It looks like the usual behavior for ptrace requests would be to return 0 when everything
> is OK. Unless there a strong motivation for doing different for this new request, I
> would be tempted to use the same expected behavior than other requests on success:
> return 0.
> 
> Unless there is a strong motivation for returning either size or sizeof(conf) ? If we
> return sizeof(conf) to user-space, it means it should check it and deal with the
> size mismatch. Is that size ever expected to change ?

When adding new interfaces, it's generally a good idea to allow for
future extensions.
If some day in the future the structure is extended, the return value
would be the way to tell userspace what's actually supported by the kernel.


-- 
ldv

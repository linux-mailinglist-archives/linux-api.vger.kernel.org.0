Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14C13B9DBE
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 10:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGBIyN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 04:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGBIyN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 04:54:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636DC061762;
        Fri,  2 Jul 2021 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Oc8KMkpBYdZMwI+ReRnPMa1xDeaaOBuU3aOqlFtbqE=; b=FddeFFaCwTroJyXgl761K7vVQM
        5Ouerg33itrAWShIDF2owiSiFj+fseQg1bYnxrdzfcpTbhiLpz/Tgms8eianoblMc33f/xF6uy8c0
        4UwULb0AeFmRYZBxOGAtjnn4qHjbeUiPIg5OmU2PFySngMTiDZOW1pA9uM5B/CQXZrcDWtkPPQ40J
        5NDmCOH8zSnznBrLJSs4jJhT9oQjv3C3rNeqfkvutjgzmMBJCJfHXLis6STF88JY7h1HurjHALyEu
        a+HF+3FV9A6cMrerRjAoKTKAMAuQpVYU9es6hokcfcn7hHrI5KYis86S0m5O7vwxu/AbceWAPa0K0
        q/77vkiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzEtH-00Domh-Js; Fri, 02 Jul 2021 08:51:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 966CB30007E;
        Fri,  2 Jul 2021 10:51:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 34EC52DD2261F; Fri,  2 Jul 2021 10:51:13 +0200 (CEST)
Date:   Fri, 2 Jul 2021 10:51:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN7TgV9RDJTRaY8R@hirez.programming.kicks-ass.net>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414055217.543246-3-avagin@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


I'm terrified of all of this...

On Tue, Apr 13, 2021 at 10:52:15PM -0700, Andrei Vagin wrote:

> +long swap_vm_exec_context(struct sigcontext __user *uctx)
> +{
> +	struct sigcontext ctx = {};
> +	sigset_t set = {};
> +
> +
> +	if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> +		return -EFAULT;
> +	/* A floating point state is managed from user-space. */
> +	if (ctx.fpstate != 0)
> +		return -EINVAL;
> +	if (!user_access_begin(uctx, sizeof(*uctx)))
> +		return -EFAULT;
> +	unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> +	user_access_end();

But here you save the sigcontext without FPU state.

> +
> +	if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> +		goto badframe;

And here you restore sigcontext, *with* FPU state.  At which point your
FPU state is irrecoverably lost.

Also, I'm not at all convinced this can ever do the right thing when the
tasks don't agree on what the FPU state is. I suppose in the best case
the save will EFAULT.

> +
> +	return 0;
> +Efault:
> +	user_access_end();
> +badframe:
> +	signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> +	return -EFAULT;
> +}

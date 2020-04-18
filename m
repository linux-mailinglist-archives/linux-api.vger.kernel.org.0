Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265AB1AE900
	for <lists+linux-api@lfdr.de>; Sat, 18 Apr 2020 02:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgDRAq4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Apr 2020 20:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgDRAq4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 17 Apr 2020 20:46:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E767214D8;
        Sat, 18 Apr 2020 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587170815;
        bh=14qSYdrLemwVEC2uAz97e2xRaw+5yWSJoO7bWCN/K+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yxkA8fcXsZ3kHBWGVChkWfhLXCziPW7a3jxL/C2RqnxvOCRPknlE3ur4ow8QKyd1C
         KRYzLVsbvXBu5n4P5eslol7AvQWnzw0Lxwn2EEBNGYbRtXL0EHdnqPh9H05MLVrh4w
         FNWiKKtyNJWl/oZBQwCLwS+px7QRgKEm1hk2sSi8=
Date:   Fri, 17 Apr 2020 17:46:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        vbabka@suse.cz, rdunlap@infradead.org, willy@infradead.org,
        kernel@gpiccoli.net
Subject: Re: [PATCH V3] panic: Add sysctl to dump all CPUs backtraces on
 oops event
Message-Id: <20200417174654.9af0c51afb5d9e35e5519113@linux-foundation.org>
In-Reply-To: <20200327224116.21030-1-gpiccoli@canonical.com>
References: <20200327224116.21030-1-gpiccoli@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 27 Mar 2020 19:41:16 -0300 "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:

> Usually when kernel reach an oops condition, it's a point of no return;
> in case not enough debug information is available in the kernel splat,
> one of the last resorts would be to collect a kernel crash dump and
> analyze it. The problem with this approach is that in order to collect
> the dump, a panic is required (to kexec-load the crash kernel). When
> in an environment of multiple virtual machines, users may prefer to
> try living with the oops, at least until being able to properly
> shutdown their VMs / finish their important tasks.
> 
> This patch implements a way to collect a bit more debug details when an
> oops event is reached, by printing all the CPUs backtraces through the
> usage of NMIs (on architectures that support that). The sysctl added
> (and documented) here was called "oops_all_cpu_backtrace", and when
> set will (as the name suggests) dump all CPUs backtraces.
> 
> Far from ideal, this may be the last option though for users that for
> some reason cannot panic on oops. Most of times oopses are clear enough
> to indicate the kernel portion that must be investigated, but in virtual
> environments it's possible to observe hypervisor/KVM issues that could
> lead to oopses shown in other guests CPUs (like virtual APIC crashes).
> This patch hence aims to help debug such complex issues without
> resorting to kdump.
> 
> ...
>
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -513,6 +513,12 @@ static inline u32 int_sqrt64(u64 x)
>  }
>  #endif
>  
> +#ifdef CONFIG_SMP
> +extern unsigned int sysctl_oops_all_cpu_backtrace;
> +#else
> +#define sysctl_oops_all_cpu_backtrace 0
> +#endif /* CONFIG_SMP */
> +

hm, we have a ton of junk in kernel.h just to communicate between
sysctl.c and a handful of other files.  Perhaps one day someone can
move all that into a new sysctl-externs.h.

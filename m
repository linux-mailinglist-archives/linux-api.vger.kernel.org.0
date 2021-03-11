Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8E337A2A
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 17:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKQ5w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 11:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhCKQ50 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Mar 2021 11:57:26 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C0C061574;
        Thu, 11 Mar 2021 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ppV5eKP+GTwT8841mn3VqiRD2uTN7WT0z5PGxeKiaTU=; b=JvvWPkglVPY+62xqjH6sjY7+AH
        dnyYZA6+nBL5WOheOekWnlbQ6GnYvi0waEZ5t4aWCLVN2/uv4qFZ9OrhBNIwQrDxYDa48BDiqtKrL
        wAkN3RM1PxUTUqOQmW6PXrPB2cHM+bd5wAY56tC6WuekmNVUg7OEF1uYueDAaen3N2TFxZgRCcACb
        Gy0nfntxV/1oJVsdUGiS1Av+z5v6RBKcIFfTrzPoy/i0uaTqdWIzU6cST62MYG4AXAwSkdp31Bb5T
        ecWniiVWBTJ6jpgZkDQVrSGGngxUk7BvkGWXIBNwMSfTWmIivDWsN5q1kiFUH8dEHxh9F2Vt8mAg/
        sbW9346Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKOcQ-009cwK-R4; Thu, 11 Mar 2021 16:57:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55DE63013E5;
        Thu, 11 Mar 2021 17:56:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4110F29E5D623; Thu, 11 Mar 2021 17:56:58 +0100 (CET)
Date:   Thu, 11 Mar 2021 17:56:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Aili Yao <yaoaili@kingsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <YEpL2im5KCoEeXlS@hirez.programming.kicks-ass.net>
References: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
 <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
 <20210311091941.45790fcf@alex-virtual-machine>
 <CALCETrVqkK29n=6wtVhd7qgTWf83x3SUk6+bkD30asHyWSqppw@mail.gmail.com>
 <0a0909a9005842fa9e49ba9917580e79@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0909a9005842fa9e49ba9917580e79@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 11, 2021 at 04:52:10PM +0000, Luck, Tony wrote:
> > I think we need to at least fix the existing bug before we add more
> > signals.  AFAICS the MCE_IN_KERNEL_COPYIN code is busted for kernel
> > threads.
> 
> Can a kernel thread do get_user() or copy_from_user()?  Do we have kernel threads
> that have an associated user address space to copy from?

kthread_use_mm()

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF2B1ABE83
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505610AbgDPKuJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 06:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505584AbgDPKuD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 16 Apr 2020 06:50:03 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB6821973;
        Thu, 16 Apr 2020 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587034203;
        bh=LjtYJ1+zP8B4coyCSSkpAR0h9NEbqGTk1VJW9/0u9YM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hVtiK8gSA6OqY8oY4HnFhpmgvWLI2HvqcFXcU5YyKJdhNP37a5BfYSw23JXFYOAzq
         3ZnmfvIdea6UiBOS7K1SXBWE6YBf4bP5IHp97F4Q1bnDE9Xor5UAQcDwN0BM0jsxjh
         dOpxHZr2HaQzsEDck+ov8Ah3UdmIFICjC2gf65aE=
Date:   Thu, 16 Apr 2020 19:49:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-Id: <20200416194955.3448c8526ea3f59e95c506da@kernel.org>
In-Reply-To: <20200416012931.GE11244@42.do-not-panic.com>
References: <20200414113222.16959-1-vbabka@suse.cz>
        <20200414113222.16959-2-vbabka@suse.cz>
        <20200415180355.00bc828ea726c421638db871@kernel.org>
        <20200416012931.GE11244@42.do-not-panic.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Luis,

On Thu, 16 Apr 2020 01:29:31 +0000
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Wed, Apr 15, 2020 at 06:03:55PM +0900, Masami Hiramatsu wrote:
> > On Tue, 14 Apr 2020 13:32:20 +0200
> > Vlastimil Babka <vbabka@suse.cz> wrote:
> > > diff --git a/init/main.c b/init/main.c
> > > index a48617f2e5e5..7b43118215d6 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -1372,6 +1372,8 @@ static int __ref kernel_init(void *unused)
> > >  
> > >  	rcu_end_inkernel_boot();
> > >  
> > > +	do_sysctl_args();
> > > +
> > 
> > Ah, I see. Since the sysctl is designed to be called after all __init calls were
> > done, it shouldn't use bootconfig directly because bootconfig is full of __init
> > call.
> 
> The idea is bootconfig would be useful in the sense of a library set of
> helpers which could be modified to remove __init, and then used to
> instrument the cmdline depending on certain debugging kconfig entries.

Would you mean making bootconfig (parser and APIs) be more generic so that
other subsystem can reuse it with their data?
Or just make it available after boot? (I think this latter one will be
useful for module initialization)

> We currently have no way to purposely extend / break the cmdline for
> debugging purposes, so, bootconfig's parsers, since it already has a
> way to extend the cmdlineline, might make it much easier to do this
> later.
> 
> Without bootconfig, if we wanted to add new kconfig to, for example,
> add new funny cmdline arguments to test they worked or not, we'd have
> to devise our own set of helpers now. ie, new functionality. bootconfig
> however already has existing functionality to tweak the cmdline, and so
> some code could be leveraged there for this purpose.

Hmm, you can use the bootconfig as a "supplemental" kernel command line,
but not tweak (like modify/replace) it. Would you like to change the
kernel command line parameter on-line?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

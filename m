Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242F3E8866
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfJ2MkR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 08:40:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfJ2MkR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sMcCsiPZroEcuV8OSVTJGo4oXf0H1fQaUisPb3xX7L8=; b=KnyYMMfRnAFyBc2hjQAOkZ1Ai
        pITPlePXil77rCv1X/hxMOgpBLXAXV0JrtL3VwKyl9l4T1zvUg7L+kqLs91pWMH0VyxFEsbXFlHZR
        IyHXs7ZNFAK2i2e+3Q8hBzD8AHG64LyO7H3VuTQvynBLUw4X6LWPw7jeHwPEVM8QvARYSN1YDMNi+
        JsHg5NVOED7Oxxyh9lDXZLkJpDDn1tPrKpEJKNq3+qyS62yAgroqEzriILDOPof6ms48gX4AGdmN5
        MGdW8Tk5qIcVrMXu4F+bcSKSjcaX3ZRJRg07oT7RtllhE7UpwUvFLN3TZNw6XZBPvNtNso4eu7KXD
        cok5eK38A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPQmv-0000x4-1h; Tue, 29 Oct 2019 12:39:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 630913040CB;
        Tue, 29 Oct 2019 13:38:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26FAC20D7FF19; Tue, 29 Oct 2019 13:39:49 +0100 (CET)
Date:   Tue, 29 Oct 2019 13:39:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, thomas.lendacky@amd.com
Subject: AMD TLB errata, (Was: [PATCH RFC] mm: add MAP_EXCLUSIVE to create
 exclusive user mappings)
Message-ID: <20191029123949.GL4114@hirez.programming.kicks-ass.net>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
 <20191029064318.s4n4gidlfjun3d47@box>
 <20191029085602.GI4114@hirez.programming.kicks-ass.net>
 <20191029110024.yjytp22lhd2vekrv@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029110024.yjytp22lhd2vekrv@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 02:00:24PM +0300, Kirill A. Shutemov wrote:
> On Tue, Oct 29, 2019 at 09:56:02AM +0100, Peter Zijlstra wrote:
> > On Tue, Oct 29, 2019 at 09:43:18AM +0300, Kirill A. Shutemov wrote:
> > > But some CPUs don't like to have two TLB entries for the same memory with
> > > different sizes at the same time. See for instance AMD erratum 383.
> > > 
> > > Getting it right would require making the range not present, flush TLB and
> > > only then install huge page. That's what we do for userspace.
> > > 
> > > It will not fly for the direct mapping. There is no reasonable way to
> > > exclude other CPU from accessing the range while it's not present (call
> > > stop_machine()? :P). Moreover, the range may contain the code that doing
> > > the collapse or data required for it...
> > > 
> > > BTW, looks like current __split_large_page() in pageattr.c is susceptible
> > > to the errata. Maybe we can get away with the easy way...
> > 
> > As you write above, there is just no way we can have a (temporary) hole
> > in the direct map.
> > 
> > We are careful about that other errata, and make sure both translations
> > are identical wrt everything else.
> 
> It's not clear if it is enough to avoid the issue. "under a highly specific
> and detailed set of conditions" is not very specific set of conditions :P

Yeah, I know ... :/ Tom is there any chance you could shed a little more
light on that errata?


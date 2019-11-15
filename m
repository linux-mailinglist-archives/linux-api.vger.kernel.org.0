Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4EFE01C
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 15:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOOby (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Nov 2019 09:31:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:32832 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKOOby (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Nov 2019 09:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lFf6dMuZ+Z677Mu+atmNfBMTjTNBdV46hR58S1n03Bw=; b=fLdav0zx2sYSW0v3s7tI6JqhI
        i7d9/vr4rYSEvqt/p7lCLO5nk4FjdEP/waWiqJFTEs4e7A3brAzpOhscHMxVCEEHx8WDQaY2fd8Gr
        GK3TZyjntH4NZYVDHPPKRUN+AsgdOJw2Cm2ZA2fsSg2yhR1F8LWGZb3c8HNAHerseKwJPUt366auU
        yXVDObbWRAX2R2xTnSjp74xVKH4/hcGL9VqcxEzgIIACyD2Q8xu6GqD9a9uiaEDpt8LXrHH8EkZVT
        0q5wDIWmPdE6CFeLG/2Xak2uIEe2UlAm65b4AUoKrm1vQ3tMwtkUeiJT21GYinhobMjPfO3WOy2ow
        IjCWf0kTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVcd2-0000Es-S4; Fri, 15 Nov 2019 14:31:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EA5D304637;
        Fri, 15 Nov 2019 15:30:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52A882B12E7AC; Fri, 15 Nov 2019 15:31:14 +0100 (CET)
Date:   Fri, 15 Nov 2019 15:31:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: AMD TLB errata, (Was: [PATCH RFC] mm: add MAP_EXCLUSIVE to
 create exclusive user mappings)
Message-ID: <20191115143114.GN4131@hirez.programming.kicks-ass.net>
References: <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
 <20191029064318.s4n4gidlfjun3d47@box>
 <20191029085602.GI4114@hirez.programming.kicks-ass.net>
 <20191029110024.yjytp22lhd2vekrv@box>
 <20191029123949.GL4114@hirez.programming.kicks-ass.net>
 <1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 15, 2019 at 08:12:52AM -0600, Tom Lendacky wrote:
> I talked with some of the hardware folks and if you maintain the same bits
> in the large and small pages (aside from the large page bit) until the
> flush, then the errata should not occur.

Excellent!

Thanks for digging that out Tom.

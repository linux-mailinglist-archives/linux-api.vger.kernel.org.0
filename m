Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E26E83A1
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 09:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfJ2I4v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 04:56:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38224 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfJ2I4u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 04:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xez2J0gdWTQqquZ7HMjmzRRSRKuRWvTSCcnNPVHNA/g=; b=ahVlpW42taty0lSMLliukzweJ
        8X1ZH4o3vxmyak/TqNyxf+gECDUZYtp8vOeQ6+PqM84XwgzJLbPzwd6Qt5PG44zLYkayeKOqdVGWk
        EBvmbYDmTM/qMF9WUUuSFuzj2Yrw62cJy0fL24dBwAnFV6zbi4EHYEPP2hiqc6+RuQoBTvJooa8iE
        dBkUF5CznIhOc0ErpTfWlgg77CpH39CI/28hg7lS84MVEc7lexhWN9OMfGXalAzlEx+6LluZy7E9b
        SEEoo+KVUU78wyle+Ct+G9N34+5ZPTjrbW0oiZMpsHqpx6uZJTKYLC8hTHFiDG1UVwmoIq3RDBTuP
        2ebVCEniw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPNIL-0008JR-Rv; Tue, 29 Oct 2019 08:56:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74473306091;
        Tue, 29 Oct 2019 09:55:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20B0220D7FEE3; Tue, 29 Oct 2019 09:56:02 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:56:02 +0100
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191029085602.GI4114@hirez.programming.kicks-ass.net>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <CAA9_cmd7f2y2AAT6646S=tco3yfyLgCAC4Qp=1iTQaJqrQcOwQ@mail.gmail.com>
 <20191029064318.s4n4gidlfjun3d47@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029064318.s4n4gidlfjun3d47@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 09:43:18AM +0300, Kirill A. Shutemov wrote:
> But some CPUs don't like to have two TLB entries for the same memory with
> different sizes at the same time. See for instance AMD erratum 383.
> 
> Getting it right would require making the range not present, flush TLB and
> only then install huge page. That's what we do for userspace.
> 
> It will not fly for the direct mapping. There is no reasonable way to
> exclude other CPU from accessing the range while it's not present (call
> stop_machine()? :P). Moreover, the range may contain the code that doing
> the collapse or data required for it...
> 
> BTW, looks like current __split_large_page() in pageattr.c is susceptible
> to the errata. Maybe we can get away with the easy way...

As you write above, there is just no way we can have a (temporary) hole
in the direct map.

We are careful about that other errata, and make sure both translations
are identical wrt everything else.

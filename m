Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D87C1565C3
	for <lists+linux-api@lfdr.de>; Sat,  8 Feb 2020 18:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBHRl2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 8 Feb 2020 12:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgBHRl2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 8 Feb 2020 12:41:28 -0500
Received: from hump (unknown [185.189.199.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF6921741;
        Sat,  8 Feb 2020 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581183687;
        bh=M5iGyv9f4kxeousKItvHS+SWTdXy1QHRukV9utRFi0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1WsJ7Y9DO7oleGTs2z3bbQ6ik8fmcjNcOtCstN9UfZluoPeE40jiSTGKrjieyy+KV
         yxp7IlExIl3Lqyi2TpfXtmmHMwPYhOD7Jid6tI5lAdjlhjaHDrZl3fXxWSOiTRv8PV
         XbTKA7gKNny+Ei/c18DC3J4eljlDYsLLnS28ibDg=
Date:   Sat, 8 Feb 2020 19:39:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
Message-ID: <20200208173922.GA15879@hump>
References: <20200130162340.GA14232@rapoport-lnx>
 <df5a888b-1a11-e806-741d-94684b22c966@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5a888b-1a11-e806-741d-94684b22c966@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 06, 2020 at 10:51:13AM -0800, Dave Hansen wrote:
> On 1/30/20 8:23 AM, Mike Rapoport wrote:
> >  include/linux/memfd.h      |   9 ++
> >  include/uapi/linux/magic.h |   1 +
> >  include/uapi/linux/memfd.h |   6 +
> >  mm/Kconfig                 |   4 +
> >  mm/Makefile                |   1 +
> >  mm/memfd.c                 |  10 +-
> >  mm/secretmem.c             | 244 +++++++++++++++++++++++++++++++++++++
> >  7 files changed, 273 insertions(+), 2 deletions(-)
> 
> It seems pretty self-contained and relatively harmless.
> 
> But, how much work is it going to be to tell the rest of the kernel that
> page_to_virt() doesn't work any more?

Why page_to_virt() won't work anymore? Or you refer to that the kernel code
won't be able to access the page contents?

> Do we need to make kmap() work on these?

I don't think we need to make kmap() work on these. The idea is to prevent
kernel from accessing such memory areas.
 
> I guess fixing vm_normal_page() would fix a lot of that.
> 
> In general, my concern about creating little self-contained memory types
> is that they will get popular and folks will start wanting more features
> from them.  For instance, what if I want NUMA affinity, migration, or
> large page mappings that are secret?

Sure, why not :)
Well, this is true for any feature: it may become popular, people will
start using it and it will add more complexity.

My goal is to design this thing keeping in mind that all the above (and
probably more) will be requested sooner or later.
 
> Can these pages work as guest memory?

Actually, this is one of the driving usecases. I believe that people that
use mem=X to limit kernel control of the memory and the manage the
remaining memory for the guests can switch to fd-based approach.
 
> Who would the first users of this thing be?

We were thinking about using such areas to store small secrets, e.g. with
openssl_malloc().

Another usecase is the VM memory.

-- 
Sincerely yours,
Mike.

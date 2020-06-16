Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03D1FB935
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbgFPQBv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733179AbgFPQBu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 12:01:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88815C06174E
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 09:01:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so9704927pfp.9
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2Y4BhWefKmP9iji9eylvkFo4/M9jmgkj2BXKFGkoJE=;
        b=aJ8p70Y5LnowTS4d6Nvq5WyEu93YaLiozLfkw0uDW6dYUF3xQNCbIJvKarTK5Ed9iD
         m7i0zsBqFI1pIpAyIluoSmBT0Risms7oI2Pp32JEbx7n0H5pqbwQtOkP1/KHECdDu/FT
         ltBtg48/YKabACQ+Epr94E4U9IQIdRDp/x9Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C2Y4BhWefKmP9iji9eylvkFo4/M9jmgkj2BXKFGkoJE=;
        b=mVAUi8z0dfrU/yTNWl70zFaVSC24pxVP3mimhJvTJ20S+U3M3F0GFPqnJ/0GgZIaez
         mnFpnFTSyqujpRJIhjjoAAI8h4/PkWWLY3N2xbgwlSSCh1Xk8ByUZHYmFdKdu4Avob6e
         oPpp2rkZNVlmzhHW2Gnk4EPanWQOo43IVZwpyd4fX2QAjLKqR6QgS5exZ513gSAUUCoU
         TgEbSdqr4Uhd08Fdlh3OS/eKTfwfL6+plZUsnSgkqgxOToUZTl+NPOSx5gDtUnCcR4K0
         kZrX8yNrp1lI5OBh1S0nLilexlIvnmgyqk3mHC7GT6ut9hjDqauUB1WXZEFZlWLo+PCQ
         HIcA==
X-Gm-Message-State: AOAM5326arC8cKQHe9n411I/DsnvxIL4v469TS3OBaaIrNX1HhYdWlBQ
        SzglkIbJQlMYZdZDhTij/pYTUmhNmY3i3g==
X-Google-Smtp-Source: ABdhPJxZYUpPJAibIwbYuU5zDTSd1Kb3np/+gOul4WD0kGGfyZGJ7hHLOe/iwa9+dycWyfSgo2noGQ==
X-Received: by 2002:a63:5307:: with SMTP id h7mr2625624pgb.28.1592323309057;
        Tue, 16 Jun 2020 09:01:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iq19sm2942471pjb.48.2020.06.16.09.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:01:48 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:01:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
Message-ID: <202006160851.E8F9928AAB@keescook>
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-5-keescook@chromium.org>
 <fc0c14cd-bcf0-c94c-6cba-d0ce1844e93c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0c14cd-bcf0-c94c-6cba-d0ce1844e93c@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 07:40:17AM -0700, Dave Hansen wrote:
> On 6/16/20 12:49 AM, Kees Cook wrote:
> > +	/* Mark the second page as untouched (i.e. "old") */
> > +	preempt_disable();
> > +	set_pte_at(&init_mm, vaddr, ptep, pte_mkold(*(READ_ONCE(ptep))));
> > +	local_flush_tlb_kernel_range(vaddr, vaddr + PAGE_SIZE);
> > +	preempt_enable();
> 
> If you can, I'd wrap that nugget up in a helper.  I'd also suggest being
> very explicit in a comment about what it is trying to do: ensure no TLB
> entries exist so that a future access will always set the Accessed bit.

Yeah, good idea!

> 
> > +	/* Make sure the PTE agrees that it is untouched. */
> > +	if (WARN_ON_ONCE(sd_touched(ptep)))
> > +		return;
> > +	/* Read a portion of struct seccomp_data from the second page. */
> > +	check = sd->instruction_pointer;
> > +	/* First, verify the contents are zero from vzalloc(). */
> > +	if (WARN_ON_ONCE(check))
> > +		return;
> > +	/* Now make sure the ACCESSED bit has been set after the read. */
> > +	if (!sd_touched(ptep)) {
> > +		/*
> > +		 * If autodetection fails, fall back to standard beahavior by
> > +		 * clearing the entire "allow" bitmap.
> > +		 */
> > +		pr_warn_once("seccomp: cannot build automatic syscall filters\n");
> > +		bitmap_zero(bitmaps->allow, NR_syscalls);
> > +		return;
> > +	}
> 
> I can't find any big holes with this.  It's the kind of code that makes
> me nervous, but mostly because it's pretty different that anything else
> we have in the kernel.
> 
> It's also clear to me here that you probably have a slightly different
> expectation of what the PTE accessed flag means versus the hardware
> guys.  What you are looking for it to mean is roughly: "a retired
> instruction touched this page".
> 
> The hardware guys would probably say it's closer to "a TLB entry was
> established for this page."  Remember that TLB entries can be
> established speculatively or from things like prefetchers.  While I
> don't know of anything microarchitectural today which would trip this
> mechanism, it's entirely possible that something in the future might.
> Accessing close to the page boundary is the exact kind of place folks
> might want to optimize.

Yeah, and to that end, going the cBPF emulator route removes this kind
of "weird" behavior.

> 
> *But*, at least it would err in the direction of being conservative.  It
> would say "somebody touched the page!" more often than it should, but
> never _less_ often than it should.

Right -- I made sure to design the bitmaps and the direction of the
checking to fail towards running the filter instead of bypassing it.

> One thing about the implementation (which is roughly):
> 
> 	// Touch the data:
> 	check = sd->instruction_pointer;
> 	// Examine the PTE mapping that data:
> 	if (!sd_touched(ptep)) {
> 		// something
> 	}
> 
> There aren't any barriers in there, which could lead to the sd_touched()
> check being ordered before the data touch.  I think a rmb() will
> suffice.  You could even do it inside sd_touched().

Ah yeah, I had convinced myself that READ_ONCE() gained me that
coverage, but I guess that's not actually true here.

> Was there a reason you chose to export a ranged TLB flush?  I probably
> would have just used the single-page flush_tlb_one_kernel() for this
> purpose if I were working in arch-specific code.

No particular reason -- it just seemed easiest to make available given
the interfaces. I could do the single-page version instead, if this way
of doing things survives review. ;)

Thanks for looking at it!

-- 
Kees Cook

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC8E8429
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 10:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfJ2JT3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 05:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfJ2JT3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 05:19:29 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1982D20873;
        Tue, 29 Oct 2019 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572340768;
        bh=09ecCW/OZCt/5BQeGtrO08ZMgiWal40RLCJlcZrHmzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6bG3TOPT1CgBrvnoj6mEcMekIPIdcA7C9AZxFiSEc8b3BVnBzS0Znr2OWRvBF00J
         aNjrpKfZ0VeHzVvpVkdFQsO/yOVAkWgLMiRePByul58aDGX4UQX2/xSuMJXPj8LKti
         t2nzHsmS1tv9Ewfk/K+WR3PwFNj5gydfdHO9KDSM=
Date:   Tue, 29 Oct 2019 10:19:19 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191029091918.GC18773@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <d6ac08fe-23f3-c2d5-24c4-88e68f3fd4d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ac08fe-23f3-c2d5-24c4-88e68f3fd4d0@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 10:12:44AM -0700, Dave Hansen wrote:
> On 10/27/19 3:17 AM, Mike Rapoport wrote:
> > The pages in these mappings are removed from the kernel direct map and
> > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > the pages are mapped back into the direct map.
> 
> This looks fun.  It's certainly simple.
> 
> But, the description is not really calling out the pros and cons very
> well.  I'm also not sure that folks will use an interface like this that
> requires up-front, special code to do an allocation instead of something
> like madvise().  That's why protection keys ended up the way it did: if
> you do this as a mmap() replacement, you need to modify all *allocators*
> to be enabled for this.  If you do it with mprotect()-style, you can
> apply it to existing allocations.

Actually, I've started with mprotect() and then realized that mmap() would
be simpler, so I switched over to mmap().
 
> Some other random thoughts:
> 
>  * The page flag is probably not a good idea.  It would be probably
>    better to set _PAGE_SPECIAL on the PTE and force get_user_pages()
>    into the slow path.

The page flag won't work on 32-bit, indeed. But do we really need such
functionality on 32-bit?

>  * This really stops being "normal" memory.  You can't do futexes on it,
>    cant splice it.  Probably need a more fleshed-out list of
>    incompatible features.

True, my bad. I should have mentioned more than THP/compaction/migration.

>  * As Kirill noted, each 4k page ends up with a potential 1GB "blast
>    radius" of demoted pages in the direct map.  Not cool.  This is
>    probably a non-starter as it stands.
>  * The global TLB flushes are going to eat you alive.  They probably
>    border on a DoS on larger systems.

As I wrote in another email, we could use some kind of pooling to reduce
the "blast radius" and that will reduce that amount of TLB flushes as well.
The size of the MAP_EXCLUSIVE obeys the RLIMIT_MEMLOCK and we can add a
system-wide limit for size of such allocations.

>  * Do we really want this user interface to dictate the kernel
>    implementation?  In other words, do we really want MAP_EXCLUSIVE,
>    or do we want MAP_SECRET?  One tells the kernel what do *do*, the
>    other tells the kernel what the memory *IS*.

I hesitated quite some time between EXCLUSIVE and SECRET. I've settled down
on EXCLUSIVE because in my view that better describes the fact that the
region is only mapped in its owner address space. And as such it can be
used to store secrets, but it can be used for other purposes as well.

>  * There's a lot of other stuff going on in this area: XPFO, SEV, MKTME,
>    Persistent Memory, where the kernel direct map is a liability in some
>    way.  We probably need some kind of overall, architected solution
>    rather than five or ten things all poking at the direct map.

Agree.
 

-- 
Sincerely yours,
Mike.

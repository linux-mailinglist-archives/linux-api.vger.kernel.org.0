Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 993C2E779D
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 18:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbfJ1Rdb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 13:33:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:42803 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404155AbfJ1Rdb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Oct 2019 13:33:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 10:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="399514952"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2019 10:32:30 -0700
Date:   Mon, 28 Oct 2019 10:32:30 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20191028173229.GC5061@linux.intel.com>
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
> 
> Some other random thoughts:
> 
>  * The page flag is probably not a good idea.  It would be probably
>    better to set _PAGE_SPECIAL on the PTE and force get_user_pages()
>    into the slow path.
>  * This really stops being "normal" memory.  You can't do futexes on it,
>    cant splice it.  Probably need a more fleshed-out list of
>    incompatible features.
>  * As Kirill noted, each 4k page ends up with a potential 1GB "blast
>    radius" of demoted pages in the direct map.  Not cool.  This is
>    probably a non-starter as it stands.
>  * The global TLB flushes are going to eat you alive.  They probably
>    border on a DoS on larger systems.
>  * Do we really want this user interface to dictate the kernel
>    implementation?  In other words, do we really want MAP_EXCLUSIVE,
>    or do we want MAP_SECRET?  One tells the kernel what do *do*, the
>    other tells the kernel what the memory *IS*.

If we go that route, maybe MAP_USER_SECRET so that there's wiggle room in
the event that there are different secret keepers that require different
implementations in the kernel?   E.g. MAP_GUEST_SECRET for a KVM guest to
take the userspace VMM (Qemu) out of the TCB, i.e. the mapping would be
accessible by the kernel (or just KVM?) and the KVM guest, but not
userspace.

>  * There's a lot of other stuff going on in this area: XPFO, SEV, MKTME,
>    Persistent Memory, where the kernel direct map is a liability in some
>    way.  We probably need some kind of overall, architected solution
>    rather than five or ten things all poking at the direct map.
> 

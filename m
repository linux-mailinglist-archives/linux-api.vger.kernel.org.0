Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9DE8472
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 10:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfJ2J3C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 05:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ2J3C (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 05:29:02 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8A720717;
        Tue, 29 Oct 2019 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572341341;
        bh=rd5XRgLhghBx1DA/0IIWdYW9FTH+bTzevOPMMdv912k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKgpw0ntEHHZ4HT/ZDySA9OrNTk1psA6bonWPTGjVnybbuJ2QiFiXDXAyb6TCx4QY
         bn7Eylclfd5UxQxW+R/+tUxgi/2g2YvsAoYLKFeTYKmAj9dB8Fe4BluWHfeK1EqDlj
         h29PNydkzT3l7Zc6n3kkHms3xHDJEbMML4v9RIpY=
Date:   Tue, 29 Oct 2019 10:28:53 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20191029092852.GD18773@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <d6ac08fe-23f3-c2d5-24c4-88e68f3fd4d0@intel.com>
 <20191028180808.GA17669@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028180808.GA17669@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 11:08:08AM -0700, Matthew Wilcox wrote:
> On Mon, Oct 28, 2019 at 10:12:44AM -0700, Dave Hansen wrote:
> > Some other random thoughts:
> > 
> >  * The page flag is probably not a good idea.  It would be probably
> >    better to set _PAGE_SPECIAL on the PTE and force get_user_pages()
> >    into the slow path.
> >  * This really stops being "normal" memory.  You can't do futexes on it,
> >    cant splice it.  Probably need a more fleshed-out list of
> >    incompatible features.
> >  * As Kirill noted, each 4k page ends up with a potential 1GB "blast
> >    radius" of demoted pages in the direct map.  Not cool.  This is
> >    probably a non-starter as it stands.
> >  * The global TLB flushes are going to eat you alive.  They probably
> >    border on a DoS on larger systems.
> >  * Do we really want this user interface to dictate the kernel
> >    implementation?  In other words, do we really want MAP_EXCLUSIVE,
> >    or do we want MAP_SECRET?  One tells the kernel what do *do*, the
> >    other tells the kernel what the memory *IS*.
> >  * There's a lot of other stuff going on in this area: XPFO, SEV, MKTME,
> >    Persistent Memory, where the kernel direct map is a liability in some
> >    way.  We probably need some kind of overall, architected solution
> >    rather than five or ten things all poking at the direct map.
> 
> Another random set of thoughts:
> 
>  - Should devices be permitted to DMA to/from MAP_SECRET pages?

I can't say I have a clear cut yes or no here. One possible use case for
such pages is to read a secrets from storage directly into them. On the
other side, DMA to/from a device can be used to exploit those secrets...

>  - How about GUP?

Do you mean GUP for "remote" memory? I'd say no.

>  - Can I ptrace my way into another process's secret pages?

No.

>  - What if I splice() the page into a pipe?

I think it should fail.

-- 
Sincerely yours,
Mike.

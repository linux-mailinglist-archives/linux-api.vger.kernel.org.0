Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB39E781D
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 19:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfJ1SIL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 14:08:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfJ1SIL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 14:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Oii312J4rwKfjBtVwSgoriFHTTc3+9xh/Qx156700k=; b=XDc/2ESgjMpplBzpDrC0S7Jp1
        0qNTtrxHoUFs0nJAAGBFV1U+sTNzXyMzk6FwQ8U2kqQqeTWcSpvbLIOfEcBFQzyb/2npOWiU9bu+S
        AZMyc3mzxjvJgKgUJx4zYZ+eHkI4/IvYoaQViQvUvwQlLhkC1PMP1DksUfid674VuAMnACmwOipl9
        yByP1E3zbfKdH0E28vR3tA+5ICf8HAyoNxytN+AXycznam8Q0eMFdSxXCaPiKY82hNcz3UX6wooQP
        +Po1osJUqQ2E70MIa+ZVW3lYr/T/5vCvrqgDKkaSIINdKVbMlHcbonidtye3Ziud1pRsml4yT34QS
        ph8bCJQ8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP9R2-0003fP-VK; Mon, 28 Oct 2019 18:08:08 +0000
Date:   Mon, 28 Oct 2019 11:08:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20191028180808.GA17669@bombadil.infradead.org>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <d6ac08fe-23f3-c2d5-24c4-88e68f3fd4d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ac08fe-23f3-c2d5-24c4-88e68f3fd4d0@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 10:12:44AM -0700, Dave Hansen wrote:
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
>  * There's a lot of other stuff going on in this area: XPFO, SEV, MKTME,
>    Persistent Memory, where the kernel direct map is a liability in some
>    way.  We probably need some kind of overall, architected solution
>    rather than five or ten things all poking at the direct map.

Another random set of thoughts:

 - Should devices be permitted to DMA to/from MAP_SECRET pages?
 - How about GUP?  Can I ptrace my way into another process's secret pages?
 - What if I splice() the page into a pipe?

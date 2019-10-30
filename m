Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C324E97EE
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 09:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfJ3IPj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 04:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfJ3IPj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Oct 2019 04:15:39 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CC62067D;
        Wed, 30 Oct 2019 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572423338;
        bh=iS1J5NyS2mmPn50lpxeYWffskvCfVMjwF0kqUnoxyWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyAYL+pk/pQmtYM6DFquQE87kHJQ+2nodze4tZvavQE73bdBil7hC7rx+P9j1WuGU
         JlmZrz8Hf1kfu0trTmrlgRjxU+WoR1EdQemFlorT+lCJKW8ebDw74pSN9GIR0asSfK
         aPtAhhSUkxoe/pVNW25rZQ0PopjelW+Hk9lv1tBE=
Date:   Wed, 30 Oct 2019 09:15:30 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
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
Message-ID: <20191030081529.GB20624@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <085ed07e-e646-f7a4-0370-06f33a2a4e4a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085ed07e-e646-f7a4-0370-06f33a2a4e4a@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 12:02:34PM +0100, David Hildenbrand wrote:
> On 27.10.19 11:17, Mike Rapoport wrote:
> >From: Mike Rapoport <rppt@linux.ibm.com>
> >
> >The mappings created with MAP_EXCLUSIVE are visible only in the context of
> >the owning process and can be used by applications to store secret
> >information that will not be visible not only to other processes but to the
> >kernel as well.
> >
> >The pages in these mappings are removed from the kernel direct map and
> >marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> >the pages are mapped back into the direct map.
> >
> 
> Just a thought, the kernel is still able to indirectly read the contents of
> these pages by doing a kdump from kexec environment, right?

Right.

> Also, I wonder
> what would happen if you map such pages via /dev/mem into another user space
> application and e.g., use them along with kvm [1].

Do you mean that one application creates MAP_EXCLUSIVE and another
applications accesses the same physical pages via /dev/mem? 

With /dev/mem all physical memory is visible...
 
> [1] https://lwn.net/Articles/778240/
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

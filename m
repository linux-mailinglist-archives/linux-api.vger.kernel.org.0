Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2D39972E
	for <lists+linux-api@lfdr.de>; Thu,  3 Jun 2021 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhFCAsU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Jun 2021 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCAsT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Jun 2021 20:48:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4870C06174A
        for <linux-api@vger.kernel.org>; Wed,  2 Jun 2021 17:46:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o9so928285pgd.2
        for <linux-api@vger.kernel.org>; Wed, 02 Jun 2021 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=osOs0sHgu+64jN5ym3Au5W/VmmFJT/nDNYVamcF5dls=;
        b=bIHL9vqryreOafST/ivSUZS4GWhywJbx7et4ZIiMUaBRnA7NWCTciWiUyxl6ulMfLH
         kXmXxr8cMjOWt8/k7dZ65XzqJ6X1BOHznHYtJdFdzh9dNfhh08tUI5qvo92hUV9LyRVt
         PmYnNgiekCfnu3BTs1AEvG3zbo0tb+h8fCRVbBGfETiFPwT+8huhKeM5TINFzKblHjxN
         syvCafh6ZBRekNM5KyqkbEaIn+TAkAyBv6RWd53zYyo9Bx7o+TNzuvFxN1r82B4lZWR2
         RcEnkvajmirWQ9AVXoeMyjOeXtLCxWSbRh1rJohuWKXM5HnS5WCawiy1AXC6cCp/6s7P
         K9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=osOs0sHgu+64jN5ym3Au5W/VmmFJT/nDNYVamcF5dls=;
        b=lludK1y1JzUInqvxsSQwSwzZ3uLd59dL7eFKJrh7KscZsPnpcCacZdAo13ZYWlZcYO
         /xwZ4Ib+8RAIefukAMZNK1vL3vAe75VnNHQgw8OztrODSfjJV8rJ///TZxkSXyh7SGk5
         3sbFlN2HPGLcPxCtjpL2ZrajSCxQ+Ma0qJMH21mpHd65nKw3nLIEA9qmGMhhUd9hZ5QR
         75iy62yeP+/EmXitu7YhlYf5/4Qha3SculZSRhfCEf5z6z2ysR+0ttX05Vy+4AqkfarS
         YQUJ0TYdtwefBjDlp+hC4wUypO7poTUhAefrpxchdCPW23a33CB2IsSk6W5aBplbqFXY
         /zkA==
X-Gm-Message-State: AOAM530UxN+y2hDLuvS+OC7zcxVhJFJWymRq7vNJxjx1dN6FPQouH6ls
        bbeRa9MsKYj7jn6FzobHJ2qy7A==
X-Google-Smtp-Source: ABdhPJw9aoPIjkkHWSFoZXJWBT0STKpUe02wN8ncCMWEz3zK931xLJWKMZFE58iRtnhkygGC9ZYUMQ==
X-Received: by 2002:a65:5608:: with SMTP id l8mr27030754pgs.329.1622681194923;
        Wed, 02 Jun 2021 17:46:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g29sm804315pgm.11.2021.06.02.17.46.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Jun 2021 17:46:34 -0700 (PDT)
Date:   Wed, 2 Jun 2021 17:46:02 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Ming Lin <mlin@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Simon Ser <contact@emersion.fr>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem
 read
In-Reply-To: <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org>
Message-ID: <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
References: <1622589753-9206-1-git-send-email-mlin@kernel.org> <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils> <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 2 Jun 2021, Ming Lin wrote:
> 
> This is what I wrote so far.
> 
> ---
>  include/linux/mm.h                     |  2 ++
>  include/linux/mman.h                   |  1 +
>  include/uapi/asm-generic/mman-common.h |  1 +
>  mm/memory.c                            | 12 ++++++++++++
>  mm/mmap.c                              |  4 ++++
>  5 files changed, 20 insertions(+)

I have not looked at the rest, just looking at mm/memory.c:

> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3676,6 +3676,18 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	}
>   	ret = vma->vm_ops->fault(vmf);
> +	if (unlikely(ret & VM_FAULT_SIGBUS) && (vma->vm_flags & VM_NOSIGBUS))
> {
> +		/*
> +		 * Get zero page for MAP_NOSIGBUS mapping, which isn't
> +		 * coherent wrt shmem contents that are expanded and
> +		 * filled in later.
> +		 */
> +		vma->vm_flags |= VM_MIXEDMAP;
> +		if (!vm_insert_page(vma, (unsigned long)vmf->address,
> +				ZERO_PAGE(vmf->address)))
> +			return VM_FAULT_NOPAGE;
> +	}
> +
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY
> |
>  			    VM_FAULT_DONE_COW)))
>  		return ret;

Sorry, I directed you to mm/memory.c without indicating what's
appropriate here.  Please don't attempt to use VM_MIXEDMAP and
vm_insert_page(): they're for special driver mmaps, they're no
better here than they were in mm/shmem.c.

It's do_anonymous_page()'s business to map in the zero page on
read fault (see "my_zero_pfn(vmf->address)" in there), or fill
a freshly allocated page with zeroes on write fault - and now
you're sticking to MAP_PRIVATE, write faults in VM_WRITE areas
are okay for VM_NOSIGBUS.

Ideally you can simply call do_anonymous_page() from __do_fault()
in the VM_FAULT_SIGBUS on VM_NOSIGBUS case.  That's what to start
from anyway: but look to see if there's state to be adjusted to
achieve that; and it won't be surprising if somewhere down in
do_anonymous_page() or something it calls, there's a BUG on it
being called when vma->vm_file is set, or something like that.
May need some tweaking.

Hugh

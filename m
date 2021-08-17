Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46763EF51E
	for <lists+linux-api@lfdr.de>; Tue, 17 Aug 2021 23:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhHQVnE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Aug 2021 17:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHQVnE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Aug 2021 17:43:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DDC061764;
        Tue, 17 Aug 2021 14:42:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso935576pjy.5;
        Tue, 17 Aug 2021 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+H0gXNKH3urURMSdySQgW8qNOqBtUMbrLmE7hYGHoA=;
        b=ItcrMaINrM2S+C3s7hI47qjwnxgeDNYAzzVwQe4s3VQNW600GAMPbzH6WepeccL7+Y
         HbYt0Sr4FCJTIMmlwG8TPBwiukxsEMhvGktbW84uo7HYHX853vqMc1Xx7ay7z8QD/RGa
         rfFZKSeF1IZ8fK+RUFhMUZnD67gIieTcN9poeWMoUSvq05OezWweSEWJyBh5xe8jYErL
         jpsYhoyB0JLnrLJ4Q7SZfLEu3mlIQKkUBW2qP+gOUBlsp26pnYVonkVPPXhd40T4PzTm
         s/rwd4jbliQuwaeQjNSdCZplTa2dR7cfwl/hgY9i5PIiysl6WCEtkir96xfXBtwX3IT5
         eD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+H0gXNKH3urURMSdySQgW8qNOqBtUMbrLmE7hYGHoA=;
        b=RpQub52gs0rVNxhamOa8rUi8uXtFLVCMxsyJ+dGw3Os6z5epKJckaMy+RASQ3bKepJ
         9Q9A3mKMTEN+np8Z7LyIs/QFC+YtNfCQCVAf4YSeqTbPS35PbwPnGFsAj5ogfSIe/pFi
         vwGBvg/GjfbYgKoJ1zrnpIPjpIt7gGtHlXTnBNm0tGWy4p4M5SDi7fdNB04DuzRUQEgo
         AeGjSRo1rnyLUjkrBTBYvbHA5U/bVptJo0pAnNl+XoqtJHbsAlLJoYkvxZTtt1i+ur1n
         3a7Ju8pKhC4pysmrvMBFw1FArcBT9i1qgx2ok9lUiFXOVhy9kPZXSkD0eDaYzMdB5+mI
         KWVA==
X-Gm-Message-State: AOAM531gR4u7DchD0g/CdyXpa1HIWr5DEMRGPhXS+plxK3G9xcvkQu6R
        jWpdjIXg3PqCThsMShlTYJw=
X-Google-Smtp-Source: ABdhPJxIw5oKSYdNhmNUOXRnN1wOg8UQmF0W6l9JJUYULjiosNhFVgGg9Gg1tfs0F7PUe5wlqXcQMg==
X-Received: by 2002:a17:90a:4285:: with SMTP id p5mr5717285pjg.162.1629236549972;
        Tue, 17 Aug 2021 14:42:29 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id q1sm3597256pfs.143.2021.08.17.14.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 14:42:29 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Pankaj Gupta <pankaj.gupta@ionos.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
To:     David Hildenbrand <david@redhat.com>, linux-man@vger.kernel.org
References: <20210816081922.5155-1-david@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <d70ef542-051a-521f-807d-fa469b28e897@gmail.com>
Date:   Tue, 17 Aug 2021 23:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816081922.5155-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello David,

Thank you for writing this! Could you please take
a look at the comments below and revise?

On 8/16/21 10:19 AM, David Hildenbrand wrote:
> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
> 
> Further, commit eb2faa513c24 ("mm/madvise: report SIGBUS as -EFAULT for
> MADV_POPULATE_(READ|WRITE)"), part of v5.14-rc6, made sure that SIGBUS is
> converted to -EFAULT instead of -EINVAL.
> 
> Let's document the behavior and error conditions of these new madvise()
> options.
> 
> Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> Cc: Alejandro Colomar <alx.manpages@gmail.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> - Use semantic newlines in all cases
> - Add two missing "
> - Document -EFAULT handling
> - Rephrase some parts to make it more generic: VM_PFNMAP and VM_IO are only
>   examples for special mappings
> 
> ---
>  man2/madvise.2 | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/man2/madvise.2 b/man2/madvise.2
> index f1f384c0c..f6cea9ad2 100644
> --- a/man2/madvise.2
> +++ b/man2/madvise.2
> @@ -469,6 +469,72 @@ If a page is file-backed and dirty, it will be written back to the backing
>  storage.
>  The advice might be ignored for some pages in the range when it is not
>  applicable.
> +.TP
> +.BR MADV_POPULATE_READ " (since Linux 5.14)"
> +Populate (prefault) page tables readable for the whole range without actually

I have trouble to understand "Populate (prefault) page tables readable".
Does it mean that it is just the page tables are being populated, and the
PTEs are marked to indicate that the pages are readable? If yes, I
think some rewording would help.

> +reading memory.

I don't understand "without actually reading memory"? Do you mean,
"without actually  faulting in the pages"; or something else?

> +Depending on the underlying mapping,
> +map the shared zeropage,
> +preallocate memory or read the underlying file;
> +files with holes might or might not preallocate blocks.
> +Do not generate
> +.B SIGBUS
> +when populating fails,
> +return an error instead.

Better:

[[
If populating fails, a
.B SIGBUS
signal is not generated; instead, an error i returned.
]]

> +.IP
> +If
> +.B MADV_POPULATE_READ
> +succeeds,
> +all page tables have been populated (prefaulted) readable once.
> +If
> +.B MADV_POPULATE_READ
> +fails,
> +some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_READ
> +cannot be applied to mappings without read permissions
> +and special mappings,
> +for example,
> +marked with the kernel-internal

s/marked/mappings marked/

> +.B VM_PFNMAP
> +and

Just checking: should it be "and" or "or" here"?

Looking at the EINVAL error below, I guess "or", and a better 
wording would be:

[[
...for example, mappings marked with kernel-internal flags such as
.B VMPPFNMAP
or
.BR BR_V_IO.
]]

> +.BR VM_IO .
> +.IP
> +Note that with
> +.BR MADV_POPULATE_READ ,
> +the process can be killed at any moment when the system runs out of memory.
> +.TP
> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)"
> +Populate (prefault) page tables writable for the whole range without actually

I have trouble to understand "Populate (prefault) page tables writable".
Does it mean that it is just the page tables are being populated, and the
PTEs are marked to indicate that the pages are writable? If yes, I
think some rewording would help.

> +writing memory.

I don't understand "without actually writing memory"? Do you mean,
"without actually  faulting in the pages"; or something else?

> +Depending on the underlying mapping,
> +preallocate memory or read the underlying file;
> +files with holes will preallocate blocks.
> +Do not generate
> +.B SIGBUS
> +when populating fails,
> +return an error instead.

Better:

[[
If populating fails, a
.B SIGBUS
signal is not generated; instead, an error i returned.
]]

+.IP
> +If
> +.B MADV_POPULATE_WRITE
> +succeeds,
> +all page tables have been populated (prefaulted) writable once.
> +If
> +.B MADV_POPULATE_WRITE
> +fails, some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_WRITE
> +cannot be applied to mappings without write permissions
> +and special mappings,
> +for example,
> +marked with the kernel-internal

s/marked/mappings marked/

> +.B VM_PFNMAP
> +and

Just checking: should it be "and" or "or" here"?

Looking at the EINVAL error below, I guess "or", and a better 
wording would be:

[[
...for example, mappings marked with kernel-internal flags such as
.B VMPPFNMAP
or
.BR BR_V_IO.
]]

> +.BR VM_IO .
> +.IP
> +Note that with
> +.BR MADV_POPULATE_WRITE ,
> +the process can be killed at any moment when the system runs out of memory.
>  .SH RETURN VALUE
>  On success,
>  .BR madvise ()
> @@ -490,6 +556,17 @@ A kernel resource was temporarily unavailable.
>  .B EBADF
>  The map exists, but the area maps something that isn't a file.
>  .TP
> +.B EFAULT
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and populating (prefaulting) page tables failed because a
> +.B SIGBUS
> +would have been generated on actual memory access and the reason is not a
> +HW poisoned page.

Maybe:
s/.$/(see the description of MADV_HWPOISON in this page)./
?

> +.TP
>  .B EINVAL
>  .I addr
>  is not page-aligned or
> @@ -533,6 +610,18 @@ or
>  .BR VM_PFNMAP
>  ranges.
>  .TP
> +.B EINVAL
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +but the specified address range includes ranges with insufficient permissions
> +or incompatible mappings such as
> +.B VM_IO
> +or
> +.BR VM_PFNMAP.

s/.BR VM_PFNMAP./.BR VM_PFNMAP ./

> +.TP
>  .B EIO
>  (for
>  .BR MADV_WILLNEED )
> @@ -548,6 +637,15 @@ Not enough memory: paging in failed.
>  Addresses in the specified range are not currently
>  mapped, or are outside the address space of the process.
>  .TP
> +.B ENOMEM
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and populating (prefaulting) page tables failed because there was not enough
> +memory.
> +.TP
>  .B EPERM
>  .I advice
>  is
> @@ -555,6 +653,15 @@ is
>  but the caller does not have the
>  .B CAP_SYS_ADMIN
>  capability.
> +.TP
> +.B EHWPOISON
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and populating (prefaulting) page tables failed because a HW poisoned page
> +was encountered.
>  .SH VERSIONS
>  Since Linux 3.18,
>  .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

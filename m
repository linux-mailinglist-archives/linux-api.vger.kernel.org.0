Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2C3DA2DD
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhG2MKC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhG2MKB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jul 2021 08:10:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2FC061765;
        Thu, 29 Jul 2021 05:09:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g15so6669389wrd.3;
        Thu, 29 Jul 2021 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vQTKbKS+/LH19uuLNpiiGje2jFblTOyPqwAuffuliDA=;
        b=qeBmZy4bp9GmS6mfdgEVjwkaC/m+fALTtDySt72x1ZNIT/nBFugoJ8892oMXlVLIc+
         joJiSlMlCzgYFQd5DMiM9cOG8njk6MfNia4bwsYHabc3XhZY57z7jD+AOj6tYZYedm2Q
         6eA8oPaYdJlCV4sGGGnU1srECxrpaH6tF1XnSKI8wDAzcLSRuHhBY/QUwIfzWIYD/omm
         vFTT/zx5oI0qXineSC8KU9nd7LR3EqbhrmX5PGOBYcyF3rWU/Gh6xZW26Q34TAjWFN8w
         bGMPN3rKFgadPnmhBTSyK6bGL1qw0oQi4mX2vZJM1Gyl6+2KigLzbQEIwmE78/lWYdXR
         axlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQTKbKS+/LH19uuLNpiiGje2jFblTOyPqwAuffuliDA=;
        b=sERayNgWJKdeJk3+Ch5pJyDD/Eo5qmO5nMUqpGeqrts0Kg/btW0Y4Ch2p6AvHUpwJl
         VgwUt0djbOgzV9nHnYAiCh4hEah7ebcmn0QyETwiQ58T4VbzLZbYtD/wumJx5iNrMyY5
         BlMoodb5bOChflF81weD5oaCgSFyvB8BzTsZY/DXPCJXxFC8VRo+DZBC1VYqhT0MaW8i
         8Y/fNm9pU2TMEDpbsR0HZiFJ3WA3zz487dguiHwNCTAjF6rKC/6z04chtmBZgkKU9qzI
         AJ8FWgmyFhN9r8zA7M4W5EHnt6W/2ocNaAUXUupiHoWlPwgZ1hgpnmWmm0KulA6zDH7x
         pqtg==
X-Gm-Message-State: AOAM532tyllpk4w0BP/UjkTbQb7y69lAzJSuXxjQW22QUTbbL3CwHoak
        7jkg/AbvPuUm8C3oyx8LFa0nk5cqxTA=
X-Google-Smtp-Source: ABdhPJwnUNmNkrWN95kZ2B6Gb6qydeBm6knpM3GsbDmvw45bhZOXojMavgbLX1+XR8M9BleQVTG7NQ==
X-Received: by 2002:adf:e550:: with SMTP id z16mr4741697wrm.250.1627560597074;
        Thu, 29 Jul 2021 05:09:57 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id j1sm3432402wrm.86.2021.07.29.05.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 05:09:56 -0700 (PDT)
Subject: Re: [PATCH] refpage_create.2: Document refpage_create(2)
To:     Peter Collingbourne <pcc@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210717025951.3946505-1-pcc@google.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <d4a138c2-88cc-704b-5bb5-cafe580376aa@gmail.com>
Date:   Thu, 29 Jul 2021 14:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210717025951.3946505-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On 7/17/21 4:59 AM, Peter Collingbourne wrote:
> ---
> The syscall has not landed in the kernel yet.
> Therefore, as usual, the patch should not be taken yet
> and I've used 5.x as the introducing kernel version for now.

Thanks!  Please see a few comments below.
Apart from formatting and code issues I noted,
the text looks good to me.

Please, ping us when this is merged in the kernel :)

Regards,

Alex

> 
>   man2/refpage_create.2 | 167 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 167 insertions(+)
>   create mode 100644 man2/refpage_create.2
> 
> diff --git a/man2/refpage_create.2 b/man2/refpage_create.2
> new file mode 100644
> index 000000000..c0b928b92
> --- /dev/null
> +++ b/man2/refpage_create.2
> @@ -0,0 +1,167 @@
> +.\" Copyright (C) 2021 Google LLC
> +.\" Author: Peter Collingbourne <pcc@google.com>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.TH REFPAGE_CREATE 2 2021-07-16 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +refpage_create \- create a reference page file descriptor
> +.SH SYNOPSIS
> +.nf
> +.BR "#include <unistd.h>"
> +.PP
> +.BI "int syscall(SYS_refpage_create, void *" content ", unsigned int " size ,
> +.BI "            unsigned long " flags ");"
> +.fi
> +.PP
> +.IR Note :
> +glibc provides no wrapper for
> +.BR refpage_create (),
> +necessitating the use of
> +.BR syscall (2).
> +.SH DESCRIPTION
> +The
> +.BR refpage_create ()
> +system call is used to create a file descriptor
> +that conceptually refers to a read-only file
> +whose contents are an infinite repetition of
> +.I size
> +bytes of data read from the
> +.I content
> +argument to the system call,
> +and which may be mapped into memory with
> +.BR mmap (2).
> +The file descriptor is created as if by passing
> +.BR O_RDONLY | O_CLOEXEC
> +to
> +.BR open (2).
> +.PP
> +In reality, any read-only pages in the mapping are backed
> +by a so-called reference page,
> +whose contents are specified using the arguments to
> +.BR refpage_create ().
> +.PP
> +The reference page will consist of repetitions of
> +.I size
> +bytes read
> +from
> +.IR content ,
> +as many as are required to fill the page. The
> +.I size
> +argument must be a power of two less than or equal to the page size, and the
> +.I content
> +argument must have at least
> +.I size
> +alignment. The behavior is as if a copy of this data

s/\. /.\n/

Rationale: semantic newlines.

> +is made while servicing the system call;
> +any updates to the data after the system call has returned
> +will not be reflected in the reference page.
> +.PP
> +If the architecture specifies that // metadata may be associated /J/

Please, use semantic newlines (see man-pages(7))

> +with memory addresses, // that metadata if present is copied
> +into the reference page along with the data itself,
> +but only if the size argument is at least as large
> +as the granularity of the metadata.
> +For example, with the ARMv8.5 Memory Tagging Extension,
> +the memory tags are copied, // but only if the size is greater than /J/
> +or equal to // the architecturally specified tag granule size of 16 bytes.
> +.PP
> +Writable private mappings trigger specific copy-on-write behavior
> +when a page in the mapping is written to.
> +The behavior is as if the reference page is copied,
> +but the kernel may use a more efficient technique such as
> +.BR memset (3)
> +to produce the copy if the
> +.I size
> +argument originally used to create the reference page file descriptor
> +is sufficiently small.
> +For this reason it is recommended to specify as small of a
> +.I size
> +argument as possible
> +in order to activate any such optimizations implemented in the kernel.
> +.PP
> +The advantage of using this system call
> +over creating normal anonymous mappings
> +and manually initializing the pages from userspace
> +is that it is more efficient.
> +If it is not known that all of the pages in the mapping
> +will be faulted (for example, if the system call is used
> +by a general purpose memory allocator
> +where the behavior of the client program is unknown),
> +letting the pages be prepared on fault only if needed
> +is more efficient from both a performance
> +and memory consumption perspective.
> +Even if all of the pages would end up being faulted,
> +it would still be more efficient
> +to have the kernel initialize the pages with the required contents once
> +than to have the kernel zero initialize them on fault
> +and then have userspace initialize them again with different contents.
> +.SH EXAMPLES
> +The following program creates a 128KB memory mapping

The SI mandates that a space shall be inserted between a number and the 
associated unit.

Also, if it really means 128 KiB, which I guess, please use KiB.  See 
units(7).

Use a non-breaking space to make sure that the unit goes with the number.

With all that, it would be:

... creates a 128\ KiB memory ...

> +preinitialized with the pattern byte 0xAA
> +and verifies that the contents of the mapping are correct.
> +.PP
> +.EX
> +#include <linux/unistd.h>
> +#include <stdio.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +int main() {
> +    unsigned char pattern = 0xaa;

Please use capital AA to help visually differentiate x and a.

> +    unsigned long mmap_size = 131072;

Why that magic number?
Maybe a shift to indicate that it's a power of 2...  or 128 * 1024...
I don't know from the top of my head powers of 2 that high :)

Also, why 'unsigned long'?  The SYNOPSIS says it's an 'unsigned int'.

> +
> +    int fd = syscall(SYS_refpage_create, &pattern, 1, 0);

Please use sizeof(pattern) instead of 1 to communicate the relationship 
between them.

> +    if (fd < 0) {
> +        perror("refpage_create");
> +        return 1;

Please use EXIT_FAILURE (<stdlib.h>).  Also use exit(3) instead of 
return, as is common practice in manual pages.

> +    }
> +    unsigned char *p = mmap(0, mmap_size, PROT_READ | PROT_WRITE,

Use NULL instead of 0 for pointers.  The first argument of mmap(2) is 
'void *addr'.

> +                            MAP_PRIVATE, fd, 0);
> +    if (p == MAP_FAILED) {
> +        perror("mmap");
> +        return 1;
> +    }
> +    for (unsigned i = 0; i != mmap_size; ++i) {

s/unsigned/unsigned int/

> +        if (p[i] != pattern) {
> +            fprintf(stderr, "refpage failed contents check @ %u: "
> +                    "0x%x != 0x%x\n",

I prefer 0x%X, which is already in use in some manual pages (seccomp(2)).

Also, 'i' may be more readable in hex, given it's an offset of an 
address (actually the concept of a size_t, even if the kernel doesn't 
use that type) don't you think?

> +                    i, p[i], pattern);
> +            return 1;

exit(3)

> +        }
> +    }
> +}
> +.EE
> +.SH NOTE
> +Reading from a reference page file descriptor, e.g. with
> +.BR read (2),
> +is not supported, nor would this be particularly useful.
> +.SH VERSIONS
> +This system call first appeared in Linux 5.x. > +.SH CONFORMING TO
> +The
> +.BR refpage_create ()
> +system call is Linux-specific.
> +.SH SEE ALSO
> +.BR mmap (2),
> +.BR open (2).
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

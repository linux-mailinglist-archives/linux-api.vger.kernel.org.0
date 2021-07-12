Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFA3C5B48
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhGLLIm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbhGLLIl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 07:08:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB757C0613DD;
        Mon, 12 Jul 2021 04:05:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k11so22100243ioa.5;
        Mon, 12 Jul 2021 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSwNPTsC/8sEkb3/Qbj7s/4olGJXHcNy8GUmiGRD1IQ=;
        b=WKf0HuO/4GM40HCh/sHG15Xu0pOdtA1HZh5RDiSmwm0oRG7nxVQwdk3xvR3PCgcJog
         1JbfKSAGgpKtrI7SgefywgwbSzTvTAxWO4/RmXGcSgpRB56u8W83qzemtZgKa9i43r80
         5R4pQ1qI+WUqngC0jG9L5PcErooNJrk1ZwbAX9AvGuEivhlWfTBXwrwkn3710o4nMVgd
         U4UtbxXMB7orx1jy967uLZILbCzOoslW2WHQ28RFdPnuOGLvezRwj5YcjmoRJ2QHHbny
         ffSPYsbZyWCubj3XSglapNnJX/oXTH/SR1P/pb+EMmskvvr9EMh7KIjPak9vyBYftfo9
         vMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSwNPTsC/8sEkb3/Qbj7s/4olGJXHcNy8GUmiGRD1IQ=;
        b=H9ywTogaQ0ekVB6BmPP5NefNuird/F8KPM2QfR9qnsvnP3DJXaP3RSST7oz9qgzreT
         oF3ff49hwhinHnT4RL7JFttFVD9u4oLPizKIJvDr++lkQCZifPId3TdE62F1HKBZEY6i
         Vb/0WtDf/11XZX9xauSRGHSw/oLhWf4Ay019cuwgLd13ZoDKaM4WUnOP42JHaD4AYOAq
         xTHadpp0DAoAKxYp0OHOfOPx2Ar+BZ0WIpZSHkgkdiAR9IFTRXwub1ACVsbqlzXCuAN+
         YGKljpI9TTL9dCHEXeOfMqyfWFH8fz+9UeblWBc4TloQV/JRX5QBulF6r1LhObjYT1Yl
         KEwA==
X-Gm-Message-State: AOAM531iGv7zxiy/+759BMsDi6NAtL5S9Wa67rQYylJ6Qryb/A5rbfGs
        HzsHovmj5IpL/NWOVP7/U4uY+oHzEAmutog/I4M=
X-Google-Smtp-Source: ABdhPJzCK63GiemQEhRBpAsmSFmG6b3otrlU34e1HcN1uGM+g+ULPaFYe3ny2s3Ikm5W3PjXtEgsQRutTwYU4MisiaU=
X-Received: by 2002:a05:6638:1316:: with SMTP id r22mr44316582jad.89.1626087953168;
 Mon, 12 Jul 2021 04:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210712083917.16361-1-david@redhat.com>
In-Reply-To: <20210712083917.16361-1-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 12 Jul 2021 13:05:42 +0200
Message-ID: <CAM9Jb+hKGCFkTFydUH--bpQaZM7YxaRznfQS4rFS47JtephyYw@mail.gmail.com>
Subject: Re: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and MADV_POPULATE_WRITE
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
>
> Let's document the behavior and error conditions of these new madvise()
> options.
>
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
>  man2/madvise.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/man2/madvise.2 b/man2/madvise.2
> index f1f384c0c..3ec8c53a7 100644
> --- a/man2/madvise.2
> +++ b/man2/madvise.2
> @@ -469,6 +469,59 @@ If a page is file-backed and dirty, it will be written back to the backing
>  storage.
>  The advice might be ignored for some pages in the range when it is not
>  applicable.
> +.TP
> +.BR MADV_POPULATE_READ " (since Linux 5.14)
> +Populate (prefault) page tables readable for the whole range without actually
> +reading. Depending on the underlying mapping, map the shared zeropage,
> +preallocate memory or read the underlying file; files with holes might or
> +might not preallocate blocks.
> +Do not generate
> +.B SIGBUS
> +when populating fails, return an error instead.
> +.IP
> +If
> +.B MADV_POPULATE_READ
> +succeeds, all page tables have been populated (prefaulted) readable once.
> +If
> +.B MADV_POPULATE_READ
> +fails, some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_READ
> +cannot be applied to mappings without read permissions
> +and special mappings marked with the kernel-internal
> +.B VM_PFNMAP
> +and
> +.BR VM_IO .
> +.IP
> +Note that with
> +.BR MADV_POPULATE_READ ,
> +the process can be killed at any moment when the system runs out of memory.
> +.TP
> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)
> +Populate (prefault) page tables writable for the whole range without actually
> +writing. Depending on the underlying mapping, preallocate memory or read the
> +underlying file; files with holes will preallocate blocks.
> +Do not generate
> +.B SIGBUS
> +when populating fails, return an error instead.
> +.IP
> +If
> +.B MADV_POPULATE_WRITE
> +succeeds, all page tables have been populated (prefaulted) writable once.
> +If
> +.B MADV_POPULATE_WRITE
> +fails, some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_WRITE
> +cannot be applied to mappings without write permissions
> +and special mappings marked with the kernel-internal
> +.B VM_PFNMAP
> +and
> +.BR VM_IO .
> +.IP
> +Note that
> +.BR MADV_POPULATE_WRITE ,
> +the process can be killed at any moment when the system runs out of memory.
>  .SH RETURN VALUE
>  On success,
>  .BR madvise ()
> @@ -533,6 +586,17 @@ or
>  .BR VM_PFNMAP
>  ranges.
>  .TP
> +.B EINVAL
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +but the specified address range includes ranges with insufficient permissions,
> +.B VM_IO
> +or
> +.BR VM_PFNMAP.
> +.TP
>  .B EIO
>  (for
>  .BR MADV_WILLNEED )
> @@ -548,6 +612,14 @@ Not enough memory: paging in failed.
>  Addresses in the specified range are not currently
>  mapped, or are outside the address space of the process.
>  .TP
> +.B ENOMEM
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +but populating (prefaulting) page tables failed.
> +.TP
>  .B EPERM
>  .I advice
>  is
> @@ -555,6 +627,14 @@ is
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
> +and a HW poisoned page is encountered.
>  .SH VERSIONS
>  Since Linux 3.18,
>  .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb

From the end user point of view, I find document simple and easy to understand.
Did not went deep into the implementation yet, just skimmed a bit.

Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>

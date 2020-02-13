Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0615BEBF
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBMMzq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 07:55:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43311 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgBMMzq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 07:55:46 -0500
Received: from [95.91.247.236] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2E1q-0008Or-C8; Thu, 13 Feb 2020 12:55:38 +0000
Date:   Thu, 13 Feb 2020 13:55:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Brian Geffon <bgeffon@google.com>, mtk.manpages@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH] mremap.2: Add information for MREMAP_DONTUNMAP.
Message-ID: <20200213125537.n6zqqshtez7kxzlj@wittgenstein>
References: <20200207201856.46070-1-bgeffon@google.com>
 <20200207202124.68949-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207202124.68949-1-bgeffon@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This seems to miss hitting the correct mailing list: 
mtk.manpages@gmail.com
linux-man@vger.kernel.org

Christian

On Fri, Feb 07, 2020 at 12:21:24PM -0800, Brian Geffon wrote:
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  man2/mremap.2 | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/mremap.2 b/man2/mremap.2
> index d73fb64fa..c660a45be 100644
> --- a/man2/mremap.2
> +++ b/man2/mremap.2
> @@ -26,7 +26,8 @@
>  .\" 1996-04-12 Tom Bjorkholm <tomb@mydata.se>
>  .\"            Update for Linux 1.3.87 and later
>  .\" 2005-10-11 mtk: Added NOTES for MREMAP_FIXED; revised EINVAL text.
> -.\"
> +.\" 2020-02-05 Brian Geffon <bgeffon@google.com>
> +.\"            Update for MREMAP_DONTUNMAP.
>  .TH MREMAP 2 2019-03-06 "Linux" "Linux Programmer's Manual"
>  .SH NAME
>  mremap \- remap a virtual memory address
> @@ -129,6 +130,13 @@ If
>  is specified, then
>  .B MREMAP_MAYMOVE
>  must also be specified.
> +.TP
> +.BR MREMAP_DONTUNMAP " (since Linux ?.?)"
> +This flag which must be used in conjuction with
> +.B MREMAP_MAYMOVE
> +remaps a mapping to a new address and it does not unmap the mapping at \fIold_address\fP. This flag can only be used with private anonymous mappings. Any access to the range specified at \fIold_address\fP after completion will result in a page fault. If a
> +.BR userfaultfd (2)
> +was registered on the mapping specified by \fIold_address\fP it will continue to watch that mapping for faults.
>  .PP
>  If the memory segment specified by
>  .I old_address
> @@ -176,6 +184,8 @@ a value other than
>  .B MREMAP_MAYMOVE
>  or
>  .B MREMAP_FIXED
> +or
> +.B MREMAP_DONTUNMAP
>  was specified in
>  .IR flags ;
>  .IP *
> @@ -197,9 +207,14 @@ and
>  .IR old_size ;
>  .IP *
>  .B MREMAP_FIXED
> +or
> +.B MREMAP_DONTUNMAP
>  was specified without also specifying
>  .BR MREMAP_MAYMOVE ;
>  .IP *
> +.B MREMAP_DONTUNMAP
> +was specified with an \fIold_address\fP that was not private anonymous;
> +.IP *
>  \fIold_size\fP was zero and \fIold_address\fP does not refer to a
>  shareable mapping (but see BUGS);
>  .IP *
> @@ -209,10 +224,20 @@ flag was not specified.
>  .RE
>  .TP
>  .B ENOMEM
> +Not enough memory was available to complete the operation.
> +Possible causes are:
> +.RS
> +.IP * 3
>  The memory area cannot be expanded at the current virtual address, and the
>  .B MREMAP_MAYMOVE
>  flag is not set in \fIflags\fP.
>  Or, there is not enough (virtual) memory available.
> +.IP *
> +.B MREMAP_DONTUNMAP
> +was used without
> +.B MREMAP_FIXED
> +causing a new mapping to be created that would exceed the virtual memory available or it would exceed the maximum number of allowed mappings.
> +.RE
>  .SH CONFORMING TO
>  This call is Linux-specific, and should not be used in programs
>  intended to be portable.
> -- 
> 2.25.0.341.g760bfbb309-goog
> 

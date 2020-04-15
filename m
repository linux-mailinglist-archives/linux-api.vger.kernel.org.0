Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090AB1A9365
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbgDOGlG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 02:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgDOGlF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 02:41:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F17C061A0C;
        Tue, 14 Apr 2020 23:41:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so6308418wrs.6;
        Tue, 14 Apr 2020 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U8TwIdyAMHCGD65LcfsNv1dps+LWQzXnmih7ivW+iwI=;
        b=pDd/QED2TjetbLunJPMXoJonJRZrJ9PY4pKrJxtGfFhUQWq2acuHke6HxvRkSjpd9F
         h0rRzz/7dvTAycclwpyau9aCA4yO2DRi+KrIJ7DYl0IaQNStADb56kYbJ8GHzOefaJ/b
         RmFQKM/nbg9//76cwBBBObTY1D7fvGaAl4V++tLkc1tt86whilA/VF2pn6f1HvnX2KKv
         m1DJr1yNHzL+EhEGlwDJNyeNbMAIwBuCj1KrE/m/nVaqu+UqbQd4RNDo4lFw6k0v0pkz
         wFoX8/AoGjbQxkv3oeV/lIoVUsKei7nB6NODKkxVwyowDb2mtT4Ze4YeJZRwOD2uho/M
         MNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U8TwIdyAMHCGD65LcfsNv1dps+LWQzXnmih7ivW+iwI=;
        b=Dt3Udn4DfEZtuD2/0EUXudPy5SBE+0/OHFhYpnzXpGfH4sG1hP24+DqI2+5CNc5Fbk
         oF8MnHH4H6n7ycS0ZHcfIUXrGlafWEYh3X15yOlSdaYEP+j4V98iIxg9JUXMg5ldnAPg
         Rt8bJ9qCpeYhEMLki0ng1OwgZURUNk0f1txYqGM4FeKzxpoS0shuAW4u6ZPCTUlBmYPd
         E7gGQTZH4XXjcX0PHIedn8JOlJJfTzBzebG1xnqsB5o7wjGBHvfDyfFexTjSfgMDyUwt
         2o+Q+NYSheB02Hl33kxrTvK47RmN7IHEg6yYxid/YWKA34OLJ3pp5mXiLfkiZwHL9QBq
         sX9A==
X-Gm-Message-State: AGi0PuZD/jTGCuy1kYc8IfnXeQroXIQt3px9BBRaJ9r1ST3/kaBc9KsD
        HOsRUmJ+PZHnHsx9oylsC6GX9XQl
X-Google-Smtp-Source: APiQypIiSa36qQuryvRFPHZAb38Da+CxzjLHqJcBCMrYhcRW5R4YE/nbUJMgIa7p+dEAhJp+TGQyeQ==
X-Received: by 2002:adf:b1d0:: with SMTP id r16mr6958136wra.312.1586932863432;
        Tue, 14 Apr 2020 23:41:03 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id 91sm8073740wra.37.2020.04.14.23.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 23:41:02 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, "Michael S . Tsirkin" <mst@redhat.com>,
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
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v7] mremap.2: Add information for MREMAP_DONTUNMAP.
To:     Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200221174248.244748-1-bgeffon@google.com>
 <20200221174248.244748-3-bgeffon@google.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b5a4c54d-c358-7b54-c038-c79185330742@gmail.com>
Date:   Wed, 15 Apr 2020 08:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200221174248.244748-3-bgeffon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Brian,

I see that MREMAP_DONTUNMAP has been merged. Thanks for the 
patch below.

In addition to Vlastimil's comments, could you please take a look
at my comments below.

On 2/21/20 6:42 PM, Brian Geffon wrote:
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  man2/mremap.2 | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/mremap.2 b/man2/mremap.2
> index d73fb64fa..54ec67b20 100644
> --- a/man2/mremap.2
> +++ b/man2/mremap.2
> @@ -26,7 +26,8 @@
>  .\" 1996-04-12 Tom Bjorkholm <tomb@mydata.se>
>  .\"            Update for Linux 1.3.87 and later
>  .\" 2005-10-11 mtk: Added NOTES for MREMAP_FIXED; revised EINVAL text.
> -.\"
> +.\" 2020-02-05 Brian Geffon <bgeffon@google.com>
> +.\"            Update for MREMAP_DONTUNMAP.

No need to add this piece. This info is maintained
via the Git log these days.

>  .TH MREMAP 2 2019-03-06 "Linux" "Linux Programmer's Manual"
>  .SH NAME
>  mremap \- remap a virtual memory address
> @@ -129,6 +130,13 @@ If
>  is specified, then
>  .B MREMAP_MAYMOVE
>  must also be specified.
> +.TP
> +.BR MREMAP_DONTUNMAP " (since Linux 5.7)"
> +This flag which must be used in conjuction with

s/conjuction/conjunction/

> +.B MREMAP_MAYMOVE
> +remaps a mapping to a new address and it does not unmap the mapping at \fIold_address\fP. This flag can only be used with private anonymous mappings. Any access to the range specified at \fIold_address\fP after completion will result in a page fault. If a

Please wrap source lines to no more than about 75 columns.
Also, always start new sentences on new lines ("Semantic newlines").

As a general rule, I prefer formatting to be done like this:

.BR old_address .

rather than:

\fIold_address\fP.

(Yes, I know there's plenty of existing text that goes the other
way, but I try to avoid the \fX...\fP style for new text.

Re the "Any access to the range ... will result in a page fault", I think
it would be helpful to be more explicit. I presume that if we
access the range at old_address the mapping is repopulated with 
zero-filled pages, right? It would be good to note that explicitly,

> +.BR userfaultfd (2)
> +was registered on the mapping specified by \fIold_address\fP it will continue to watch that mapping for faults.

(See comments above re wrapping and formatting.)

Perhaps it would be nice to have a short paragraph on use cases?

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
> @@ -197,9 +207,17 @@ and
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
> +.B MREMAP_DONTUNMAP
> +was specified and \fIold_size\fP was not equal to \fInew_size\fP;
> +.IP *
>  \fIold_size\fP was zero and \fIold_address\fP does not refer to a
>  shareable mapping (but see BUGS);
>  .IP *
> @@ -209,10 +227,20 @@ flag was not specified.
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

(See comments above re wrapping.)

> +.RE
>  .SH CONFORMING TO
>  This call is Linux-specific, and should not be used in programs
>  intended to be portable.


Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

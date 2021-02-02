Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138DE30BC4F
	for <lists+linux-api@lfdr.de>; Tue,  2 Feb 2021 11:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBBKqD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Feb 2021 05:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBBKqB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Feb 2021 05:46:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894EC061573;
        Tue,  2 Feb 2021 02:45:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id p15so19848150wrq.8;
        Tue, 02 Feb 2021 02:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cyJs+3SGCj9XR6rS/VsjsM1IE2RFshzJsPr437bOekg=;
        b=R8CCZUhvPLE+ptZxc8GsaJl3TmtQXWE+yVmgMvkuloUSR8roQI2BOFKdoCN1Z3/lBd
         CHJb//Dqnu5oJ8Mg5ryuxRPLl8yF0XgbhVZ/GgFyeUjN2xzvkH1MnMTFC5xEu5n2sqrj
         yApTNm+noDQvdPwKDq/LGeyFQkMefdCjQZ7MAGJLITogCc+A0SUllzCxBWkKBeoSbojG
         3Ml0bCa0n46GOYn2spBVqp5JSup/Tu5ibPzLCuYqT7cie8TR63+ojVYxctSjGrBZWt5D
         g/kFmSNzt8SCTl0DYdrZK27v5RU0rH+kz+yXKtff96mRzwsjNmcEg5H3xnXJY2qdwSPA
         wekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cyJs+3SGCj9XR6rS/VsjsM1IE2RFshzJsPr437bOekg=;
        b=ISFZZCMm3ZqelQ4jvmHEcbR7mid8/pI1QXskYBAKABJsePGQnay9LuAzT44ZHbxYIl
         WHx8YYXZiMyLVHWLIw8irRynkVuXYanABlD77tV9b5EuX2UxJ6RG2eKCw9nsmO3aZlXV
         QzU4/xhkFgvGyRYXGTczYWyTkdpRLZ1dN6MYtxtQnZEBU8K85v5BSoJRTEHeSREbtNLl
         0xnVNADu4yAm4OlElSG91g9yzC+uSkmJvhEbD+rCXYpPAf7A/zxq5DmkTylJPBvuyqaz
         HJ9/jSFFUOzsQTGyrtqqHIAJ2PnI09MMAxYSFSyUc1haj/csK9wTj+78DM2TPG7FCkyr
         dTlg==
X-Gm-Message-State: AOAM5318lgem+lFFb81cgaEW4ALA6ltkp6/gtMuM+7GJaK8WC5i8s15K
        73vhYrmKj+dDlblAEb+f9gk=
X-Google-Smtp-Source: ABdhPJwDwlBcePjdaZRYJS1IF8/IBOZLW5rSrIat6PDunt6i+D5zMu2/LoXBqWkb0y8kvKPjbTwFIw==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr22537227wrz.86.1612262718594;
        Tue, 02 Feb 2021 02:45:18 -0800 (PST)
Received: from ?IPv6:2001:a61:2542:b001:294f:8948:78a8:d929? ([2001:a61:2542:b001:294f:8948:78a8:d929])
        by smtp.gmail.com with ESMTPSA id b3sm2647400wme.32.2021.02.02.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 02:45:17 -0800 (PST)
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        jannh@google.com, keescook@chromium.org, jeffv@google.com,
        minchan@kernel.org, mhocko@suse.com, shakeelb@google.com,
        rientjes@google.com, edgararriaga@google.com, timmurray@google.com,
        linux-mm@kvack.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] process_madvise.2: Add process_madvise man page
To:     Suren Baghdasaryan <surenb@google.com>, linux-man@vger.kernel.org
References: <20210202053046.1653012-1-surenb@google.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <079db245-a08c-0dbd-01d4-8065f533652e@gmail.com>
Date:   Tue, 2 Feb 2021 11:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202053046.1653012-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Suren (and Minchan and Michal)

Thank you for the revisions!

I've applied this patch, and done a few light edits.

However, I have a questions about undocumented pieces in *madvise(2)*,
as well as one other question. See below. 

On 2/2/21 6:30 AM, Suren Baghdasaryan wrote:
> Initial version of process_madvise(2) manual page. Initial text was
> extracted from [1], amended after fix [2] and more details added using
> man pages of madvise(2) and process_vm_read(2) as examples. It also
> includes the changes to required permission proposed in [3].
> 
> [1] https://lore.kernel.org/patchwork/patch/1297933/
> [2] https://lkml.org/lkml/2020/12/8/1282
> [3] https://patchwork.kernel.org/project/selinux/patch/20210111170622.2613577-1-surenb@google.com/#23888311
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Michal Hocko <mhocko@suse.com>
> ---
> changes in v2:
> - Changed description of MADV_COLD per Michal Hocko's suggestion
> - Applied fixes suggested by Michael Kerrisk
> changes in v3:
> - Added Michal's Reviewed-by
> - Applied additional fixes suggested by Michael Kerrisk
> 
> NAME
>     process_madvise - give advice about use of memory to a process
> 
> SYNOPSIS
>     #include <sys/uio.h>
> 
>     ssize_t process_madvise(int pidfd,
>                            const struct iovec *iovec,
>                            unsigned long vlen,
>                            int advice,
>                            unsigned int flags);
> 
> DESCRIPTION
>     The process_madvise() system call is used to give advice or directions
>     to the kernel about the address ranges of another process or the calling
>     process. It provides the advice to the address ranges described by iovec
>     and vlen. The goal of such advice is to improve system or application
>     performance.
> 
>     The pidfd argument is a PID file descriptor (see pidfd_open(2)) that
>     specifies the process to which the advice is to be applied.
> 
>     The pointer iovec points to an array of iovec structures, defined in
>     <sys/uio.h> as:
> 
>     struct iovec {
>         void  *iov_base;    /* Starting address */
>         size_t iov_len;     /* Number of bytes to transfer */
>     };
> 
>     The iovec structure describes address ranges beginning at iov_base address
>     and with the size of iov_len bytes.
> 
>     The vlen represents the number of elements in the iovec structure.
> 
>     The advice argument is one of the values listed below.
> 
>   Linux-specific advice values
>     The following Linux-specific advice values have no counterparts in the
>     POSIX-specified posix_madvise(3), and may or may not have counterparts
>     in the madvise(2) interface available on other implementations.
> 
>     MADV_COLD (since Linux 5.4.1)

I just noticed these version numbers now, and thought: they can't be
right (because the system call appeared only in v5.11). So I removed 
them. But, of course in another sense the version numbers are (nearly)
right, since these advice values were added for madvise(2) in Linux 5.4.
However, they are not documented in the madvise(2) manual page. Is it
correct to assume that MADV_COLD and MADV_PAGEOUT have exactly the same
meaning in madvise(2) (but just for the calling process, of course)?

>         Deactive a given range of pages which will make them a more probable

I changed: s/Deactive/Deactivate/

>         reclaim target should there be a memory pressure. This is a
>         nondestructive operation. The advice might be ignored for some pages
>         in the range when it is not applicable.
> 
>     MADV_PAGEOUT (since Linux 5.4.1)
>         Reclaim a given range of pages. This is done to free up memory occupied
>         by these pages. If a page is anonymous it will be swapped out. If a
>         page is file-backed and dirty it will be written back to the backing
>         storage. The advice might be ignored for some pages in the range when
>         it is not applicable.

[...]

>     The hint might be applied to a part of iovec if one of its elements points
>     to an invalid memory region in the remote process. No further elements will
>     be processed beyond that point.

Is the above scenario the one that leads to the partial advice case described in
RETURN VALUE? If yes, perhaps I should add some words to make that clearer.

You can see the light edits that I made in
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=e3ce016472a1b3ec5dffdeb23c98b9fef618a97b
and following that I restructured DESCRIPTION a little in
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3aac0708a9acee5283e091461de6a8410bc921a6

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE6631AE3D
	for <lists+linux-api@lfdr.de>; Sat, 13 Feb 2021 23:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMWFJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 13 Feb 2021 17:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMWFI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 13 Feb 2021 17:05:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB41C061574;
        Sat, 13 Feb 2021 14:04:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n8so4149504wrm.10;
        Sat, 13 Feb 2021 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QdWTAJ+beg12quntIhZalfc07GrzP+2YyUm2HopaRE=;
        b=SDV1e/8p0mhz8BYGtaU8iXpVNnzGc/lsF99FH6PlV6Frz34BSC/wr9tOlTwd5C3qKN
         JpRnsYIYL1Y0dZLvlX078YM39xoN9Zp9XL+23x8RfR0tB2LrlPgEnUncmxTDqM59VTQA
         kmBF8JAxAXOGfDFGE9DLJ/fLJQdVFU6kyWA+Sk/WLWIuNal/oijtFn/7nI9ZAbD2qO8K
         f9a5muDX+ywFF9T/Paz2QiKGuVCRuIcEVB+1/kZEhJyKA5ua4EJtAJ+0Qv0RiaKZ4Ko0
         zq6al7Wa/ITyzyz3bDJcRhEbBgCy326AtHgR5u4snp9eCx1/cmImE4iHi8ovwUkNPsNC
         GGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8QdWTAJ+beg12quntIhZalfc07GrzP+2YyUm2HopaRE=;
        b=QSuAnJbFDXUAt1jt6Ktl5azWCKO+AfJZpkBH++pfoKEBbFpnWNnxNy8/NBZ8qaEd7b
         Xs8x7K5vAlT8Un9a9Hp0UzHWsCzFJl3gcQ1lLT+Qy1sAb+2byEsYB9OnWrujjf0fjjdG
         5Bqf0waLF61zaofnow/spxTYR5EDmWCr38YtWY4Yo/CjRxd7PwZPxrq0J/ww/kMQiKkk
         rfv7mCvgo0GQuwmKMw/d1JuHAI2e+2NvVpYGxKpHaGR1y739yQnusggcDATI9W5JSPZL
         MlyEIv3A9Mor8t2vj0rOuG4uC3RCya+aatoAvxKffLiHFEciiKQOa+pbFyZM9JKQ7Nhe
         /ygw==
X-Gm-Message-State: AOAM531BabjrgApEVWi66QGo7Fe+IJYBQzUECnc3w9fDOIZcXtVSUFsn
        e5vPygFw5PcsNw3ErwkJfB7Oxgx0IRyu5A==
X-Google-Smtp-Source: ABdhPJyK3AQIsJbi2V5mWgsIJwWnJfg9UssexqDTKfiEhKzTFbke9lDM1hFwoWdxJRbg6g+V5Or4sA==
X-Received: by 2002:adf:ef86:: with SMTP id d6mr6449258wro.419.1613253867076;
        Sat, 13 Feb 2021 14:04:27 -0800 (PST)
Received: from ?IPv6:2001:a61:3a2d:1d01:99ab:4f20:ed7f:402b? ([2001:a61:3a2d:1d01:99ab:4f20:ed7f:402b])
        by smtp.gmail.com with ESMTPSA id o18sm17971832wmp.19.2021.02.13.14.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 14:04:26 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=c3=ada?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v3 1/1] process_madvise.2: Add process_madvise man page
To:     Suren Baghdasaryan <surenb@google.com>
References: <20210202053046.1653012-1-surenb@google.com>
 <079db245-a08c-0dbd-01d4-8065f533652e@gmail.com>
 <CAJuCfpGotx_04Stn5Nw6Au+TVG9LuAJ=CB_s7uxjMLOLerw-GA@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <2d303517-cdcd-9ec8-e57d-3d065edb573c@gmail.com>
Date:   Sat, 13 Feb 2021 23:04:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpGotx_04Stn5Nw6Au+TVG9LuAJ=CB_s7uxjMLOLerw-GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Suren,

On 2/2/21 11:12 PM, Suren Baghdasaryan wrote:
> Hi Michael,
> 
> On Tue, Feb 2, 2021 at 2:45 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Hello Suren (and Minchan and Michal)
>>
>> Thank you for the revisions!
>>
>> I've applied this patch, and done a few light edits.
> 
> Thanks!
> 
>>
>> However, I have a questions about undocumented pieces in *madvise(2)*,
>> as well as one other question. See below.
>>
>> On 2/2/21 6:30 AM, Suren Baghdasaryan wrote:
>>> Initial version of process_madvise(2) manual page. Initial text was
>>> extracted from [1], amended after fix [2] and more details added using
>>> man pages of madvise(2) and process_vm_read(2) as examples. It also
>>> includes the changes to required permission proposed in [3].
>>>
>>> [1] https://lore.kernel.org/patchwork/patch/1297933/
>>> [2] https://lkml.org/lkml/2020/12/8/1282
>>> [3] https://patchwork.kernel.org/project/selinux/patch/20210111170622.2613577-1-surenb@google.com/#23888311
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> Reviewed-by: Michal Hocko <mhocko@suse.com>
>>> ---
>>> changes in v2:
>>> - Changed description of MADV_COLD per Michal Hocko's suggestion
>>> - Applied fixes suggested by Michael Kerrisk
>>> changes in v3:
>>> - Added Michal's Reviewed-by
>>> - Applied additional fixes suggested by Michael Kerrisk
>>>
>>> NAME
>>>     process_madvise - give advice about use of memory to a process
>>>
>>> SYNOPSIS
>>>     #include <sys/uio.h>
>>>
>>>     ssize_t process_madvise(int pidfd,
>>>                            const struct iovec *iovec,
>>>                            unsigned long vlen,
>>>                            int advice,
>>>                            unsigned int flags);
>>>
>>> DESCRIPTION
>>>     The process_madvise() system call is used to give advice or directions
>>>     to the kernel about the address ranges of another process or the calling
>>>     process. It provides the advice to the address ranges described by iovec
>>>     and vlen. The goal of such advice is to improve system or application
>>>     performance.
>>>
>>>     The pidfd argument is a PID file descriptor (see pidfd_open(2)) that
>>>     specifies the process to which the advice is to be applied.
>>>
>>>     The pointer iovec points to an array of iovec structures, defined in
>>>     <sys/uio.h> as:
>>>
>>>     struct iovec {
>>>         void  *iov_base;    /* Starting address */
>>>         size_t iov_len;     /* Number of bytes to transfer */
>>>     };
>>>
>>>     The iovec structure describes address ranges beginning at iov_base address
>>>     and with the size of iov_len bytes.
>>>
>>>     The vlen represents the number of elements in the iovec structure.
>>>
>>>     The advice argument is one of the values listed below.
>>>
>>>   Linux-specific advice values
>>>     The following Linux-specific advice values have no counterparts in the
>>>     POSIX-specified posix_madvise(3), and may or may not have counterparts
>>>     in the madvise(2) interface available on other implementations.
>>>
>>>     MADV_COLD (since Linux 5.4.1)
>>
>> I just noticed these version numbers now, and thought: they can't be
>> right (because the system call appeared only in v5.11). So I removed
>> them. But, of course in another sense the version numbers are (nearly)
>> right, since these advice values were added for madvise(2) in Linux 5.4.
>> However, they are not documented in the madvise(2) manual page. Is it
>> correct to assume that MADV_COLD and MADV_PAGEOUT have exactly the same
>> meaning in madvise(2) (but just for the calling process, of course)?
> 
> Correct. They should be added in the madvise(2) man page as well IMHO.

So, I decided to move the description of MADV_COLD and MADV_PAGEOUT
to madvise(2) and refer to that page from the process_madvise(2)
page. This avoids repeating the same information in two places.

>>>         Deactive a given range of pages which will make them a more probable
>>
>> I changed: s/Deactive/Deactivate/
> 
> thanks!
> 
>>
>>>         reclaim target should there be a memory pressure. This is a
>>>         nondestructive operation. The advice might be ignored for some pages
>>>         in the range when it is not applicable.
>>>
>>>     MADV_PAGEOUT (since Linux 5.4.1)
>>>         Reclaim a given range of pages. This is done to free up memory occupied
>>>         by these pages. If a page is anonymous it will be swapped out. If a
>>>         page is file-backed and dirty it will be written back to the backing
>>>         storage. The advice might be ignored for some pages in the range when
>>>         it is not applicable.
>>
>> [...]
>>
>>>     The hint might be applied to a part of iovec if one of its elements points
>>>     to an invalid memory region in the remote process. No further elements will
>>>     be processed beyond that point.
>>
>> Is the above scenario the one that leads to the partial advice case described in
>> RETURN VALUE? If yes, perhaps I should add some words to make that clearer.
> 
> Correct. This describes the case when partial advice happens.

Thanks. I added a few words to clarify this.


>> You can see the light edits that I made in
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=e3ce016472a1b3ec5dffdeb23c98b9fef618a97b
>> and following that I restructured DESCRIPTION a little in
>> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3aac0708a9acee5283e091461de6a8410bc921a6
> 
> The edits LGTM.

Thanks for checking them.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

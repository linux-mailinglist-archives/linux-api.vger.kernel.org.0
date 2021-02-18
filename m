Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF531E729
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 09:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBRH6L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 02:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhBRH4R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Feb 2021 02:56:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20656C061574;
        Wed, 17 Feb 2021 23:55:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m1so2109288wml.2;
        Wed, 17 Feb 2021 23:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VuOr5IRYyD3SOn+5chtalvwQdWPMiTxF9JpEV7axuU=;
        b=DiTZz/4gmJZPeTC5pv54B/6ep6c4fIy5ngNCoDUIRkkmLho2VvinhJ1mkzcRljbaKw
         4CJD0yTXHFFSnmhiyBYE4ydfNjhRNJHQ7mYNnqhSS4DeCt4/9PaUd6u48IsL5Qz6nf6p
         oMrgW9xB+Beq4LiN/xmy0zmV9bThfFonj9oyYnhz1l3I6zmyitlpj6ICdRhN45uMJceG
         ZvyAVZh9LRLDdbBcH3Bxtk0I3pVm76joUGkkd+A/fglhVxxMtSX5FgisfOVSdQEfXn3Z
         KOySjv69SsVPdtmtkvy1STkomL3q3xgkqmu9JXTlujoSfZLAH7l9BUcwEH7mjpWdIHVS
         LN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VuOr5IRYyD3SOn+5chtalvwQdWPMiTxF9JpEV7axuU=;
        b=UarYHgzkbK38jENeWSluZ3kIAxrrobOl+LDH24zCUg3bVhAqrUnFIduMI0AExeik2j
         46b8X0nXkC+RBFpbGIlf0YJaI1yu9EcJzVWpLlSo1S0qzTeDWmqk7T9ljgCJSmnGjPMe
         CzoIVVoB8rkbqx0oi4IOgHbA62VIhIDDq/RKNjOtb1LucO1Q3OaNPuK3+wiUdSwZ3jd4
         R0+HIzsQnZgXdW2rXwcuMJQJ1OWn9ytHSvjgbHU8H2dPMIc1cV5bmlElAoVzoSP2ZE1V
         PEoQxOy9HT9wolB2g4eX2rgQLvHGFm6XBboCEE3n7gzNMfCZP0Yl4M8EyCGIROPAID9y
         OrDA==
X-Gm-Message-State: AOAM533VdgLyAZINtcNTJJcIougqIGnWf/Gbiesh9zOxObpsqZKgHJt6
        /Xa0XC+Z6Unt6dDDYXK1epY=
X-Google-Smtp-Source: ABdhPJzB2TIsvhv0bBBak6Op7cXkJ1RH2wz0nb5/aO3RSIANbztDN+kcjVRGxzqpkXPSK0o0IJh9YA==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr2443813wmk.116.1613634935639;
        Wed, 17 Feb 2021 23:55:35 -0800 (PST)
Received: from ?IPv6:2001:a61:3a2d:1d01:99ab:4f20:ed7f:402b? ([2001:a61:3a2d:1d01:99ab:4f20:ed7f:402b])
        by smtp.gmail.com with ESMTPSA id t9sm7401393wrw.76.2021.02.17.23.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 23:55:35 -0800 (PST)
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
 <2d303517-cdcd-9ec8-e57d-3d065edb573c@gmail.com>
 <CAJuCfpFC0B=jXFEuPYYBZAjgx1B6S8vG-i7_0iBc_RHeWynyzw@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7fb20d93-92d0-14b3-f7f9-8b9af4ebb584@gmail.com>
Date:   Thu, 18 Feb 2021 08:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpFC0B=jXFEuPYYBZAjgx1B6S8vG-i7_0iBc_RHeWynyzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Suren,

>> Thanks. I added a few words to clarify this.>
> Any link where I can see the final version?

Sure:
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/process_madvise.2

Also rendered below.

Thanks,

Michael

NAME
       process_madvise - give advice about use of memory to a process

SYNOPSIS
       #include <sys/uio.h>

       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
                               size_t vlen, int advice,
                               unsigned int flags);

       Note: There is no glibc wrapper for this system call; see NOTES.

DESCRIPTION
       The process_madvise() system call is used to give advice or direc‐
       tions to the kernel about the address ranges of another process or
       of  the  calling  process.  It provides the advice for the address
       ranges described by iovec and vlen.  The goal of such advice is to
       improve system or application performance.

       The  pidfd  argument  is a PID file descriptor (see pidfd_open(2))
       that specifies the process to which the advice is to be applied.

       The pointer iovec points to an array of iovec structures,  defined
       in <sys/uio.h> as:

           struct iovec {
               void  *iov_base;    /* Starting address */
               size_t iov_len;     /* Length of region */
           };

       The iovec structure describes address ranges beginning at iov_base
       address and with the size of iov_len bytes.

       The vlen specifies the number of elements in the iovec  structure.
       This value must be less than or equal to IOV_MAX (defined in <lim‐
       its.h> or accessible via the call sysconf(_SC_IOV_MAX)).

       The advice argument is one of the following values:

       MADV_COLD
              See madvise(2).

       MADV_PAGEOUT
              See madvise(2).

       The flags argument is reserved for future use; currently, this ar‐
       gument must be specified as 0.

       The  vlen  and iovec arguments are checked before applying any ad‐
       vice.  If vlen is too big, or iovec is invalid, then an error will
       be returned immediately and no advice will be applied.

       The  advice might be applied to only a part of iovec if one of its
       elements points to an invalid memory region in the remote process.
       No further elements will be processed beyond that point.  (See the
       discussion regarding partial advice in RETURN VALUE.)

       Permission to apply advice to another process  is  governed  by  a
       ptrace   access   mode   PTRACE_MODE_READ_REALCREDS   check   (see
       ptrace(2)); in addition, because of the  performance  implications
       of applying the advice, the caller must have the CAP_SYS_ADMIN ca‐
       pability.

RETURN VALUE
       On success, process_madvise() returns the number of bytes advised.
       This  return  value may be less than the total number of requested
       bytes, if an error occurred after some iovec elements were already
       processed.   The caller should check the return value to determine
       whether a partial advice occurred.

       On error, -1 is returned and errno is set to indicate the error.

ERRORS
       EBADF  pidfd is not a valid PID file descriptor.

       EFAULT The memory described by iovec is outside the accessible ad‐
              dress space of the process referred to by pidfd.

       EINVAL flags is not 0.

       EINVAL The  sum of the iov_len values of iovec overflows a ssize_t
              value.

       EINVAL vlen is too large.

       ENOMEM Could not allocate memory for internal copies of the  iovec
              structures.

       EPERM  The  caller  does not have permission to access the address
              space of the process pidfd.

       ESRCH  The target process does not exist (i.e., it has  terminated
              and been waited on).

VERSIONS
       This  system  call first appeared in Linux 5.10.  Support for this
       system call is optional, depending on  the  setting  of  the  CON‐
       FIG_ADVISE_SYSCALLS configuration option.

CONFORMING TO
       The process_madvise() system call is Linux-specific.

NOTES
       Glibc does not provide a wrapper for this system call; call it us‐
       ing syscall(2).

SEE ALSO
       madvise(2),          pidfd_open(2),           process_vm_readv(2),
       process_vm_write(2)


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

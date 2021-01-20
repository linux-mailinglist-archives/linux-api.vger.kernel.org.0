Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C132FD0AC
	for <lists+linux-api@lfdr.de>; Wed, 20 Jan 2021 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbhATMsu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Jan 2021 07:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388024AbhATLmm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Jan 2021 06:42:42 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C3C061575;
        Wed, 20 Jan 2021 03:42:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id a109so23113653otc.1;
        Wed, 20 Jan 2021 03:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=aeRTXvtNxwVABREsHjTYkGSFjdbU4S5fTot1w30c9XQ=;
        b=IgLEjGUAxhX8ynP0t6nmh32bIgxpRpiLYKbWMU7s1t6AyUw8R5S9dk2Oz8OBkvtvub
         G5ghTO1Hf9wEgbnz59uI838G4gsbCWnGR4QXA1MN/klX6qx+KW6KjYFWfidufDlaCjjA
         QZQZM6qxgVifGaXA4OOrlGxqf9HGOiZaGyTWungo2VaueOjB30VBxAOtyE71ckOVk0eI
         LbjwlH31j5b2l4CRrV1J8qxM1sP/zAckjgw2kbvh/A/hPQ9rstqbIQiGoLR/aJvzCQXk
         6pApZ9UOiPOOh/yydb+eBUwO2AiFtHJZ3lFZA0pGx80FFO2LOK6SNgxYZRQnP/WUwdFu
         7eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=aeRTXvtNxwVABREsHjTYkGSFjdbU4S5fTot1w30c9XQ=;
        b=b17Opkg8FKxtcZ3cFJsEZ5fmLd551ITDD2FY9lYTYsDF4cmboJqih42JbxcTbK1eOO
         C6Hwp6Fi3uBobcBb2k+u10aTEOKmiBL5l/JQJWTreAPCAVYyYvWC3KuQYKce/HYV8EV/
         lQW5wzwrG88859F8p29eumo7NnMLB3G3kdlNL8PKXlbNuluZIckQpznK8zKl2tmWTtCh
         0anFjnkwlnnZ16H3rzxmoYjzkA5OPuldayASMLYs1O8QccEfsbQJm5F7axncOv2aGNnC
         XiM/TrTBW4k7e90fPyYASvKIUYQW57R/crcdYszjaVqU90bSCndcZJIOjF8EBBx1K+D1
         nsbw==
X-Gm-Message-State: AOAM531I7CzZ/k4KBXILoZwjqSessKRp467GLNWqOox2QiGQ0ft0ofvz
        tY3T3WHl/rj5TDlrlWvVvxc6ieWp0Ethw1H2L+4=
X-Google-Smtp-Source: ABdhPJyXwItn3U9e67/BlrhaibOqvsmd2FY4ADrgMTsVdeTfEtWp6oL3Hp1VMnWm1USsTKiVy049cr6fUnPgzD6LmfA=
X-Received: by 2002:a9d:7753:: with SMTP id t19mr827992otl.114.1611142921845;
 Wed, 20 Jan 2021 03:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20210101235529.1563262-1-krisman@collabora.com>
In-Reply-To: <20210101235529.1563262-1-krisman@collabora.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 20 Jan 2021 12:41:50 +0100
Message-ID: <CAKgNAkixpPz4uiv56zEQ5U0zW1E0S3LnWXpJ6ucrgYaE10CSKQ@mail.gmail.com>
Subject: Re: [PATCH] entry: Use different define for selector variable in SUD
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello all,

On Sat, 2 Jan 2021 at 00:55, Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Michael Kerrisk suggested that, from an API perspective, it is a bad
> idea to share the PR_SYS_DISPATCH_ defines between the prctl operation
> and the selector variable.  Therefore, define two new constants to be
> used by SUD's selector variable, and the corresponding documentation.
>
> While this changes the API, it is backward compatible, as the values
> remained the same and the old defines are still in place.  In addition,
> SUD has never been part of a Linux release, it will show up for the
> first time in 5.11.

Would it be possible to get this patch applied before 5.11 is released please?

To add some background, while reviewing a patch that Gabriel wrote to
to document this feature, I encountered a confusion that I'm sure many
others would encounter also. My initial comments were

[[
The value of arg2 can be either PR_SYS_DISPATCH_ON or
PR_SYS_DISPATCH_OFF. The value of the selector pointed to by
arg5 can likewise be R_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.
What is the relationship between these two attributes? For example,
what does it mean if arg2 is P R_SYS_DISPATCH_ON and, at the time of
the prctl() call, the selector has the value PR_SYS_DISPATCH_OFF?
]]

The issue is that the same names are being used in two parts of the
API with *different* meanings:

1. Define/clear SUD/the non-SUD memory region
2. Enable/disable SUD filtering in the SUD memory region (i.e., the
part of the virtual address space outside the region defined in 1).

In API design terms this feels wrong and is confusing. The numeric
values don't need to change (so there are no ABI changes implied, and
anyway this is a new feature in 5.11), but different names should be
used in the two parts of the API, as is fixed in this patch by
Gabriel.

Acked-my: Michael Kerrisk <mtk.manpages@gmail.com>

Cheers,

Michael



> Cc: Linux API <linux-api@vger.kernel.org>
> Suggested-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../admin-guide/syscall-user-dispatch.rst          |  4 ++--
>  include/uapi/linux/prctl.h                         |  2 ++
>  kernel/entry/syscall_user_dispatch.c               |  4 ++--
>  .../syscall_user_dispatch/sud_benchmark.c          |  8 +++++---
>  .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++------
>  5 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
> index a380d6515774..fc13112e36e3 100644
> --- a/Documentation/admin-guide/syscall-user-dispatch.rst
> +++ b/Documentation/admin-guide/syscall-user-dispatch.rst
> @@ -70,8 +70,8 @@ trampoline code on the vDSO, that trampoline is never intercepted.
>  [selector] is a pointer to a char-sized region in the process memory
>  region, that provides a quick way to enable disable syscall redirection
>  thread-wide, without the need to invoke the kernel directly.  selector
> -can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
> -value should terminate the program with a SIGSYS.
> +can be set to PR_SYS_DISPATCH_FILTER_ALLOW or PR_SYS_DISPATCH_FILTER_BLOCK.
> +Any other value should terminate the program with a SIGSYS.
>
>  Security Notes
>  --------------
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 90deb41c8a34..a66c9fe41249 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -251,5 +251,7 @@ struct prctl_mm_map {
>  #define PR_SET_SYSCALL_USER_DISPATCH   59
>  # define PR_SYS_DISPATCH_OFF           0
>  # define PR_SYS_DISPATCH_ON            1
> +# define PR_SYS_DISPATCH_FILTER_ALLOW  0
> +# define PR_SYS_DISPATCH_FILTER_BLOCK  1
>
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index b0338a5625d9..265c33b26dcf 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -50,10 +50,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>                 if (unlikely(__get_user(state, sd->selector)))
>                         do_exit(SIGSEGV);
>
> -               if (likely(state == PR_SYS_DISPATCH_OFF))
> +               if (likely(state == PR_SYS_DISPATCH_FILTER_ALLOW))
>                         return false;
>
> -               if (state != PR_SYS_DISPATCH_ON)
> +               if (state != PR_SYS_DISPATCH_FILTER_BLOCK)
>                         do_exit(SIGSYS);
>         }
>
> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
> index 6689f1183dbf..7617bd9ba6e1 100644
> --- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
> @@ -22,6 +22,8 @@
>  # define PR_SET_SYSCALL_USER_DISPATCH  59
>  # define PR_SYS_DISPATCH_OFF   0
>  # define PR_SYS_DISPATCH_ON    1
> +# define PR_SYS_DISPATCH_FILTER_ALLOW  0
> +# define PR_SYS_DISPATCH_FILTER_BLOCK  1
>  #endif
>
>  #ifdef __NR_syscalls
> @@ -55,8 +57,8 @@ unsigned long trapped_call_count = 0;
>  unsigned long native_call_count = 0;
>
>  char selector;
> -#define SYSCALL_BLOCK   (selector = PR_SYS_DISPATCH_ON)
> -#define SYSCALL_UNBLOCK (selector = PR_SYS_DISPATCH_OFF)
> +#define SYSCALL_BLOCK   (selector = PR_SYS_DISPATCH_FILTER_BLOCK)
> +#define SYSCALL_UNBLOCK (selector = PR_SYS_DISPATCH_FILTER_ALLOW)
>
>  #define CALIBRATION_STEP 100000
>  #define CALIBRATE_TO_SECS 5
> @@ -170,7 +172,7 @@ int main(void)
>         syscall(MAGIC_SYSCALL_1);
>
>  #ifdef TEST_BLOCKED_RETURN
> -       if (selector == PR_SYS_DISPATCH_OFF) {
> +       if (selector == PR_SYS_DISPATCH_FILTER_ALLOW) {
>                 fprintf(stderr, "Failed to return with selector blocked.\n");
>                 exit(-1);
>         }
> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> index 6498b050ef89..21e1550db118 100644
> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> @@ -18,6 +18,8 @@
>  # define PR_SET_SYSCALL_USER_DISPATCH  59
>  # define PR_SYS_DISPATCH_OFF   0
>  # define PR_SYS_DISPATCH_ON    1
> +# define PR_SYS_DISPATCH_FILTER_ALLOW  0
> +# define PR_SYS_DISPATCH_FILTER_BLOCK  1
>  #endif
>
>  #ifndef SYS_USER_DISPATCH
> @@ -30,8 +32,8 @@
>  # define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
>  #endif
>
> -#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
> -#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
> +#define SYSCALL_DISPATCH_ON(x) ((x) = PR_SYS_DISPATCH_FILTER_BLOCK)
> +#define SYSCALL_DISPATCH_OFF(x) ((x) = PR_SYS_DISPATCH_FILTER_ALLOW)
>
>  /* Test Summary:
>   *
> @@ -56,7 +58,7 @@
>
>  TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
>  {
> -       char sel = 0;
> +       char sel = PR_SYS_DISPATCH_FILTER_ALLOW;
>         struct sysinfo info;
>         int ret;
>
> @@ -79,7 +81,7 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
>
>  TEST(bad_prctl_param)
>  {
> -       char sel = 0;
> +       char sel = PR_SYS_DISPATCH_FILTER_ALLOW;
>         int op;
>
>         /* Invalid op */
> @@ -220,7 +222,7 @@ TEST_SIGNAL(bad_selector, SIGSYS)
>         sigset_t mask;
>         struct sysinfo info;
>
> -       glob_sel = 0;
> +       glob_sel = PR_SYS_DISPATCH_FILTER_ALLOW;
>         nr_syscalls_emulated = 0;
>         si_code = 0;
>         si_errno = 0;
> @@ -288,7 +290,7 @@ TEST(direct_dispatch_range)
>  {
>         int ret = 0;
>         struct sysinfo info;
> -       char sel = 0;
> +       char sel = PR_SYS_DISPATCH_FILTER_ALLOW;
>
>         /*
>          * Instead of calculating libc addresses; allow the entire
> --
> 2.29.2
>


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF30F37477A
	for <lists+linux-api@lfdr.de>; Wed,  5 May 2021 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhEER5Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 May 2021 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhEER5J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 May 2021 13:57:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72333C025389
        for <linux-api@vger.kernel.org>; Wed,  5 May 2021 10:27:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso2395037otv.6
        for <linux-api@vger.kernel.org>; Wed, 05 May 2021 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpXkesvqHOL8k54CBCo40z1c8NG5SDEJNQ8hz6LZPW8=;
        b=vI0evSyV7t9DWQjtznpLUR2rImOSJyA5xmP6QnZKJnXJGSMySPLjcPkM2OaFJz/xdz
         BkAr4ISlfXkLOfwaRCoDGAf+xbbMkc0LIzfErF/sL449OtqyPtZCwtyx+8cVwEYtFI4d
         h3sCat0O20mfUmzxf/1TaBHng6DBsc0mqwMnbERKdaLqdQp4Hqw7XmZ+qBZqBtF1hZqM
         rmjynPusGQJMemZNWc0scoA9lVuUxhXGLTz3qRTayl5LZhFeLD7lBum0WZLBNmG2DR1k
         4mflGXgb1Z5WNvQR18blkwwFmmrI0tFc6qvXiT6nhFPfpvdTTQcoS3IQg6d5nS1+BqOS
         AhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpXkesvqHOL8k54CBCo40z1c8NG5SDEJNQ8hz6LZPW8=;
        b=unsJQO8WxfVRK+P0g90Vvr1Y4AMm3o699WkINUlPfKkz8YeZ711c12EjRj9kyN4dVL
         xXcZTNML5DRc7gB8RePZ197SONJMFuzauZbGFMkfH34HAyBgBct6vYO2FiK7UArvjIg7
         i1oDvr3QjpA9aDEQ4FXNGSP0+ATpvQcPMzU63lKxWBNHlR6EUi9WLY5MQ5Xbnn986bmZ
         egCx5KC128M+kOzttPNMHBm26MpWFd2lMu1sb5y7Z1mAZZ3Ss2x473Y8xeBDJdVW4O2l
         UTErFfrG25SChv28lat5J3L5kva0jxUay63lU3ZQH0ctMGTxU+eZViSDJjfKa9NSgExD
         cGwg==
X-Gm-Message-State: AOAM531kRqp+OAZTVrKHt1RQOL4QZEU4jRvkgpXJTH2oQoCi5wFYDK/o
        alBSKevj3bESMObuOskciFtb6qbUyNl68gSM8ANpVQ==
X-Google-Smtp-Source: ABdhPJxq5fuPYJBQfja70OA0Rq3kgXOL/SBQ/YCUKwHUN/s1bQwhwcAT6ZN4DwTS+GoBhojS5l1j4PfAeXzPLraUdf4=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr25559833otn.233.1620235671263;
 Wed, 05 May 2021 10:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org> <20210505141101.11519-1-ebiederm@xmission.com>
 <20210505141101.11519-12-ebiederm@xmission.com>
In-Reply-To: <20210505141101.11519-12-ebiederm@xmission.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 19:27:00 +0200
Message-ID: <CANpmjNPcYS9F+mgFP_DnO5c7kmMs28cdMBWN+ZxE7YNe_oK=_w@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] signalfd: Remove SIL_FAULT_PERF_EVENT fields
 from signalfd_siginfo
To:     "Eric W. Beiderman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 5 May 2021 at 16:11, Eric W. Beiderman <ebiederm@xmission.com> wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> With the addition of ssi_perf_data and ssi_perf_type struct signalfd_siginfo
> is dangerously close to running out of space.  All that remains is just
> enough space for two additional 64bit fields.  A practice of adding all
> possible siginfo_t fields into struct singalfd_siginfo can not be supported
> as adding the missing fields ssi_lower, ssi_upper, and ssi_pkey would
> require two 64bit fields and one 32bit fields.  In practice the fields
> ssi_perf_data and ssi_perf_type can never be used by signalfd as the signal
> that generates them always delivers them synchronously to the thread that
> triggers them.
>
> Therefore until someone actually needs the fields ssi_perf_data and
> ssi_perf_type in signalfd_siginfo remove them.  This leaves a bit more room
> for future expansion.
>
> v1: https://lkml.kernel.org/r/20210503203814.25487-12-ebiederm@xmission.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  fs/signalfd.c                 | 16 ++++++----------
>  include/uapi/linux/signalfd.h |  4 +---
>  2 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 335ad39f3900..040e1cf90528 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -114,12 +114,13 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 break;
>         case SIL_FAULT_BNDERR:
>         case SIL_FAULT_PKUERR:
> +       case SIL_FAULT_PERF_EVENT:
>                 /*
> -                * Fall through to the SIL_FAULT case.  Both SIL_FAULT_BNDERR
> -                * and SIL_FAULT_PKUERR are only generated by faults that
> -                * deliver them synchronously to userspace.  In case someone
> -                * injects one of these signals and signalfd catches it treat
> -                * it as SIL_FAULT.
> +                * Fall through to the SIL_FAULT case.  SIL_FAULT_BNDERR,
> +                * SIL_FAULT_PKUERR, and SIL_FAULT_PERF_EVENT are only
> +                * generated by faults that deliver them synchronously to
> +                * userspace.  In case someone injects one of these signals
> +                * and signalfd catches it treat it as SIL_FAULT.
>                  */
>         case SIL_FAULT:
>                 new.ssi_addr = (long) kinfo->si_addr;
> @@ -132,11 +133,6 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>                 new.ssi_addr = (long) kinfo->si_addr;
>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>                 break;
> -       case SIL_FAULT_PERF_EVENT:
> -               new.ssi_addr = (long) kinfo->si_addr;
> -               new.ssi_perf_type = kinfo->si_perf_type;
> -               new.ssi_perf_data = kinfo->si_perf_data;
> -               break;
>         case SIL_CHLD:
>                 new.ssi_pid    = kinfo->si_pid;
>                 new.ssi_uid    = kinfo->si_uid;
> diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
> index e78dddf433fc..83429a05b698 100644
> --- a/include/uapi/linux/signalfd.h
> +++ b/include/uapi/linux/signalfd.h
> @@ -39,8 +39,6 @@ struct signalfd_siginfo {
>         __s32 ssi_syscall;
>         __u64 ssi_call_addr;
>         __u32 ssi_arch;
> -       __u32 ssi_perf_type;
> -       __u64 ssi_perf_data;
>
>         /*
>          * Pad strcture to 128 bytes. Remember to update the
> @@ -51,7 +49,7 @@ struct signalfd_siginfo {
>          * comes out of a read(2) and we really don't want to have
>          * a compat on read(2).
>          */
> -       __u8 __pad[16];
> +       __u8 __pad[28];
>  };
>
>
> --
> 2.30.1

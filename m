Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B3209A11
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2020 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbgFYGst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 25 Jun 2020 02:48:49 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45559 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgFYGst (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jun 2020 02:48:49 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MGA0o-1jcITa1v1Y-00GZ7V; Thu, 25 Jun 2020 08:48:46 +0200
Received: by mail-qt1-f169.google.com with SMTP id j10so3811912qtq.11;
        Wed, 24 Jun 2020 23:48:46 -0700 (PDT)
X-Gm-Message-State: AOAM533bSYcFkq5u8I1cPLwR5C/1h0wCCPcVGTKh8Zkx0H0b2/GqM4Fw
        Z8JwKf99DuNPi2nZmqBq/XVz0pYV/4gELDAnHB8=
X-Google-Smtp-Source: ABdhPJwJfoAQe7bg+6/cF9QAvyR+RjvAhE5vpUgYCG406wBKAZ0pXDqrbInCtKUTN6gbvAUsuW0npAUiXhhv9jDyXTk=
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr31004183qtm.7.1593067725254;
 Wed, 24 Jun 2020 23:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200612185122.327860-1-andrealmeid@collabora.com>
In-Reply-To: <20200612185122.327860-1-andrealmeid@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Jun 2020 08:48:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1fwYX-S84ukxEWBt_DZ09MdBLbQyf4Jgrr-AeqG89jeA@mail.gmail.com>
Message-ID: <CAK8P3a1fwYX-S84ukxEWBt_DZ09MdBLbQyf4Jgrr-AeqG89jeA@mail.gmail.com>
Subject: Re: [RFC 0/4] futex2: Add new futex interface
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, krisman@collabora.com,
        Collabora kernel ML <kernel@collabora.com>,
        Darren Hart <dvhart@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Florian Weimer <fweimer@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        malteskarupke@web.de, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:LPEg7+RF/q09fzQm3Nrfm5ZP5BtGFOwKGrcVgVdBPZ0zbLvP65S
 VYSxbYaeRQl2eZbJIBj6mEluGOSEi86P0UcoSBhhPDbuYgLqDzXkqZGWMF3FRljJ79km/NH
 vLF7QaDOXzzD4UA6+XNS0tmXr4koG3osXeBlV1OFwIGrb/Sf97RaYH+Gqua7qlHT5fbmIXa
 meaiZR9k9xW2JE8R7DhNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QInPhZW5tRo=:/wJCxg8hJSU7fMZlNMobUt
 Ma9rI0a9WjGvQ4veLpnjkYk/qnV4G8U8+DhZLt3SNaQDY9h/cNtMi+d+F/FWm2YMCKjhtN6x4
 QYe/RpOUi522P0OMYo/hEXphVypNH2iwCKuoD29f4N7jQpuzAE9M3Vj7L5kvzHIGvH+ccz4ph
 B+vIvTCVgq+1g5FMY6Qz36c3D3U0Uaa4V4l1aBO5hwAy4m4Q78m71SIFycb5YNcvJlVRvmSlG
 NcvC7lJOVblBvrKK693Z2xYL8MBf2XGXxwGx3FspPasEhPYcJUGtWZvZtWElKTVRA3Sl+jbsu
 IG4uzFNZY0rNTW2WcgCbMsXLMZxWiHhL4waUgGAWJjoooJ0saQJInOLjXsz2LVlw8UYFc3voj
 4sQ3Pq7+FYu/ZO2Yud0kBUGhqBZJOEeYWVqSDy+RcOxCxZlWDFMgBFx5ttGoRF54QS2OKrQGp
 or2nsMSWCtCvgsMTmrsOtwuc8uT4QBanYmPZ9x7AiDEC26SupaLMU8C/rCRhPQpS1gkOoU870
 qx/6AeDUtg3kvhERsAlD9iYzHMv4OVWj6/02SA48P/nD2SnTNkS4nlEL38McgiYTmdDFQEZ/b
 EiDQ/Fnxn7HTht9wz1VJKkkv7RaNRF5w0d6zfCGHx39ZIe2QEUct5jm/rA+vJllQVPCKgD9oC
 BP40LqojgxHn5Q3E2nvWppSrpTeum71oHzLDEpL4tXE5umDviAhQ1wW/BjFBR1a3nFiAJqQaN
 +DhExNv1rBClfqDH5oYDF/zFPTGPDIOqwOluVBcx3k6a8quyOnFegs+Ni2oaqUDGsrRTz3jgO
 nFgTU87dHzspu3DhLtQfzVEiiaC/11R3/bzDgYX00nYZjFTXFI=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 12, 2020 at 8:51 PM André Almeida <andrealmeid@collabora.com> wrote:

> - The proposed interface uses ktime_t type for absolute timeout, and I
>   assumed that it should use values in a nsec resolution. If this is true,
>   we have some problems with i386 ABI, please check out the
>   COMPAT_32BIT_TIME implementation in patch 1 for more details. I
>   haven't added a time64 implementation yet, until this is clarified.

ktime_t is not part of the uapi headers, and has always been considered
an implementation detail of the kernel so far. I would argue it should
stay that way. The most sensible alternatives would be to either use
a "__u64 *timeout" argument for a relative timeout, or a
"struct __kernel_timespec *timeout" for an absolute timeout.

old_time32_t also makes no sense for multiple reasons:

- It's another kernel internal type and not part of the uapi headers
- your time32 call has different calling conventions from your time64
  version, not just a different type.
- there should be no need to add syscalls that are known to be buggy
  when there is a replacement type that does not have that bug.

> - Is expected to have a x32 ABI implementation as well? In the case of
>   wait and wake, we could use the same as x86_64 ABI. However, for the
>   waitv (aka wait on multiple futexes) we would need a proper x32 entry
>   since we are dealing with 32bit pointers.

For new syscalls, I'd actually recommend not having a separate
entry point, but just checking 'if (in_compat_syscall())' inside of the
implementation to pick one behavior vs the other when accessing
the user pointers. This keeps the implementation simpler and
avoids assigning a new x32 syscall number that would be different
from all the other architectures.

      Arnd

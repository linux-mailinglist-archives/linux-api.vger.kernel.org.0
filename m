Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAEE21B679
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 15:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGJNdS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jul 2020 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJNdR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jul 2020 09:33:17 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jul 2020 06:33:17 PDT
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78511C08C5CE;
        Fri, 10 Jul 2020 06:33:17 -0700 (PDT)
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 3E94A7C1278;
        Fri, 10 Jul 2020 15:23:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1594387397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0a47GLKOaTiWzGq8XsdXklDdSZ4NNZ9YA/m4rMqQRc=;
        b=J1TuL69JeYwZWoKtV+F+2RVX5EevU5myizrh5IdpnW0CZBoYkIc+cRqFm9tfHZQIMvyc8i
        RVVUJLIXbz6tZI6C8PVx9hQamgWTx4PVGtGauA6p1syNbUYu8PiNQYtRhCuQlSuAwJeJTb
        hVde8USor0K+SSvZ3ACV4y31kMERGpY=
MIME-Version: 1.0
Date:   Fri, 10 Jul 2020 15:23:17 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, krisman@collabora.com, kernel@collabora.com,
        dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
Subject: Re: [RFC v2 0/4] futex2: Add new futex interface
In-Reply-To: <20200709175921.211387-1-andrealmeid@collabora.com>
References: <20200709175921.211387-1-andrealmeid@collabora.com>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <4d9163924224d4265c280fc2ca6481c3@natalenko.name>
X-Sender: oleksandr@natalenko.name
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On 09.07.2020 19:59, André Almeida wrote:
> This RFC is a followup to the previous discussion initiated from my 
> last
> patch "futex: Implement mechanism to wait on any of several 
> futexes"[1].
> As stated in the thread, the correct approach to move forward with the
> wait multiple operation would be to create a new syscall that would 
> have
> all new cool features.
> 
> The first patch adds the new interface and just translate the call for
> the old interface, without implementing new features. The goal here is
> to establish the interface and to check if everyone is happy with this
> API. The rest of patches are selftests to show the interface in action.
> I have the following questions:
> 
> - What suggestions do you have to implement this? Start from scratch or
>   reuse the most code possible?
> 
> - The interface seems correct and implements the requirements asked by 
> you?
> 
> Those are the cool new features that this syscall should address some
> day:
> 
> - Operate with variable bit size futexes, not restricted to 32:
>   8, 16 and 64
> 
> - Wait on multiple futexes, using the following semantics:
> 
>   struct futex_wait {
> 	void *uaddr;
> 	unsigned long val;
> 	unsigned long flags;
>   };
> 
>   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
> 		  unsigned long flags, struct __kernel_timespec *timo);
> 
> - Have NUMA optimizations: if FUTEX_NUMA_FLAG is set, the `void *uaddr`
>   argument won't be a value of type u{8, 16, 32, 64} anymore, but a 
> struct
>   containing a NUMA node hint:
> 
>   struct futex32_numa {
> 	  u32 value __attribute__ ((aligned (8)));
> 	  u32 hint;
>   };
> 
>   struct futex64_numa {
> 	  u64 value __attribute__ ((aligned (16)));
> 	  u64 hint;
>   };
> 
> Thanks,
> 	André
> 
> Changes since v1:
>  - The timeout argument now uses __kernel_timespec as type
>  - time32 interface was removed
>  v1: https://lore.kernel.org/patchwork/cover/1255437/
> 
> [1] https://lore.kernel.org/patchwork/patch/1194339/
> 
> André Almeida (4):
>   futex2: Add new futex interface
>   selftests: futex: Add futex2 wake/wait test
>   selftests: futex: Add futex2 timeout test
>   selftests: futex: Add futex2 wouldblock test
> 
>  MAINTAINERS                                   |   2 +-
>  arch/x86/entry/syscalls/syscall_32.tbl        |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
>  include/linux/syscalls.h                      |   7 ++
>  include/uapi/asm-generic/unistd.h             |   8 +-
>  include/uapi/linux/futex.h                    |  10 ++
>  init/Kconfig                                  |   7 ++
>  kernel/Makefile                               |   1 +
>  kernel/futex2.c                               |  73 ++++++++++++
>  kernel/sys_ni.c                               |   4 +
>  tools/include/uapi/asm-generic/unistd.h       |   7 +-
>  .../selftests/futex/functional/.gitignore     |   1 +
>  .../selftests/futex/functional/Makefile       |   4 +-
>  .../selftests/futex/functional/futex2_wait.c  | 111 ++++++++++++++++++
>  .../futex/functional/futex_wait_timeout.c     |  38 ++++--
>  .../futex/functional/futex_wait_wouldblock.c  |  33 +++++-
>  .../testing/selftests/futex/functional/run.sh |   3 +
>  .../selftests/futex/include/futex2test.h      |  77 ++++++++++++
>  18 files changed, 373 insertions(+), 17 deletions(-)
>  create mode 100644 kernel/futex2.c
>  create mode 100644 
> tools/testing/selftests/futex/functional/futex2_wait.c
>  create mode 100644 tools/testing/selftests/futex/include/futex2test.h

What branch/tag this submission is based on please? It seems it is not a 
5.8 but rather 5.7 since the second patch misses faccessat2() syscall 
and fails to be applied cleanly.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)

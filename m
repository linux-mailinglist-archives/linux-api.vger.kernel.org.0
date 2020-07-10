Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690121B6F2
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGJNqJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jul 2020 09:46:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42116 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGJNqJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jul 2020 09:46:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 528722A0FD4
Subject: Re: [RFC v2 0/4] futex2: Add new futex interface
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, krisman@collabora.com, kernel@collabora.com,
        dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
References: <20200709175921.211387-1-andrealmeid@collabora.com>
 <4d9163924224d4265c280fc2ca6481c3@natalenko.name>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <4c9e997a-bbad-f3f2-0c9b-277aebf960c5@collabora.com>
Date:   Fri, 10 Jul 2020 10:45:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d9163924224d4265c280fc2ca6481c3@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi

On 7/10/20 10:23 AM, Oleksandr Natalenko wrote:
> Hello.
> 
> On 09.07.2020 19:59, André Almeida wrote:
>> This RFC is a followup to the previous discussion initiated from my last
>> patch "futex: Implement mechanism to wait on any of several futexes"[1].
>> As stated in the thread, the correct approach to move forward with the
>> wait multiple operation would be to create a new syscall that would have
>> all new cool features.
>>
>> The first patch adds the new interface and just translate the call for
>> the old interface, without implementing new features. The goal here is
>> to establish the interface and to check if everyone is happy with this
>> API. The rest of patches are selftests to show the interface in action.
>> I have the following questions:
>>
>> - What suggestions do you have to implement this? Start from scratch or
>>   reuse the most code possible?
>>
>> - The interface seems correct and implements the requirements asked by
>> you?
>>
>> Those are the cool new features that this syscall should address some
>> day:
>>
>> - Operate with variable bit size futexes, not restricted to 32:
>>   8, 16 and 64
>>
>> - Wait on multiple futexes, using the following semantics:
>>
>>   struct futex_wait {
>>     void *uaddr;
>>     unsigned long val;
>>     unsigned long flags;
>>   };
>>
>>   sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
>>           unsigned long flags, struct __kernel_timespec *timo);
>>
>> - Have NUMA optimizations: if FUTEX_NUMA_FLAG is set, the `void *uaddr`
>>   argument won't be a value of type u{8, 16, 32, 64} anymore, but a
>> struct
>>   containing a NUMA node hint:
>>
>>   struct futex32_numa {
>>       u32 value __attribute__ ((aligned (8)));
>>       u32 hint;
>>   };
>>
>>   struct futex64_numa {
>>       u64 value __attribute__ ((aligned (16)));
>>       u64 hint;
>>   };
>>
>> Thanks,
>>     André
>>
>> Changes since v1:
>>  - The timeout argument now uses __kernel_timespec as type
>>  - time32 interface was removed
>>  v1: https://lore.kernel.org/patchwork/cover/1255437/
>>
>> [1] https://lore.kernel.org/patchwork/patch/1194339/
>>
>> André Almeida (4):
>>   futex2: Add new futex interface
>>   selftests: futex: Add futex2 wake/wait test
>>   selftests: futex: Add futex2 timeout test
>>   selftests: futex: Add futex2 wouldblock test
>>
>>  MAINTAINERS                                   |   2 +-
>>  arch/x86/entry/syscalls/syscall_32.tbl        |   2 +
>>  arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
>>  include/linux/syscalls.h                      |   7 ++
>>  include/uapi/asm-generic/unistd.h             |   8 +-
>>  include/uapi/linux/futex.h                    |  10 ++
>>  init/Kconfig                                  |   7 ++
>>  kernel/Makefile                               |   1 +
>>  kernel/futex2.c                               |  73 ++++++++++++
>>  kernel/sys_ni.c                               |   4 +
>>  tools/include/uapi/asm-generic/unistd.h       |   7 +-
>>  .../selftests/futex/functional/.gitignore     |   1 +
>>  .../selftests/futex/functional/Makefile       |   4 +-
>>  .../selftests/futex/functional/futex2_wait.c  | 111 ++++++++++++++++++
>>  .../futex/functional/futex_wait_timeout.c     |  38 ++++--
>>  .../futex/functional/futex_wait_wouldblock.c  |  33 +++++-
>>  .../testing/selftests/futex/functional/run.sh |   3 +
>>  .../selftests/futex/include/futex2test.h      |  77 ++++++++++++
>>  18 files changed, 373 insertions(+), 17 deletions(-)
>>  create mode 100644 kernel/futex2.c
>>  create mode 100644
>> tools/testing/selftests/futex/functional/futex2_wait.c
>>  create mode 100644 tools/testing/selftests/futex/include/futex2test.h
> 
> What branch/tag this submission is based on please? It seems it is not a
> 5.8 but rather 5.7 since the second patch misses faccessat2() syscall
> and fails to be applied cleanly.
> 

As stated in MAINTAINERS[1], this submission is based on locking/core
branch from tip/tip[2] tree. The most updated release tag in this tree
is v5.8-rc1. My patches applied on top of locking/core are available in
my tree: https://gitlab.collabora.com/tonyk/linux/-/commits/futex2

According to 6c3c184fc420 ("tools headers API: Update faccessat2
affected files"), it seems that `faccessat2` entry at
`tools/include/uapi/asm-generic/unistd.h` was added after the syscall
was merged, so that's why 5.8-rc1 misses the syscall in this specific
file. Rebasing locking/core in 5.8-rc2 or above will fix that.

> Thanks.
> 

Thanks,
	André

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAINTAINERS?h=v5.8-rc4#n7102

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=locking/core

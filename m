Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E452CDA834
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2019 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439403AbfJQJW0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Oct 2019 05:22:26 -0400
Received: from [217.140.110.172] ([217.140.110.172]:36512 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfJQJWZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 17 Oct 2019 05:22:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803C3168F;
        Thu, 17 Oct 2019 02:21:58 -0700 (PDT)
Received: from [192.168.1.103] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 094333F718;
        Thu, 17 Oct 2019 02:21:49 -0700 (PDT)
Subject: Re: [PATCHv7 01/33] ns: Introduce Time Namespace
To:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-2-dima@arista.com>
 <80af93da-d497-81de-2a2a-179bb3bc852d@arm.com>
 <alpine.DEB.2.21.1910161230070.2046@nanos.tec.linutronix.de>
 <20191016233342.GA3075@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f37e6f71-09f6-4391-e6ef-974c4476c8a0@arm.com>
Date:   Thu, 17 Oct 2019 10:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016233342.GA3075@gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

On 10/17/19 12:33 AM, Andrei Vagin wrote:
>>> Having CONFIG_TIME_NS "default y" makes so that the option is selected even on
>>> the architectures that have no support for time namespaces.
>>> The direct consequence is that the fallbacks defined in this patch are never
>>> selected and this ends up in kernel compilation errors due to missing symbols.
>>>
>>> The error below shows what happens on arm64 (similar behavior on other
>>> architectures):
>>>
>>> aarch64-linux-gnu-ld: kernel/time/namespace.o: in function `timens_on_fork':
>>> kernel/time/namespace.c:321: undefined reference to `vdso_join_timens'
>>>
>>> My proposal is to keep TIME_NS "default n" (just remove "default y"), let the
>>> architectures that enable time namespaces select it and make CONFIG_TIME_NS
>>> select GENERIC_VDSO_TIME_NS if arch has HAVE_GENERIC_VDSO.
>> Nah.
>>
>> config TIME_NS
>> 	bool "TIME namespace"
>> 	depends on GENERIC_VDSO_TIME_NS
> I was thinking to fix this by the same way with a small difference.
> 
> If GENERIC_GETTIMEOFDAY isn't set, it should be safe to allow enabling
> TIME_NS. In this case, clock_gettime works via system call and we don't
> have arch-specific code in this case. Does this sound reasonable?
> 
>         depends on (!GENERIC_GETTIMEOFDAY || GENERIC_VDSO_TIME_NS)

This option would not work because not all the architectures have been converted
to the unified vdso approach. For example if you try to build ppc64 that does
not set GENERIC_GETTIMEOFDAY but has vdso support you would get:

powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs'
being placed in section `.gnu.hash'.
kernel/time/namespace.o: In function `.timens_set_vvar_page.isra.2.part.3':
namespace.c:(.text+0x178): undefined reference to `.arch_get_vdso_data'
kernel/time/namespace.o: In function `.timens_install':
namespace.c:(.text+0x798): undefined reference to `.vdso_join_timens'
kernel/time/namespace.o: In function `.timens_on_fork':
namespace.c:(.text+0x90c): undefined reference to `.vdso_join_timens'
/home/vinfra01/Projects/linux/Makefile:1074: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory '/home/vinfra01/Projects/linux-out'
Makefile:179: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

-- 
Regards,
Vincenzo

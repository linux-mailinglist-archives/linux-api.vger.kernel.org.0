Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF77E0FFD
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 04:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfJWCXg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Oct 2019 22:23:36 -0400
Received: from ozlabs.org ([203.11.71.1]:38491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388674AbfJWCXg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 22 Oct 2019 22:23:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46yZ1G4hQlz9sNx;
        Wed, 23 Oct 2019 13:23:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571797413;
        bh=gyxcFcSQMQaH20uIesQOzlFQbDgaiG1arpkyJmpTzq0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QpfT5/G+zSS+DmKo+il/qX7DI/HPmSjgMhVJ+8Qdx/VNue4nCior2DrKCqZ4NFBEm
         S/9QDnQLs9JxpawQ2Xl/j2f3IcQEtk7W3Zp3XtRUAX5b1qCNP8T+DfoYMFeBu4pLJO
         wLN0gSDbVyzDPLKxo//rdoNL87IbWbFSp5F8wPh3AoD0nJrGgWhOL/8PLe9io9O23E
         1t+YjJQ1aXmuLGnz3QfQ7k5nZH63L0r2wRmtVT4Q2yg5VkzWg/7tTah2KMwoZ9yGUK
         BMBmY7yt6AJABIsP65YPef4QZ66+9Ig8VN7UMliVhltsql8yfzmwPmn5unrmQuiYG2
         m9aANTrIpIIdg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     cyphar@cyphar.com, mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usercopy: Avoid soft lockups in test_check_nonzero_user()
In-Reply-To: <20191017060938.p4tmr5ruv6frgse4@wittgenstein>
References: <20191011022447.24249-1-mpe@ellerman.id.au> <20191016122732.13467-1-mpe@ellerman.id.au> <20191016130319.vcc2mqac3ta5jjat@wittgenstein> <871rvctkof.fsf@mpe.ellerman.id.au> <20191017060938.p4tmr5ruv6frgse4@wittgenstein>
Date:   Wed, 23 Oct 2019 13:23:27 +1100
Message-ID: <87sgnk5heo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:
> On Thu, Oct 17, 2019 at 09:00:48AM +1100, Michael Ellerman wrote:
>> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> > On Wed, Oct 16, 2019 at 11:27:32PM +1100, Michael Ellerman wrote:
>> >> On a machine with a 64K PAGE_SIZE, the nested for loops in
>> >> test_check_nonzero_user() can lead to soft lockups, eg:
>> >> 
>> >>   watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
>> >>   Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
>> >>   CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
>> >>   ...
>> >>   NIP __might_sleep+0x20/0xc0
>> >>   LR  __might_fault+0x40/0x60
>> >>   Call Trace:
>> >>     check_zeroed_user+0x12c/0x200
>> >>     test_user_copy_init+0x67c/0x1210 [test_user_copy]
>> >>     do_one_initcall+0x60/0x340
>> >>     do_init_module+0x7c/0x2f0
>> >>     load_module+0x2d94/0x30e0
>> >>     __do_sys_finit_module+0xc8/0x150
>> >>     system_call+0x5c/0x68
>> >> 
>> >> Even with a 4K PAGE_SIZE the test takes multiple seconds. Instead
>> >> tweak it to only scan a 1024 byte region, but make it cross the
>> >> page boundary.
>> >> 
>> >> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
>> >> Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
>> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> >
>> > With Aleksa's Reviewed-by I've picked this up:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=copy_struct_from_user
>> 
>> Thanks. Are you planning to send that to Linus for v5.4 or v5.5 ?
>
> This looks like a pretty straight bugfix to me since it's clearly
> causing an issue for you on power so v5.4-rc4 is what I'd aim for. I
> just want it to be in linux-next until tomorrow.

I see it in mainine now, thanks!

cheers

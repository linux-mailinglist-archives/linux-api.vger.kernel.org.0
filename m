Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74AD90D9
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfJPM2e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 08:28:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35093 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJPM2e (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Oct 2019 08:28:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46tWmZ1H2hz9sPT;
        Wed, 16 Oct 2019 23:28:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571228910;
        bh=zy552ubPLEsREybng5yyRj8M9/b2s2rupYBl2LF3oTc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bCMHAt5NbQsRJswiloLS3BOMtt5ozH95akKYDF6rl/hufXVy+LHqqh/fqsjrfF+3z
         Alet/wZMxFgDW8KadWsXJTA0jeN+2Zdkh9XybwAMoSY29aEywv5tdejZ9Qsrv9XOty
         sEuw2h4sMcPBOoPFygj1lmCyE1KhQLZMMmcCm3OnfAW+s0UfdxMkNDgQDZfo65iEBc
         Ayib6bC0jO1+iOBlp22lb66OFocUOhlpDv6LjB3iF+uyMZnhNPQ5a8Jt/9SyNFiYAb
         dG1LdmqIZVEf8EoaCY5/te9lPxv+l5L9BKm++npzrJ3CyxemLqh9zRs1MWThBC/8WT
         4l2wEZN3JDAGg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Avoid soft lockups in test_check_nonzero_user()
In-Reply-To: <20191011094333.7hovhhacrvlf6uq6@wittgenstein>
References: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com> <20191011022447.24249-1-mpe@ellerman.id.au> <20191011034810.xkmz3e4l5ezxvq57@yavin.dot.cyphar.com> <20191011094333.7hovhhacrvlf6uq6@wittgenstein>
Date:   Wed, 16 Oct 2019 23:28:20 +1100
Message-ID: <87a7a0ub6j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:
> On Fri, Oct 11, 2019 at 02:48:10PM +1100, Aleksa Sarai wrote:
>> On 2019-10-11, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > On a machine with a 64K PAGE_SIZE, the nested for loops in
>> > test_check_nonzero_user() can lead to soft lockups, eg:
>> > 
>> >   watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
>> >   Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
>> >   CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
>> >   ...
>> >   NIP __might_sleep+0x20/0xc0
>> >   LR  __might_fault+0x40/0x60
>> >   Call Trace:
>> >     check_zeroed_user+0x12c/0x200
>> >     test_user_copy_init+0x67c/0x1210 [test_user_copy]
>> >     do_one_initcall+0x60/0x340
>> >     do_init_module+0x7c/0x2f0
>> >     load_module+0x2d94/0x30e0
>> >     __do_sys_finit_module+0xc8/0x150
>> >     system_call+0x5c/0x68
>> > 
>> > Even with a 4K PAGE_SIZE the test takes multiple seconds. Instead
>> > tweak it to only scan a 1024 byte region, but make it cross the
>> > page boundary.
>> > 
>> > Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
>> > Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
>> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> > ---
>> >  lib/test_user_copy.c | 23 ++++++++++++++++++++---
>> >  1 file changed, 20 insertions(+), 3 deletions(-)
>> > 
>> > How does this look? It runs in < 1s on my machine here.
>> > 
>> > cheers
>> > 
>> > diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
>> > index 950ee88cd6ac..9fb6bc609d4c 100644
>> > --- a/lib/test_user_copy.c
>> > +++ b/lib/test_user_copy.c
>> > @@ -47,9 +47,26 @@ static bool is_zeroed(void *from, size_t size)
>> >  static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
>> >  {
>> >  	int ret = 0;
>> > -	size_t start, end, i;
>> > -	size_t zero_start = size / 4;
>> > -	size_t zero_end = size - zero_start;
>> > +	size_t start, end, i, zero_start, zero_end;
>> > +
>> > +	if (test(size < 1024, "buffer too small"))
>> > +		return -EINVAL;
>> > +
>> > +	/*
>> > +	 * We want to cross a page boundary to exercise the code more
>> > +	 * effectively. We assume the buffer we're passed has a page boundary at
>> > +	 * size / 2. We also don't want to make the size we scan too large,
>> > +	 * otherwise the test can take a long time and cause soft lockups. So
>> > +	 * scan a 1024 byte region across the page boundary.
>> > +	 */
>> > +	start = size / 2 - 512;
>> > +	size = 1024;
>> 
>> I don't think it's necessary to do "size / 2" here -- you can just use
>> PAGE_SIZE directly and check above that "size == 2*PAGE_SIZE" (not that
>> this check is exceptionally necessary -- since there's only one caller
>> of this function and it's in the same file).
>
> Michael, in case you resend, can you make my life a little easier and do
> it on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=copy_struct_from_user
> please. I have a fix from Aleksa sitting in there laready that _might_
> cause a conflict otherwise.

No worries, done.

cheers

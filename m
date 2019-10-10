Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B5D27DC
	for <lists+linux-api@lfdr.de>; Thu, 10 Oct 2019 13:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJJLT7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 07:19:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfJJLT7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 Oct 2019 07:19:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46ppX75MNmz9sPJ;
        Thu, 10 Oct 2019 22:19:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1570706394;
        bh=hSkH/Vvcj3/2iQYTo8nx3/9/utoxNug+YjWhFTACNkc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fOqlWeiF4L7bmkFBb7nQ83IyOixm5FQ68BuefPyhvwUsy0NAbtilnbVPd//4ARm5Q
         /L5WipWJEwFuJ4hnIMxTLpJtHJMh9iljG8wWbJ1zIA1VK+KSCMJ8gFgPMfeO04jZ6S
         WR3+0q0nBHiNhsuZPCXPm2MNDt8k1iP9H43evUtq4BdaWktwFQC/rV/Mlwh2pcW9Ou
         iSGCzoqtTawcSFQ8nge9bPxR2b7EKpbuoiaD018YHrIp6Hg6jF3/IvR3Glxif8EjX6
         Fld4pexBCbrEu9KQzOmNc3FKdwrANILSqBu062DQcQIGE46hwe4RIrGlMtqhiwDVal
         Z+XlemFWwnKlQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] lib: introduce copy_struct_from_user() helper
In-Reply-To: <20191001011055.19283-2-cyphar@cyphar.com>
References: <20191001011055.19283-1-cyphar@cyphar.com> <20191001011055.19283-2-cyphar@cyphar.com>
Date:   Thu, 10 Oct 2019 22:19:44 +1100
Message-ID: <87eezkx2y7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Aleksa,

Aleksa Sarai <cyphar@cyphar.com> writes:
> A common pattern for syscall extensions is increasing the size of a
> struct passed from userspace, such that the zero-value of the new fields
> result in the old kernel behaviour (allowing for a mix of userspace and
> kernel vintages to operate on one another in most cases).
>
> While this interface exists for communication in both directions, only
> one interface is straightforward to have reasonable semantics for
> (userspace passing a struct to the kernel). For kernel returns to
> userspace, what the correct semantics are (whether there should be an
> error if userspace is unaware of a new extension) is very
> syscall-dependent and thus probably cannot be unified between syscalls
> (a good example of this problem is [1]).
>
> Previously there was no common lib/ function that implemented
> the necessary extension-checking semantics (and different syscalls
> implemented them slightly differently or incompletely[2]). Future
> patches replace common uses of this pattern to make use of
> copy_struct_from_user().
>
> Some in-kernel selftests that insure that the handling of alignment and
> various byte patterns are all handled identically to memchr_inv() usage.
...
> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> index 67bcd5dfd847..950ee88cd6ac 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/test_user_copy.c
> @@ -31,14 +31,133 @@
...
> +static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
> +{
> +	int ret = 0;
> +	size_t start, end, i;
> +	size_t zero_start = size / 4;
> +	size_t zero_end = size - zero_start;
> +
> +	/*
> +	 * We conduct a series of check_nonzero_user() tests on a block of memory
> +	 * with the following byte-pattern (trying every possible [start,end]
> +	 * pair):
> +	 *
> +	 *   [ 00 ff 00 ff ... 00 00 00 00 ... ff 00 ff 00 ]
> +	 *
> +	 * And we verify that check_nonzero_user() acts identically to memchr_inv().
> +	 */
> +
> +	memset(kmem, 0x0, size);
> +	for (i = 1; i < zero_start; i += 2)
> +		kmem[i] = 0xff;
> +	for (i = zero_end; i < size; i += 2)
> +		kmem[i] = 0xff;
> +
> +	ret |= test(copy_to_user(umem, kmem, size),
> +		    "legitimate copy_to_user failed");
> +
> +	for (start = 0; start <= size; start++) {
> +		for (end = start; end <= size; end++) {
> +			size_t len = end - start;
> +			int retval = check_zeroed_user(umem + start, len);
> +			int expected = is_zeroed(kmem + start, len);
> +
> +			ret |= test(retval != expected,
> +				    "check_nonzero_user(=%d) != memchr_inv(=%d) mismatch (start=%zu, end=%zu)",
> +				    retval, expected, start, end);
> +		}
> +	}

This is causing soft lockups for me on powerpc, eg:

  [  188.208315] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
  [  188.208782] Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
  [  188.209594] CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
  [  188.210392] NIP:  c000000000173650 LR: c000000000379cb0 CTR: c0000000007b20d0
  [  188.210612] REGS: c0000000ec213560 TRAP: 0901   Tainted: G             L     (5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty)
  [  188.210876] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28222422  XER: 20000000
  [  188.211060] CFAR: c000000000379cac IRQMASK: 0 
  [  188.211060] GPR00: c000000000379cb0 c0000000ec2137f0 c0000000013bbb00 c000000000f527f0 
  [  188.211060] GPR04: 000000000000004b 0000000000000000 00000000000085f5 c00000000fffb780 
  [  188.211060] GPR08: 0000000000000000 0000000000000000 c0000000fb9a3080 c008000000411478 
  [  188.211060] GPR12: c0000000007b20d0 c00000000fffb780 
  [  188.211802] NIP [c000000000173650] __might_sleep+0x20/0xc0
  [  188.211924] LR [c000000000379cb0] __might_fault+0x40/0x60
  [  188.212037] Call Trace:
  [  188.212101] [c0000000ec2137f0] [c0000000001b99b4] vprintk_func+0xc4/0x230 (unreliable)
  [  188.212274] [c0000000ec213810] [c0000000007b21fc] check_zeroed_user+0x12c/0x200
  [  188.212478] [c0000000ec213860] [c0080000004106cc] test_user_copy_init+0x67c/0x1210 [test_user_copy]
  [  188.212681] [c0000000ec2139a0] [c000000000010440] do_one_initcall+0x60/0x340
  [  188.212859] [c0000000ec213a70] [c000000000213d4c] do_init_module+0x7c/0x2f0
  [  188.213004] [c0000000ec213b00] [c000000000216f24] load_module+0x2d94/0x30e0
  [  188.213150] [c0000000ec213d00] [c000000000217578] __do_sys_finit_module+0xc8/0x150
  [  188.213350] [c0000000ec213e20] [c00000000000b5d8] system_call+0x5c/0x68
  [  188.213494] Instruction dump:
  [  188.213587] 409efec0 4e800020 60000000 60000000 3c4c0125 384284d0 7c0802a6 60000000 
  [  188.213767] fba1ffe8 fbc1fff0 fbe1fff8 7c9e2378 <f821ff81> 7c7f1b78 7cbd2b78 e94d0958 


I think it's partly because I have DEBUG_ATOMIC_SLEEP enabled, which
means each unsafe_get_user() calls __might_fault() etc.

But even turning that off, it still takes forever.

> @@ -106,6 +225,11 @@ static int __init test_user_copy_init(void)
>  #endif
>  #undef test_legit
>  
> +	/* Test usage of check_nonzero_user(). */
> +	ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);

I suspect it's just that PAGE_SIZE for me is 64K, and so the nested loop
above gets too big too fast.

If my math is right it's doing about 500 million iterations, vs ~2
million on a 4K kernel.

If I do the change below the entire test_user_copy module loads and runs
all the tests in about 10 seconds.

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index 950ee88cd6ac..03b617a36144 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -226,7 +226,7 @@ static int __init test_user_copy_init(void)
 #undef test_legit
 
        /* Test usage of check_nonzero_user(). */
-       ret |= test_check_nonzero_user(kmem, usermem, 2 * PAGE_SIZE);
+       ret |= test_check_nonzero_user(kmem, usermem, 2 * 4096);
        /* Test usage of copy_struct_from_user(). */
        ret |= test_copy_struct_from_user(kmem, usermem, 2 * PAGE_SIZE);
 

How long does it take on your systems? Is 10s in the ball park, or is
there something else pathological happening on my machine, and shrinking
it to 4096 is just papering over it?

cheers

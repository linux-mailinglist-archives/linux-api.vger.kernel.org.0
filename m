Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5558DD9EBE
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2019 00:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438927AbfJPWBA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 18:01:00 -0400
Received: from ozlabs.org ([203.11.71.1]:41521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438917AbfJPWA7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Oct 2019 18:00:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46tmT01FSSz9sRX;
        Thu, 17 Oct 2019 09:00:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571263256;
        bh=4MsmL64dyZAIeoPnH7Xa/yFXBwCvuSkYKcnGrR7vIrs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QFObH92PJgBMlT3l42RO6dn04vkLru885Ofz29/erFVxqrgij3GfB4TRcqOBFetjj
         3Vrac09I7jEjIbSdKe7Aq8lgAPD7olJMcrypLTjI8X0lFSgu6GOKLOAgkWODtK7glp
         6uu8lRYFIBwbomqe79Td0dgUaBEpo9vJUArQ+hjqjB7SYIWDiYtyUg503uGRrXn9Sd
         Ney8b05Sc0mOpi3+MmhElvZnYeqU6QnABvpSYVOSc6WJShTCqalBrd60mzt2N/OGsH
         8BZ4tQSGU5xsXnLyhFnE+cvG415V0ePFa8smqfUFBpnVxELOdNp2lZyGUZN2K+Y/jy
         MuQemmbUXh4TQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     cyphar@cyphar.com, mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usercopy: Avoid soft lockups in test_check_nonzero_user()
In-Reply-To: <20191016130319.vcc2mqac3ta5jjat@wittgenstein>
References: <20191011022447.24249-1-mpe@ellerman.id.au> <20191016122732.13467-1-mpe@ellerman.id.au> <20191016130319.vcc2mqac3ta5jjat@wittgenstein>
Date:   Thu, 17 Oct 2019 09:00:48 +1100
Message-ID: <871rvctkof.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:
> On Wed, Oct 16, 2019 at 11:27:32PM +1100, Michael Ellerman wrote:
>> On a machine with a 64K PAGE_SIZE, the nested for loops in
>> test_check_nonzero_user() can lead to soft lockups, eg:
>> 
>>   watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
>>   Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
>>   CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
>>   ...
>>   NIP __might_sleep+0x20/0xc0
>>   LR  __might_fault+0x40/0x60
>>   Call Trace:
>>     check_zeroed_user+0x12c/0x200
>>     test_user_copy_init+0x67c/0x1210 [test_user_copy]
>>     do_one_initcall+0x60/0x340
>>     do_init_module+0x7c/0x2f0
>>     load_module+0x2d94/0x30e0
>>     __do_sys_finit_module+0xc8/0x150
>>     system_call+0x5c/0x68
>> 
>> Even with a 4K PAGE_SIZE the test takes multiple seconds. Instead
>> tweak it to only scan a 1024 byte region, but make it cross the
>> page boundary.
>> 
>> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
>> Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> With Aleksa's Reviewed-by I've picked this up:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=copy_struct_from_user

Thanks. Are you planning to send that to Linus for v5.4 or v5.5 ?

cheers

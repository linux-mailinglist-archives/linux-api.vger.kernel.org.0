Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782818F796
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 01:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfHOX3f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 19:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfHOX3f (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 15 Aug 2019 19:29:35 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C61206C2;
        Thu, 15 Aug 2019 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565911774;
        bh=z09KQTqOI+IV+jDADbs07zi7F0ekc5wG54z2cyDIZHE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LrE54f0xQ8mcNy2rlonCs6Orsy20gQT/XvJU42aw4yc8p3JHmwewI4g9A3uf+uXIg
         Q2mCIE7fOnCe0uCKKYeGsBPjSkuoRRx3Jt/t5SuKQFfaLsaMaa5hF6wJq//vxr0B5l
         CEC10gNUEzfDJIjkZJMi8MabiqX5XRlEkfK4u4XM=
Subject: Re: [PATCHv6 35/36] selftests/timens: Add a simple perf test for
 clock_gettime()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org, shuah <shuah@kernel.org>
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-36-dima@arista.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0992df9a-d3b3-5ca1-e1fd-b5d9d365b32e@kernel.org>
Date:   Thu, 15 Aug 2019 17:29:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815163836.2927-36-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/15/19 10:38 AM, Dmitry Safonov wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   tools/testing/selftests/timens/.gitignore     |   2 +
>   tools/testing/selftests/timens/Makefile       |  10 +-
>   tools/testing/selftests/timens/gettime_perf.c | 101 +++++++++++
>   .../selftests/timens/gettime_perf_cold.c      | 160 ++++++++++++++++++
>   4 files changed, 271 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/timens/gettime_perf.c
>   create mode 100644 tools/testing/selftests/timens/gettime_perf_cold.c
> 
> diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
> index 3b7eda8f35ce..16292e4d08a5 100644
> --- a/tools/testing/selftests/timens/.gitignore
> +++ b/tools/testing/selftests/timens/.gitignore
> @@ -1,4 +1,6 @@
>   clock_nanosleep
> +gettime_perf
> +gettime_perf_cold
>   procfs
>   timens
>   timer
> diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
> index ae1ffd24cc43..97e0460eaf48 100644
> --- a/tools/testing/selftests/timens/Makefile
> +++ b/tools/testing/selftests/timens/Makefile
> @@ -1,6 +1,12 @@
> -TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
> +TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
> +
> +uname_M := $(shell uname -m 2>/dev/null || echo not)
> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
> +ifeq ($(ARCH),x86_64)
> +TEST_GEN_PROGS += gettime_perf_cold
> +endif
>   
>   CFLAGS := -Wall -Werror
> -LDFLAGS := -lrt
> +LDFLAGS := -lrt -ldl
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
> new file mode 100644
> index 000000000000..f7d7832c0293
> --- /dev/null
> +++ b/tools/testing/selftests/timens/gettime_perf.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sched.h>
> +#include <time.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <dlfcn.h>
> +
> +#include "log.h"
> +#include "timens.h"
> +
> +//#define TEST_SYSCALL
> +

How is this supposed to be used? When does TEST_SYSCALL
get defined?

> +typedef int (*vgettime_t)(clockid_t, struct timespec *);
> +
> +vgettime_t vdso_clock_gettime;
> +
> +static void fill_function_pointers(void)
> +{
> +	void *vdso = dlopen("linux-vdso.so.1",
> +			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
> +	if (!vdso)
> +		vdso = dlopen("linux-gate.so.1",
> +			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
> +	if (!vdso) {
> +		pr_err("[WARN]\tfailed to find vDSO\n");
> +		return;
> +	}
> +
> +	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
> +	if (!vdso_clock_gettime)
> +		pr_err("Warning: failed to find clock_gettime in vDSO\n");
> +
> +}
> +
> +static void test(clock_t clockid, char *clockstr, bool in_ns)
> +{
> +	struct timespec tp, start;
> +	long i = 0;
> +	const int timeout = 3;
> +
> +#ifndef TEST_SYSCALL
> +	vdso_clock_gettime(clockid, &start);
> +#else
> +	syscall(__NR_clock_gettime, clockid, &start);
> +#endif

Hmm. This doesn't look right. Does this test need to be compiled
with TEST_SYSCALL. Please find a way to do this without ifdef.

thanks,
-- Shuah


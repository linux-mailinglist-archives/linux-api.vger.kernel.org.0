Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DF40A258
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 03:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhINBMW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 13 Sep 2021 21:12:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhINBMV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 21:12:21 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:f4d2:afff:fe2b:18b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 30B301F42CB3;
        Tue, 14 Sep 2021 02:11:04 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 5/6] selftests: futex2: Add waitv test
Organization: Collabora
References: <20210913175249.81074-1-andrealmeid@collabora.com>
        <20210913175249.81074-6-andrealmeid@collabora.com>
Date:   Mon, 13 Sep 2021 21:11:00 -0400
In-Reply-To: <20210913175249.81074-6-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Mon, 13 Sep 2021 14:52:48 -0300")
Message-ID: <87wnnkezbv.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Create a new file to test the waitv mechanism. Test both private and
> shared futexes. Wake the last futex in the array, and check if the
> return value from futex_waitv() is the right index.
>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  .../selftests/futex/functional/.gitignore     |   1 +
>  .../selftests/futex/functional/Makefile       |   3 +-
>  .../selftests/futex/functional/futex_waitv.c  | 158 ++++++++++++++++++
>  .../testing/selftests/futex/functional/run.sh |   3 +
>  .../selftests/futex/include/futex2test.h      |  31 ++++
>  5 files changed, 195 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/futex/functional/futex_waitv.c
>  create mode 100644 tools/testing/selftests/futex/include/futex2test.h
>
> diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
> index 0e78b49d0f2f..fbcbdb6963b3 100644
> --- a/tools/testing/selftests/futex/functional/.gitignore
> +++ b/tools/testing/selftests/futex/functional/.gitignore
> @@ -8,3 +8,4 @@ futex_wait_uninitialized_heap
>  futex_wait_wouldblock
>  futex_wait
>  futex_requeue
> +futex_waitv
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index bd1fec59e010..5cc38de9d8ea 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -17,7 +17,8 @@ TEST_GEN_FILES := \
>  	futex_wait_uninitialized_heap \
>  	futex_wait_private_mapped_file \
>  	futex_wait \
> -	futex_requeue
> +	futex_requeue \
> +	futex_waitv
>  
>  TEST_PROGS := run.sh
>  
> diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
> new file mode 100644
> index 000000000000..567667dfa7cf
> --- /dev/null
> +++ b/tools/testing/selftests/futex/functional/futex_waitv.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/******************************************************************************
> + *
> + *   Copyright Collabora Ltd., 2021
> + *
> + * DESCRIPTION
> + *	Test waitv/wake mechanism of futex2, using 32bit sized futexes.
> + *
> + * AUTHOR
> + *	André Almeida <andrealmeid@collabora.com>
> + *
> + * HISTORY
> + *      2021-Feb-5: Initial version by André <andrealmeid@collabora.com>

We have git to keep history nowadays.  This type of changelog is a relic
from less civilized times and adds no extra information.  :)



-- 
Gabriel Krisman Bertazi

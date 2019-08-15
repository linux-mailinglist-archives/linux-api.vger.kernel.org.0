Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D538F784
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 01:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfHOXSZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 19:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbfHOXSZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 15 Aug 2019 19:18:25 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8579E2083B;
        Thu, 15 Aug 2019 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565911104;
        bh=iJhe6y6JGRGDCMzyg3rw4IDGMv4To3vHo/3eeEQyvLg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IhO632crOR6eYMBweQJSP5H1+7IbfN4OwDJ7QF5x3ujTb3wWBdBrmZjEuNcjSeCtX
         ftNUKBS9Ixy+M6JqOL3m2kk2aj1OdwPmXzDucHzC3E5S+WMOuhLnB3dF0WlJdE9nvE
         5ivGmIi1O+GhXuCbfop4x9HJxqBF19zvvO6kQJRc=
Subject: Re: [PATCHv6 30/36] selftest/timens: Add Time Namespace test for
 supported clocks
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
 <20190815163836.2927-31-dima@arista.com>
From:   shuah <shuah@kernel.org>
Message-ID: <02add700-b626-a1b4-09e1-1e4d5cd242f2@kernel.org>
Date:   Thu, 15 Aug 2019 17:18:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815163836.2927-31-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Dmitry,

Thanks for the patch.

On 8/15/19 10:38 AM, Dmitry Safonov wrote:
> A test to check that all supported clocks work on host and inside
> a new time namespace. Use both ways to get time: through VDSO and
> by entering the kernel with implicit syscall.
> 
> Introduce a new timens directory in selftests framework for
> the next timens tests.
> 
> Co-developed-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Andrei Vagin <avagin@openvz.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   tools/testing/selftests/Makefile          |   1 +
>   tools/testing/selftests/timens/.gitignore |   1 +
>   tools/testing/selftests/timens/Makefile   |   5 +
>   tools/testing/selftests/timens/config     |   1 +
>   tools/testing/selftests/timens/log.h      |  26 +++
>   tools/testing/selftests/timens/timens.c   | 185 ++++++++++++++++++++++
>   tools/testing/selftests/timens/timens.h   |  63 ++++++++
>   7 files changed, 282 insertions(+)
>   create mode 100644 tools/testing/selftests/timens/.gitignore
>   create mode 100644 tools/testing/selftests/timens/Makefile
>   create mode 100644 tools/testing/selftests/timens/config
>   create mode 100644 tools/testing/selftests/timens/log.h
>   create mode 100644 tools/testing/selftests/timens/timens.c
>   create mode 100644 tools/testing/selftests/timens/timens.h
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 25b43a8c2b15..6fc63b84a857 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -47,6 +47,7 @@ TARGETS += splice
>   TARGETS += static_keys
>   TARGETS += sync
>   TARGETS += sysctl
> +TARGETS += timens

How long does this test run for? Does this test need to be run
as root? If yes, please add a root check and skip the test.

What does the test output looks like for skip and pass/fail cases?

thanks,
-- Shuah

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A278FAD0
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHPGUg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 02:20:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45286 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPGUg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 02:20:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so2022311plr.12;
        Thu, 15 Aug 2019 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6wpx1jZV11EfJBX2ao9RqO5NgPM+k8gE3yf97Juvvo=;
        b=USUPb5Jopdm/rkGvdhG9iz8y0GbSUYKT0fZvhRdItvYCPkJ2Tvk+peyP2QViYMx0Ae
         QV+XODUU6/tTCt6rAW1ndzPqd+fNAOJj1YR1pWNwI8V42OfitR7Eh81i0VT3PN4ybanD
         qB4NtnNaDZEWjPvM8t2Rpyj4sbDkyl1attQTJftJLrzoVn6lca8R3jK9C6W3EdwRorCS
         Gg6KWp9l5tAue9JQUDrZbREOYCnnctbAU37N8EwRUgLIFehl4wzkjnT8D34dTGTZYOef
         5r3oDFH11Par0e8BTHu8sBm0WU/BgmLgecjja3MyyJpOuN8gWiH9sjdBFtRqn8M6q1Qk
         bnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6wpx1jZV11EfJBX2ao9RqO5NgPM+k8gE3yf97Juvvo=;
        b=uX0pzNQjWONOyhrwtWLSai6f2fvUemPLrG3sTHIXXY7Oz4MkGh1rG1KeLTcNzJHzDu
         3t7oPd7iOwNSWQ3xcJQit8UDzcKj2MjDuuXLDIWCk5g7RHSwHQAACC6xnrtJzxm6L4R6
         2Fcg+CxGDVdeqNVb1ysrj8hrs86cyYeLch0fcZABa7lIDgjciY03kStxJCCEy881RVWf
         63W4c++Q20IiF++p+TnGz7BV1EZUF24I8M8Qpor8sh+lU4CcWtGWriNkVdZmsDNFrN6P
         pk5pNIBgfDgSvksViLnOaA1RU7Zs2Rd+R0FHn6Q3BnrXb05BBU8CaDM7lYAbfcK87tQt
         0juw==
X-Gm-Message-State: APjAAAXTNEbu0K/PsutuXzz+iHjIPcoG6TVzFQ9vD77qjYbNqvOGI4YU
        /Tu0tZvepmyLCJeAW8A93Rm1/yMQvBhq9g==
X-Google-Smtp-Source: APXvYqwbVkUU6fNLZecwKHqqLM+ALbX/jeVJm7GYtxm6JjAIrxGPms6JTzDPRbhcyDEtmP1Rz3Dzng==
X-Received: by 2002:a17:902:be01:: with SMTP id r1mr7382945pls.229.1565936435295;
        Thu, 15 Aug 2019 23:20:35 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id q13sm5047936pfl.124.2019.08.15.23.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 23:20:34 -0700 (PDT)
Date:   Thu, 15 Aug 2019 23:20:32 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 30/36] selftest/timens: Add Time Namespace test for
 supported clocks
Message-ID: <20190816062032.GB14312@gmail.com>
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-31-dima@arista.com>
 <02add700-b626-a1b4-09e1-1e4d5cd242f2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <02add700-b626-a1b4-09e1-1e4d5cd242f2@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 15, 2019 at 05:18:21PM -0600, shuah wrote:
> Hi Dmitry,
> 
> Thanks for the patch.
> 
> On 8/15/19 10:38 AM, Dmitry Safonov wrote:
> > A test to check that all supported clocks work on host and inside
> > a new time namespace. Use both ways to get time: through VDSO and
> > by entering the kernel with implicit syscall.
> > 
> > Introduce a new timens directory in selftests framework for
> > the next timens tests.
> > 
> > Co-developed-by: Andrei Vagin <avagin@openvz.org>
> > Signed-off-by: Andrei Vagin <avagin@openvz.org>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >   tools/testing/selftests/Makefile          |   1 +
> >   tools/testing/selftests/timens/.gitignore |   1 +
> >   tools/testing/selftests/timens/Makefile   |   5 +
> >   tools/testing/selftests/timens/config     |   1 +
> >   tools/testing/selftests/timens/log.h      |  26 +++
> >   tools/testing/selftests/timens/timens.c   | 185 ++++++++++++++++++++++
> >   tools/testing/selftests/timens/timens.h   |  63 ++++++++
> >   7 files changed, 282 insertions(+)
> >   create mode 100644 tools/testing/selftests/timens/.gitignore
> >   create mode 100644 tools/testing/selftests/timens/Makefile
> >   create mode 100644 tools/testing/selftests/timens/config
> >   create mode 100644 tools/testing/selftests/timens/log.h
> >   create mode 100644 tools/testing/selftests/timens/timens.c
> >   create mode 100644 tools/testing/selftests/timens/timens.h
> > 
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 25b43a8c2b15..6fc63b84a857 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -47,6 +47,7 @@ TARGETS += splice
> >   TARGETS += static_keys
> >   TARGETS += sync
> >   TARGETS += sysctl
> > +TARGETS += timens
> 
> How long does this test run for?

On my laptop, it needs 30 miliseconds.

> Does this test need to be run
> as root? If yes, please add a root check and skip the test.

Yes, it needs to be as root. We will add this check. Thanks.

> 
> What does the test output looks like for skip and pass/fail cases?

[avagin@laptop timens]$ ./timens 
not ok 1 # SKIP Time namespaces are not supported

[root@fc24 timens]# ./timens 
1..10
ok 1 Passed for CLOCK_BOOTTIME (syscall)
ok 2 Passed for CLOCK_BOOTTIME (vdso)
ok 3 Passed for CLOCK_BOOTTIME_ALARM (syscall)
ok 4 Passed for CLOCK_BOOTTIME_ALARM (vdso)
ok 5 Passed for CLOCK_MONOTONIC (syscall)
ok 6 Passed for CLOCK_MONOTONIC (vdso)
ok 7 Passed for CLOCK_MONOTONIC_COARSE (syscall)
ok 8 Passed for CLOCK_MONOTONIC_COARSE (vdso)
ok 9 Passed for CLOCK_MONOTONIC_RAW (syscall)
ok 10 Passed for CLOCK_MONOTONIC_RAW (vdso)
# Pass 10 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Thanks,
Andrei

> 
> thanks,
> -- Shuah

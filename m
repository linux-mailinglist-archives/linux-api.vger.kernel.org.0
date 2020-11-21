Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1D2BBD90
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 07:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgKUG7Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 01:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKUG7P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 01:59:15 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C9C0613CF
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 22:59:15 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s18so12106579oih.1
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 22:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=8EjPYWVziI0AdsHJ0vJtUZHJlazcOnJUwSGeWealU+4=;
        b=TVcGUin60T069vDIXwCS+UUpEz2QJ9WuJLtbRzRnM5vbdWStes5b8+5wGwmLbUF7Wu
         O/KwsX3liebsja7AtLbCsuPp8qV+UWylWH3EsebtusvALBVo+FODG1isZC3HKHl5h0Qt
         1x8vBJLLoCuI1VWjgOlN6B1HQ61zrVXBCALsnz8WVi+G62j7mdOWTX1xAjPF+g8wYi+u
         qisCxMtBqW34f/aBaXVZBRHjty1U6pPL9+dtk1IlQ1Q0YT35l72IMfMeZ9mZV4W4hco/
         5taX8YGC31EBeSurdtbrT5jvasDPfoBXbj/u1EuAFzO5vebpChuTI6PhFvszMTXf5w73
         9Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8EjPYWVziI0AdsHJ0vJtUZHJlazcOnJUwSGeWealU+4=;
        b=FKvbtrWzf72PLq88fzvbCzJoPoZig7BN/sEIpn6v3ha/2Lv1OFa1c7Sim7G4l0Aj7e
         qGUaC6EnARbCZ3qkFTO0VcNeg2mhw7OS7Vp00u0W+GXSvi9Jf9gDRHJBkHUtUm0tC+/I
         sggvRqxHGD0M3qpizAmxrllpKEIhAgG5Easvanryc7RWKT+nYvLxy4FMBWRVEuTD+2My
         cB+GHooAqQDWqQ3++euby6wCp8sdb2UvgvDR4k9d1/FfREBQVWnhbu5aVdcwhDu7qEyi
         xlwv5N+pcwHwYnKNw6tZ32/2vXWF/Zn4PacRakUKCsOkipAX6scmGccjxT0EOivVcGiQ
         MttQ==
X-Gm-Message-State: AOAM530Tv92DrvEb0K/zUKkcjbBWrr/VTOTI8/T0U24k7iV1TCTcmbbH
        yBlGJMLcKIW8hshEwPCFWuZgBGBwB7Fg3SaoRHc=
X-Google-Smtp-Source: ABdhPJwRyQAu4Pn44WAJk7VYz1m0tCXlLKiTKcTmR0J+aZjam78DtqTDazRFfUJRbHB1QOYrnUcVUEq08vuscEUv0D0=
X-Received: by 2002:aca:b706:: with SMTP id h6mr9271608oif.177.1605941954783;
 Fri, 20 Nov 2020 22:59:14 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 21 Nov 2020 07:59:04 +0100
Message-ID: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
Subject: Problems with the new pthread clock implementations
To:     Mike Crowe <mac@mcrowe.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Mike,

I've been taking a closer look at the the new pthread*clock*() APIs:
pthread_clockjoin_np()
pthread_cond_clockwait()
pthread_mutex_clocklock()
pthread_rwlock_clockrdlock()
pthread_rwlock_clockwrlock()
sem_clockwait()

I've noticed some oddities, and at least a couple of bugs.

First off, I just note that there's a surprisingly wide variation in
the low-level futex calls being used by these APIs when implementing
CLOCK_REALTIME support:

pthread_rwlock_clockrdlock()
pthread_rwlock_clockwrlock()
sem_clockwait()
pthread_cond_clockwait()
    futex(addr,
        FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 3,
        {abstimespec}, FUTEX_BITSET_MATCH_ANY)
    (This implementation seems to be okay)

pthread_clockjoin_np()
    futex(addr, FUTEX_WAIT, 48711, {reltimespec})
    (This is buggy; see below.)

pthread_mutex_clocklock()
    futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec})
    (There's bugs and strangeness here; see below.)

=== Bugs ===

pthread_clockjoin_np():
As already recognized in another mail thread [1], this API accepts any
kind of clockid, even though it doesn't support most of them.

A further bug is that even if CLOCK_REALTIME is specified,
pthread_clockjoin_np() sleeps against the CLOCK_MONOTONIC clock.
(Currently it does this for *all* clockid values.) The problem here is
that the FUTEX_WAIT operation sleeps against the CLOCK_MONOTONIC clock
by default. At the least, the FUTEX_CLOCK_REALTIME is required for
this case. Alternatively, an implementation using
FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME (like the first four
functions listed above) might be appropriate.

===

pthread_mutex_clocklock():
First of all, there's a small oddity. Suppose we specify the clockid
as CLOCK_REALTIME, and then while the call is blocked, we set the
clock realtime backwards. Then, there will be further futex calls to
handle the modification to the clock (and possibly multiple futex
calls if the realtime clock is adjusted repeatedly):

        futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec1})
        futex(addr, FUTEX_WAIT_PRIVATE, 2, {reltimespec2})
        ...

Then there seems to be a bug. If we specify the clockid as
CLOCK_REALTIME, and while the call is blocked we set the realtime
clock forwards, then the blocking interval of the call is *not*
adjusted (shortened), when of course it should be.

===

I've attached a couple of small test programs at the end of this mail.

Thanks,

Michael

[1] https://lore.kernel.org/linux-man/20201119120034.GA20599@mcrowe.com/

=============================================

/* t_pthread_clockjoin_np.c

   Copyright Michael Kerrisk, 2020. Licensed GPLv2+
*/
#define _GNU_SOURCE
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

#define errExitEN(en, msg) \
                        do { errno = en; perror(msg); \
                             exit(EXIT_FAILURE); } while (0)

static void *
threadFunc(void *arg)
{
    printf("New thread started\n");
    sleep(2000);
    return NULL;
}

int
main(int argc, char *argv[])
{
    pthread_t t1;
    int nsecs;
    int s;

    nsecs = (argc > 1) ? atoi(argv[1]) : 10;

    s = pthread_create(&t1, NULL, threadFunc, (void *) 1);
    if (s != 0)
        errExitEN(s, "pthread_create");

    struct timespec ts, tsm1, tsm2;
    if (clock_gettime(CLOCK_MONOTONIC, &tsm1) == -1)
        errExit("clock_gettime");

    int clockid;
    clockid = CLOCK_REALTIME;
    if (clock_gettime(clockid, &ts) == -1)
        errExit("clock_gettime");

    ts.tv_sec += nsecs;
    printf("ts.tv_sec = %ld\n", ts.tv_sec);

    s = pthread_clockjoin_np(t1, NULL, clockid, &ts);
    if (s == 0) {
        printf("pthread_clockjoin_np() successfully joined\n");
    } else {
        if (s == ETIMEDOUT)
            printf("pthread_clockjoin_np() timed out\n");
        else
            errExitEN(s, "pthread_clockjoin_np");
    }

    if (clock_gettime(CLOCK_MONOTONIC, &tsm2) == -1)
        errExit("clock_gettime");

    printf("CLOCK_MONOTONIC diff = %ld secs\n", tsm2.tv_sec - tsm1.tv_sec);

    exit(EXIT_SUCCESS);
}

=============================================


/* t_pthread_mutex_clocklock.c

   Copyright Michael Kerrisk, 2020. Licensed GPLv2+
*/
#define _GNU_SOURCE
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

#define errExitEN(en, msg) \
                        do { errno = en; perror(msg); \
                             exit(EXIT_FAILURE); } while (0)

static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;

static void *
threadFunc(void *arg)
{
    int s;

    printf("Thread created\n");
    s = pthread_mutex_lock(&mtx);
    if (s != 0)
        errExitEN(s, "pthread_mutex_lock");
    else
        printf("Thread 1 locked mutex\n");

    pause();
    return NULL;
}

int
main(int argc, char *argv[])
{
    pthread_t t1;
    int nsecs;
    int s;

    nsecs = (argc > 1) ? atoi(argv[1]) : 10;

    s = pthread_create(&t1, NULL, threadFunc, argv[1]);
    if (s != 0)
        errExitEN(s, "pthread_create");

    usleep(100000);

    struct timespec ts, tsm1, tsm2;
    if (clock_gettime(CLOCK_MONOTONIC, &tsm1) == -1)
        errExit("clock_gettime");

    int clockid;
    clockid = CLOCK_REALTIME;
    if (clock_gettime(clockid, &ts) == -1)
        errExit("clock_gettime");

    ts.tv_sec += nsecs;
    printf("ts.tv_sec = %ld\n", ts.tv_sec);

    s = pthread_mutex_clocklock(&mtx, clockid, &ts);
    if (s == 0) {
        printf("pthread_mutex_clocklock() got lock\n");
    } else {
        if (s == ETIMEDOUT)
            printf("pthread_mutex_clocklock() timed out\n");
        else
            errExitEN(s, "pthread_mutex_clocklock");
    }

    if (clock_gettime(CLOCK_MONOTONIC, &tsm2) == -1)
        errExit("clock_gettime");

    printf("CLOCK_MONOTONIC diff = %ld secs\n", tsm2.tv_sec - tsm1.tv_sec);

    exit(EXIT_SUCCESS);
}


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

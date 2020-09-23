Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D302759CF
	for <lists+linux-api@lfdr.de>; Wed, 23 Sep 2020 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWOWS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Sep 2020 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWOWR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Sep 2020 10:22:17 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1774C0613CE
        for <linux-api@vger.kernel.org>; Wed, 23 Sep 2020 07:22:17 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 7so83535vsp.6
        for <linux-api@vger.kernel.org>; Wed, 23 Sep 2020 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DfASuP4wTyn3pr6VYvm8A1z5RVX46kLf4FcH4npIyzc=;
        b=D4nNydf+MHc+IWQZKD3zTZKNm9RDLRVf/ccFBiozGSMayUBpd+Nfk55jyjJJlWdo2s
         90YZZJmlz465/26fH4FhpNPrJxICDVSVh2Ff7cg5G09PCizdTa00F5sZBtCRdeFfq4ne
         OMvuIii0a+wdxKNhTqttw+N0+F6TAv10tlqac7xzm1uiix7bWROjgeT749p3o6BwunjP
         r8QMKPmx8Plf5kRBoRJwNyyfI0qwKo1zWFMvUBgiXiGN8OYe+h8u6ps2iUeWtcbWffkx
         2Ij0YugqNZa8iYouPDA4bHfLObTlLYXI0ThxaM7rNl/5QhtguMDpZKTIXxAURJYKZVY6
         MPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DfASuP4wTyn3pr6VYvm8A1z5RVX46kLf4FcH4npIyzc=;
        b=Ak/7/LVrdci9Tkk2cYYmYcYpb94iwunoH1uhfBFXu2DPe7m5iQ+NIsmVWpf3WWuSz7
         rbLuWSVEPJCFjHvcqb7mEnbS2cGZhU2MSQIYUccQ/QG/65kUu8/+TYUHIlVDcRLXZdvI
         sQrF3YSg5rXdS985ABfCKMQ2vGZsVtbEa5owsn19RVygKm++Cjcpixh7X5sKSYnxGegO
         csgLVXfJV1Pg3qCw9QgIbDVETkQCERwzldVwv8TCZh3j8WQj7pDvOnlSG8Dd59pEwSrU
         80ZXxUOSzEQ5lrtI3VDgcLs7dBktg+TtkZXH5vVEbfRenXstbXRwqFulvZw75EpK6S1e
         Eb7Q==
X-Gm-Message-State: AOAM531NCINhkXXPSa/ITReLaNM7YfJaK98a9JCBbzpmqG6MmRcEZGZ0
        yUwsbmRRdYBeVg2KKmlW2K+k674qNdicZC7YnFHDkg==
X-Google-Smtp-Source: ABdhPJyGT5d7kAzOWWOZyEuq+BVCrWdPRUSfm6tf7pVHXKklSwXBe0J8rse0+Sbr94QBjZSwHfW71Ao8kAoWRyg03gY=
X-Received: by 2002:a05:6102:310f:: with SMTP id e15mr92501vsh.39.1600870936625;
 Wed, 23 Sep 2020 07:22:16 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 23 Sep 2020 19:52:05 +0530
Message-ID: <CA+G9fYtF44bTzjswt26tOwfEQxrWvcSOROmEtH0HKfGn24QbRQ@mail.gmail.com>
Subject: selftests: pidfd: pidfd_wait hangs on linux next kernel on all devices
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

selftests: pidfd: pidfd_wait hangs on linux next kernel on x86_64,
i386 and arm64 Juno-r2
These devices are using NFS mounted rootfs.
I have tested pidfd testcases independently and all test PASS.

The Hang or exit from test run noticed when run by run_kselftest.sh

pidfd_wait.c:208:wait_nonblock:Expected sys_waitid(P_PIDFD, pidfd,
&info, WSTOPPED, NULL) (-1) == 0 (0)
wait_nonblock: Test terminated by assertion

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: e64997027d5f171148687e58b78c8b3c869a6158
  git describe: next-20200922
  make_kernelversion: 5.9.0-rc6
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/865/config

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Test output log:
---------------------
[ 1385.104983] audit: type=1701 audit(1600804535.960:87865):
auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=31268
comm=\"pidfd_wait\"
exe=\"/opt/kselftests/default-in-kernel/pidfd/pidfd_wait\" sig=6 res=1

# selftests: pidfd: pidfd_wait
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.wait_simple ...
# #            OK  global.wait_simple
# ok 1 global.wait_simple
# #  RUN           global.wait_states ...
# #            OK  global.wait_states
# ok 2 global.wait_states
# #  RUN           global.wait_nonblock ...
# # pidfd_wait.c:208:wait_nonblock:Expected sys_waitid(P_PIDFD, pidfd,
&info, WSTOPPED, NULL) (-1) == 0 (0)
# # wait_nonblock: Test terminated by assertion
# #          FAIL  global.wait_nonblock
# not ok 3 global.wait_nonblock
# # FAILED: 2 / 3 tests passed.
# # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
Marking unfinished test run as failed

ref:
https://lkft.validation.linaro.org/scheduler/job/1782129#L11737
https://lkft.validation.linaro.org/scheduler/job/1782130#L12735
https://lkft.validation.linaro.org/scheduler/job/1782138#L14178

-- 
Linaro LKFT
https://lkft.linaro.org

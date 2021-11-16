Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8204529C9
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 06:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhKPFej (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 00:34:39 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58554 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhKPFe2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 00:34:28 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:57294)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmr44-0061wr-4m; Mon, 15 Nov 2021 22:31:28 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45424 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmr41-001kkp-Ra; Mon, 15 Nov 2021 22:31:27 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Marko =?utf-8?B?TcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        <linux-api@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <20211101034147.6203-1-khuey@kylehuey.com>
        <877ddqabvs.fsf@disp2133>
        <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
        <87fsse8maf.fsf@disp2133>
        <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
        <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
Date:   Mon, 15 Nov 2021 23:29:11 -0600
In-Reply-To: <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
        (Kyle Huey's message of "Mon, 8 Nov 2021 15:58:21 -0800")
Message-ID: <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mmr41-001kkp-Ra;;;mid=<87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18p/w9FA9mP3DYg6eIC8J58yA3YyhBqU9Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4942]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1362 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (1.0%), b_tie_ro: 11 (0.8%), parse: 1.64
        (0.1%), extract_message_metadata: 5 (0.4%), get_uri_detail_list: 2.2
        (0.2%), tests_pri_-1000: 6 (0.5%), tests_pri_-950: 1.78 (0.1%),
        tests_pri_-900: 1.43 (0.1%), tests_pri_-90: 62 (4.6%), check_bayes: 60
        (4.4%), b_tokenize: 10 (0.7%), b_tok_get_all: 9 (0.7%), b_comp_prob:
        3.2 (0.2%), b_tok_touch_all: 34 (2.5%), b_finish: 0.97 (0.1%),
        tests_pri_0: 1243 (91.3%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 3.8 (0.3%), poll_dns_idle: 1.25 (0.1%), tests_pri_10:
        4.0 (0.3%), tests_pri_500: 11 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] signal: requeuing undeliverable signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Kyle Huey recently reported[1] that rr gets confused if SIGKILL prevents
ptrace_signal from delivering a signal, as the kernel setups up a signal
frame for a signal that rr did not have a chance to observe with ptrace.

In looking into it I found a couple of bugs and a quality of
implementation issue.

- The test for signal_group_exit should be inside the for loop in get_signal.
- Signals should be requeued on the same queue they were dequeued from.
- When a fatal signal is pending ptrace_signal should not return another
  signal for delivery.

Kyle Huey has verified[2] an earlier version of this change.

I have reworked things one more time to completely fix the issues
raised, and to keep the code maintainable long term.

I have smoke tested this code and combined with a careful review I
expect this code to work fine.  Kyle if you can double check that
my last round of changes still works for rr I would appreciate it.

Eric W. Biederman (3):
      signal: In get_signal test for signal_group_exit every time through the loop
      signal: Requeue signals in the appropriate queue
      signal: Requeue ptrace signals

 fs/signalfd.c                |  5 +++--
 include/linux/sched/signal.h |  7 ++++---
 kernel/signal.c              | 44 ++++++++++++++++++++++++++------------------
 3 files changed, 33 insertions(+), 23 deletions(-)

[1] https://lkml.kernel.org/r/20211101034147.6203-1-khuey@kylehuey.com
[2] https://lkml.kernel.org/r/CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com

Eric

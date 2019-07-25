Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EFA754BA
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfGYQ5h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 12:57:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33382 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGYQ5g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 12:57:36 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqh3a-0001sw-Mh; Thu, 25 Jul 2019 10:57:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqh3W-00083e-6X; Thu, 25 Jul 2019 10:57:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, joel@joelfernandes.org,
        tglx@linutronix.de, tj@kernel.org, dhowells@redhat.com,
        jannh@google.com, luto@kernel.org, akpm@linux-foundation.org,
        cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
References: <20190724144651.28272-1-christian@brauner.io>
        <20190724144651.28272-5-christian@brauner.io>
        <20190725103543.GF4707@redhat.com>
        <20190725104006.7myahvjtnbcgu3in@brauner.io>
        <20190725112503.GG4707@redhat.com> <20190725114359.GH4707@redhat.com>
        <20190725122650.4i3arct5rpchqmyt@brauner.io>
Date:   Thu, 25 Jul 2019 11:57:19 -0500
In-Reply-To: <20190725122650.4i3arct5rpchqmyt@brauner.io> (Christian Brauner's
        message of "Thu, 25 Jul 2019 14:26:51 +0200")
Message-ID: <878ssmuk5s.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hqh3W-00083e-6X;;;mid=<878ssmuk5s.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18QSBD8aKgfkOI6Bh2C9GVbrFxs+FxUpU8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4140 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.2 (0.1%), b_tie_ro: 1.53 (0.0%), parse: 1.00
        (0.0%), extract_message_metadata: 14 (0.3%), get_uri_detail_list: 2.4
        (0.1%), tests_pri_-1000: 14 (0.3%), tests_pri_-950: 1.06 (0.0%),
        tests_pri_-900: 0.88 (0.0%), tests_pri_-90: 27 (0.7%), check_bayes: 26
        (0.6%), b_tokenize: 9 (0.2%), b_tok_get_all: 9 (0.2%), b_comp_prob:
        3.2 (0.1%), b_tok_touch_all: 3.5 (0.1%), b_finish: 0.62 (0.0%),
        tests_pri_0: 324 (7.8%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 4.7 (0.1%), poll_dns_idle: 3743 (90.4%),
        tests_pri_10: 1.91 (0.0%), tests_pri_500: 3751 (90.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Thu, Jul 25, 2019 at 01:43:59PM +0200, Oleg Nesterov wrote:
>> Or. We can change wait_consider_task() to not clear ->notask_error if
>> WXXX and the child is PF_WAIT_PID.
>> 
>> This way you can "safely" use wait() without WNOHANG, it won't block if
>> all the children which can report an even are PF_WAIT_PID.
>> 
>> But I do not understand your use-cases, I have no idea if this can help
>
> One usecase (among others listed in the commit message) are shared
> libraries. P_ALL is usually something you can't really use in a shared
> library because you have no idea what else might be fork()ed off. Only
> the main program can use this but none of the auxiliary libraries that
> it uses.
> The other way around you want to be able fork() off something without
> affecting P_ALL in the main program.
> The key is that you want to be able to create child processes in a
> shared library without the main programing having to know about this so
> that it can use P_ALL and never get stuff from the library.
>
> Assume you have a project with a main loop with a million things
> happening in that mainloop like some gui app running an avi video. For
> example, gtk uses gstreamer which forks off all codecs in child
> processes which are sandboxed for security. So gstreamer is using helper
> processes in the background which are my children now. Now I'm creating
> four more additional helper processes as well. Now, in my (glib, qt
> whatever) mainloop on SIGCHLD some part of the app is checking with
> WNHOANG and finds a process has exited. It's cleaning this thing up now
> but it's not a process it wanted to clean up. The other part of the app
> is now doing waitid(P_PID, pid) but will find the process already gone
> it wanted to reap.
>
> I hope I'm expressing this well enough.


I think so.

A) I think Oleg is correct that you should test the flag in
   do_wait_thread rather than elsewhere.

B) We have a deficiency in do_wait that should be addressed.  The
   do_wait function does not have a fast path for waiting on a
   particular process.  For adding this functionality I such a fast path
   goes from a nice to have to a necessity for getting all of the
   fiddly details correct.

C) I believe the semantics should be that while such a file descriptor
   is open, only that file descriptor can be used to reap the process.
   And that it should be allowed to pass the file descriptor between
   processes.  Which means the parent can die and the process be
   reparted to init and we should still be able to reap the process with
   the file descriptor.

D) I think it is a toss up how we should deal with such a process when
   the file descriptor is closed.  Setting the process to autoreap
   or reparent to init and let init deal with it.  My inclination is
   that autoreap is the correct behavior.
   
Eric

  




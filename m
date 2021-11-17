Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811DB454AFE
	for <lists+linux-api@lfdr.de>; Wed, 17 Nov 2021 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhKQQec (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Nov 2021 11:34:32 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55958 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbhKQQe3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Nov 2021 11:34:29 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:33436)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnNqL-00AvqG-5R; Wed, 17 Nov 2021 09:31:29 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57668 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnNqK-000CQN-0b; Wed, 17 Nov 2021 09:31:28 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Marko =?utf-8?B?TcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211101034147.6203-1-khuey@kylehuey.com>
        <877ddqabvs.fsf@disp2133>
        <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
        <87fsse8maf.fsf@disp2133>
        <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
        <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
        <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
        <875yssekcd.fsf_-_@email.froward.int.ebiederm.org>
        <202111161022.7B5720B@keescook>
Date:   Wed, 17 Nov 2021 10:31:20 -0600
In-Reply-To: <202111161022.7B5720B@keescook> (Kees Cook's message of "Tue, 16
        Nov 2021 10:23:48 -0800")
Message-ID: <877dd6bv6v.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnNqK-000CQN-0b;;;mid=<877dd6bv6v.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19oxkzpsBrrn4aOH5JpxHcwA5X7nGF6NIo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 588 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.7%), parse: 1.21
        (0.2%), extract_message_metadata: 17 (2.8%), get_uri_detail_list: 1.98
        (0.3%), tests_pri_-1000: 21 (3.6%), tests_pri_-950: 1.45 (0.2%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 93 (15.9%), check_bayes:
        89 (15.2%), b_tokenize: 7 (1.2%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 65 (11.0%), b_finish: 1.36
        (0.2%), tests_pri_0: 427 (72.6%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.47 (0.1%), tests_pri_10:
        2.6 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] signal: In get_signal test for signal_group_exit every time through the loop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, Nov 15, 2021 at 11:32:50PM -0600, Eric W. Biederman wrote:
>> 
>> Recently while investigating a problem with rr and signals I noticed
>> that siglock is dropped in ptrace_signal and get_signal does not jump
>> to relock.
>> 
>> Looking farther to see if the problem is anywhere else I see that
>> do_signal_stop also returns if signal_group_exit is true.  I believe
>> that test can now never be true, but it is a bit hard to trace
>> through and be certain.
>> 
>> Testing signal_group_exit is not expensive, so move the test for
>> signal_group_exit into the for loop inside of get_signal to ensure
>> the test is never skipped improperly.
>
> Seems reasonable.
>
>> 
>> This has been a potential since I added the test for signal_group_exit
>
> nit: missing word after "potential"? "bug", "problem"?

Yes.  Potential problem.  I will update the comment.

>> was added.
>> 
>> Fixes: 35634ffa1751 ("signal: Always notice exiting tasks")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> ---
>>  kernel/signal.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 7c4b7ae714d4..986fa69c15c5 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2662,19 +2662,19 @@ bool get_signal(struct ksignal *ksig)
>>  		goto relock;
>>  	}
>>  
>> -	/* Has this task already been marked for death? */
>> -	if (signal_group_exit(signal)) {
>> -		ksig->info.si_signo = signr = SIGKILL;
>> -		sigdelset(&current->pending.signal, SIGKILL);
>> -		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
>> -				&sighand->action[SIGKILL - 1]);
>> -		recalc_sigpending();
>> -		goto fatal;
>> -	}
>> -
>>  	for (;;) {
>>  		struct k_sigaction *ka;
>>  
>> +		/* Has this task already been marked for death? */
>> +		if (signal_group_exit(signal)) {
>> +			ksig->info.si_signo = signr = SIGKILL;
>> +			sigdelset(&current->pending.signal, SIGKILL);
>> +			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
>> +				&sighand->action[SIGKILL - 1]);
>> +			recalc_sigpending();
>> +			goto fatal;
>> +		}
>> +
>>  		if (unlikely(current->jobctl & JOBCTL_STOP_PENDING) &&
>>  		    do_signal_stop(0))
>>  			goto relock;
>> -- 
>> 2.20.1
>> 

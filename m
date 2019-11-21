Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE2105BF1
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 22:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKUV3J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 21 Nov 2019 16:29:09 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39276 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKUV3J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 16:29:09 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iXu09-00071w-Ic; Thu, 21 Nov 2019 14:28:33 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iXtzu-00068w-Nz; Thu, 21 Nov 2019 14:28:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, serge@hallyn.com
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
        <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
Date:   Thu, 21 Nov 2019 15:27:49 -0600
In-Reply-To: <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
        (Prakash Sangappa's message of "Mon, 18 Nov 2019 09:01:18 -0800")
Message-ID: <87wobszzqi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iXtzu-00068w-Nz;;;mid=<87wobszzqi.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX182a0yGpvBu2lFxE1HKcEnWojHyg7qEIgI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_05,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_14,XMNoVowels,XMSubLong,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0115]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Prakash Sangappa <prakash.sangappa@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 429 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.85 (0.4%), parse: 0.82
        (0.2%), extract_message_metadata: 3.5 (0.8%), get_uri_detail_list:
        1.52 (0.4%), tests_pri_-1000: 3.1 (0.7%), tests_pri_-950: 1.11 (0.3%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 23 (5.3%), check_bayes: 22
        (5.0%), b_tokenize: 7 (1.5%), b_tok_get_all: 8 (1.7%), b_comp_prob:
        2.4 (0.6%), b_tok_touch_all: 3.5 (0.8%), b_finish: 0.58 (0.1%),
        tests_pri_0: 380 (88.6%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.79 (0.2%), tests_pri_10:
        1.82 (0.4%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RESEND RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability inside user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Prakash Sangappa <prakash.sangappa@oracle.com> writes:

> Allow CAP_SYS_NICE to take effect for processes having effective uid of a
> root user from init namespace.
>
> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
> ---
>  kernel/sched/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f..628bd46 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4548,6 +4548,8 @@ int can_nice(const struct task_struct *p, const int nice)
>  	int nice_rlim = nice_to_rlimit(nice);
>  
>  	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
> +		(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
> +		uid_eq(current_euid(), GLOBAL_ROOT_UID)) ||
>  		capable(CAP_SYS_NICE));
>  }
>  
> @@ -4784,7 +4786,9 @@ static int __sched_setscheduler(struct task_struct *p,
>  	/*
>  	 * Allow unprivileged RT tasks to decrease priority:
>  	 */
> -	if (user && !capable(CAP_SYS_NICE)) {
> +	if (user && !(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
> +		uid_eq(current_euid(), GLOBAL_ROOT_UID)) &&
> +		!capable(CAP_SYS_NICE)) {
>  		if (fair_policy(policy)) {
>  			if (attr->sched_nice < task_nice(p) &&
>  			    !can_nice(p, attr->sched_nice))


I remember looking at this before.  I don't remember if I commented.

1) Having GLOBAL_ROOT_UID in a user namespace is A Bad Idea™.
   Definitely not something we should make special case for.
   That configuration is almost certainly a privilege escalation waiting
   to happen.

2) If I read the other thread correctly there was talk about setting the
   nice levels of processes in other containers.  Ouch!

   The only thing I can think that makes any sense at all is to allow
   setting the nice levels of the processes in your own container.

   I can totally see having a test to see if a processes credentials are
   in the caller's user namespace or a child of caller's user namespace
   and allowing admin level access if the caller has the appropriate
   caps in their user namespace.

   But in this case I don't see anything preventing the admin in a
   container from using the ordinary nice levels on a task.  You are
   unlocking the nice levels reserved for the system administrator
   for special occassions.   I don't see how that makes any sense
   to do from inside a container.

The design goal of user namespaces (assuming a non-buggy kernel) is to
ensure user namespaces give a user no more privileges than the user had
before creating a user namespace.  In this case you are granting a user
who creates a user namespace the ability to change nice levels on all
process in the system (limited to users whose uid happens to be
GLOBAL_ROOT_UID).  But still this is effectively a way to get
CAP_SYS_NICE back if it was dropped.

As a violation of security policy this change simply can not be allowed.
The entire idiom:  "ns_capable(__task_cred(p)->user_ns, ...)" is a check
that provides no security.

Eric





   
   


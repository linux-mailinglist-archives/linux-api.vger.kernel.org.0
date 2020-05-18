Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8B1D8B7D
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 01:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgERXL6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 19:11:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50656 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgERXL6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 19:11:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaovK-0002rl-SN; Mon, 18 May 2020 17:11:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jaovG-0003jx-Ae; Mon, 18 May 2020 17:11:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, tycho@tycho.ws,
        keescook@chromium.org, cyphar@cyphar.com
References: <20200515234005.32370-1-sargun@sargun.me>
Date:   Mon, 18 May 2020 18:08:11 -0500
In-Reply-To: <20200515234005.32370-1-sargun@sargun.me> (Sargun Dhillon's
        message of "Fri, 15 May 2020 16:40:05 -0700")
Message-ID: <87h7wc4zac.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jaovG-0003jx-Ae;;;mid=<87h7wc4zac.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18PaDb13dtx9TkkbNG4DzN0+x9R61gVrp0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4170]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sargun Dhillon <sargun@sargun.me>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4163 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (0.3%), b_tie_ro: 11 (0.3%), parse: 1.33
        (0.0%), extract_message_metadata: 17 (0.4%), get_uri_detail_list: 1.63
        (0.0%), tests_pri_-1000: 7 (0.2%), tests_pri_-950: 1.71 (0.0%),
        tests_pri_-900: 1.38 (0.0%), tests_pri_-90: 163 (3.9%), check_bayes:
        140 (3.4%), b_tokenize: 7 (0.2%), b_tok_get_all: 6 (0.1%),
        b_comp_prob: 2.3 (0.1%), b_tok_touch_all: 120 (2.9%), b_finish: 1.10
        (0.0%), tests_pri_0: 266 (6.4%), check_dkim_signature: 0.66 (0.0%),
        check_dkim_adsp: 3.0 (0.1%), poll_dns_idle: 3670 (88.2%),
        tests_pri_10: 2.2 (0.1%), tests_pri_500: 3687 (88.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sargun Dhillon <sargun@sargun.me> writes:

> This includes the thread group leader ID in the seccomp_notif. This is
> immediately useful for opening up a pidfd for the group leader, as
> pidfds only work on group leaders.

The code looks fine (except for the name of the test), but can you
please talk and think about this as something other than the
group leader?

The initial thread in a thread group can die, and the tgid is still
valid for the entire group.  Because the initial thread of a
process/thread group can die (but rarely does) that tends to result in
kernel code that fails when thread_group_leader dies.

To remove that class of bugs I am slowy working to remove the
thread_group_leader from the kernel entirely.

Looking at the names of the fields in the structure it looks like
there is another class of bugs to be removed by renaming PIDTYPE_PID
to PIDTYPE_TID in the kernel as well.  Just skimming the example code
it looks very simple to get confused.

Is there any chance some can modify struct seccomp_notify to do
{
	...
        union {
		__u32 pid;
                __u32 tid;
	};
        ...
}

Just to reduce the chance of confusion between the userspace pid and the
in kernel pid names?

Eric

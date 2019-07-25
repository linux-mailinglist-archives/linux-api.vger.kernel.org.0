Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414E175145
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfGYOek (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 10:34:40 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47383 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387419AbfGYOek (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 10:34:40 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqepJ-0001Jq-24; Thu, 25 Jul 2019 08:34:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hqepH-0006NE-M7; Thu, 25 Jul 2019 08:34:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20190724144651.28272-1-christian@brauner.io>
        <20190724144651.28272-3-christian@brauner.io>
        <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
Date:   Thu, 25 Jul 2019 09:34:28 -0500
In-Reply-To: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 24 Jul 2019 10:45:38 -0700")
Message-ID: <87zhl2uqrv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hqepH-0006NE-M7;;;mid=<87zhl2uqrv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gVaTKVGLJz8XxpXm33KW5W1R4i/Eu1S8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 280 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.4 (0.9%), b_tie_ro: 1.68 (0.6%), parse: 0.74
        (0.3%), extract_message_metadata: 14 (4.9%), get_uri_detail_list: 1.07
        (0.4%), tests_pri_-1000: 21 (7.4%), tests_pri_-950: 1.27 (0.5%),
        tests_pri_-900: 1.09 (0.4%), tests_pri_-90: 21 (7.5%), check_bayes: 19
        (6.9%), b_tokenize: 6 (2.3%), b_tok_get_all: 6 (2.2%), b_comp_prob:
        1.91 (0.7%), b_tok_touch_all: 3.0 (1.1%), b_finish: 0.66 (0.2%),
        tests_pri_0: 206 (73.7%), check_dkim_signature: 0.49 (0.2%),
        check_dkim_adsp: 3.0 (1.1%), poll_dns_idle: 0.22 (0.1%), tests_pri_10:
        2.2 (0.8%), tests_pri_500: 7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner <christian@brauner.io> wrote:
>>
>> This adds the pidfd_wait() syscall.
>
> I despise this patch.
>
> Why can't this just be a new P_PIDFD flag, and then use
> "waitid(P_PIDFD, pidfd, ...);"
>
> Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
> takes an argument of type pid_t, but it's the same type in the end,
> and it does seem like the whole *point* of "waitid()" is that
> "idtype_t idtype" which tells you what kind of ID you're passing it.

Just to emphasize this point.

The posix declaration of waitid is:
>int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);

Where id_t is defined as:
> id_t - Used as a general identifier; can be used to contain at least a pid_t, uid_t, or gid_t.

And the BSDs at least have defined P_UID and P_GID.  So that flexibility
has been used.

So it looks entirely reasonable to have P_PIDFD that just waits for a
specified child.

Eric

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3F3B7A85
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhF2W5i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 18:57:38 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35474 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhF2W5g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Jun 2021 18:57:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:47960)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lyMdH-000LwU-8A; Tue, 29 Jun 2021 16:55:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41336 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lyMdG-0039ez-C7; Tue, 29 Jun 2021 16:55:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-api@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        <linux-man@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Jun 2021 17:54:24 -0500
Message-ID: <87r1gkp9i7.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lyMdG-0039ez-C7;;;mid=<87r1gkp9i7.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+C/+RI8ccgi3UsWtxmzQboBPz6VqLQeJo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_XMDrugObfuBody_08 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4894]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-api@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 317 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (3.7%), b_tie_ro: 10 (3.2%), parse: 0.92
        (0.3%), extract_message_metadata: 2.9 (0.9%), get_uri_detail_list:
        0.73 (0.2%), tests_pri_-1000: 3.5 (1.1%), tests_pri_-950: 1.19 (0.4%),
        tests_pri_-900: 1.00 (0.3%), tests_pri_-90: 66 (20.9%), check_bayes:
        65 (20.4%), b_tokenize: 4.4 (1.4%), b_tok_get_all: 4.9 (1.6%),
        b_comp_prob: 1.60 (0.5%), b_tok_touch_all: 51 (15.9%), b_finish: 0.91
        (0.3%), tests_pri_0: 209 (65.9%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 0.91 (0.3%), tests_pri_10:
        3.1 (1.0%), tests_pri_500: 8 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Semantics of SECCOMP_MODE_STRICT?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


I am the process of cleaning up the process exit path in the kernel, and
as part of that I am looking at the callers of do_exit.  A very
interesting one is __seccure_computing_strict.

Looking at the code is very clear that if a system call is attempted
that is not in the table the thread attempting to execute that system
call is terminated.

Reading the man page for seccomp it says that the process is delivered
SIGKILL.

The practical difference is what happens for multi-threaded
applications.

What are the desired semantics for a multi-threaded application if one
thread attempts to use a unsupported system call?  Should the thread be
terminated or the entire application?

Do we need to fix the kernel, or do we need to fix the manpages?

Thank you,
Eric




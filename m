Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EC3B8992
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 22:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhF3UOk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 16:14:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49604 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhF3UOj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 16:14:39 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lygZ7-00BxLo-8J; Wed, 30 Jun 2021 14:12:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43832 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lygZ5-007Q6s-LZ; Wed, 30 Jun 2021 14:12:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-api@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87r1gkp9i7.fsf@disp2133> <202106292156.9458CF22@keescook>
Date:   Wed, 30 Jun 2021 15:11:23 -0500
In-Reply-To: <202106292156.9458CF22@keescook> (Kees Cook's message of "Tue, 29
        Jun 2021 22:23:06 -0700")
Message-ID: <87k0mbp0yc.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lygZ5-007Q6s-LZ;;;mid=<87k0mbp0yc.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18aOKYeX4bVt7U5rQ+ngAg94VyPJEFtMio=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4969]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michael Kerrisk <mtk.manpages@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1015 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.0%), b_tie_ro: 8 (0.8%), parse: 0.96 (0.1%),
         extract_message_metadata: 12 (1.2%), get_uri_detail_list: 0.82 (0.1%),
         tests_pri_-1000: 18 (1.7%), tests_pri_-950: 1.34 (0.1%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 86 (8.5%), check_bayes: 84
        (8.3%), b_tokenize: 6 (0.6%), b_tok_get_all: 5 (0.5%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 67 (6.6%), b_finish: 1.18 (0.1%),
        tests_pri_0: 874 (86.0%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 2.9 (0.3%), poll_dns_idle: 0.67 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 8 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] seccomp.2:  Clarify that bad system calls kill the thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 man2/seccomp.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/seccomp.2 b/man2/seccomp.2
index a3421871f0f4..bde54c3e3e99 100644
--- a/man2/seccomp.2
+++ b/man2/seccomp.2
@@ -69,9 +69,10 @@ The only system calls that the calling thread is permitted to make are
 .BR exit_group (2)),
 and
 .BR sigreturn (2).
-Other system calls result in the delivery of a
+Other system calls result in the termination of the calling thread,
+or termination of the entire process with the
 .BR SIGKILL
-signal.
+signal when there is only one thread.
 Strict secure computing mode is useful for number-crunching
 applications that may need to execute untrusted byte code, perhaps
 obtained by reading from a pipe or socket.
-- 
2.29.2

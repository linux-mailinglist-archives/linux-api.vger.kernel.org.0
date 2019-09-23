Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF18BBDE5
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2019 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503085AbfIWV2P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Sep 2019 17:28:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35019 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfIWV2O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Sep 2019 17:28:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCVsT-0001pQ-Cr; Mon, 23 Sep 2019 15:28:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iCVsS-0000Vb-NH; Mon, 23 Sep 2019 15:28:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
Date:   Mon, 23 Sep 2019 16:27:45 -0500
In-Reply-To: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com> (Michael
        Kerrisk's message of "Mon, 23 Sep 2019 11:12:00 +0200")
Message-ID: <87ftkmu2i6.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iCVsS-0000Vb-NH;;;mid=<87ftkmu2i6.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SQE2thKRm/QLiTB53mCy2cfZL6O/p/LI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4971]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 248 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.5 (1.0%), b_tie_ro: 1.74 (0.7%), parse: 0.92
        (0.4%), extract_message_metadata: 3.3 (1.3%), get_uri_detail_list:
        1.09 (0.4%), tests_pri_-1000: 3.7 (1.5%), tests_pri_-950: 1.27 (0.5%),
        tests_pri_-900: 0.97 (0.4%), tests_pri_-90: 18 (7.2%), check_bayes: 16
        (6.6%), b_tokenize: 5 (2.1%), b_tok_get_all: 5 (2.1%), b_comp_prob:
        1.76 (0.7%), b_tok_touch_all: 2.7 (1.1%), b_finish: 0.59 (0.2%),
        tests_pri_0: 200 (80.4%), check_dkim_signature: 0.49 (0.2%),
        check_dkim_adsp: 2.3 (0.9%), poll_dns_idle: 0.66 (0.3%), tests_pri_10:
        2.3 (0.9%), tests_pri_500: 8 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: For review: pidfd_send_signal(2) manual page
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> Hello Christian and all,
>
> Below, I have the rendered version of the current draft of
> the pidfd_send_signal(2) manual page that I have written.
> The page source can be found in a Git branch at:
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=draft_pidfd
>
> I would be pleased to receive corrections and notes on any
> details that should be added. (For example, are there error
> cases that I have missed?)
>
> Would you be able to review please?
>
> Thanks,
>
> Michael
>
>
> NAME
>        pidfd_send_signal - send a signal to a process specified by a file
>        descriptor
>
> SYNOPSIS
>        int pidfd_send_signal(int pidfd, int sig, siginfo_t info,

 This needs to be "siginfo_t *info," -----------------------^

>                              unsigned int flags);
>

Eric

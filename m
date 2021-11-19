Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9D44575A4
	for <lists+linux-api@lfdr.de>; Fri, 19 Nov 2021 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhKSRl0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Nov 2021 12:41:26 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:56124 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhKSRlX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Nov 2021 12:41:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:56980)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo7q7-00FTBc-TF; Fri, 19 Nov 2021 10:38:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43164 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo7q5-006GMV-W0; Fri, 19 Nov 2021 10:38:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kyle Huey <me@kylehuey.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Robert O'Callahan <rocallahan@gmail.com>
In-Reply-To: <20211119160348.22409-1-khuey@kylehuey.com> (Kyle Huey's message
        of "Fri, 19 Nov 2021 08:03:48 -0800")
References: <87y27mvnke.fsf@disp2133>
        <20211119160348.22409-1-khuey@kylehuey.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 19 Nov 2021 11:38:11 -0600
Message-ID: <87ilwonj0c.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mo7q5-006GMV-W0;;;mid=<87ilwonj0c.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/a0Zx+gWJ9DOTPKk9YuaDFOXKqR13iyuo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kyle Huey <me@kylehuey.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1380 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 13 (0.9%), b_tie_ro: 11 (0.8%), parse: 1.29
        (0.1%), extract_message_metadata: 16 (1.1%), get_uri_detail_list: 0.96
        (0.1%), tests_pri_-1000: 18 (1.3%), tests_pri_-950: 1.61 (0.1%),
        tests_pri_-900: 1.27 (0.1%), tests_pri_-90: 91 (6.6%), check_bayes: 87
        (6.3%), b_tokenize: 6 (0.4%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 68 (4.9%), b_finish: 1.15 (0.1%),
        tests_pri_0: 1213 (87.9%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 3.7 (0.3%), poll_dns_idle: 0.64 (0.0%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 18 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/6] coredump: Limit coredumps to a single thread group
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Kyle Huey <me@kylehuey.com> writes:

>> Solve this by making a userspace visible change to only kill a single
>> process/thread group. [...] With LinuxThreads long gone I don't
>> expect anyone to have a notice this behavior change in practice.
>
> FWIW rr's test suite does have an explicit test that we correctly record and 
> replay the old behavior. We don't actually care what that behavior is though,
> so we will update our tests.

Thanks.  I am keep being afraid someone will have a program where it
actually matters.  But so far so good.

Eric


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879F744671F
	for <lists+linux-api@lfdr.de>; Fri,  5 Nov 2021 17:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhKEQlI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Nov 2021 12:41:08 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58662 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhKEQlH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 5 Nov 2021 12:41:07 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:42698)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mj2ET-0040wi-Cl; Fri, 05 Nov 2021 10:38:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47856 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mj2ER-005uAo-CI; Fri, 05 Nov 2021 10:38:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
References: <878ry512iv.fsf@disp2133>
        <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
Date:   Fri, 05 Nov 2021 11:37:55 -0500
In-Reply-To: <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 3 Nov 2021 12:34:44 -0700")
Message-ID: <871r3uy2vw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mj2ER-005uAo-CI;;;mid=<871r3uy2vw.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VqaJj8/S8xVQx26R9tPAt2wUIi1RqVro=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1359 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (0.9%), b_tie_ro: 11 (0.8%), parse: 1.32
        (0.1%), extract_message_metadata: 21 (1.5%), get_uri_detail_list: 1.69
        (0.1%), tests_pri_-1000: 21 (1.6%), tests_pri_-950: 1.65 (0.1%),
        tests_pri_-900: 1.28 (0.1%), tests_pri_-90: 98 (7.2%), check_bayes: 82
        (6.1%), b_tokenize: 7 (0.5%), b_tok_get_all: 6 (0.5%), b_comp_prob:
        2.3 (0.2%), b_tok_touch_all: 63 (4.7%), b_finish: 1.00 (0.1%),
        tests_pri_0: 1190 (87.5%), check_dkim_signature: 0.62 (0.0%),
        check_dkim_adsp: 2.9 (0.2%), poll_dns_idle: 0.82 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] per signal_struct coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Nov 3, 2021 at 12:07 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Please pull the per_signal_struct_coredumps-for-v5.16 branch
>
> I've pulled it, but I'm not convinced about that odd extra merge
> commit that contains the commentary.
>
> That's what signed tags are for, and they have that explanation that
> then makes it into the merge - plus they have the crypto signature to
> show it all comes from you.
>
> So that would have been the much better model than a fake extra merge.
>
> But at least that extra merge did have explanations, so at least it
> doesn't trigger me on _that_ level.

I have been creating those when I place a patchset with an interesting
cover letter in a branch.  Now with the entire branch being just that
patchset, it doesn't make a lot of sense (except as somewhere to store
that cover letter so I don't loose it).  At other times when there are
multiple sets of changes on a single branch I think it makes more sense.

Am I missing a better way to preserve the cover letter for the
changes when multiple sets of changes land in a single branch?

Eric

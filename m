Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF662CAC9
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE1P5Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 11:57:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35975 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1P5Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 11:57:16 -0400
X-Greylist: delayed 2028 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 11:57:16 EDT
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVdwk-0005LO-Ez; Tue, 28 May 2019 09:23:26 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hVdwj-0000nk-MF; Tue, 28 May 2019 09:23:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        fweimer@redhat.com, oleg@redhat.com, arnd@arndb.de,
        dhowells@redhat.com, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
References: <20190526102612.6970-1-christian@brauner.io>
Date:   Tue, 28 May 2019 10:23:21 -0500
In-Reply-To: <20190526102612.6970-1-christian@brauner.io> (Christian Brauner's
        message of "Sun, 26 May 2019 12:26:11 +0200")
Message-ID: <87ef4i7gd2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hVdwj-0000nk-MF;;;mid=<87ef4i7gd2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192bua1YZy3Dbuv7XOFCoNXo6ZmQQ/qw3c=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian@brauner.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 412 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.0 (1.0%), b_tie_ro: 3.2 (0.8%), parse: 0.73
        (0.2%), extract_message_metadata: 10 (2.5%), get_uri_detail_list: 1.49
        (0.4%), tests_pri_-1000: 11 (2.7%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 33 (7.9%), check_bayes: 30
        (7.3%), b_tokenize: 11 (2.7%), b_tok_get_all: 9 (2.1%), b_comp_prob:
        4.4 (1.1%), b_tok_touch_all: 3.1 (0.7%), b_finish: 0.69 (0.2%),
        tests_pri_0: 340 (82.5%), check_dkim_signature: 0.66 (0.2%),
        check_dkim_adsp: 5 (1.3%), poll_dns_idle: 0.26 (0.1%), tests_pri_10:
        1.99 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] fork: add clone6
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> This adds the clone6 system call.
>
> As mentioned several times already (cf. [7], [8]) here's the promised
> patchset for clone6().
>
> We recently merged the CLONE_PIDFD patchset (cf. [1]). It took the last
> free flag from clone().
>
> Independent of the CLONE_PIDFD patchset a time namespace has been discussed
> at Linux Plumber Conference last year and has been sent out and reviewed
> (cf. [5]). It is expected that it will go upstream in the not too distant
> future. However, it relies on the addition of the CLONE_NEWTIME flag to
> clone(). The only other good candidate - CLONE_DETACHED - is currently not
> recycable as we have identified at least two large or widely used codebases
> that currently pass this flag (cf. [2], [3], and [4]). Given that we
> grabbed the last clone() flag we effectively blocked the time namespace
> patchset. It just seems right that we unblock it again.

I am not certain just extending clone is the right way to go.

- Last I looked glibc does not support calling clone without creating
  a stack first.  Which makes it unpleasant to support clone as a fork
  with extra flags as container runtimes would appreciate.

- Tying namespace creation to process creation is unnecessary.
  I admit both the time and the pid namespace actually need a new
  process before you can use them, but the trick of having a namespace
  for children and a namespace the current process uses seems to handle
  that case nicely.

- There is cruft in clone current runtimes do not use.
  The entire CSIGNAL mask. Also: CLONE_PARENT, CLONE_DETACHED.  And
  probably one or two other bits that I am not remembering right now.

  It would probably make sense to make all of the old linux-thread
  support optional so we can compile it out, and in a decade or two
  get rid of it as unused code.

Maybe some of this is time critical and doing everything in a single
system call makes sense.  But I don't a few extra microseconds matters
in container creation.  It feels to me like the road to better
maintenance of the kernel would just be to move work out of clone.

It certainly feels like we could implement all of the current
clone functionality on top of a simpler clone that I have described.

Perhaps we want sys_createns that like setns works on a single
namespace at a time.

Eric

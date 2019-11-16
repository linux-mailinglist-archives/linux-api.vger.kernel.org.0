Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9CFF624
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 00:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKPXhB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Sat, 16 Nov 2019 18:37:01 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34825 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfKPXhB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 16 Nov 2019 18:37:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iW7ca-0004q7-ES; Sat, 16 Nov 2019 16:36:52 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iW7cZ-0002Kz-8i; Sat, 16 Nov 2019 16:36:52 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter\, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
        <2787174.DQlWHN5GGo@positron.chronox.de>
        <2476454.l8LQlgn7Hv@positron.chronox.de>
Date:   Sat, 16 Nov 2019 17:36:25 -0600
In-Reply-To: <2476454.l8LQlgn7Hv@positron.chronox.de> ("Stephan
 \=\?utf-8\?Q\?M\=C3\=BCller\=22's\?\=
        message of "Sat, 16 Nov 2019 10:34:12 +0100")
Message-ID: <87k17z4cna.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iW7cZ-0002Kz-8i;;;mid=<87k17z4cna.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jtMUClcEVigt0J0xFKcebuOvgMEa2yOk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4098]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;Stephan M=c3=bcller <smueller@chronox.de>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 732 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.4 (0.3%), b_tie_ro: 1.61 (0.2%), parse: 0.85
        (0.1%), extract_message_metadata: 12 (1.6%), get_uri_detail_list: 1.29
        (0.2%), tests_pri_-1000: 13 (1.7%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.87 (0.1%), tests_pri_-90: 24 (3.3%), check_bayes: 23
        (3.1%), b_tokenize: 7 (1.0%), b_tok_get_all: 8 (1.1%), b_comp_prob:
        2.3 (0.3%), b_tok_touch_all: 3.3 (0.4%), b_finish: 0.53 (0.1%),
        tests_pri_0: 256 (35.0%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.2 (0.3%), poll_dns_idle: 399 (54.5%), tests_pri_10:
        1.90 (0.3%), tests_pri_500: 418 (57.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v25 03/12] LRNG - /proc interface
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Stephan Müller <smueller@chronox.de> writes:

> The LRNG /proc interface provides the same files as the legacy
> /dev/random. These files behave identically. Yet, all files are
> documented at [1].

For someone who works in this area a lot this description is confusing.

You are talking about sysctls not ordinary proc files.

You don't have a call register_sysctl.  If you want your own
implementation of these sysctls that would seem to be the way to get
them.  Teach each implementation to register their own set of sysctls
if they are enabled.

The entire structure of the code you are adding I have quite confusing,
and a bit messing.

Why add a declaration of random_table in patch 1 and then delete that
declaration in patch 3?  Nothing uses that declaration until this point.

What is the point of adding an extern declaration just before you
declare the table itself?  As I understand the C language that achieves
nothing.  I understand that is what the existing code in
drivers/char/random.c does but that is equally buggy there.

I also don't understand why you don't modify the existing random
generator code into the form you want?  What is the point of a
side-by-side replacement?  Especially since only one of them can
be compiled into the kernel at the same time?

This build a replacement and then switch over seems like a recipe for
loosing the lessons of history because you are not making incremental
changes that can be clearly understood, reviewed and bisected.

As I read your patchset until this change your code will fail to compile
in an ordinary configuration with proc enabled.  Have you even tested
compiling your patchset one patch at a time?

For me a great reorganization to impelment a better structure that fails
to have a good structure on the usual merits makes me dubious about the
entire thing.  As it can be a sign the author was pushing so hard to
make things work he stopped looking at problematic details.

Dubious-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric

> +
> +extern struct ctl_table random_table[];
> +struct ctl_table random_table[] = {
> +	{

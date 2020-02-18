Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD48161F0A
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2020 03:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgBRCkB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Feb 2020 21:40:01 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48680 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBRCkA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Feb 2020 21:40:00 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j3snj-0002JE-BO; Mon, 17 Feb 2020 19:39:55 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j3sni-0005j8-H3; Mon, 17 Feb 2020 19:39:55 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        x86@kernel.org, Andrei Vagin <avagin@gmail.com>
References: <874kvossh4.fsf@nanos.tec.linutronix.de>
Date:   Mon, 17 Feb 2020 20:37:55 -0600
In-Reply-To: <874kvossh4.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Tue, 18 Feb 2020 00:29:27 +0100")
Message-ID: <87lfp0boxo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j3sni-0005j8-H3;;;mid=<87lfp0boxo.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188tyzk0ONX2b2vqwoFCe9Sq5pQxsGyBLU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 327 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.8%), b_tie_ro: 1.83 (0.6%), parse: 0.63
        (0.2%), extract_message_metadata: 12 (3.8%), get_uri_detail_list: 1.01
        (0.3%), tests_pri_-1000: 15 (4.7%), tests_pri_-950: 0.97 (0.3%),
        tests_pri_-900: 0.83 (0.3%), tests_pri_-90: 23 (7.0%), check_bayes: 22
        (6.6%), b_tokenize: 7 (2.0%), b_tok_get_all: 8 (2.5%), b_comp_prob:
        1.97 (0.6%), b_tok_touch_all: 3.2 (1.0%), b_finish: 0.62 (0.2%),
        tests_pri_0: 259 (79.2%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.3 (0.7%), poll_dns_idle: 0.79 (0.2%), tests_pri_10:
        2.6 (0.8%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Time Namespaces: CLONE_NEWTIME and clone3()?
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Christian Brauner <christian.brauner@ubuntu.com> writes:
>> On Mon, Feb 17, 2020 at 10:47:53PM +0100, Michael Kerrisk (man-pages) wrote:
>>> Actually, I think the alternative you propose just here is better. I
>>> imagine there are times when one will want to create multiple
>>> namespaces with a single call to clone3(), including a time namespace.
>>> I think this should be allowed by the API. And, otherwise, clone3()
>>> becomes something of a second-class citizen for creating namespaces.
>>> (I don't really get the "less invasive" argument. Implementing this is
>>> just a piece of kernel to code to make user-space's life a bit simpler
>>> and more consistent.)
>>
>> I don't particularly mind either way. If there's actual users that need
>> to set it at clone3() time then we can extend it. So I'd like to hear
>> what Adrian, Dmitry, and Thomas think since they are well-versed how
>> this will be used in the wild. I'm weary of exposing a whole new uapi
>> struct and extending clone3() without any real use-case but I'm happy to
>> if there is!
>
> I really have no clue. I merily helped getting this in shape without
> creating havoc for timekeeping and VDSO. I have to punt to the container
> wizards.

Short version.  If you are going to do migration of a container with
CRIU you want the time namespace in your container.  Possibly you can
avoid creating the time namespace until restore, but I don't think so.

Without the time namespace you get all kinds of applications that use
monotonic timers that will see their timers be ill behaved (probably
going backwards) over a checkpoint-restart event.

Eric

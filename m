Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374DF1A3BF9
	for <lists+linux-api@lfdr.de>; Thu,  9 Apr 2020 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDIVfQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 9 Apr 2020 17:35:16 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45652 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIVfP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Apr 2020 17:35:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMepN-0006bs-Vj; Thu, 09 Apr 2020 15:35:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMepN-00032q-1R; Thu, 09 Apr 2020 15:35:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrey Vagin <avagin@openvz.org>
Cc:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
References: <703440af-031c-16b5-c1ff-54fb4bb5e10c@gmail.com>
        <CANaxB-y0ZB223dQgvxvUHRzkn4f-_B2vTzYxe_mi=o+3SJ4yVw@mail.gmail.com>
Date:   Thu, 09 Apr 2020 16:32:21 -0500
In-Reply-To: <CANaxB-y0ZB223dQgvxvUHRzkn4f-_B2vTzYxe_mi=o+3SJ4yVw@mail.gmail.com>
        (Andrey Vagin's message of "Thu, 9 Apr 2020 12:17:52 -0700")
Message-ID: <87a73kny56.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1jMepN-00032q-1R;;;mid=<87a73kny56.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ah23PW2EV6pjinWNRtdlzOJou4jxyK7w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrey Vagin <avagin@openvz.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 8 (1.6%), parse: 0.97 (0.2%),
         extract_message_metadata: 12 (2.4%), get_uri_detail_list: 1.21 (0.3%),
         tests_pri_-1000: 10 (2.0%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 105 (21.7%), check_bayes:
        102 (21.2%), b_tokenize: 11 (2.2%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 3.5 (0.7%), b_tok_touch_all: 77 (15.9%), b_finish: 1.00
        (0.2%), tests_pri_0: 329 (68.3%), check_dkim_signature: 0.66 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.38 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: A further though on /proc/PID/timens_offsets
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andrey Vagin <avagin@openvz.org> writes:

> On Tue, Apr 7, 2020 at 6:24 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>
>>        The  clock-id  identifies the clock whose offsets are being shown.
>>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
>>        TIME.
>>
>> What was the reason for exposing numeric clock IDs in the
>> timens_offsets file? In API terms, that seems a little ugly.
>>
>> I think it would have been much nicer if the clocks were defined
>> symbolically in this file. I.e., that reading the file would have
>> shown something like
>>
>> monotonic    x    y
>> boottime     x    y
>>
>> And that records similarly with symbolic clock names could have
>> been written to the file. Was there a reason not to do this?
>
> No, there was not except that I haven't thought about this. I agree
> that symbolic clock names looks nicer for humans, but numeric clock
> IDs are a bit more convenient when we  need to set/read offsets from
> code. This interface is in the released kernel, so I think we can't
> change the format of the content of this file. But we can add support
> of symbolic clock names for setting clock offsets. What do you think?

The rule is we can change things as long as userspace doesn't care.  For
very new interfaces like this it is possible there are few enough
userspace programs that nothing cares.

Do you know if someone is using this interface yet?

Eric

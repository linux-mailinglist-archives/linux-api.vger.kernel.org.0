Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74D12D604
	for <lists+linux-api@lfdr.de>; Tue, 31 Dec 2019 04:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfLaDuQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 22:50:16 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39438 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfLaDuQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 22:50:16 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1im8Xu-0005Oc-AF; Mon, 30 Dec 2019 20:50:14 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1im8Xt-0002v1-Dx; Mon, 30 Dec 2019 20:50:14 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        cl@linux.com, cai@lca.pw, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
        <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
        <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
        <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
        <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
        <20191218101711.GB21485@dhcp22.suse.cz>
        <0059a598-5726-2488-cd37-b4b7f9b3353e@linux.alibaba.com>
Date:   Mon, 30 Dec 2019 21:49:03 -0600
In-Reply-To: <0059a598-5726-2488-cd37-b4b7f9b3353e@linux.alibaba.com> (Yang
        Shi's message of "Mon, 30 Dec 2019 19:00:43 -0800")
Message-ID: <87lfqtcfyo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1im8Xt-0002v1-Dx;;;mid=<87lfqtcfyo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uhutDF4Ukz8J1ef+/uLeFxpg4smyiZiY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4296]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Yang Shi <yang.shi@linux.alibaba.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 360 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 5 (1.5%), b_tie_ro: 3.5 (1.0%), parse: 1.29
        (0.4%), extract_message_metadata: 12 (3.3%), get_uri_detail_list: 1.28
        (0.4%), tests_pri_-1000: 13 (3.5%), tests_pri_-950: 1.53 (0.4%),
        tests_pri_-900: 1.26 (0.3%), tests_pri_-90: 25 (7.0%), check_bayes: 23
        (6.4%), b_tokenize: 6 (1.6%), b_tok_get_all: 8 (2.3%), b_comp_prob:
        2.4 (0.7%), b_tok_touch_all: 3.4 (1.0%), b_finish: 0.97 (0.3%),
        tests_pri_0: 288 (80.0%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.9 (0.8%), poll_dns_idle: 1.05 (0.3%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already on the target nodes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> writes:

> On 12/18/19 2:17 AM, Michal Hocko wrote:
>> On Tue 17-12-19 23:36:09, John Hubbard wrote:
>> [...]
>>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>>> index 2d96468fa..1bf1053f2 100644
>>> --- a/man2/move_pages.2
>>> +++ b/man2/move_pages.2
>>> @@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>>>   .B ENODEV
>>>   One of the target nodes is not online.
>>>   .TP
>>> -.B ENOENT
>>> -No pages were found that require moving.
>>> -All pages are either already
>>> -on the target node, not present, had an invalid address or could not be
>>> -moved because they were mapped by multiple processes.
>>> -.TP
>>>   .B EPERM
>>>   The caller specified
>>>   .B MPOL_MF_MOVE_ALL
>>>
>>> ...But I'm not sure if we should change the implementation, instead, so
>>> that it *can* return ENOENT. That's the main question to resolve before
>>> creating any more patches, I think.
>> I would start by dropping any note about ENOENT first. I am not really
>> sure there is a reasonable usecase for it but maybe somebody comes up
>> with something and only then we should consider it.
>>
>> Feel free to add
>> Acked-by: Michal Hocko <mhocko@suse.com>
>>
>> ideally with a kernel commit which removed the ENOENT.
>
> A quick audit doesn't show kernel code or comment notes about ENOENT
> wrongly. The status could be set as ENOENT if the page is not present
> (follow_page() returns NULL), and man page does match what kernel
> does.

Doesn't the function one layer up then consume the ENOENT?

Eric


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2C136C3B
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 12:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgAJLox (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jan 2020 06:44:53 -0500
Received: from foss.arm.com ([217.140.110.172]:42924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgAJLox (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 10 Jan 2020 06:44:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352771063;
        Fri, 10 Jan 2020 03:44:52 -0800 (PST)
Received: from [10.37.13.8] (unknown [10.37.13.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1DBA3F534;
        Fri, 10 Jan 2020 03:44:46 -0800 (PST)
Subject: Re: [PATCHv8 02/34] lib/vdso: make do_hres and do_coarse as
 __always_inline
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20191112012724.250792-1-dima@arista.com>
 <20191112012724.250792-3-dima@arista.com>
 <ed2e65ae-75b0-ed79-0a95-90be6b82e6be@arm.com>
 <878smfa66i.fsf@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e74a63cb-5248-4473-81a7-d1b2f959ec7a@arm.com>
Date:   Fri, 10 Jan 2020 11:47:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <878smfa66i.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 1/10/20 11:42 AM, Thomas Gleixner wrote:
> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>> On 11/12/19 1:26 AM, Dmitry Safonov wrote:
>>> +» » vd·=·&vd[CS_HRES_COARSE];
>>> +out_hres:
>>> +» » return·do_hres(vd,·clock,·ts);
>>> » }·else·if·(msk·&·VDSO_COARSE)·{
>>> » » do_coarse(&vd[CS_HRES_COARSE],·clock,·ts);
>>> » » return·0;
>>> » }·else·if·(msk·&·VDSO_RAW)·{
>>> -» » return·do_hres(&vd[CS_RAW],·clock,·ts);
>>> +» » vd·=·&vd[CS_RAW];
>>> +» » /*·goto·allows·to·avoid·extra·inlining·of·do_hres.·*/
>>> +» » goto·out_hres;
>>
>> What is the performance impact of "goto out_hres"?
> 
> On x86 it's invisible at least in my limited testing.

On arm64 as well based on mine as well. Shall we keep the code more readable
here (without goto)?

> 
> Thanks,
> 
>         tglx
> 

-- 
Regards,
Vincenzo

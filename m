Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D791136C30
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 12:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgAJLnA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 10 Jan 2020 06:43:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgAJLm7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 06:42:59 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipsgg-0003Mf-5N; Fri, 10 Jan 2020 12:42:46 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BC66A105BE5; Fri, 10 Jan 2020 12:42:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: Re: [PATCHv8 02/34] lib/vdso: make do_hres and do_coarse as __always_inline
In-Reply-To: <ed2e65ae-75b0-ed79-0a95-90be6b82e6be@arm.com>
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-3-dima@arista.com> <ed2e65ae-75b0-ed79-0a95-90be6b82e6be@arm.com>
Date:   Fri, 10 Jan 2020 12:42:45 +0100
Message-ID: <878smfa66i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
> On 11/12/19 1:26 AM, Dmitry Safonov wrote:
>> +» » vd·=·&vd[CS_HRES_COARSE];
>> +out_hres:
>> +» » return·do_hres(vd,·clock,·ts);
>> » }·else·if·(msk·&·VDSO_COARSE)·{
>> » » do_coarse(&vd[CS_HRES_COARSE],·clock,·ts);
>> » » return·0;
>> » }·else·if·(msk·&·VDSO_RAW)·{
>> -» » return·do_hres(&vd[CS_RAW],·clock,·ts);
>> +» » vd·=·&vd[CS_RAW];
>> +» » /*·goto·allows·to·avoid·extra·inlining·of·do_hres.·*/
>> +» » goto·out_hres;
>
> What is the performance impact of "goto out_hres"?

On x86 it's invisible at least in my limited testing.

Thanks,

        tglx

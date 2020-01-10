Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7913F136CAC
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 13:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAJMCi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 10 Jan 2020 07:02:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgAJMCi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 07:02:38 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipszh-0003mg-RE; Fri, 10 Jan 2020 13:02:25 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7BD8C105BE5; Fri, 10 Jan 2020 13:02:25 +0100 (CET)
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
In-Reply-To: <e74a63cb-5248-4473-81a7-d1b2f959ec7a@arm.com>
References: <20191112012724.250792-1-dima@arista.com> <20191112012724.250792-3-dima@arista.com> <ed2e65ae-75b0-ed79-0a95-90be6b82e6be@arm.com> <878smfa66i.fsf@nanos.tec.linutronix.de> <e74a63cb-5248-4473-81a7-d1b2f959ec7a@arm.com>
Date:   Fri, 10 Jan 2020 13:02:25 +0100
Message-ID: <875zhja59q.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
> On 1/10/20 11:42 AM, Thomas Gleixner wrote:
>>>> +» » /*·goto·allows·to·avoid·extra·inlining·of·do_hres.·*/
>>>> +» » goto·out_hres;
>>>
>>> What is the performance impact of "goto out_hres"?
>> 
>> On x86 it's invisible at least in my limited testing.
>
> On arm64 as well based on mine as well. Shall we keep the code more readable
> here (without goto)?

The delta patch below makes it readable again and also avoids the double
inlining. Quick testing shows no difference.

Thanks,

        tglx

8<---------------
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -98,17 +98,15 @@ static __maybe_unused int
 	msk = 1U << clock;
 	if (likely(msk & VDSO_HRES)) {
 		vd = &vd[CS_HRES_COARSE];
-out_hres:
-		return do_hres(vd, clock, ts);
 	} else if (msk & VDSO_COARSE) {
 		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
 		return 0;
 	} else if (msk & VDSO_RAW) {
 		vd = &vd[CS_RAW];
-		/* This goto avoids extra inlining of do_hres. */
-		goto out_hres;
+	} else {
+		return -1;
 	}
-	return -1;
+	return do_hres(vd, clock, ts);
 }
 
 static __maybe_unused int

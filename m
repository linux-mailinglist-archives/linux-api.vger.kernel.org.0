Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE6A890B
	for <lists+linux-api@lfdr.de>; Wed,  4 Sep 2019 21:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfIDO4u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Sep 2019 10:56:50 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:34054
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729944AbfIDO4u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Sep 2019 10:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567609008; bh=ZiZUpa4OlflpyykovNV00Zn2esYZ6QcbKLYZHtiNUds=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kdTM8h4SvoXCtFh3aPtY0+13TysL9zTXW0z6Uyd1g2MFYlhcPLO2YfsD6a0NAY0n2a3JYANIy+7Xq0IpDlYqA1knU2FqmA4Ap3QGaUE0pKnXr82qfDdispihs+/LILi8RoBIGnO4XpN6B0kAneSe1e0W6sZHxAkrf+ZUCzp4NIPakTEpO/j4qQNaZ7FGbjPky5QN0Za6nAVc5XCtyNL3RXAAkvzrvUc+00Dnpv/kmOKXQfUC0lcd3EWV6sLr8g7jCcRUkPc4bUuCDymw6sko1oFXUjMgaJRx+EnXhNAlmWsKIJZbKEMklDfBAF8/SXfmMqp3cuLuZWJy/I54rhjFIA==
X-YMail-OSG: opM.IoIVM1nmPQ6ac22krzy3RhYyjsKlAXH..fafy0u1.b.v4c6Wst5wl4gwQZc
 kTsSvw7BqxrCGP075bn_ZMxZyduB5r90n5msR5B.4wDeABhoJ.3RTEnqSFut0Z3EfqvbzGwChUOj
 vGoA6QuK8NdhfCpXute0rpFHFYe3eL4hwWpyDPs6IRLZISdWGTmAzNwTowydw6lcfHIU.1g0z8UU
 CRlmnVLWjQu1z3SkDGcbympDZVRFuToMqECjO8z_KS6pFdwsaLy_HnU.t.80TejK_fVp5QRVJlj_
 oCtQGdLcBeS27MCucR1UpAG08DnBN3Pbqzi9vaWvjKqybLI9XvX.FBlfB2QC6_Fpkr70gQ6P4ZFu
 h7VqGy4vsVr1_cvw1EnARMfx25zEtF.JF2S6xpoloa1_5iVSRoglSF7bS2NIyEd8WY4e1xFKWxFj
 w24.V2AGGGUk302jPO4igK_HwxmYiTPjuamXwJ12Sm.ex2WwJfYzkiVmUkL5l.1zIH72QMKOcEkq
 5KQ8uAxX68oxn29eJeAlmdYutg4Dci1N2iwekXXGBDCw5hMpYnwTgKbaGho5LKedUrp4eQc8c.3V
 8wnq.qXjXR0rZfSCoB4Sm26kjGBUCAd5rBKstuXAvye7CrVm.s.cluybTF9O2A.9VghbGUhKmr_A
 _JSSQQ_Icmi9OS.OSwnvv_yCzRUAcd1sVyUsrA1btQYDLZhMSHMeD3sYCXMOFC6dqXpqGWrW9luN
 TX3mmwu6FPEGTWllORiJl.32.NS1AHeEvAkG0rxPhMaQkzGwdM_dx7okQg9_TBhjvsY6X3r8XR09
 Ln37Ne_gowGu6dOwpxwctC9wbOj7pZieFbDKf3Fp4wGIOdICbcCau63OrD23pwBpVkSoEgnjrBb4
 ZFOoKA_VKSGeh36umXadTqlQilhU74H0B.WXxfDYWbOZjfkQ3A0sBpsFyJNf95PgTDTp0C.UlQkg
 .QebP8aRAsp1nSPb3s9opmOlrlHpI2utLb1nYAnP9x1bIZTRgfTJBUp8L8psdwVdmLuz.OI.2rv.
 rOA7BtAsrSO3ycuHqALj4oIjugzd5xb8TKM1pvyc2W9ZKYO9uAYZ2BAtAQ6E5iiHEoWbPXdNrI.P
 lrnDg.f85u3yS2KtyAE61rvvgfzpVibnwGG7s1TboD47CVhhtsoYY_TxONC6fE9Knv.u1VHLII2F
 _F_rFz6nxKn6Ucj6UbtCvccxj7COilwe9s44nClkdUY7dfvV6WWXANRYApOeksAvpuw9C_A6S4FP
 NHe03IUfHxPXKv7DrtFvolZZAn8NfmznWc7U8MfHaqkysw4GG71Q9HGKrm3wiVCbRCJjCHT5k4ly
 b4bW5Pzp_1BYTK2AOZ2ib.gmWOs.nTzrfjjJp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2019 14:56:48 +0000
Received: by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ab143955ae61667d238fde3beed8cf6c;
          Wed, 04 Sep 2019 14:56:47 +0000 (UTC)
Subject: Re: [PATCH 11/11] smack: Implement the watch_key and
 post_notification hooks [untested] [ver #7]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <23d61564-026e-b37a-8b16-ce68d5949f6c@schaufler-ca.com>
 <87bf0363-af77-1e5a-961f-72730e39e3a6@schaufler-ca.com>
 <e36fa722-a300-2abf-ae9c-a0246fc66d0e@schaufler-ca.com>
 <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk>
 <4910.1567525310@warthog.procyon.org.uk>
 <11467.1567534014@warthog.procyon.org.uk>
 <31205.1567598939@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5be00881-258a-d888-e544-0d14ac496dcf@schaufler-ca.com>
Date:   Wed, 4 Sep 2019 07:56:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <31205.1567598939@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/4/2019 5:08 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> I rebuilt with keys-next, updated the tests again, and now
>> the suite looks to be running trouble free.
> Can I put you down as an Acked-by or something on this patch?

I haven't done anything to see if the patch is actually useful.
I don't have much (read: anything) in the way of key tests for
Smack, so I can't say if this is what I want long term. But as
it does appear harmless, yes, you can add my Acked-by on this.

>
> Thanks,
> David

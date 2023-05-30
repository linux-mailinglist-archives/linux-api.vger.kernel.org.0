Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACC7716D1A
	for <lists+linux-api@lfdr.de>; Tue, 30 May 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjE3TFN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 May 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjE3TFM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 May 2023 15:05:12 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B4102
        for <linux-api@vger.kernel.org>; Tue, 30 May 2023 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685473510; bh=29vdUlQQy1A/jtE7IYxgGsr2dtmKgUDXNUnDB6PPHm8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L9AfHzZwktsyeJ3XHl8TLISkOAP871XtNFM1HIBDnlQdtXZTewIlY99B4BJnO5/VoVUqRX2QybSi2WPqprxd3rQ35UA3tatz2Haj2+z6tuFCzVv2VoGCd2Q5zad5ELBk6v7dNX0eQUpWmd1XciSxFo5/mzt1UYM4MEwYmU9OQATCle/6OUOdYoDIVT9VqH9pISCk49YOdgDtwVEES31HG/cX2MnB23/0MugahKISkwr1uEKq9UEEWpQq7kNFf114GLYgXmWGrVe4U74zsNIyjbpn4tsoHweKswfOIV6Xkr4vLjhZk/CSIYVr/5SoLOrVIMyedc9yIARwRMMRBYv1Jg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685473510; bh=vM2MjgeiK0de7kwIrh0Owxv5oaaOChV6roR0U/jpSnf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Sulhujk6yxichHHBao2xmeAq2zK297+jBxpEV/w+fcBZzZ4ShFp3IDMDar+2+JxN1G6GYDQKjS6tsGOuVHgHypdnVuk6p+3riX088KIXej+vW7dFhzlQM30Myj1gftpmRFLQ1kEVlFCjPcVxTkwuUbkpOdAnH8Tk3qLSgxg3hdyniX69blwuz681yYZI6uxJ5jJcrr1/kK7mI6LgP01bgm7K/o50xz6dT+PCC36U9e3HvmKW4xGsvwHWiwFxRI7SMae9L/iBpg/0fBoe2PQXhjNMJw6oLjS45fZewy6uifvf89VrvYyjZRXpvR8ej3RRePQhd8cuI1wIbtozIOgUsQ==
X-YMail-OSG: osbvCaYVM1lwHvjwxwmcnmVCt_1ava3_l60lv6aYYMwNcX6qqrw934oc1w3Fz80
 g_G8ASWRIMcZI81e.31hpzr56VRfxbwWdPs9KbPiiQQG.H43aKks2CMzlovJ6dnPJovAiI5XlpEM
 DKHmbePhigzUH1msQFh5aU8rEnwjn3EQrjtCbgT5kCQ5d6uvJ4_KdAD_wZSxsgGLVvXDm1S7Pkvz
 dA3QbMBuebh50vKCqgCcMoSZEjH4lgUpnGZnyw8pPsbpxemZVCQiHnbXxxcDOmnYL3n55HJ5t3Vk
 7EGysNReLO5S1n5I8BAEf55r3OYzRG1KeDUtlOel4WflEbsGUFIyfQ5jB616pbfMpBuR2sHxkwZ8
 _Hlm6czf96UFdbiSAImG7H3lhB3mPyWOLW60ZCXj9xgLUuR2XMGkQoh5nmt2jr0fh5xyLwa.8K2Y
 83gzwa709tBGqNyMjccGbg1wZOe4WFoNRmab5t4ZeJfnVINgW3w2her_9exjbFySKKhkcsJHp6nh
 Q4Amo974EtPqsJbbuORNxzbax8.EB87RRqtMEJ4QzSHdzEYxDtG1kIDHcLVPQe71GIb1cJfsVFGH
 dz_vkz9_Z0ZlrPcx3H4.jmaJ2_kjtcmWxljyKS7a3jcA1xKnfwv.Mj4LBR2QCl62.8Zo3QAMpsxn
 Pkew6Ji_kWKEM5ViBMVmo7pRovJa_8MBpM2AN.APNWULfqM12C7A.HgJHUuZvRV6RBAhKMXipSQt
 0OA0iUp2PIbEfcglAVmy04WtvC49kib3iTNNMjfcvMGpDX0Y63oLW9V05pBt5Rw29F.FUjWGcqDS
 9Teu.RXh5OtuiUAXL4x1pZ3C84irsLGUBSdvB7WWQHkP0z_sXrhlwwS30id4qLyM.WZdQWsZlJYF
 _u1S0FcDdGDgm0xIiy7qeJN9CwRAE_78MNKh_dRllBDDLqLUcMvlltL3W_6hLtv0gAIyWnc503EW
 jERDXcGUFi4lzbBKiJx2KCWAXUsSb1VhdNAn4uSCrE88qSxooB1JtJE9zOVn.4D.jPSTfVljcL_0
 QS6bWkIYxRRxL8BDeFCxyeIR321hJzZzzP7_98Kiw9HaRVCFa_kq2.Rf8vEPOLPLo4y0x5S8fkhQ
 LyFILEC5Nmcf3pePyX4fBzduK5jWJo7RYSXuDJMmNYhbEBTeS5Bd1onzvlsagye1n4UABkD7jYvt
 j_SbLJw22T3mOFtBnuM5RVOTHWhADOnQVCdXt12gLe74nAXCn45VXafrgwHHajgkSQa75li36PS6
 2JpB7EwKFUcCEpLeCue6KCnbrwgK2rzxwfBhYWD7RlMv1vgGcVt4A_in_CS5JO3MePfeSjn4N5fM
 4ce7WT2.uVQ9d6D9iCU7FWH8MR.pSYOzU43aaL4V7Mw3EHgbe_dy5WPfZ.rRGspng9ut6GStxfgD
 5PSvjZymCHhZ8PHkQTV6YH4L44KAHJTNBgSEhSxOYQQZWJsLX5bYveKncZ51CE27InzY.Z.E1A7l
 aaa8jy2_UOIQwwJ5oARN_nkGvvzxckbxiABS5TN5aDxKGqUa8SOx_X9cilcNgkRz5yCGVl5bMMnj
 ZkhuDl73XjhGy2MEuid6VMS7eTJ3V47JTxcuxt2YIskMtwf1s7pxKAA12L_424FTPvlkpH5faNQ5
 hU9zIW2Qu9zMDdqQ.oBh1xMLBgJxXAYjgS0HZGArk_7_vmgFcXPF6WOLS.YYTPaSjBmrSCMbcWv4
 tyB1YrGuxbXY_gDuxd66_d8AGUxRrt0G2gSCEQZiLdCPGp8z8AOZirG4jR3TRYWc15d0Km6mizgr
 aOM.5QXDFF0tw0_2XEuNfHOuDrFZY31gTd_aHcysW.iBEjppkjKXyhgyhKTMK.QL.Q13358cFpjF
 3dYYijUoNYxkWAEhkOpTgaVw8R7jzd5jiJEybWSE8OUWafVU5vqrwzMYK9LTy2jZCb0joL3MYtlT
 zOkj0ilhG3ANUkey_nYfySsgupgkC.gCrmjFS_HF9SBm0l1CjLQrC6haf5YGdUOxfeeOjvMGuMgM
 QQWlNb_ceIsrYFehp9h9Was3URkPQQbFgGZBXLkLfvlL1EEdLttN02D0eGTQIUYZm5rE6h99QbcP
 r3eql0ucZtE_GJl601HyckHBMCXa.mlnpydSCIlfLB9p9KW8FSlg7kOcRCPdr.746bARchYfR2bg
 nb8VqTzaX9zbal09DiiqPj.9L0.oj2do0ZFUjrNBOKZ55DlwC4I3rXSDbUWrhChK3gWebvoHh71G
 ycOHSoBvXk4me6tHk9NpADPSNCWU5cILMMMowEPw1UhBJlPMPMk6T8E5IeVBIs15r1xojbYWkrxv
 A7gaHwk7aYcY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e54802b8-a8ab-4317-9506-bb92222a4492
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 May 2023 19:05:10 +0000
Received: by hermes--production-gq1-6db989bfb-jqsjz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 814f54fcd2f99d924aeb689c6ba8361f;
          Tue, 30 May 2023 19:05:08 +0000 (UTC)
Message-ID: <4055d6df-60cc-3e90-9af3-bd714a521481@schaufler-ca.com>
Date:   Tue, 30 May 2023 12:05:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org>
 <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
 <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/30/2023 11:02 AM, Jeff Xu wrote:
>>>> As I believe we are in the latter stages of review for the syscall
>>>> API, perhaps you could take a look and ensure that the current
>>>> proposed API works for what you are envisioning with Landlock?
>>>>
>>> Which review/patch to look for the proposed API ?
>> https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-ca.com/T/
>>
>>
> How easy is it to add a customized LSM with new APIs?

I haven't found it difficult, but that was in the pre-syscall era.
Look at Landlock for an example of LSM specific syscalls, if you want
to go that route.

> I'm asking because there are some hard-coded constant/macro, i.e.
>
> +#define LSM_ID_LANDLOCK 111
> (Do IDs need to be sequential ?)

No, but I would want a good reason for doing otherwise.

> + define LSM_CONFIG_COUNT
>
> Today, only security/Kconfig change is needed to add a new LSM, I think ?

That's correct. The syscall patches make it a trifle more difficult,
requiring they be acknowledged in security.c. We could probably work
around that, but it's really a small price to pay to get a constant
value.


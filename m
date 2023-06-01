Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75C71F4AD
	for <lists+linux-api@lfdr.de>; Thu,  1 Jun 2023 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFAVag (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jun 2023 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjFAVaf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jun 2023 17:30:35 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96C19D
        for <linux-api@vger.kernel.org>; Thu,  1 Jun 2023 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685655032; bh=zM+5aZeDwbSAee1Y5s2f8MQhwdxBalJ1GhUidbcbdaM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=g1hrqvKbTrcRnFxm+NnSrVqKMUmgX+BlydESoowmSBirqpZCBXS2kKiI3jhqdcCisXwKt9nK4Z2rbE2979pEHxz+EXxaUbrMERIXjADxs11c1hDWpL2ZReQtcemJvN6g1cURApbNGlCI81J5gQX/OIs1Ccq201/JIXWEEp8iWUESixBvOBdGWHJlB6Smonmpe3uzsq52nAf0r3300ooYqUIpQqZtn2get7AzYQg9pXLapnIgG92mOyayYnx2GFq0D5mpH4WDZkFlkOVbtvxJwDc+s1jwfEIcl+6s5hyHjiSn+zqKnrkR09WWUNAvK5wRDN+kcxxHLszSk4FGZZw34A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685655032; bh=nXKJOFN59Kbraw/P9k0UYhOxXgdXEeVexuRFwNr46OU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ch7h1x+9QQ74T8pFzy0vJ9udIetNpb7PD78Sv5oeV0c66wxzEv4WmI+UhE2KGSTNs0DGfv/WroQhZrTI7LtuI5MvDJCCbx2pmAb7uK95ljrNcoDW524ecVHnkf7ARAf2r81v9GvckKqBClbzNb/klLvz8+A+FflnA9PdMVzEZSfqnn9edsRdiK0Q/OZA2BxiWxSBQtkV5Ye2Ii0UnhFWSl9LxgO+VWCjlLEd4MSVcpR6Hd3xa2l4ckRVLcCBkFmRvRt7rUSGnZMQoDV1BTG3IFw1DxL8x5EuZVoXsMMJoXIjUHTDEwukQWp/l/wIRYNmvthmDMwWxGhOE+G27Ao48A==
X-YMail-OSG: ul6sybQVM1ma.m_.OSFbciMpz40DiGqCFCUHXQMP0rXhPPLaSgNiQxyoto5BjaP
 kMn4VFmb30pgM_Zvlpa93SoWhoW2Y7ktqCZp9DQ6QDxZDIAXp3S5grMGSPtxa_ylMYOh.D_qnxIs
 lt0eUEB0oL8bH9cBujk_LwIQApBqmjJkaMidO.ROM6ZFtoQQq8Elw1RRtXkGO_pWRnZ7Dy0PUvoN
 ZNidJjXcjrKwT70fE7L0l8lpBHFebe5MP5IKq4fc2LUDD3aGyW1n3uAc5f59haY4Hna2Ggi7a0Oz
 H42JmYH1g3GVtVR3rMoIW8I4nsR8cI2Aukdykhlj2ELuSlX.C5M33WCcj1HQsJ72AfgtjeyosYIl
 XypmyKR2Ug8yAVDS53G3Iohu.qk4QFy5ibyvK0RLJOAmeZUw7_n0_WdmVwwnpPL3W_xlGML2Uhh3
 gDGkkxK119dmG9R7IxuyweoUUxo4dqsfV1RXPK5ft40.7zyareDWO12iIaPd_MPgK9gVbPeVCfyt
 rYwvSzGcBNIzMERH2eViTQHIrrReVnFpKqpTd9b1MmseXDOn1d4TwCk8ylQF3mfSM89pNLjhG295
 v6K7voLpZaNadmuP.nnCbhTFzjZ_YDRrqP9wqK3.6D.I1V6sP4xPeF3esycWerjTrfnX4XtuKoNE
 yuwkEZ_G4_7hTwpim9AnWM_IY9gejbBOZ9E97WzTdObFr4To1dAJ2rp0VgPAEcKhLSSKiBvEjXKq
 m18MNJOebHnOjrniwHs93vbN3ezxsHPbxWqDOakjXKdfp35z99mkt_.PYIs7vMlGd2fvnYKJzTL2
 mAIfcs.9_dCbLobwOAJ7EUbpO5LrGM3rI5SM3iU_E7iFuTYHc7MRtr_j1j.nGnxZzQCVUTpcL_az
 Gwgn.EuV5epxZWHCXKQXpyxqBJz4vA_mF2bWFBW3YHvszugblgcuTLkJ.pxDBauccWMbeQNKRh6p
 s2meefB7s5b4_dIaGx9uPReEurDEc.ULtzbs8.d35qcoC_oM5UpsBD9auOD94Yx2TT85kTXmKEZC
 hWScU2CZ_lTJnj5JyCWCY5eO7Jw8ehF_rRVNJGWlZUsYbC2wVVd6xkNbUIiu6cwshJir_2r8y6uG
 Z44.LPEUOmzJGkddmVRze_SUHsqiiLXMNjb9aopgXfi6mAbjt.qMUo_syfNJHS2PB7b36E1iht1p
 qNPRxHxIBDX9TUaq_rR5J9WfyDAIM0tYRrOlU70hZv6RACDWHFclyKOrRiTqPE.c7dCvpXrLVVPd
 CI7Y_QNCccZZ78Rhtx8rRzEhlJLzZ8vLfe8kRY9RRzcJP6lXD4Zo7oLFMWZyKZ1kd0XRCfF9Vp_g
 Qw7qxeAfvZUDFDEdwtvY6QKpeZlN7x6H2N.7s01D_h2I592cX.bh5gfheLE8bCN.mKKU3hr3bjzh
 lFjHez0H5Gl5IAE.vqMgz.GRRR1iysfvTP.UCX61tR1.._gDf7XrBZxc3llzjVIrx28bO07nH_yP
 XZj20WpG3qVBYKnA8U94kVl1BBUMTADMeYB43xvSVMPIPmUMh0AQ5tUcybTEra2no_eFVEfihM9k
 JbBeb.dqzc0nN7NK2ZnMR0cA66ZnRpwGO.LaG6vUH6LuHDLOGk3sj9sCWYHV68Pb10AwRRJP04eI
 _mvK9vjh1uCtnN320.v1s7NfPFbjpmoy7UE1rmAKqDMhOADfVCTi60G42Q6XampVfqdxgzuXwYdZ
 CeKMdRn6k5ogXZ8pAcjtrJGllb8zi_EIICEgWgaklKgCCXgNl3EAxCw093Y3Kk_Pi2_MR2v_1yZy
 L2N4uX3QVBI22jkWifHcVvlhP3wmFWJkO.cKxjqTNl8ume59Jm.QelzmQQ_ur7xuj8XpVOmwFow7
 0UuqopP.._dTEsIKvACy3I5vufnN9vwVpXzImmN_KGOwk1kHzRQS0gA6vccZXgc3EafuNLDq52RL
 MkfmzZxjJFSpZBwi9ndSQO5rljTgROR2pt6l67s4KrbWkIKMFhZ89xV7ye941RUwwvpYiWBCtQbs
 EBS.4x7YvdzjZyRBJNnUPumqT1U0scFfCYuYAlgqm3r.k4nfibDGz41HS03_nQr.7DP43_PFs3pQ
 HTvBGA3gYHV2vAoN4jlEAraiCtJZBOMnBWuNrIn5WRTKUgsuRoaXOxzQt06uTYH7Ekjo3XfjlADF
 1.zaMUY3cmlajYEvgQNW1QXYLsFjEgx8IvgzcPL2HjoMvgX2aJgO8tM1F.kyuLa7XLP9PxOqiXRU
 _ortFHJ5OlUpuC8uo6WtIDQ4_wkxdcXzYfHY1Ep4f_qd65a7y0Lvvp0yCAvPhwVuVKy60ZfvKYrN
 5r64AYYmXf7q__A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dbb0b646-e1c0-469a-8d04-b3221f92cf05
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Jun 2023 21:30:32 +0000
Received: by hermes--production-ne1-574d4b7954-6wwdb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 641943e6dfb7a4e002474ee1126c8805;
          Thu, 01 Jun 2023 21:30:28 +0000 (UTC)
Message-ID: <70845d67-9862-47f4-b7d8-e9e78e1fea17@schaufler-ca.com>
Date:   Thu, 1 Jun 2023 14:30:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>,
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
 <9ee2bd8b-5150-1dc6-d845-733ca9b68d26@digikod.net>
 <CABi2SkWQz3gvaQVWL30CBM-SDLHrWaGOwQS0rfKi==D9TP8L0Q@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABi2SkWQz3gvaQVWL30CBM-SDLHrWaGOwQS0rfKi==D9TP8L0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/1/2023 1:45 PM, Jeff Xu wrote:
> On Wed, May 31, 2023 at 6:01 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> On 30/05/2023 20:02, Jeff Xu wrote:
>>>>>> As I believe we are in the latter stages of review for the syscall
>>>>>> API, perhaps you could take a look and ensure that the current
>>>>>> proposed API works for what you are envisioning with Landlock?
>>>>>>
>>>>> Which review/patch to look for the proposed API ?
>>>> https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-ca.com/T/
>>>>
>>>>
>>> How easy is it to add a customized LSM with new APIs?
>>> I'm asking because there are some hard-coded constant/macro, i.e.
>> I guess this question is related to the Chromium OS LSM right? I think
>> this would be a good opportunity to think about mainlining this LSM to
>> avoid the hassle of dealing with LSM IDs.
>>
> Yes :-)
> I agree it is good to think about upstream, there are things chromeOS
> did that can be beneficial to the main. At the same time, part of it
> might never be accepted by upstream because it is chromeOS specific,
> so those need to be cleaned up.

Perhaps, but look at what's been done with SELinux in support of Android.
You don't believe that the binder LSM hooks are for any other purpose, do
you? You'll never know what turns out to be acceptable unless you give it
a try.


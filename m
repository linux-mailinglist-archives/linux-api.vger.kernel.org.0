Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C835716D60
	for <lists+linux-api@lfdr.de>; Tue, 30 May 2023 21:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjE3TTy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 May 2023 15:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjE3TTu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 May 2023 15:19:50 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642AC8E
        for <linux-api@vger.kernel.org>; Tue, 30 May 2023 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685474387; bh=szIPdoJIXx45Svi45D0tHGIJloPlDPxxC+xo1qJzUgI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jQZFD+/eB77FMs+ArgpyfrprlFu0HrYZHXKt5tg+8jVGU3f49BxWPTmAbWozLhd9h2LHuFKJ3yBsLClWR/YrYOivMtYWdjddNoNcwLpVvF94JILUXZ5PZdCdv5S8qhHv4jyePsZx5Bn1OkMNp1BsTL/NdQhOCc6sTBU0oxe9TLcMa8Dp2eK084oyDRmk6r9vsRBuV6B/IsbdKon2SW96ghP7qB+NjwM+VJnOhuruEzLJHRGz1xpdXUuqy6TPQVbUY98/KmD/HOrzbGSkKimiDcFmVzWAdsxi3BUmMEYFYnEDFpGMqjR2EhnR+Z14XcZuVNYVXM+r2QdrXRtqEb6tsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685474387; bh=cQQb6dHURmtdQ+8dhC+vWt7h3iyIz0jmM3q9nKX2+rI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kjb8Qu9yJFDN1Wf7eh5cxJhl5RpxeRAckTZaarMymgAiLe/pvAifx24awIYWg/1F37UX0HTzi2QAE4n6p/dRtwA4d+kdJk+DlxdfElRjGef6mOflb6LYrjuJTD0yUVF0rjt6a8x5gd4+b44qoNJbeHNlHTaVkTi57uYT+o+hE1wfAY0ez0XqR9lmdItWzGMqzFdb0Ms03kMCoZuAKA2M2D44kAW3oDU/uPGGVxTTmDWd+9gSdrMuxfmgq0UwTc8stegscJlASsssAq7ZzuLxn3xFYiPNeAiXkpYXqQ+WMXnPEGj3BcDEM4hAKlyfKrq3HBLIhh3FRSmEE1J7scWiLA==
X-YMail-OSG: lI4Td4YVM1kWBoqwC0l9jmUBSksU2jM52EHzPW9wX.ZTY4rZurd2c.XzAmGQ.l0
 ylRRgs6sXyjySABVOYEAnUp0t5GjsewbiGUhJ6oQpTIyIpcV6bSAUn_zMD1Roe3JwufeSsktD4Z7
 2uVv3c07aqRTYpDILxjZxiQmoKn2Qdt2R4Yr8SI.Bmj6hSKi93xxV3SNmbkK9VHuWPnvV71a.Dl7
 nbanwVf.MVoGEsUVlIqm0dl1qU6.q9BY1YKB4jQ7lxCWz_ujS2bCYUXq.3aBTi4CJVcndNsHM7HF
 5ZNbIL_s25eXka2NbZpHjxDoIale4UHT8bN73W3IYmHFT4fiHF1mEAWHqUYx_lJUROQv3nwiwX32
 VnYkLSnD6WdvH7PWO0u2g.vaZbTLWLnlu.xQSjLWj.JmsJ33m6fHUmh7joW3LYblZszzK.ef_hBi
 kv1zlxpwZ3.GKvfG1eKh8NYNZNnsZMfOJujsPxkOgUYCmDfiOueXEqchRCftMBjuvAX6lIASoNgg
 0sJ25_67.uaBSgFQYuV_EnrmtMOpRIf.wGH9pZZWw58A8t2yWO30SIzcWK1iAbbFEvBMDl3rj_mJ
 tYzpURbuSOJrf05Ucig2.loTeTy8h1mWpeEtc1M.gMaF_mhra6R9E04W3NLu5B0xnql.YQpWSzMJ
 3N37tqgQUF3zPvAD6IT5kp3PXYXS0T8YLPElBPy_UeK4EvHUqtki9FZniacQt8ftiQsoGPuQhiBL
 s1TRzI1WFX.WBdobJKI7t0asfU2yWOmIyDcgtPBujIT1f2Xz6Ku1Rkf5YNIvRXHLJE8Cujmn7yGM
 QEygn_d5qy8C1G02sN3t2ltyGyZGvnYdhAOZmssJXzXMrMwA30_j4QmvP4IPUs9D_yovxh7a5PlU
 eGu.ZqgzXJqKzwyJZYAV.G_EkjxoF5fRLkRUqKgFprh6fROG_K5B6SabVXwJIUA0qwPrJFNjQi0s
 2EUmqo54ZvUNnmmeiRumxLwrlkMCBRI9fYh6vXeRaXv2BhVXqHKQmZLbFrZzm0UCDQiogHgk5oX5
 PLRSqmN7f7kb4XTHhZxyG8GlU0DEeYLweax.phxyyAJCNY_ztOU1D1u6rJ.eolcNBCMgf9jl3SG8
 YKDEWERyU6rWDyjC6ZOOp5G8UH9Y.cOBaH_kOUP9_agNTT0MMPZea.fk4o0K8hYz2MKhJuC2tn61
 CLMJePjRJ5rx5GUUOettq2sdU8nhlVErNagQTq.4fWfTZkifBTbD60QYWpArmqdrYPKzRXe9TLLg
 hZB475biJKIf6i_Lfu.IoGoR4RSblKvuDUI8RNYO99Z8nWd0p23w.B7u3lXtPBLuK1gOCPcA6kb2
 bq_r6v6AfoaiD2yjfItK0tx9iIdrt5MWlX67H2nph_pBYnrxMAsYIecT4F6nAMNCDqrWwS3ELPM8
 s93wnVbfpNf490pu81uG1QHy5ewn7rvHAwNFZnIyt4_PPiURD6.ZK41oPFwqK2phn3kO8MEgJ3xE
 Pr2eDQI94VXV9qhe4YHliIU3jE0bHtkDQoQuFQjhVeVM.alZRLT_KhBRqgVDGPdylAl0gnYl9uGa
 r.Xezt.wZmXdI9vDrTLMzdzYvelyGn9VKGAM.EieIvJnD0ZDhYp6gmbnQT44C4kNzvYe7TSwZnE1
 rkO63UVSR0qv9tTwKHjCPtPs8TuGw6Wb2KycPSXzj6_YDNUzkO.9hLAYHrGvGZ1qEWPin42tr5n2
 .zkJ9k6.ViG8VzSP8Ul9JIl39Ze4Gp7BWBPo1gxUVTXvPFsX6Q0impl_eO_W4vD2tk_i3Mu5BGi4
 bRfNYZ65d4Ass3J.icL8W6bfv79gkV09O9l6CRDb9sdV43jBAOx_H0scHSTwbfMLFhPgTWJKTyOV
 qUbasFSbCbKM9nqfdEPmIKvH_msVl21Bu1zKZXrzPRAOwCYPO7AE70c1pvUo8cx3m693lUosFdqk
 CCMbMDAkU1z05Za4T8wtdPJx5U__TzGmVPvk2grIKWZyZYNUCV5JnQoWbXZNxQ7qpdePKD0EXt.9
 X_HYQc17KB7hn08JSj0yXUaVXUGAU4iyOnfjnUNHs6_jeLX9JUVFF_uqPNEQDMlgLsLDripneSym
 iJYFFBJMZr_7qTt23QVsXFDpGiHa89CHK93f2DtsgLtCpdCd33ZlAK12QfY_N69WxRwIIN2z00mq
 8GrSE9nlia8OyLm78TYrrjVzH5h9Sx8WmcyTt63hZQZsPaMdJNXGTtevNbtTa_NnaEl7HfHUOmwl
 tEcMyauYX.O21jtaAvztqLvP.dzhyiw8O6NnuztI390wECWEBrYk92oTRRO.E4FrVAyPgDxXHg.B
 bT9Lc9ts5qg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: af54bf28-36d5-457d-86a5-bd9f7e1d730b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 May 2023 19:19:47 +0000
Received: by hermes--production-gq1-6db989bfb-z7s2g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c00ae7dcbec40b5f89dfa51000ac8f2f;
          Tue, 30 May 2023 19:19:43 +0000 (UTC)
Message-ID: <e1db62f4-32c5-d784-ba4e-5acc242bc00c@schaufler-ca.com>
Date:   Tue, 30 May 2023 12:19:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
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
 <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
 <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net>
 <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
 <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com>
 <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21495 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/30/2023 11:05 AM, Jeff Xu wrote:
> On Thu, May 25, 2023 at 9:28 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 5/24/2023 9:02 AM, Mickaël Salaün wrote:
>>> On 24/05/2023 17:38, Mickaël Salaün wrote:
>>>> On 23/05/2023 23:12, Paul Moore wrote:
>>>>> On Tue, May 23, 2023 at 2:13 AM Jeff Xu <jeffxu@chromium.org> wrote:
>>>>>> On Mon, May 22, 2023 at 12:56 PM Paul Moore <paul@paul-moore.com>
>>>>>> wrote:
>>>>>>> On Thu, May 18, 2023 at 5:26 PM Casey Schaufler
>>>>>>> <casey@schaufler-ca.com> wrote:
>>>>>>>> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
>>>>>>>>> Adds a new getprocattr hook function to the Landlock LSM, which
>>>>>>>>> tracks
>>>>>>>>> the landlocked state of the process. This is invoked when
>>>>>>>>> user-space
>>>>>>>>> reads /proc/[pid]/attr/domain
>>>>>>>> Please don't add a Landlock specific entry directly in the attr/
>>>>>>>> directory. Add it only to attr/landlock.
>>>>>>>>
>>>>>>>> Also be aware that the LSM maintainer (Paul Moore) wants to move
>>>>>>>> away from the /proc/.../attr interfaces in favor of a new system
>>>>>>>> call,
>>>>>>>> which is in review.
>>>>>>> What Casey said above.
>>>>>>>
>>>>>>> There is still some uncertainty around timing, and if we're perfectly
>>>>>>> honest, acceptance of the new syscalls at the Linus level, but yes, I
>>>>>>> would very much like to see the LSM infrastructure move away from
>>>>>>> procfs and towards a syscall API.  Part of the reasoning is that the
>>>>>>> current procfs API is ill-suited to handle the multiple, stacked LSMs
>>>>>>> and the other part being the complexity of procfs in a namespaced
>>>>>>> system.  If the syscall API is ultimately rejected, we will need to
>>>>>>> revisit the idea of a procfs API, but even then I think we'll need to
>>>>>>> make some changes to the current approach.
>>>>>>>
>>>>>>> As I believe we are in the latter stages of review for the syscall
>>>>>>> API, perhaps you could take a look and ensure that the current
>>>>>>> proposed API works for what you are envisioning with Landlock?
>>>> I agree, and since the LSM syscalls are almost ready that should not
>>>> change much the timing. In fact, extending these syscalls might be
>>>> easier than tweaking the current procfs/attr API for Landlock specific
>>>> requirements (e.g. scoped visibility). We should ensure that these
>>>> syscalls would be a good fit to return file descriptors, but in the
>>>> short term we only need to know if a process is landlocked or not, so a
>>>> raw return value (0 or -errno) will be enough.
>>>>
>>>> Mentioning in the LSM syscalls patch series that they may deal with (and
>>>> return) file descriptors could help API reviewers though.
>>> It should be kept in mind that the current LSM syscalls only deal with
>>> the calling task, whereas the goal of this Landlock patch series is to
>>> inspect other tasks. A new LSM syscall would need to be created to
>>> handle pidfd e.g., named lsm_get_proc_attr() or lsm_get_pid_attr().
>> I think it would be lsm_get_pid_attr(). Yes, it's the obvious next step.
>>
>>> I'm not sure if this should be a generic LSM syscall or a Landlock
>>> syscall though. I have plan to handle processes other than the caller
>>> (e.g. to restrict an existing process hierarchy), so thinking about a
>>> Landlock-specific syscall could make sense.
>>>
>>> To summarize, creating a new LSM syscall to deal with pidfd and to get
>>> LSM process "status/attr" looks OK. However, Landlock-specific
>>> syscalls to deal with Landlock specificities (e.g. ruleset or domain
>>> file descriptor) make more sense.
>>>
>>> Having one LSM-generic syscall to get minimal Landlock attributes
>>> (i.e. mainly to know if a process is sandboxed), and another
>>> Landlock-specific syscall to do more things (e.g. get the domain file
>>> descriptor, restrict a task) seems reasonable. The second one would
>>> overlap with the first one though. What do you think?
>> I find it difficult to think of a file descriptor as an attribute of
>> a process. To my (somewhat unorthodox) thinking a file descriptor is
>> a name for an object, not an attribute of the object. You can't access
>> an object by its attributes, but you can by its name. An attribute is
>> a description of the object. I'm perfectly happy with lsm_get_pid_attr()
>> returning an attribute that is a file descriptor if it describes the
>> process in some way, but not as a substitute for opening /proc/42.
>>
>>
> If I understand correctly:
> 1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
> process's landlock sandbox status: true/false.

There would have to be a new LSM_ATTR_ENFORCMENT to query.
Each LSM could then report what, if any, value it choose to.
I can't say whether SELinux would take advantage of this.
I don't see that Smack would report this attribute.

>
> Is this a right fit for SELinux to also return the process's enforcing
> mode ? such as enforcing/permissive.
>
> 2> Landlock will have its own specific syscall to deal with Landlock
> specificities (e.g. ruleset or domain file descriptor).

I don't see how a syscall to load arbitrary LSM policy (e.g. landlock ruleset,
Smack rules) would behave, so each LSM is on it's own regarding that. I doubt
that the VFS crowd would be especially keen on an LSM creating file descriptors,
but stranger things have happened.



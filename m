Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA51E711103
	for <lists+linux-api@lfdr.de>; Thu, 25 May 2023 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjEYQaP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 May 2023 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEYQaO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 May 2023 12:30:14 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CD6E6A
        for <linux-api@vger.kernel.org>; Thu, 25 May 2023 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685032117; bh=l24o/qZYPVsTdpLHbBO+tWrD6HMJA4puWzSK8ypba9M=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QgFHlBvzuwsZF5ie+WmSCWbYdw0mWmRz7os1GgkQriIRDYjWZJbgWi9uu/ZzSclUmNXhrSLMXP7ZAALo6OtrxCb7jUrNIYg1dHj+jcZZMrWP/qJOA5/I8wUSaOHyBVQsIE+r2gfwz76ieeiA5jZY2j5YvG4YVxU55sPqnrk0JR3r/OXfrIsnbPDE/V+pUbrRPG5fy6+LN3PAQCd63fSwNJeNblUzWB096EoJ7+ARqWLZyoan2Qx8Hwovwm6SARZwu1yF1RbcWZI/RaJNbEDKFLopuhHmHGaYPqyJclg67iakzWSmnsF9ANmbNqjQWAr72G1zF+w4bS+g9zruu4InuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1685032117; bh=k/cr0IjcZadDtB49i4URWmIpoa8uaQYuvM22/a2e/bW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=umP3+wKMN/pqsCUa99f18nJhpjgjqjF9T658zWfUk5uR1RYCM/QrSfrY6c/kyJHmcUFGd5MMhUa/APJmuKwHD9mL8jmvGpybjAlo/t5RL5sFlBIUr3IDzsBuHd4k6JS4wN1NOWCNli58gyGqHrxm4LaMEotRU7EgYsfws0CCqceQzye/00DXAHv9yiMl9KMhMmKF2KZRX09U/A9VR6jT9kOriIn5BD34SZuBEcQvMtn10/GlUhdsKfhfAayLZccvQpaIZlTL7Ivh9fjpntNoK0juDncKavfyf+D1Zii5XvTRCy76pbJ9gx+cq1aDDpyWpw0A24bzhu4pBy2wV3Ia6A==
X-YMail-OSG: urHBNzMVM1kI2KSPFU3PCWu7l2A_rcbx1XzOiNVOmyiigznejw4fIrgtJhXysM6
 wYJyqq_9fLCfGUg2t0qtbi_COwxLWbxzQFxN.hBuDwZknEFmpexjUIzuEzPMeJWl9xeKKRWEpkrd
 ZE_0vQvT.i9mZ7nRB0JNWwvlfVm7x39GBG4kyvHllA4ZrY7TFvWtXaxUgMt5gcZhPt6MdFFl2ipf
 QZ66a3seiQQfvQSW4PoQRwwT8.yfMaYP8f0lFSR1KxlEGJyrmiaScfbRJ3XzSqmRMHQj2h4bjl93
 ROlD2Fipp0YVDhtb32qVGYFfug.2AkqlMClHyqsYfe5.1nOZsW0TrNPrOmuBP2vLpJ6cjFg3Y304
 DP79rgkCG9TO4n_LglnrR2EQYJRxbGg61vnEsNIl7FJ.lNUGnnbnMeuxUmxqhiSSzVOurq9TvU.v
 dPbyGkmykRI4MKJqQqITFbVX73ECzMUEcRf7ZuX6Fje15Jz95OQoD_vHjDTiDivKLH0RXduqc7vq
 K9BXQln1xIavoKIOyGB1tRVHBSQdymwOvqoXxFtFMIlP4YHEfLMW9AdmBq6V_hKBojF8azUOOuNS
 374ZWucC1QZYgNQihl.qOcuynx5xRSTbMCfUenAXfvI98TVmrGn.w1ieHQ6LAkagpuE9gfmC9dcN
 HKobDPR1IY_5VCt_ezrxK7zD04aswlxnuI3gj4FgbWmk2oRFhmIaFl1zYHdERmq3GX5J_LdSdAXL
 Rm3VbxwiYRH03qLMlgiHFfz_vHFQo2eQm.ZQDGeehquiRSOckFDZwnMP5dBm4Ou5g4MlOQUYrBed
 qWr9GN.PtVWs4uzxE9fJXQiG5g0NT2wiTIMTxP52CX5ubbqXyWRi0n6kZiluLX0sNTTF7T_zY6nH
 vT4okzQZ0qhh.1wkXtW.NyLVadMVhEpDSPY1xYJCX5yI9L4W7oWanUMi2wmhhGJRhV_ZxyXlYryU
 aMT10zIIE2Jb9FI2A6KBV1GSE44FLQRT0iw2.eDgbV9IaD2OWXkJFcQhTnGYZ_OfXzzDLK9NAuJU
 HSv1xGh8RCDBhCzIK7HzmHe.k1Q.FjG8keMu6uwRM3CQq6bUX4LdtNvqlOFG4b7hpKgdwd9UFsVC
 V3XTqL_i0lcJm0aEZhtRI1HucbFYR0nuq3gyU8d6HavRQ3TuRW_525WA0BpYUnd5ChU6PV7kwU8n
 h03DbdWmQgBb05XXLF.th1o7RqG7RH2oGiiwznPWTap48ViqM7gbWrRZkrzjxKAc1IX.8MqQ63LM
 toP3HiDGj0YxUWKAQH5169wm_wtKGOcbzxajpdMkE3ShJdqdwruHHReo1UVKrdB8ouWiJvR2hyxU
 Uo.MzDg3zerVH7WHsDAyRWKQEMW8CYrlm8dURv5kKfo1UEXWcnnT2noPBbpFDmzQiwqjbQ8NsnZe
 JQJE5wN2uktSHFp_9AD.eVF4v5CY37VM8UFeDrmWZjVRLqxpZoo7OCpKYAkcsrD0cbHx4Cdm8wcQ
 riQUQj12kRejOIOUnBwnAZOECiCj38wLmWOZp71_EZvgU3x0TGfKpVySJ14h4d05D5zAPWUeESO8
 oc0MOOLmJf5V4iN30Hn6BlyAWjcbEKzowbCQEGXM8HRGAm6aALjbmmQ4ayTkw3928azz9gsRF6_n
 DaBg8OKIibFTH8NpTo_FvXY8TCO9qGUb2rUj1HfsJoa7PV_58564MqNrSglkAJnKEsnlQ0mZk7KD
 feJZnWkfVxAcSjXsuf_UtsDbiy1_aP39wqWoSiGCr7PYxebLnxFiiHTgI8hir3MAdjh.GSbRxfhP
 hBsfnsfNkPwzoFJfEDiEwViuyF_zjdDjViPoiumPE4819_yA6vYsqObyf6Jdsr_160TQSPG90M2o
 q4.nYeZLzXqhwkbXiPb8BgAHk5SraPFmIhDvQ02QwqTkecOHV3Hq9WVWz_Y6Sc_GLkoYKB4XH8Fm
 3gAXCuQHkbQ7lMY3iSUTSJ687V1jmZ5UYFTT8bIf2sQnYWGsvfNEgMPs8zcr.rc_wwHFMmyDGVwl
 r4brB61.2zcuaKjR8jvGUL4L92Gx8a4_RG8V7_vUwEU_p5SnO4nN3yWlfe36LJTfpdIbCV7qFPmR
 .Bb7c7O5fpPwjTmShJ6ukb5hDo_GjI6.vnuzCHlo6.W1GPldeUififcOCUS5UEJ7e7p6g3NF0EBR
 4LHPbZMZ9zbOfCypShl8QJFLIzQ3_OUk_elav95Rm50jf4HWN.Q9wlpgwyNXOkMvucfekLXzy3O4
 1Dtc16LruWHDGCBrSTtzQ2B4BwG3F1t.mBU7aEy664ze0FBWs5miGSeY76U_zh5mLWvVZlsuIhgz
 XYXOXWXA4zu4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1c207c0a-8127-4861-8712-622a7af3df7a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 May 2023 16:28:37 +0000
Received: by hermes--production-gq1-6db989bfb-7p67n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b082792b4f5488b0518e45c4d63fda79;
          Thu, 25 May 2023 16:28:31 +0000 (UTC)
Message-ID: <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com>
Date:   Thu, 25 May 2023 09:28:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>, Jeff Xu <jeffxu@chromium.org>
Cc:     Shervin Oloumi <enlightened@chromium.org>,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
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

On 5/24/2023 9:02 AM, Mickaël Salaün wrote:
>
> On 24/05/2023 17:38, Mickaël Salaün wrote:
>>
>> On 23/05/2023 23:12, Paul Moore wrote:
>>> On Tue, May 23, 2023 at 2:13 AM Jeff Xu <jeffxu@chromium.org> wrote:
>>>> On Mon, May 22, 2023 at 12:56 PM Paul Moore <paul@paul-moore.com>
>>>> wrote:
>>>>> On Thu, May 18, 2023 at 5:26 PM Casey Schaufler
>>>>> <casey@schaufler-ca.com> wrote:
>>>>>> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
>>>>>>> Adds a new getprocattr hook function to the Landlock LSM, which
>>>>>>> tracks
>>>>>>> the landlocked state of the process. This is invoked when
>>>>>>> user-space
>>>>>>> reads /proc/[pid]/attr/domain
>>>>>>
>>>>>> Please don't add a Landlock specific entry directly in the attr/
>>>>>> directory. Add it only to attr/landlock.
>>>>>>
>>>>>> Also be aware that the LSM maintainer (Paul Moore) wants to move
>>>>>> away from the /proc/.../attr interfaces in favor of a new system
>>>>>> call,
>>>>>> which is in review.
>>>>>
>>>>> What Casey said above.
>>>>>
>>>>> There is still some uncertainty around timing, and if we're perfectly
>>>>> honest, acceptance of the new syscalls at the Linus level, but yes, I
>>>>> would very much like to see the LSM infrastructure move away from
>>>>> procfs and towards a syscall API.  Part of the reasoning is that the
>>>>> current procfs API is ill-suited to handle the multiple, stacked LSMs
>>>>> and the other part being the complexity of procfs in a namespaced
>>>>> system.  If the syscall API is ultimately rejected, we will need to
>>>>> revisit the idea of a procfs API, but even then I think we'll need to
>>>>> make some changes to the current approach.
>>>>>
>>>>> As I believe we are in the latter stages of review for the syscall
>>>>> API, perhaps you could take a look and ensure that the current
>>>>> proposed API works for what you are envisioning with Landlock?
>>
>> I agree, and since the LSM syscalls are almost ready that should not
>> change much the timing. In fact, extending these syscalls might be
>> easier than tweaking the current procfs/attr API for Landlock specific
>> requirements (e.g. scoped visibility). We should ensure that these
>> syscalls would be a good fit to return file descriptors, but in the
>> short term we only need to know if a process is landlocked or not, so a
>> raw return value (0 or -errno) will be enough.
>>
>> Mentioning in the LSM syscalls patch series that they may deal with (and
>> return) file descriptors could help API reviewers though.
>
> It should be kept in mind that the current LSM syscalls only deal with
> the calling task, whereas the goal of this Landlock patch series is to
> inspect other tasks. A new LSM syscall would need to be created to
> handle pidfd e.g., named lsm_get_proc_attr() or lsm_get_pid_attr().

I think it would be lsm_get_pid_attr(). Yes, it's the obvious next step.

>
> I'm not sure if this should be a generic LSM syscall or a Landlock
> syscall though. I have plan to handle processes other than the caller
> (e.g. to restrict an existing process hierarchy), so thinking about a
> Landlock-specific syscall could make sense.
>
> To summarize, creating a new LSM syscall to deal with pidfd and to get
> LSM process "status/attr" looks OK. However, Landlock-specific
> syscalls to deal with Landlock specificities (e.g. ruleset or domain
> file descriptor) make more sense.
>
> Having one LSM-generic syscall to get minimal Landlock attributes
> (i.e. mainly to know if a process is sandboxed), and another
> Landlock-specific syscall to do more things (e.g. get the domain file
> descriptor, restrict a task) seems reasonable. The second one would
> overlap with the first one though. What do you think?

I find it difficult to think of a file descriptor as an attribute of
a process. To my (somewhat unorthodox) thinking a file descriptor is
a name for an object, not an attribute of the object. You can't access
an object by its attributes, but you can by its name. An attribute is
a description of the object. I'm perfectly happy with lsm_get_pid_attr()
returning an attribute that is a file descriptor if it describes the
process in some way, but not as a substitute for opening /proc/42.



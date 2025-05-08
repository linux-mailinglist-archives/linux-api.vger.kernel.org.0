Return-Path: <linux-api+bounces-3731-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E56AB00C0
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 18:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC821B65813
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE828315F;
	Thu,  8 May 2025 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c125g/r2"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CC27A13A
	for <linux-api@vger.kernel.org>; Thu,  8 May 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723275; cv=none; b=tsLCxtbH8quksNUy0Mh/jRnkBOBvc3zdjl0lRM7YrzP2iH3fZvUJ7rtJ6Ab7xGmlmdsS+lqezLOMfRhGFhbONcV+qCO/AL4Y43n/4LN/btPH3qok0DHUsKG6mCE91BgFx9DrvDp/HKvCV4brgznJ/HMGfNVbhSVaUPdKWUjnuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723275; c=relaxed/simple;
	bh=uDb9VfuMER/sfFfRxa2/zq+UvG3+WreAOrdW4/yaYAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r76F/ATz+SS1iQxJ0r+BwB4TRiDvFDbgly5csBJVxZec14Cm0FI0Jm2MzYa8+RcR5d0kT+68KXQYDBSIMc+GXveM+5ks4wFuLzWpAuQlOo6YKSCJRR/YBrMWUAvmJaNMU9d8f7kOEOKAH2FEcNIzJAzQmWbSmhg6uFxKOZAONC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=c125g/r2; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746723265; bh=uDb9VfuMER/sfFfRxa2/zq+UvG3+WreAOrdW4/yaYAo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=c125g/r23zLZO1xiVo6KFIrRJbb+14q2Zo21LJ3Q5RJI37QhoqMJ4DysbBmrTSUWf+q3TWqw+gaUcH2pD2exsH12GYoMFub76P1B7qPGdesKF3Y1EKnp+jhD4Lgn7fwEbteG9JYL4fAYR+EqmumN17JxKhTsYntihcqg/dIbjWGTMcvtmVd6a31uC4mTk7/mkmrU/uc5+3VYIOGYiEnDHGo1mAJU4t7Opp3oVONLV53VkkLcnJ5elACOXqjhe+KXGCtFQfLmwSYEQWGlgcFq0XuyVedm6fmvTFeJ9F2bAfP7cICDo4JsrAiamAdialgfBtRVz3lfNwB4nWPBYgZMuw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746723265; bh=VFOtFIOQn9sdQRfUKv/KtMgQV0BQQFXfL0ECOodaMuk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FiuldPUY09ARdw+NYOs1nV+WopMV71na52V/d+ySM1gCbQlwWYONpXmsDI92aV87f2uFFnCauFSqSlab1bcEzLECmssuZWU4ZFD6ztcbsXC36vbJ7kQxbFW3/cRAjZcqTZUZqIj6SmQurhbG5admx697yJEWX6hbzj+PDkTHPCJc+nOnw1BoPznuK8Fc90rZnQaBYLcSEIdQWe9Ts/y2ZUTMFtOD05u1xhItABLX3xffK3Gyt2VVy9JezVyoN2wGYspFdCzrDRa7CI2+9TUYwPxN+qarZNrlMPpqEHv+CIFrB/kgcpRtxM93dbyoX63prIyBqNGpfff8u8tmvv2Uvw==
X-YMail-OSG: 4.CRYG0VM1neERNpUJxCPvJ6IuGh3fWoaW6DsTyv5UVsg0QpECBOIXO1ELNT9ik
 ls6gfR0jSAhXBtJWbr2bwhZCuX4tjD3UvOPwkD70QLspQ5qJZmH_EG5p8MWZqyGXcATj9.293qqH
 66JebTHdDBgVRdkbVI16rxCONXih5x42pKaHVLfQBmFQCMDySPjSefSIbukm.9L7LoC_rgNi2b_q
 j5uAR792jruKtk34KZRaeRGYCUwrEuvlBVWIN.oo.qpDdYUJRQfSY8iU6UVoYceLnFDNTr4GuC5E
 7tfY3Zuc2NdMSaimz6v41RbyGeFjct5fkZm_EBKgTqT3lfcEMFYOTeDLI84dI6fHLS6jaw7DsW8H
 KcK5sAQYshT5VXD1KshMOhnSdsUpO5eVCDCEFxV.i1OQVOZFAmmbW5G_gm7TS9hv.JxXbsjBmsuV
 bpUnstH3zI0TRCU9GQlStcA.xFmNdxp3VAKWhuTIXUt44wTv9JUHc72pRt8MZ.6eafS7OhhPlwDH
 kzOYcLwdcXt5QqHEBuDdGthkp_q.gv8FzqdmEHNtXug4XYiS.71fRT4jbZbwmMUAKSSbpAou9mtN
 0QY99lCwnhIbMKVdVcNbrRK7OLegWLroX8W...AsuBdgWuefQpFwok8bWLJwD9odeFX3B0neJtwX
 ViKCmroB5.lfNtjVgMDCxV0VBF91oUWXfQUiddkoJI_DqwQ0BLufjw4roFSXRhnBvgvTzQ_BmixJ
 OicaXLFYTjX_B0CoWhV92vsdSDY6pNI1IDqO5CtE9F5NlGe0YxTW_DXY.0xGVZ52JWruHHZ83X1k
 T1k6AcYqfoNB.lNui_p8kQBapwmiX6kJx9I0UelmA2bPEpRuEmIDZUGs3zyJjfMLJ5fbx_mus8zO
 Vk_myiB8Thx5yVXd6TN6d0Xj06e1fSXHkOxnOtRz3dVySqvmHDTbcRFxTIEpxKoQdoTKl1sez0mo
 9zNQZIxMFRoDrba1AL6TvOGOyP2gm._h2ZZQGjdWgA5Lubqc7hhJn7permy9xGxjpVZduaQGj1xN
 rMQ6VRTZSxQbNxU7Eg7GFYhenTCys_qUDZ29pWo4Biu4i8.SnpXGJWbXPHcuMTHp3RDnDh9W0Rea
 6V05Sxo.CPIE1oagNBaIyzd.IGJQTASDydIbamC6MHPmIpr6cfjRRKjT.kECjOGpsqMyzOqusfcX
 ZCJPb51YjmtO6Adme6t45W_pDGOgsc_SkSa5CiEfKqEpeSCa7vlDLwFQgwYip5wsbnpYtLDGmrS4
 mh7Ev46PJOcdrw1Y8NIQ3Z2DSVxVqsmwQhCqxUa8MG2_WANePmv9Dil7srXFaHjlkoigNS1tLt0p
 k1GEj1fgO9RAs2wmTAA0yp2NTSt68iC0XHgZyyT_znB8Ps1RoDcPol.32IjkaRhyKbLo3L__vuUM
 5XmbAIyZ6PnXn9sOP0D4rk4w7cAcoHznhGO1c9p0ovSPKpcl9IjvILuagUUcpjGce.xp9baaWmEd
 _Ib8DQUubykyc5_lrUzIaVzjTzU8LMLt0QM4_jkiqL09Ph5AvnrOunpeYKh4MHzD0omhOF6IPYpn
 RunrhzolG9._EqsJz2IC47mq_JrMyNd00hQ9ekSRX.b8DCcGlX0iORmQ9rI52XgUa83R1KxCTCvT
 ucV8.aIBitzYdEfnLa6t2S_I1rmE9DDobymPzEiqOgrVk9FAVNzTSf5U..75t31yt65..pgUTH.5
 7PApOwGguUC_r.uxOeu5T.4s.F_78NxN5xIU4__MXEmv17yTVBuxdjBw8VTNAhiLC.TOsQzdt7Ff
 MpZgsm88IKJKeOXFADng80uTZoxiG6eBn55.pPswpBZuCEAN_PS4jTcxIQMvZDHdzp.V8DT10wMV
 bYerKOZk.4MyiADfhwuLbItBzopec3eq0Ek_FltrNi5QD8ZD6PaZJQTmXolWYuAc.2v3pn6dI.Xz
 2y2QfvlgD5PcfR7GlQuDNdSRQw56XL7_HyLkmSyLOucUuuelskllsHcPWHWkVYTrmNt8RV.AXeOE
 DK5RitnXTPZliD0_exe9yHJt5r0N7LN3OdB1bsO4VzjOGGdtCOTPtk1GTrZOREt89v2zPExEZfAG
 IR7mBHQWcRtEEfhjDiRRONxqbrEhYcfcXKE1O0tKLyUR2i2L3Nak9wb_MlvbTjKH9A4k53YyzfSQ
 FLuzfO.F3ppuOOwEz7k2WdxXUpuHDZcoE0KeL5XDnY7ZlFNHRKqEJ27A4Vk0UUS3xTfWjmpj8WEg
 lXJpGw46bDz073r5mCZjZfBHgcYzzZgRCveK1dfW_odKJsIQ9lgkLujcKrJCYEEGiNlNM6TiR_Yp
 7Kr8UrhJ3My00ad2zScbl.Ehc0A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: de36a9ec-f2ba-41fd-b158-254f416c525a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 May 2025 16:54:25 +0000
Received: by hermes--production-gq1-74d64bb7d7-5wzx5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e3e84f21b3122641f5de2e0758ade85d;
          Thu, 08 May 2025 16:54:19 +0000 (UTC)
Message-ID: <efe5b15a-6141-424a-8391-9092e79e4acf@schaufler-ca.com>
Date: Thu, 8 May 2025 09:54:19 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Maxime_B=C3=A9lair?=
 <maxime.belair@canonical.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
 takedakn@nttdata.co.jp, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <CAHC9VhRKwB4quqBtYQyxRqCX2C6fCgTbyAP3Ov+NdQ06t1aFdA@mail.gmail.com>
 <120954c2-87b7-4bda-958b-2b4f0180a736@canonical.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <120954c2-87b7-4bda-958b-2b4f0180a736@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/8/2025 1:29 AM, John Johansen wrote:
> On 5/7/25 13:25, Paul Moore wrote:
>> On Wed, May 7, 2025 at 6:41 AM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2025/05/06 23:32, Maxime Bélair wrote:
>>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>>> index dcaad8818679..b39e6635a7d5 100644
>>>> --- a/security/lsm_syscalls.c
>>>> +++ b/security/lsm_syscalls.c
>>>> @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user
>>>> *, ids, u32 __user *, size,
>>>>   SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void
>>>> __user *, buf, u32
>>>>                __user *, size, u32, flags)
>>>>   {
>>>> -     return 0;
>>>> +     size_t usize;
>>>> +
>>>> +     if (get_user(usize, size))
>>>> +             return -EFAULT;
>>>> +
>>>> +     return security_lsm_manage_policy(lsm_id, op, buf, usize,
>>>> flags);
>>>>   }
>>>
>>> syzbot will report user-controlled unbounded huge size memory
>>> allocation attempt. ;-)
>>>
>>> This interface might be fine for AppArmor, but TOMOYO won't use this
>>> interface because
>>> TOMOYO's policy is line-oriented ASCII text data where the
>>> destination is switched via
>>> pseudo‑filesystem's filename ...
>>
>> While Tetsuo's comment is limited to TOMOYO, I believe the argument
>> applies to a number of other LSMs as well.  The reality is that there
>> is no one policy ideal shared across LSMs and that complicates things
>> like the lsm_manage_policy() proposal.  I'm intentionally saying
>> "complicates" and not "prevents" because I don't want to flat out
>> reject something like this, but I think there needs to be a larger
>> discussion among the different LSM groups about what such an API
>> should look like.  We may not need to get every LSM to support this
>> new API, but we need to get something that would work for a
>> significant majority and would be general/extensible enough that we
>> would expect it to work with the majority of future LSMs (as much as
>> we can predict the future anyway).
>>
>
> yep, I look at this is just a starting point for discussion. There
> isn't going to be any discussion without some code, so here is a v1
> that supports a single LSM let the bike shedding begin.

Aside from the issues with allocating a buffer for a big policy
I don't see a problem with this proposal. The system call looks
a lot like the other LSM interfaces, so any developer who likes
those ought to like this one. The infrastructure can easily check
the lsm_id and only call the appropriate LSM hook, so no one
is going to be interfering with other modules.



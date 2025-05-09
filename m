Return-Path: <linux-api+bounces-3736-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC484AB1798
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB8B3AE336
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A6229B38;
	Fri,  9 May 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jr/Fhw07"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0831225A50
	for <linux-api@vger.kernel.org>; Fri,  9 May 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801708; cv=none; b=HL1upqJl63B6hwAcRBVA5RoR6q/T0U4S0rxBtdmoQkLwqZ8gJcmlADpQ5BqEG+qcKuw99Qd9rC+kt9qv3bwJFhsRV6L3yqllDmfB7+HJo0pQDRTldRUIVyNzmnifY+Dq7rMAgMvX8xV2HKQEzeBX5EW1Pn+QxrPr2+iOn8JCggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801708; c=relaxed/simple;
	bh=A1DRdNzvRO7bBeDRi/bpn+3y+WIKMP/+KezebnFpDVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cB3D+BkFEffgsqYVfNLngpOksXbU4AuVRR0YdFJ0IQgpHK0A+aRDWZ/KVaBldMnvTA8GLaGZS4EyO59M2VNClFOXBJyzavnjcz825jzH1+wM76HYv7nf3vBGZ0uhixqp4q020bnVOmtRSzPWlpUcVTfjDtFc5OOB8GXdH+uygeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jr/Fhw07; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746801706; bh=jyz1EpjrXmQFEdvYzfKkRG0h9+cP/Df3Hrp2pEvQ8oI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jr/Fhw07WP7OamGatXcI7AVekPopoUy68irWRT5ftgPdIu7By/67Ze1otM+km9bHrJlL57ipKFfasJauAOYrAt2ZuEVuswDqOyD8VL4A15CkF27YEJJseL7hLuowuatuEGn1IlicYErZyzOpysNJhGRB3DTPOAshEA/gn82MAyrVVr0c+zMIoUrk+dR2AbjyTqn9AS1QMC+Cl8oJSH5lppCNeOV7OkP56oUS+fuzTdiOuoCVM/Idot+jkQDr6L7a3MxP1euDsNriAt60MXuhfgPpwNaprdoUoJC5bVZehwt4B22VS56G1SPnLds+wa6HMv/zPUBsj5wtDLhCkMcC/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746801706; bh=wgYo8Zi02gj78/MglzxlVFP6CaP/Lm32bl4ecIsN6T9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=d+S9Yi273y2/yNbbiQVQUOx1t8XEy80mJB8eSdQ/WJ7Jov0iESyYWzt66kJXIiZOf+bZoaf0TGLFsKhVZ5YL+zU2xSFxg4wGKtUGQdbMQcc5RAx70AcK6KbOvBGf9H4P2sL3plksrsJc5sX/xOZ6SlmZicjyBbOy9g2ex5n6I4tsqMwCyLYGp9yIyKxAT8xNyMd4/g853Zu/7//e52fCqhL9wBaFl1ZlUB2hzLvXVzI28Whz+UmBz9QAMj6vVDOGaUiuHOs0sc0pmVvtLyUmJS+r67RZrI4leki++QXS6S+/kqDzsohFdtcx3nw3UZVf0YDCN+43yzGpdWGMgI3vHA==
X-YMail-OSG: UDhtazUVM1kgd9EJesIiZcC9j47Ftq1XFHbnRBy0n_zZQ8sAyOfS0hV9QLCgwh0
 URVJm2Esv3nxg1WyTqUgV71tZ9x0_rWkIIBdws26amNvK.kJtelAyduQlSYBaNBmZ5TWm0oaNKnc
 WadabCdddd5kBBF8N0RiYqSwCeMTAJoVzm6XmdaRJCaGwE9UFnfwgICLWmvMsnsDmqrJKMrL27_P
 Yf0NAeF5dXxiU0eRS1PFpbDl35NxUjYrE2tITQpjGJfrM2vLI6IUpRz6CRScvT4AZI.g7sZ50u7u
 yVtC2qGFMMEkfX6YKrvp3IJ5n1p.LxamjPHpwWIMM8_7J.eyFHAjPqntTJ.XLic1aA6d4IF8B_J.
 T9DKU7gQOZSerr8IDCo6t5GHTawN_Qo_I8zFjzZVLv3E2X2LgoZHi9SiYn8xgJOPeqiDX2Ua5Ukd
 N7R5N7gpvt0FQ44kb8Ld2tLvH8XvmhpLtdfqEx5cqSUICjivnTgtOLOuEgXH9zX05S5YuobzXVRJ
 MxBf2ecjMXdldahnSVswrvlZyS919prf5baD2ab5cf1OVLnNJyjMeuGVppLbTAaXLD4gFj4UF6cj
 JqZbzaCpGNcrUdVPUl6Gq8mbiUJ6n3Ck7SAEyno0LuCQQFuxMOKv8vfCkLmlvRy1h1yuyNm2Qc_U
 LsIFIDWPADOKG9yudlREieklxUK3JLqnlhAuGA9O_YD8_I7DQ82XLfuPfz3rwvucSsJEl5zN8_ge
 8tS5ozJba9Wh_k7hXSs9t8TvmposJ81pM4Z6YxZ_X48PvEDjByv9Z5.UKLyi9boe5QBBvnkR3vpG
 2sB7hRAMKrMe.U17WI7szuSF3fzDmc_eofDA1sw6GWCKDmrkUzRgs4LdGczfEOkv4qkRRsbMaeq5
 EuojzJrG8cqTYV3OvFJyR1rBFMYZzSl_5ssfM2fUzZ2in9y0RHnysqahJ7.yAZUIqpZylQsWV0IV
 JcUiQo04Gn7VIcRA99wv9N4YqX2ZnzmG8iV_g9CsM6gMrjEnLTsCLJRDDbdoLDvMgsw1Tmv72OJd
 BuA_rWzf5jxB0M9am6M9DhRbSO0V4OFqw.Rv8XOhEeH1oK4mA.b_7xK4kmSXfSGXPQ9gRn9QfnJy
 D7tluF_ZOpjkhy5SZIGIMnX4TO2PR9jgYCdnE09bZw.ZDqtavmO71vdRnOYrcKgVN0lRigrwvMdN
 QI9qcJ2CVBUA930q32FEgf3kpMUgAo.lMQnq4FN3nnJjzkWQk9XV_O58dX.0AJICflPMDc7f.3TI
 vJD.0tboAeYAKjvIeoTRfdsWzcADjPvgNoTbg.BzTUjwigac8IPPafISOXqcck0qGLuBJ..nQ4Nz
 Z_cudwPBHgsjhIIkj8xS5Fi1IR2lo9gVzcT.XIxa8sCtthEHfS0BU7MYIs_HjBBSOY2NDWx5RLDs
 uMXNM5RPpwYP3TyiCuNzFJ.1m0pNAJa2_3qbn0KdwC2WDQKaK4NOjEzDghBUl38Ba4GdumRJxbg8
 hU.E6_3R95vCYWtxEkcjkuHD_4VHdMxSpWlFqsQ_3clzz_smcA_4Sfts3pdIHOUie56H7ykzIP_2
 J7vY9BOVFkLYa2oWUmik1Jv.EXLtl2wXuz.beiuckt88rzPEN.gTsH8PiiGXs8OiqM4MoU.9LBk2
 iQClV.pxYLW.pqqH.1lNba9OhEtAhsk_8dHPNbPH09yk0oH8fSBDQ97r.g3QYgz1WUEQQFf_Jndc
 SOXZ81vVkjZFKYa_2dlttaIOImzHJ3HGM4tNvzaO_CmNKoc.E79Qi.NV_Xk33HWG1Kb9gvE8Ybvs
 ynvYDx5N0Fd9Ua5fxay817fX7Ues0SybVDeTojOmPGoXY0ACGFrxwSlf0B1aqWUezGaGIWEIbQ2t
 C2d51FvcT8.2f97Gb8SxLMUdP6OZqxeGDJ1V4ewDN5BShHR35tNtMtU.1ZzuiFWXvndxKw_twVo2
 ZN06Im9zawq4qo1o0hMYGMPKIK_ySiL3uNdo.ZYkJoYp09tbEnhsjglrf7QRT.9JqfeDhLsPVEr2
 uv.uOKwlUDxXFCyINHoEhcLulfPBOsxvRwHzaBg4Am3s9fo0x0XoHEzYp5dzcIt8Zig8FHIrolmh
 .9iKroRAsJTj5agvxYvrJnY6BCILxoaUYRHVQJ6HhtPqTJUhABvn_xTSZDhktGtHRWewf8fixIXM
 eOi7uwQzFNfQJdZR2DXq3vcNx70tpY2.4n2He8u7gIMNJwnQ9G.EmQjf0uTkmkUlMCHFY49SAyeU
 H5ZgYSORXCcQ.pNV4WDYe53QvMT1pCYZ04fy5F_Lrq5cj897CqfSFVy13ayAQNS7iNX38zj.bcFq
 D7JpK1bZiEm0tsz4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3c06c726-96cb-4347-882d-f766ab437c20
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 May 2025 14:41:46 +0000
Received: by hermes--production-gq1-74d64bb7d7-khmfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 334e9395e8ec622649b360b124415a8a;
          Fri, 09 May 2025 14:21:30 +0000 (UTC)
Message-ID: <71c3c2d6-5569-4580-89a4-513a03a429ab@schaufler-ca.com>
Date: Fri, 9 May 2025 07:21:29 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Maxime_B=C3=A9lair?=
 <maxime.belair@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 kees@kernel.org, stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <CAHC9VhRKwB4quqBtYQyxRqCX2C6fCgTbyAP3Ov+NdQ06t1aFdA@mail.gmail.com>
 <120954c2-87b7-4bda-958b-2b4f0180a736@canonical.com>
 <efe5b15a-6141-424a-8391-9092e79e4acf@schaufler-ca.com>
 <20250509.Chuecae0phoo@digikod.net>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250509.Chuecae0phoo@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/9/2025 3:26 AM, Mickaël Salaün wrote:
> On Thu, May 08, 2025 at 09:54:19AM -0700, Casey Schaufler wrote:
>> On 5/8/2025 1:29 AM, John Johansen wrote:
>>> On 5/7/25 13:25, Paul Moore wrote:
>>>> On Wed, May 7, 2025 at 6:41 AM Tetsuo Handa
>>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> On 2025/05/06 23:32, Maxime Bélair wrote:
>>>>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>>>>> index dcaad8818679..b39e6635a7d5 100644
>>>>>> --- a/security/lsm_syscalls.c
>>>>>> +++ b/security/lsm_syscalls.c
>>>>>> @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user
>>>>>> *, ids, u32 __user *, size,
>>>>>>   SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void
>>>>>> __user *, buf, u32
>>>>>>                __user *, size, u32, flags)
>>>>>>   {
>>>>>> -     return 0;
>>>>>> +     size_t usize;
>>>>>> +
>>>>>> +     if (get_user(usize, size))
>>>>>> +             return -EFAULT;
>>>>>> +
>>>>>> +     return security_lsm_manage_policy(lsm_id, op, buf, usize,
>>>>>> flags);
>>>>>>   }
>>>>> syzbot will report user-controlled unbounded huge size memory
>>>>> allocation attempt. ;-)
>>>>>
>>>>> This interface might be fine for AppArmor, but TOMOYO won't use this
>>>>> interface because
>>>>> TOMOYO's policy is line-oriented ASCII text data where the
>>>>> destination is switched via
>>>>> pseudo‑filesystem's filename ...
>>>> While Tetsuo's comment is limited to TOMOYO, I believe the argument
>>>> applies to a number of other LSMs as well.  The reality is that there
>>>> is no one policy ideal shared across LSMs and that complicates things
>>>> like the lsm_manage_policy() proposal.  I'm intentionally saying
>>>> "complicates" and not "prevents" because I don't want to flat out
>>>> reject something like this, but I think there needs to be a larger
>>>> discussion among the different LSM groups about what such an API
>>>> should look like.  We may not need to get every LSM to support this
>>>> new API, but we need to get something that would work for a
>>>> significant majority and would be general/extensible enough that we
>>>> would expect it to work with the majority of future LSMs (as much as
>>>> we can predict the future anyway).
>>>>
>>> yep, I look at this is just a starting point for discussion. There
>>> isn't going to be any discussion without some code, so here is a v1
>>> that supports a single LSM let the bike shedding begin.
>> Aside from the issues with allocating a buffer for a big policy
>> I don't see a problem with this proposal. The system call looks
>> a lot like the other LSM interfaces, so any developer who likes
>> those ought to like this one. The infrastructure can easily check
>> the lsm_id and only call the appropriate LSM hook, so no one
>> is going to be interfering with other modules.
> We may not want to only be able to load buffers containing policies, but
> also to leverage file descriptors like Landlock does.  Getting a
> property from a kernel object or updating it is mainly about dealing
> with a buffer.  And the current LSM syscalls do just that.  Other kind
> of operations may require more than that though.
>
> I don't like multiplexer syscalls because they don't expose a clear
> semantic and can be complex to manage and filter.  This new syscall is
> kind of a multiplexer that redirect commands to an arbitrary set of
> kernel parts, which can then define their own semantic.  I'd like to see
> a clear set of well-defined operations and their required permission.
> Even better, one syscall per operation should simplify their interface.

The development and maintenance of system calls is expensive in both
time and effort. LSM specific system calls frighten me. When I was
young adding system calls was just  not  done. A system call would
never be allowed for a specific sub-system or optional feature. True,
there are issues with the LSM specific filesystem approach. But I
like it, as it allows the LSM more freedom in its interfaces and
won't clutter the API if the LSM goes away or quits using it.



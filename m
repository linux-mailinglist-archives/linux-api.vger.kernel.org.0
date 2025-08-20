Return-Path: <linux-api+bounces-4531-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679BB2E18A
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC703BCF6B
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 15:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650B321F4D;
	Wed, 20 Aug 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mye5x5No"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676DB311C29
	for <linux-api@vger.kernel.org>; Wed, 20 Aug 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705058; cv=none; b=JrdUzmRvIaXWva4H2o7jWqaMEqixBfn/9HrJ72QgXcyeYxNdDS0s6POSYB/5SyRVB+tMH6q8gxglu53kdWUxq55k45QDFnSlI/zhYAuGCREBG5SXU2nu1aZoTmel/Qs8iBvns2doLaRvhsoLC06nzWByHYalVD2QISky/6nLjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705058; c=relaxed/simple;
	bh=SXNx3lKmPrwkEW7gZM7YKiNTckmkOV0arfd/pQSGMyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYNrVQsOr88htnBNkyAzXh0jEHzu7a38t/XYWPrRQpuAOBRRiwkwImuF7n45HBaJAjHf0tj4kV8cbHblflNNs+9EyD3QRseEJHlF6/CltB3EroXMz/wjIszgV/Jvt2qudsg3XRvGfyK/2xOGI9TJklVJQnbWDYSrY8Iv+KCfjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mye5x5No; arc=none smtp.client-ip=66.163.184.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755705055; bh=jmxlOiKMyZpeZfhOYibZ1US2MQGZwPRZx/AFnnpMg34=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mye5x5NoRT+rHTIzKiWvxG3J0Y6AXNhJavf36aNnL0WqaYPmdwnV1kn1oGKfRKV+ZUksVyIAVYGJ1ZAeOz+E9W8JKHkqffsPA+SGTWwzUsicC5cyRqePI1Vw0J262ORMPJzXR/I8PvtYwW+LQdD7rR5vKPsW27XXdc5TGHzGV6doxca5LygxxMZnGNdh5WLgm6Du4P6Yn2jtNXBq8gzy8QAcC54v/fnlsbdRNpckqSciy3QFKYNDxHURsqP9oNctC72hUbyen4uJ0rwuCBkN1qHN6FV8/gZXhVuGHaNWpv0vPxtjspGlhAglLzRk7phj0CbRXig8QaA9oY80ZzphhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755705055; bh=XcN1/QfG29jt971RK/L1NxnAWtlmXvMMHvJonkIa/z3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rSOp+0KHEO/bn1o74GhnUdIbVLEvIR9q8PqQ08hoKCNl+lSrlrz/z0Vr9yGH7ECuH1Q+8GxampA0U0mvq2G17Owfu0hYQBSxB9dNpF3VgtKCGSUimPm+75zVf1aF7zEbmS8Jxctp+H0Hnnmv6ZGtpfUNU+bmqP+/KdWJgj8Xxh2N8taKPYnqJhJQxwF+oiugjR15xMvU/5FHkQVJnkNIGJ4kp+E1xzdVzIEKSeKMV31kRn8BYdHYRyDdrwS7ZM/qNm2EDFezwds696vDbdYVkjByRal+BI9GnI0dPToETM3hG7baioprp2Mv1r9wOHueWrJXPSZix7OaLAMWYfhlKQ==
X-YMail-OSG: BKd4qI0VM1m_siIoA_J1.f5_Ft3MOgvP_vxb9aCPlavZqe1BIrns.zUuLW8Ckt6
 0nLSfx8QdxyXeE0OWRUb70tbhcZj8IKvpT1ztj1UIRGxCCSXemY5ON.tg34TMAUkEGi95kKlCryo
 A0zaQJCaF.xZcJq56wnhmisOuGIPmFUWDR5en44ufd_JHcGUQF72wBQgUy0EUuXbHM3IUdQpKFUd
 YmwoXLuVCkNa4IvEjGShqaDLXMgPh8_szgEFf2KpUZ73PX1PL8BBV1pRXzn4wfB4YjZDxDC6kynQ
 r5QZkaHNyEk4YrAAs4qveU9s4QIjrKEH0k2NariJPaTuGu9JMYiVfGi9yjMMBh1.vaPaTJkeQ5Pj
 1tgiI47Z5XQ96bqleDtBZZCyOWEd9Mj.8jof7juJZlY6EWZdOUqfU_VLTYDjAqM9oOq64TRVOYAe
 1OJeDwXMjUj85STB.hPY2WHcBhmedkFrADDc4Yt6Pj0lTmw176PflNq3BqSHhxuOqXJIS1nBERAf
 f6WVmk.1u6w0uXXpKmao8bolpiD7P42DMHZuqrcWlYQ2ubVVM7SaL2e.RbzQYq_sYC1XNqYjFuXN
 NgToFyTOD41HRX3MDfOPlIi09rxRP3MjsAU9wPDj.Ga1C3UW2DVXBmuZEH7S2p5aVmkTvKZbcy1Q
 zUJUgbu5hkA88A2vWMl7PVhBEhTmO8aS9PP.zeZzHNDCm4bRh5etyxvJyLBO7mFEE4pjBUEcWeVr
 wW3Ac1phNTlpgzD.BbnzK5aFmpzaK4vj1IFV9Y7jLn9N7pbGKwqRnRYiajvj5YmccYM6PSiYqivd
 4aTTLihHs9eQFNXSLFJWgfpwqoQcwA7sduxM1eA4Z04sDV2PhqDQPuZHv_HEmnqeRYrzQFTCYAIg
 e5buOfdkDjGDL3RgcoJ0PpuJD8e8v13iIV_BhnPUjj52fPYQixSBsiQKk4jsvnUNAfs5S5m0xlxd
 aGQxHyoFKVq7QNEUstkwYu39iTd5oHHXmGkKb6s0c2.VFyrUwtbU1INVFlo2wZbODZHFDDGPNemx
 LJ3HDsPY0AIeS1fr8lm567fipCpe6ToUVmij3LfnKcPRV3N8Up.72J6w8xEuM9Gv42eO9j0LkhJ1
 OU17VtT5JBIkwi6SO62nKn.48SFMK4wtdy6skQMpsvSgD.yxf4E2j._VGWgfIYT0joJ64bMlHZhT
 qv88CpviU1bTlIGbOD_UqJn0bTEaaMHBr1lbYuh8nbYb9g2Aimv8TrE8.06E6L03pPhYeMEuxUhy
 REpgfN0Bx55MdxBMDCjqOOKiv1YQVPtDFAV2qQ6OXyjSL3T.jtEHnGF5Js1glQQ7qV5QsDspJA3V
 ydgq.vsIv8wfmzilooT_l4d6zWwUzvuSbF_3iE_jCQVv5XENQ_03E1FEruCCMg9ZI6bCTkm2L.Qh
 URiXyWQ8gq9fR7TSeqZFSsIgdf7Xnrih0Oeh7.fPhzrk.K7JsyHjpN1ymCv4XVDso6c20ie8ci2E
 GUrUcimBjwDmuGbpkAdZFr96KBHLnqR9C5JIFEWUjnbypYWjTfTcqasxgSJ4d8ghSb.V1okv0waW
 0oXXRAcxKCZscUt8kmhxBEwBVsB7ALidn8DZi9NQr3JyRfqY8PxmeKgzK1wh9Jdq48zXt2bpCbJa
 BwNBEKvvi.1FE5.sA6CcPriHHrMqP9dscKS7._Drqg5UeiVoq3CMUgdd1Wu9TUy_PAeAeupgB5yp
 xZ330S066_Dl3IFviXkJi3yoF3LrGJ1oZyAXcwzbOdcE9mB9JHETzDjxmzgXIUa6BY6Fgj3EQKu.
 qAkvyonKtV9lblGZH6F_tyAFAVSdCvbBXgAZ_AIrNi5xy8AMLzgbquEeDEN6V7yYXcUBU2VnsJrM
 gTWXKfPs3gptqcPtXc8vQnJw_CtVK6RKF4e54BgYScLgsRJOOK7VvkxOaEbQFv3YXulA2gpmRKRx
 CPjYQrmYTEmqdCBlAW.W9ssj71oc5CUTRSTzsPc0C4EbKL0t9OIPktIqG8tL0ogkbVwsbgobZraF
 zOab5kV_S_rrrLuqvOgpPsIOE0bKff.076Yu_NhRO0TZ9HTe10ILJXOv10YRqSl8fkcTITbPPKdb
 gc_hWgD..PhR2NUp_F70vozes.cieots1t5_bcNrWSn7cpCdeO6wYUbyV.nNSyAsGv9rmDlrSvhA
 1Edc_wGV5XvqtHHnVEK2P.SzALxi.zB7uBCL3EJdShT953YJpbH8nlBYCNDXTo2tNrxBtdz9saTI
 YjJtAV0uehdKI9YcXMT6NK4NzXjki5rjfWoLX2gekoT.Xiss1C042T1GNann63Ejv1iWec.l2HxO
 Kv92oyXpQ8TgpKf3s
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0e4b2175-bc63-45c1-87a7-54204571253d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Aug 2025 15:50:55 +0000
Received: by hermes--production-gq1-74d64bb7d7-r5xbr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f21546110efcd91dfbf53c9b19723f70;
          Wed, 20 Aug 2025 15:30:35 +0000 (UTC)
Message-ID: <0c7a19cb-d270-403f-9f97-354405aba746@schaufler-ca.com>
Date: Wed, 20 Aug 2025 08:30:33 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, kees@kernel.org,
 stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp,
 penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <20250709080220.110947-3-maxime.belair@canonical.com>
 <20250820.Ao3iquoshaiB@digikod.net>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250820.Ao3iquoshaiB@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/20/2025 7:21 AM, Mickaël Salaün wrote:
> On Wed, Jul 09, 2025 at 10:00:55AM +0200, Maxime Bélair wrote:
>> Define two new LSM hooks: security_lsm_config_self_policy and
>> security_lsm_config_system_policy and wire them into the corresponding
>> lsm_config_*_policy() syscalls so that LSMs can register a unified
>> interface for policy management. This initial, minimal implementation
>> only supports the LSM_POLICY_LOAD operation to limit changes.
>>
>> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
>> ---
>>  include/linux/lsm_hook_defs.h |  4 +++
>>  include/linux/security.h      | 20 ++++++++++++
>>  include/uapi/linux/lsm.h      |  8 +++++
>>  security/lsm_syscalls.c       | 17 ++++++++--
>>  security/security.c           | 60 +++++++++++++++++++++++++++++++++++
>>  5 files changed, 107 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index bf3bbac4e02a..fca490444643 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -464,3 +464,7 @@ LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
>>  LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
>>  LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
>>  	 enum lsm_integrity_type type, const void *value, size_t size)
>> +LSM_HOOK(int, -EINVAL, lsm_config_self_policy, u32 lsm_id, u32 op,
>> +	 void __user *buf, size_t size, u32 flags)
>> +LSM_HOOK(int, -EINVAL, lsm_config_system_policy, u32 lsm_id, u32 op,
>> +	 void __user *buf, size_t size, u32 flags)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index cc9b54d95d22..54acaee4a994 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -581,6 +581,11 @@ void security_bdev_free(struct block_device *bdev);
>>  int security_bdev_setintegrity(struct block_device *bdev,
>>  			       enum lsm_integrity_type type, const void *value,
>>  			       size_t size);
>> +int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
>> +				    size_t size, u32 flags);
>> +int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
>> +				      size_t size, u32 flags);
>> +
>>  #else /* CONFIG_SECURITY */
>>  
>>  /**
>> @@ -1603,6 +1608,21 @@ static inline int security_bdev_setintegrity(struct block_device *bdev,
>>  	return 0;
>>  }
>>  
>> +static inline int security_lsm_config_self_policy(u32 lsm_id, u32 op,
>> +						  void __user *buf,
>> +						  size_t size, u32 flags)
>> +{
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int security_lsm_config_system_policy(u32 lsm_id, u32 op,
>> +						    void __user *buf,
>> +						    size_t size, u32 flags)
>> +{
>> +
>> +	return -EOPNOTSUPP;
>> +}
>>  #endif	/* CONFIG_SECURITY */
>>  
>>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index 938593dfd5da..2b9432a30cdc 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -90,4 +90,12 @@ struct lsm_ctx {
>>   */
>>  #define LSM_FLAG_SINGLE	0x0001
>>  
>> +/*
>> + * LSM_POLICY_XXX definitions identify the different operations
>> + * to configure LSM policies
>> + */
>> +
>> +#define LSM_POLICY_UNDEF	0
>> +#define LSM_POLICY_LOAD		100
> Why the gap between 0 and 100?

It's conventional in LSM syscalls to start identifiers at 100.
No compelling reason other than to appease the LSM maintainer.

>
>> +
>>  #endif /* _UAPI_LINUX_LSM_H */
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index a3cb6dab8102..dd016ba6976c 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -122,11 +122,24 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>>  SYSCALL_DEFINE5(lsm_config_self_policy, u32, lsm_id, u32, op, void __user *,
>>  		buf, u32 __user *, size, u32, flags)
> Given these are a multiplexor syscalls, I'm wondering if they should not
> have common flags and LSM-specific flags.  Alternatively, the op
> argument could also contains some optional flags.  In either case, the
> documentation should guide LSM developers for flags that may be shared
> amongst LSMs.
>
> Examples of such flags could be to restrict the whole process instead of
> the calling thread.
>
>>  {
>> -	return 0;
>> +	size_t usize;
>> +
>> +	if (get_user(usize, size))
> Size should just be u32, not a pointer.
>
>> +		return -EFAULT;
>> +
>> +	return security_lsm_config_self_policy(lsm_id, op, buf, usize, flags);
>>  }
>>  
>>  SYSCALL_DEFINE5(lsm_config_system_policy, u32, lsm_id, u32, op, void __user *,
>>  		buf, u32 __user *, size, u32, flags)
>>  {
>> -	return 0;
>> +	size_t usize;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
> I like this mandatory capability check for this specific syscall.  This
> makes the semantic clearer.  However, to avoid the superpower of
> CAP_SYS_ADMIN, I'm wondering how we could use the CAP_MAC_ADMIN instead.
> This syscall could require CAP_MAC_ADMIN, and current LSMs (relying on a
> filesystem interface for policy configuration) could also enforce
> CAP_SYS_ADMIN for compatibility reasons.
>
> In fact, this "system" syscall could be a "namespace" syscall, which
> would take a security/LSM namespace file descriptor as argument.  If the
> namespace is not the initial namespace, any CAP_SYS_ADMIN implemented by
> current LSMs could be avoided.  See
> https://lore.kernel.org/r/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com
>
>> +
>> +	if (get_user(usize, size))
> ditto
>
>> +		return -EFAULT;
>> +
>> +	return security_lsm_config_system_policy(lsm_id, op, buf, usize, flags);
>>  }
>> diff --git a/security/security.c b/security/security.c
>> index fb57e8fddd91..166d7d9936d0 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -5883,6 +5883,66 @@ int security_bdev_setintegrity(struct block_device *bdev,
>>  }
>>  EXPORT_SYMBOL(security_bdev_setintegrity);
>>  
>> +/**
>> + * security_lsm_config_self_policy() - Configure caller's LSM policies
>> + * @lsm_id: id of the LSM to target
>> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
>> + * @buf: userspace pointer to policy data
>> + * @size: size of @buf
>> + * @flags: lsm policy configuration flags
>> + *
>> + * Configure the policies of a LSM for the current domain/user. This notably
>> + * allows to update them even when the lsmfs is unavailable or restricted.
>> + * Currently, only LSM_POLICY_LOAD is supported.
>> + *
>> + * Return: Returns 0 on success, error on failure.
>> + */
>> +int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
>> +				 size_t size, u32 flags)
>> +{
>> +	int rc = LSM_RET_DEFAULT(lsm_config_self_policy);
>> +	struct lsm_static_call *scall;
>> +
>> +	lsm_for_each_hook(scall, lsm_config_self_policy) {
>> +		if ((scall->hl->lsmid->id) == lsm_id) {
>> +			rc = scall->hl->hook.lsm_config_self_policy(lsm_id, op, buf, size, flags);
> The lsm_id should not be passed to the hook.
>
> The LSM syscall should manage the argument copy and buffer allocation
> instead of duplicating this code in each LSM hook implementation (see
> other LSM syscalls).
>
>> +			break;
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +/**
>> + * security_lsm_config_system_policy() - Configure system LSM policies
>> + * @lsm_id: id of the lsm to target
>> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
>> + * @buf: userspace pointer to policy data
>> + * @size: size of @buf
>> + * @flags: lsm policy configuration flags
>> + *
>> + * Configure the policies of a LSM for the whole system. This notably allows
>> + * to update them even when the lsmfs is unavailable or restricted. Currently,
>> + * only LSM_POLICY_LOAD is supported.
>> + *
>> + * Return: Returns 0 on success, error on failure.
>> + */
>> +int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
>> +				   size_t size, u32 flags)
>> +{
>> +	int rc = LSM_RET_DEFAULT(lsm_config_system_policy);
>> +	struct lsm_static_call *scall;
>> +
>> +	lsm_for_each_hook(scall, lsm_config_system_policy) {
>> +		if ((scall->hl->lsmid->id) == lsm_id) {
>> +			rc = scall->hl->hook.lsm_config_system_policy(lsm_id, op, buf, size, flags);
> ditto
>
>> +			break;
>> +		}
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>  #ifdef CONFIG_PERF_EVENTS
>>  /**
>>   * security_perf_event_open() - Check if a perf event open is allowed
>> -- 
>> 2.48.1
>>
>>


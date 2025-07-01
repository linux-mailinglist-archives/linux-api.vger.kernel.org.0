Return-Path: <linux-api+bounces-4083-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA7DAEF478
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 12:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF548232E
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2F2701C5;
	Tue,  1 Jul 2025 10:03:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B32701BF;
	Tue,  1 Jul 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364189; cv=none; b=Xa3BCzOYLu8Zv30SRLhEmoSbJrwV9H56bGcr/erHzbb7CAHGMzM2xZQE5rySFSZvM7nSgU8LyFcZUyoO/yDzHjnM6YQ3nWaCWJ+3qUDsEVLG1xCbSdVg6U/mCLbSKJee2epJ+kb6VDSk+9XJzW/to1q2XR/2V3r2BbD2/bH+pw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364189; c=relaxed/simple;
	bh=NvbjkUgdlWSy3WOQbPWAgbYm4pYFUwIcipL4RztdTgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgZA0/e0oquRXAyoiRGtXZPNmDj9jidP6BuoAd719/x9ZiubbqFMrbmdtUMGJNdmzhXHY4ZRv1QibdUaBkG5IzpQnzFjuYacNRlmwkTv2Jrn0G0PruSTlk5ukzrHdyorzyGHtPh61+46XqsQqyEFUB0GCbLYXLE6Qxnpjixh/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 561A1lZv068590;
	Tue, 1 Jul 2025 19:01:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 561A1kQM068582
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 1 Jul 2025 19:01:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8cf8c12d-65fc-4e3d-9c2e-fd7d40d38613@I-love.SAKURA.ne.jp>
Date: Tue, 1 Jul 2025 19:01:46 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infradead.org,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250701091904.395837-1-maxime.belair@canonical.com>
 <20250701091904.395837-4-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250701091904.395837-4-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/01 18:17, Maxime Bélair wrote:
> +static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	char *name;
> +	long name_size;
> +	int ret;
> +
> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +	if (size > AA_PROFILE_NAME_MAX_SIZE)
> +		return -E2BIG;
> +
> +	name = kmalloc(size, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +
> +	name_size = strncpy_from_user(name, buf, size);
> +	if (name_size < 0) {
> +		kfree(name);
> +		return name_size;
> +	}
> +
> +	ret = aa_change_profile(name, AA_CHANGE_STACK);

If size == 0, name == ZERO_SIZE_PTR and name_size == 0.
Then, aa_change_profile() will oops due to ZERO_SIZE_PTR deref.

> +
> +	kfree(name);
> +
> +	return ret;
> +}
> +
> +/**
> + * apparmor_lsm_config_system_policy - Load or replace a system policy
> + * @lsm_id: AppArmor ID (LSM_ID_APPARMOR). Unused here
> + * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
> + * @buf: user-supplied buffer in the form "<ns>\0<policy>"
> + *        <ns> is the namespace to load the policy into (empty string for root)
> + *        <policy> is the policy to load
> + * @size: size of @buf
> + * @flags: reserved for future uses; must be zero
> + *
> + * Returns: 0 on success, negative value on error
> + */
> +static int apparmor_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	loff_t pos = 0; // Partial writing is not currently supported
> +	char name[AA_PROFILE_NAME_MAX_SIZE];
> +	long name_size;
> +
> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +	if (size > AA_PROFILE_MAX_SIZE)
> +		return -E2BIG;
> +
> +	name_size = strncpy_from_user(name, buf, AA_PROFILE_NAME_MAX_SIZE);
> +	if (name_size < 0)
> +		return name_size;
> +	else if (name_size == AA_PROFILE_NAME_MAX_SIZE)
> +		return -E2BIG;
> +
> +	return aa_profile_load_ns_name(name, name_size, buf + name_size + 1,
> +				       size - name_size - 1, &pos);

If size == 0 and *name == '\0', name_size == 0. Then, size will be -1 at aa_profile_load_ns_name()
and WARN_ON_ONCE() in __kvmalloc_node_noprof() from kvzalloc() from policy_update() will trigger?

You need more stricter checks to verify that @buf is in the form "<ns>\0<policy>".
strncpy_from_user() should not try to read more than @size bytes.

> +}
> +
> +



Also, in [PATCH v4 2/3], why do you need lines below?
These functions are supposed to be called via only syscalls, aren't these?

+EXPORT_SYMBOL(security_lsm_config_self_policy);
+EXPORT_SYMBOL(security_lsm_config_system_policy);



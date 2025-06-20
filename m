Return-Path: <linux-api+bounces-3949-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B30AE1190
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 05:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1039E3B7D8B
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E3F1B3956;
	Fri, 20 Jun 2025 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q7ueolur"
X-Original-To: linux-api@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6A23CE;
	Fri, 20 Jun 2025 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388956; cv=none; b=SnMewBwS4gwkycE0nlWZqW9E1+livcBXF8PihDBub0sXci8OEfTW0AtmkkR3zoKXwHZ6m7XmyFy2o1YJzhj56xrTfHT5Tq8AtZMILeYGXunwNZzVix+OZ9kExnoM31tD/CWyr1Jz+g40DeidooXU50UwVi6bBII1D63dailJloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388956; c=relaxed/simple;
	bh=pipyYOpRRzImWVWLnx1SKvu0bqhwa5/T7OLtSrjSwSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1v2f1yD0a6T02BXn/rosvkCod3tHTf0mnNNDkgIiiruWxpdUGTfr+B/qi+osf8tBTKjW843kZNb3qXEuHGvE8CZHmqEuYDNTnw4EEaA/WjeVtwOA3iNbuTCItI4iJz4o2l+Brl8/5z+e/iUuT1rRKDnJMGegwaZbjBzBzg0gWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q7ueolur; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=huqQPaIQVjQ8U0whbg/KBNVddTgu59sO3GqyMYBnHWo=; b=Q7ueolurEkwtG5pfVrsM1kUX7z
	4VmsZeIQlyxqcYdi/2FnbwonBJ1bj0d5xYTNqGm3Zw2RZ0p8rjWZ3HgMQ2i+Ju1/SXDyIaLHL3Fw1
	0mvUDczBTquvzX4IdwihljV0mJ0+UI2c1Dzcypea1AyXv+eq3XZPf4mptHQdT8v6qUjw0ztP0gcfD
	hlPByk034y7u0yMP+eqDzTV2CMs2AQ7lqxmJrEQjfVC4VTb8Xy+kUO1Acv3VBMjXxPPWNis/mgL74
	sjf7VONqO188r29zm6jIJQvmEMUokCH8Pih1kXsJ/4agDSPAjYJrLjuTtVdr95rVHUJC3hQ36/GgF
	pyotFBGw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSS7r-00000004dnK-0wVr;
	Fri, 20 Jun 2025 03:09:11 +0000
Message-ID: <867c16fe-da0f-43d0-99ca-cba8f3c1f274@infradead.org>
Date: Thu, 19 Jun 2025 20:09:06 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, song@kernel.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org
References: <20250619181600.478038-1-maxime.belair@canonical.com>
 <20250619181600.478038-4-maxime.belair@canonical.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250619181600.478038-4-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/19/25 11:15 AM, Maxime Bélair wrote:
> Enable users to manage AppArmor policies through the new hooks
> lsm_config_self_policy and lsm_config_system_policy.
> 
> lsm_config_self_policy allows stacking existing policies in the kernel.
> This ensures that it can only further restrict the caller and can never
> be used to gain new privileges.
> 
> lsm_config_system_policy allows loading or replacing AppArmor policies in
> any AppArmor namespace.
> 
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
> ---
>  security/apparmor/apparmorfs.c         | 31 +++++++++++++
>  security/apparmor/include/apparmorfs.h |  3 ++
>  security/apparmor/lsm.c                | 63 ++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 6039afae4bfc..827fe06b20ac 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -439,6 +439,37 @@ static ssize_t policy_update(u32 mask, const char __user *buf, size_t size,
>  	return error;
>  }
>  
> +/**
> + * aa_profile_load_ns_name - load a profile into the current namespace identified by name
> + * @name The name of the namesapce to load the policy in. "" for root_ns
> + * @name_size size of @name. 0 For root ns
> + * @buf buffer containing the user-provided policy
> + * @size size of @buf
> + * @ppos position pointer in the file

Please use proper kernel-doc syntax above. Each @var_name should be followed
by a ':'.

> + *
> + * Returns: 0 on success, negative value on error
> + */
> +ssize_t aa_profile_load_ns_name(char *name, size_t name_size, const void __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct aa_ns *ns;
> +
> +	if (name_size == 0)
> +		ns = aa_get_ns(root_ns);
> +	else
> +		ns = aa_lookupn_ns(root_ns, name, name_size);
> +
> +	if (!ns)
> +		return -EINVAL;
> +
> +	int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
> +				  buf, size, ppos, ns);
> +
> +	aa_put_ns(ns);
> +
> +	return error >= 0 ? 0 : error;
> +}
> +
>  /* .load file hook fn to load policy */
>  static ssize_t profile_load(struct file *f, const char __user *buf, size_t size,
>  			    loff_t *pos)

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9b6c2f157f83..b38c4926cdc2 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1275,6 +1275,65 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>  	return aa_sock_perm(OP_SHUTDOWN, AA_MAY_SHUTDOWN, sock);
>  }
>  
> +/**
> + * apparmor_lsm_config_self_policy - Stack a profile
> + * @buf: buffer containing the user-provided name of the profile to stack
> + * @size: size of @buf

Describe all function parameters in kernel-doc above.

> + *
> + * Returns: 0 on success, negative value on error
> + */
> +static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	char *name = kvmalloc(size, GFP_KERNEL);

Check return value (i.e., name) before use?

> +	long name_size;> +	int ret;
> +
> +	if (op != LSM_POLICY_LOAD || flags)
> +		return -EOPNOTSUPP;
> +
> +	name_size = strncpy_from_user(name, buf, size);
> +	if (name_size < 0)
> +		return name_size;
> +
> +	ret = aa_change_profile(name, AA_CHANGE_STACK);
> +
> +	kvfree(name);
> +
> +	return ret;
> +}
> +
> +/**
> + * apparmor_lsm_config_system_policy - Load or replace a system policy
> + * @buf: user-supplied buffer in the form "<ns>\0<policy>"
> + *        <ns> is the namespace to load the policy into (empty string for root)
> + *        <policy> is the policy to load
> + * then '\0' then the policy to load

Misplaced line?

> + * @size: size of @buf

Please describe all function parameters in kernel-doc notation.

> + *
> + * Returns: 0 on success, negative value on error
> + */
> +static int apparmor_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{

[snip]

-- 
~Randy



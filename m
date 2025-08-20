Return-Path: <linux-api+bounces-4529-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA6B2E090
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8CA6002E3
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD85D369985;
	Wed, 20 Aug 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="VGziGNUB"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A72BE655
	for <linux-api@vger.kernel.org>; Wed, 20 Aug 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702015; cv=none; b=hDmqQquRsjNhseFMdzqpd8tb/SzzwJhAw5xOP+1SvSx7QNbYe3FDwI1KN3fpdzIJNF8qArIW9EnfaA2XsetnB27PIxcwvUf7KQKn9xdFSKW+03QfKFyf76lBO0Tz8tMxsb9CK+cD5SgUEJlqgE3s6ABMW14XD85Y1g9YMWDjfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702015; c=relaxed/simple;
	bh=c7IzczsWMi0gWGbbRidHwgG2cUmQEowvfBheaY9l/xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2kcl+2RzJZHvyFgTrfQ+TLNjDUsv0/PsCTsVeZ9nCbMZH44O/YueKcMRd/y9ZNZ+ZAS12Sbjc41iMOfFNs1C+gRqKvEpD7XCbZuFqoRJaoFXzAqGccnXKjP23K6ShPTnj6TI2qx0p6hGJl/Mo+qfJ85X22scB5ehlh1Ha5Ugtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=VGziGNUB; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c6TCR139CzfNT;
	Wed, 20 Aug 2025 16:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755699682;
	bh=0wqyaZFSWYtPdNqfHhuyrQQKSv9Wt2BD7UTOvZEAprc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGziGNUBmbblOW0eVOkJCIxxDosgWLCB+YmJ0lxig5WaddOYAD09cJwu7LpkYXT95
	 2b6FmpIFOQpHnMxkdGuui6Hn34/NrbiZj7VNE25Ri7Z9o8XuFIyJBtUD3U0cShv8jT
	 axCQWIPeeCb+Ok0mijyzTF8KAgT0ZIUgnoGFM7uM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4c6TCM1TCqzPC8;
	Wed, 20 Aug 2025 16:21:19 +0200 (CEST)
Date: Wed, 20 Aug 2025 16:21:18 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] lsm: introduce security_lsm_config_*_policy hooks
Message-ID: <20250820.Ao3iquoshaiB@digikod.net>
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <20250709080220.110947-3-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709080220.110947-3-maxime.belair@canonical.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 09, 2025 at 10:00:55AM +0200, Maxime Bélair wrote:
> Define two new LSM hooks: security_lsm_config_self_policy and
> security_lsm_config_system_policy and wire them into the corresponding
> lsm_config_*_policy() syscalls so that LSMs can register a unified
> interface for policy management. This initial, minimal implementation
> only supports the LSM_POLICY_LOAD operation to limit changes.
> 
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 +++
>  include/linux/security.h      | 20 ++++++++++++
>  include/uapi/linux/lsm.h      |  8 +++++
>  security/lsm_syscalls.c       | 17 ++++++++--
>  security/security.c           | 60 +++++++++++++++++++++++++++++++++++
>  5 files changed, 107 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bf3bbac4e02a..fca490444643 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -464,3 +464,7 @@ LSM_HOOK(int, 0, bdev_alloc_security, struct block_device *bdev)
>  LSM_HOOK(void, LSM_RET_VOID, bdev_free_security, struct block_device *bdev)
>  LSM_HOOK(int, 0, bdev_setintegrity, struct block_device *bdev,
>  	 enum lsm_integrity_type type, const void *value, size_t size)
> +LSM_HOOK(int, -EINVAL, lsm_config_self_policy, u32 lsm_id, u32 op,
> +	 void __user *buf, size_t size, u32 flags)
> +LSM_HOOK(int, -EINVAL, lsm_config_system_policy, u32 lsm_id, u32 op,
> +	 void __user *buf, size_t size, u32 flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc9b54d95d22..54acaee4a994 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -581,6 +581,11 @@ void security_bdev_free(struct block_device *bdev);
>  int security_bdev_setintegrity(struct block_device *bdev,
>  			       enum lsm_integrity_type type, const void *value,
>  			       size_t size);
> +int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				    size_t size, u32 flags);
> +int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags);
> +
>  #else /* CONFIG_SECURITY */
>  
>  /**
> @@ -1603,6 +1608,21 @@ static inline int security_bdev_setintegrity(struct block_device *bdev,
>  	return 0;
>  }
>  
> +static inline int security_lsm_config_self_policy(u32 lsm_id, u32 op,
> +						  void __user *buf,
> +						  size_t size, u32 flags)
> +{
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int security_lsm_config_system_policy(u32 lsm_id, u32 op,
> +						    void __user *buf,
> +						    size_t size, u32 flags)
> +{
> +
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..2b9432a30cdc 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -90,4 +90,12 @@ struct lsm_ctx {
>   */
>  #define LSM_FLAG_SINGLE	0x0001
>  
> +/*
> + * LSM_POLICY_XXX definitions identify the different operations
> + * to configure LSM policies
> + */
> +
> +#define LSM_POLICY_UNDEF	0
> +#define LSM_POLICY_LOAD		100

Why the gap between 0 and 100?

> +
>  #endif /* _UAPI_LINUX_LSM_H */
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index a3cb6dab8102..dd016ba6976c 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -122,11 +122,24 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>  SYSCALL_DEFINE5(lsm_config_self_policy, u32, lsm_id, u32, op, void __user *,
>  		buf, u32 __user *, size, u32, flags)

Given these are a multiplexor syscalls, I'm wondering if they should not
have common flags and LSM-specific flags.  Alternatively, the op
argument could also contains some optional flags.  In either case, the
documentation should guide LSM developers for flags that may be shared
amongst LSMs.

Examples of such flags could be to restrict the whole process instead of
the calling thread.

>  {
> -	return 0;
> +	size_t usize;
> +
> +	if (get_user(usize, size))

Size should just be u32, not a pointer.

> +		return -EFAULT;
> +
> +	return security_lsm_config_self_policy(lsm_id, op, buf, usize, flags);
>  }
>  
>  SYSCALL_DEFINE5(lsm_config_system_policy, u32, lsm_id, u32, op, void __user *,
>  		buf, u32 __user *, size, u32, flags)
>  {
> -	return 0;
> +	size_t usize;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

I like this mandatory capability check for this specific syscall.  This
makes the semantic clearer.  However, to avoid the superpower of
CAP_SYS_ADMIN, I'm wondering how we could use the CAP_MAC_ADMIN instead.
This syscall could require CAP_MAC_ADMIN, and current LSMs (relying on a
filesystem interface for policy configuration) could also enforce
CAP_SYS_ADMIN for compatibility reasons.

In fact, this "system" syscall could be a "namespace" syscall, which
would take a security/LSM namespace file descriptor as argument.  If the
namespace is not the initial namespace, any CAP_SYS_ADMIN implemented by
current LSMs could be avoided.  See
https://lore.kernel.org/r/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com

> +
> +	if (get_user(usize, size))

ditto

> +		return -EFAULT;
> +
> +	return security_lsm_config_system_policy(lsm_id, op, buf, usize, flags);
>  }
> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..166d7d9936d0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5883,6 +5883,66 @@ int security_bdev_setintegrity(struct block_device *bdev,
>  }
>  EXPORT_SYMBOL(security_bdev_setintegrity);
>  
> +/**
> + * security_lsm_config_self_policy() - Configure caller's LSM policies
> + * @lsm_id: id of the LSM to target
> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
> + * @buf: userspace pointer to policy data
> + * @size: size of @buf
> + * @flags: lsm policy configuration flags
> + *
> + * Configure the policies of a LSM for the current domain/user. This notably
> + * allows to update them even when the lsmfs is unavailable or restricted.
> + * Currently, only LSM_POLICY_LOAD is supported.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				 size_t size, u32 flags)
> +{
> +	int rc = LSM_RET_DEFAULT(lsm_config_self_policy);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, lsm_config_self_policy) {
> +		if ((scall->hl->lsmid->id) == lsm_id) {
> +			rc = scall->hl->hook.lsm_config_self_policy(lsm_id, op, buf, size, flags);

The lsm_id should not be passed to the hook.

The LSM syscall should manage the argument copy and buffer allocation
instead of duplicating this code in each LSM hook implementation (see
other LSM syscalls).

> +			break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +/**
> + * security_lsm_config_system_policy() - Configure system LSM policies
> + * @lsm_id: id of the lsm to target
> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
> + * @buf: userspace pointer to policy data
> + * @size: size of @buf
> + * @flags: lsm policy configuration flags
> + *
> + * Configure the policies of a LSM for the whole system. This notably allows
> + * to update them even when the lsmfs is unavailable or restricted. Currently,
> + * only LSM_POLICY_LOAD is supported.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
> +				   size_t size, u32 flags)
> +{
> +	int rc = LSM_RET_DEFAULT(lsm_config_system_policy);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, lsm_config_system_policy) {
> +		if ((scall->hl->lsmid->id) == lsm_id) {
> +			rc = scall->hl->hook.lsm_config_system_policy(lsm_id, op, buf, size, flags);

ditto

> +			break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  #ifdef CONFIG_PERF_EVENTS
>  /**
>   * security_perf_event_open() - Check if a perf event open is allowed
> -- 
> 2.48.1
> 
> 


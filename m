Return-Path: <linux-api+bounces-3948-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3BAE117E
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3293BF700
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 03:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142CB7DA95;
	Fri, 20 Jun 2025 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErB1qrnu"
X-Original-To: linux-api@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59804137E;
	Fri, 20 Jun 2025 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388620; cv=none; b=BcJHRa59DkwqNi1lzAFut3dmPBguRkOowCYM6DnjMVC4PuiE5FsSpiD6ISqMaLYvsxkccl9E26bGtOuK0zkyF5SSZ2Yz1CZGrQ6sUWckZZHJFIZu8F8ysn+uisGRyKPdmYH5K8JmCf9ulvMTQv7NrixR60srtZ0PL+V3CvV/DBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388620; c=relaxed/simple;
	bh=6yCZRZuZUR7WhBry7brArBVWxVYRgw6AmXA2RXTmqDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ6PAtd5KDK1cxh/RQo/duVmMpWvw4VruviEItyRTAHZmWf0fp9MgylGm5T7I776wUVzxy7G/SqA6Mdc8Fxa1X2zlpTc5VPG7NVKzOHdUFuyHioiGtdPaFaXV+EcJ50Mf3RAoxdMrmpmFplU+9uDl1IusnxD+FMRRdLKGFCRsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ErB1qrnu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EE6yPAb2qKpzwXxZMMPRxZYq/qXbroYZD+xcI7gpJLE=; b=ErB1qrnuc1Sm3Qm4rUdhaaIfU0
	XiUaXD/sR1zZv9+9N+NHewsznKYcmTqc5toEw/2o6kYM9ItRf6yjvbLg2VAZEMg9SjZ2m0Rvhx3yy
	OUZxwV9hJSuQqlyGZiXwUiPzpGMp3QoQm74QNl14EenNY4piOIAV7rZ+1c2afkcYFTGV5cW6bK12w
	l6L+oS6pi/DFEYBMBhp4YtbBxhUT1WEhPiioBeYVJG9TSqFlMlTWnouDEd9wjPp9dqyRaOnkcE8oM
	IxrmMPrzbg7zCvsFhBQYHZ9MtQcV4ci+TJc/JkNkCJ2pffzW3/W97t9VmwEufU9TMilg4tLmdz9YT
	OeQmrPKQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSS2L-00000004dla-2mTL;
	Fri, 20 Jun 2025 03:03:30 +0000
Message-ID: <848423f2-65d8-4ae2-a873-2e8cd474ab86@infradead.org>
Date: Thu, 19 Jun 2025 20:03:23 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, song@kernel.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org
References: <20250619181600.478038-1-maxime.belair@canonical.com>
 <20250619181600.478038-3-maxime.belair@canonical.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250619181600.478038-3-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/19/25 11:15 AM, Maxime Bélair wrote:
> Define two new LSM hooks: security_lsm_config_self_policy and
> security_lsm_config_system_policy and wire them into the corresponding
> lsm_config_*_policy() syscalls so that LSMs can register a unified
> interface for policy management. This initial, minimal implementation
> only supports the LSM_POLICY_LOAD operation to limit changes.
> 
> Signed-off-by: Maxime Bélair <maxime.belair@canonical.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++
>  include/linux/security.h      | 16 ++++++++
>  include/uapi/linux/lsm.h      |  8 ++++
>  security/Kconfig              | 22 +++++++++++
>  security/lsm_syscalls.c       | 17 ++++++++-
>  security/security.c           | 69 +++++++++++++++++++++++++++++++++++
>  6 files changed, 134 insertions(+), 2 deletions(-)
> 

> diff --git a/security/Kconfig b/security/Kconfig
> index 4816fc74f81e..958be7b49a9e 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -220,6 +220,28 @@ config STATIC_USERMODEHELPER_PATH
>  	  If you wish for all usermode helper programs to be disabled,
>  	  specify an empty string here (i.e. "").
>  
> +config LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE
> +	int "Maximum buffer size for lsm_manage_policy"

Update function name.

> +	range 16384 1073741824
> +	depends on SECURITY
> +	default 4194304
> +	help
> +	  The maximum size of the buffer argument of lsm_config_self_policy.
> +
> +	  The default value of 4194304 (4MiB) is reasonable and should be large
> +	  enough to fit policies in for most cases.
> +
> +config LSM_CONFIG_SYSTEM_POLICY_MAX_BUFFER_SIZE
> +	int "Maximum buffer size for lsm_manage_policy"

same here.

> +	range 16384 1073741824
> +	depends on SECURITY
> +	default 4194304
> +	help
> +	  The maximum size of the buffer argument of lsm_config_system_policy.
> +
> +	  The default value of 4194304 (4MiB) is reasonable and should be large
> +	  enough to fit policies in for most cases
> +
>  source "security/selinux/Kconfig"
>  source "security/smack/Kconfig"
>  source "security/tomoyo/Kconfig"


> diff --git a/security/security.c b/security/security.c
> index fb57e8fddd91..8efea2b6e967 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5883,6 +5883,75 @@ int security_bdev_setintegrity(struct block_device *bdev,
>  }
>  EXPORT_SYMBOL(security_bdev_setintegrity);
>  
> +/**
> + * security_lsm_config_self_policy() - Manage caller's LSM policies
> + * @lsm_id: id of the LSM to target
> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
> + * @buf: userspace pointer to policy data
> + * @size: size of @buf
> + * @flags: lsm policy management flags
> + *
> + * Manage the policies of a LSM for the current domain/user. This notably allows
> + * to update them even when the lsmfs is unavailable is restricted. Currently,

                                                        or
?

> + * only LSM_POLICY_LOAD is supported.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				 size_t size, u32 flags)
> +{
> +	int rc = LSM_RET_DEFAULT(lsm_config_self_policy);
> +	struct lsm_static_call *scall;
> +
> +	if (size > (CONFIG_LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE))
> +		return -E2BIG;
> +
> +	lsm_for_each_hook(scall, lsm_config_self_policy) {
> +		if ((scall->hl->lsmid->id) == lsm_id) {
> +			rc = scall->hl->hook.lsm_config_self_policy(lsm_id, op, buf, size, flags);
> +			break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(security_lsm_config_self_policy);
> +
> +/**
> + * security_lsm_config_system_policy() - Manage system LSM policies
> + * @lsm_id: id of the lsm to target
> + * @op: Operation to perform (one of the LSM_POLICY_XXX values)
> + * @buf: userspace pointer to policy data
> + * @size: size of @buf
> + * @flags: lsm policy management flags
> + *
> + * Manage the policies of a LSM for the whole system. This notably allows
> + * to update them even when the lsmfs is unavailable is restricted. Currently,

                                                        or
?

> + * only LSM_POLICY_LOAD is supported.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
> +				   size_t size, u32 flags)
> +{

[snip]

-- 
~Randy



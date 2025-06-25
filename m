Return-Path: <linux-api+bounces-3987-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7588AE7442
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 03:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C1B3A49E4
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 01:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410A1487F4;
	Wed, 25 Jun 2025 01:21:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979B28E0F;
	Wed, 25 Jun 2025 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750814510; cv=none; b=lxn5FjttiQuFvdu13pVywm9Nk3OHHjAjgDtQsdKn7w4xs9O3N8XrC6X/bQxoNTziS1KA6xbn38KMpD+GrIk+/8AxYwvEBPc+WXICd+hOgYZNHiOeNviu0ISaQRphd72eqsVjYlrDNXqolG5OOjL2Zi9fWSuIeVPceGm5sgTJbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750814510; c=relaxed/simple;
	bh=LINdDpNksnnx/f6tpqoh7uinTypzMUkZ0HdOvwoyNr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPdY00CqB0IyEW8Ymf5ULpUvOM4GhMPkYEWP3nCP0ROzJCF7Ik36cS0i5RkX34/fLUacFV/SJEAz1B1fwqHjcqLKr6VjY1gf4+I2oinCD6MoXZ/l2F/JiungdwAauvmADxRcAY2C46akMx/dzN6F8wJh1GWVF8uNOHtesMsiToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55P1L8Kq015816;
	Wed, 25 Jun 2025 10:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55P1L7LF015812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Jun 2025 10:21:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5313b937-304a-4f2a-8563-3ad1ea194cb9@I-love.SAKURA.ne.jp>
Date: Wed, 25 Jun 2025 10:21:06 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infraread.org,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250624143211.436045-1-maxime.belair@canonical.com>
 <20250624143211.436045-4-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250624143211.436045-4-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/06/24 23:30, Maxime Bélair wrote:
> +static int apparmor_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
> +				      size_t size, u32 flags)
> +{
> +	char *name = kvmalloc(size, GFP_KERNEL);
> +	long name_size;
> +	int ret;
> +
> +	if (!name)
> +		return -ENOMEM;
> +
> +	if (op != LSM_POLICY_LOAD || flags)

Huge memory leak.

> +		return -EOPNOTSUPP;
> +
> +	name_size = strncpy_from_user(name, buf, size);
> +	if (name_size < 0)

Here too. :-)

> +		return name_size;
> +
> +	ret = aa_change_profile(name, AA_CHANGE_STACK);
> +
> +	kvfree(name);
> +
> +	return ret;
> +}



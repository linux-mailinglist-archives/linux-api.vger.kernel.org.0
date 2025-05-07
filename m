Return-Path: <linux-api+bounces-3708-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41EAADCA9
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87957ADCF7
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71161C6FF5;
	Wed,  7 May 2025 10:41:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FADB4414;
	Wed,  7 May 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614494; cv=none; b=h6ZJR5qre0qd7SLvAEXFMvfNNgFMhQ7N1TJK3/zlxgJ44tQiIO0EVUzsKiQ8YlIq/e0uD37+U67pmZEUVGD0SBzPkw1beCVt2mwJqqQzlFl25yYIlXwv8Oc/5/GkCO3ldqtI1vIz0bRBhoSAwX/jvXbHIxzi9iUzUk4ld8fSSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614494; c=relaxed/simple;
	bh=6/fyKXdJ4DvdgGCJD0Nlf2ars3Nx3AG135w4Nl37rk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsMDHNnQPhKSM7bdz/nZ9Wy1fuCsRd8+1Zh7hk4mBGV+aX7KGsYaL4wkEQM76tSRM2Q+ievGVjEYmaT2Ocyh5/ZnGf+2Lepph506uEJ/LdAJqh5DYVnkIi1a6nSZSv6g9O+pUPZB93CLE9T37wtZ8srOaS9GyeNfxybjCdIFtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 547AePvw062699;
	Wed, 7 May 2025 19:40:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 547AeOBM062693
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 7 May 2025 19:40:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
Date: Wed, 7 May 2025 19:40:21 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, linux-api@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250506143254.718647-3-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/05/06 23:32, Maxime Bélair wrote:
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index dcaad8818679..b39e6635a7d5 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>  SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void __user *, buf, u32
>  		__user *, size, u32, flags)
>  {
> -	return 0;
> +	size_t usize;
> +
> +	if (get_user(usize, size))
> +		return -EFAULT;
> +
> +	return security_lsm_manage_policy(lsm_id, op, buf, usize, flags);
>  }

syzbot will report user-controlled unbounded huge size memory allocation attempt. ;-)

This interface might be fine for AppArmor, but TOMOYO won't use this interface because
TOMOYO's policy is line-oriented ASCII text data where the destination is switched via
pseudo‑filesystem's filename; use of filename helps restricting which type of policy
can be manipulated by which process.



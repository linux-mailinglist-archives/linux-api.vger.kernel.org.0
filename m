Return-Path: <linux-api+bounces-3986-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF11AE741A
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 03:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5511617F715
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 01:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05430748D;
	Wed, 25 Jun 2025 01:10:07 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55D8634A;
	Wed, 25 Jun 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750813807; cv=none; b=kL7YrfEa1nKQ/zRH5ePCSaFTjoeIGtqF0URQmirgU04QU5JmSaDoaM2crtEOUgxmMuvqcR4n0X9IiN/SXrywtChiAeQqhHpV3WpnzagPxGoom0e5DFD7z+2IOmfFQl6XJmZggoSm0PUM+s4v7DH/PtmPdSc/m7uB8z0jMv1ZMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750813807; c=relaxed/simple;
	bh=jY+C/TpjBj7NczdPxP5qJzNzfhMM6ZTS+CIqe8D+ro4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9UcwYmF9B9dfYy3lYXahcaFrUBImvTpqm2Tl4EM9rxhAXZlrkLDZiWG3zOOVyH5ZcakjLrRuj+fkoo4Yc6PFmBKSl+SH+VDHZ6wZjd2cFpEqsyjYrvhmUD84v72+jH8oH6LX1EuJ5dkm2pObnymdwwpUJlxeA7GDlMaWghezdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55P18vOg012417;
	Wed, 25 Jun 2025 10:08:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55P18uSx012413
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Jun 2025 10:08:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <945bf443-32b4-4432-8702-41ff7b15e420@I-love.SAKURA.ne.jp>
Date: Wed, 25 Jun 2025 10:08:55 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net, kees@kernel.org,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infraread.org,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250624143211.436045-1-maxime.belair@canonical.com>
 <20250624143211.436045-3-maxime.belair@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250624143211.436045-3-maxime.belair@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

On 2025/06/24 23:30, Maxime Bélair wrote:
> +config LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE
> +	int "Maximum buffer size for lsm_config_self_policy"
> +	range 16384 1073741824
> +	depends on SECURITY
> +	default 4194304
> +	help
> +	  The maximum size of the buffer argument of lsm_config_self_policy.
> +
> +	  The default value of 4194304 (4MiB) is reasonable and should be large
> +	  enough to fit policies in for most cases.
> +

Do we want to define LSM_CONFIG_{SELF,SYSTEM}_POLICY_MAX_BUFFER_SIZE as Kconfig?

If security_lsm_config_{self,system}_policy() are meant to be used by multiple
LSM modules, the upper limit each LSM module wants to impose would vary. Also,
1073741824 is larger than KMALLOC_MAX_SIZE; kmalloc()-based memory copying
functions will hit WARN_ON_ONCE_GFP() at __alloc_frozen_pages_noprof().

Since some of LSM modules might use vmalloc()-based memory copying functions from
security_lsm_config_{self,system}_policy(), the upper limit should be imposed by
individual LSM module which provides security_lsm_config_{self,system}_policy().



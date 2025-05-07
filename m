Return-Path: <linux-api+bounces-3712-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94384AAE4F4
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 17:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB73AFF8F
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAB28A70A;
	Wed,  7 May 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BZlELZsJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1E289E1A
	for <linux-api@vger.kernel.org>; Wed,  7 May 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632249; cv=none; b=TMOFAuWfdfSl6Woorjwb+/MSf9W5G8I3s1GMD01AE/IAvtbdGSLEyp1xdiZjz0J+gyIctGPjFE+N9+gkhaI0X3okZYNpBnVIOFBWFnY8FGQJMWLzyK33nPOAEfsrY7sMt6JhniRjyKOFajaIN5rnIy3VzYDkqAFGgINHIo5C4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632249; c=relaxed/simple;
	bh=4W2fXISKY74fWUKebM25xkg9gTyS5/XCfGEdHtg6GQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S39bDF5CYhhsVl9/Gy+n40vonKQFnKYkt2B/aCtENB2xH3Nu3xU8Pn7/pFeXD7/Nenk9Sgn0XAS+mTZoV7C+Djt7EKyVo34yppMHePRgKZg1Fu2ZtM66P4jHlKaIKWT0I6aOtkI317+dy3Rh6nd6MpnuuF2uHw1hlvk8lGKEP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BZlELZsJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A3033F29C
	for <linux-api@vger.kernel.org>; Wed,  7 May 2025 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746632243;
	bh=bkW8q66ZO+SNrvIdDdMXlBX3whDIjDtZFpXpMH9RNXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=BZlELZsJ2/Jh0dgKQubIudVNaJ1qEaDzrqXH6Vf4JX9df4QmSH0F3+no8NJYdMNYB
	 vLW/ulKkuoKoNNfTQPepNs5sevRfkVJgY63x0lZPqXaKVd0NHNxADk9jGFMw1IBVO8
	 ls+kWtUQZlcLPsBGwjKliOHRqzSQLC259y4WPyvnELMpFq4u2hUeP2WOv0XMJjKjhb
	 WQFSiEZwipFm5NHoOYyiTdkf6ZKPKglxNGC5+TJKukUnB6C2pni3TseCN02t8+HnMT
	 Wj/mhAsddU7VpEDttg3bcYhoMxOHZbEhaBHz4AnsR41yT9P93BpTV8Y0xaalbX/a2X
	 AOMUM+wcWBYGQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ace99fe4282so4070566b.1
        for <linux-api@vger.kernel.org>; Wed, 07 May 2025 08:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632239; x=1747237039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkW8q66ZO+SNrvIdDdMXlBX3whDIjDtZFpXpMH9RNXs=;
        b=D+CA7lw6+nyu5cEdHDJHMXe2hC59dFZ/6Lll14sfyKdgNTHJE0wZJfbKiNbDYgO+jq
         O0jmEHGmoKvxISl0EpMUxQmbi6mxsvSR2JnXuQ+Pu+eTdD03J3mNPRXQHaZi1tSPyG9b
         iZGulzK4BeefUc3LNPABxsBoIQ3Wo/E7o70qu2AjGEQetpD9Q5OVADYwaCwkdijWNZyE
         dr2BSPSuBlxueIBgAbHTJs79KPDwMqpC/8Nfq8s3muEh/x9TA6Ctl79UlJaSwPS2SlLz
         hEU7JAAJCFKWeA5Nzn44wZXFb+IM4c/zE72InGNqyrUmehNhF8QZP1G+uSsyMqID8s0M
         3I6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAejHFaI6kgBMOfwKx7HePoivhm/DRY21F/ByfDTzVa+nbpZDC/EFICYFntNkktpDfPrRcSqzO5mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasNXdeavQyoAqwNep9HHybtgX0FV7/U6RTh3MTCmm3w3CifP3
	8Yx/ynSzAzJz0LddQTWW5Fs8sRMal5a4acYYiy63ojMpvKqYpveGRp2bN1yq38niBy58Ti5FS/u
	GYLm5xT5Whs7Ran1TfzzXAK9O2LCC/dpCOPHVRH4B2HzyX9TBZ1On9Am95W434TTCr4SpM469SA
	==
X-Gm-Gg: ASbGnct44TcglKBqiW8hRsT3+0KUABY4P9+cBbSwsTmb5uTZpyf6IWgrAjuRBCBM7H4
	QXYnvnhgopSpbGIJ2g9xnujv/VZ+7F4L5vbcbMXlqZ3ytGCkGdRt+KxTAcz7iLk1LgcywNosEPE
	hTve4W2LCjyk8uFbQbIJzVTv04SnjkbHSv096bzw9hdRNU1HBDVAIJlkUxeKcLD1ZXJCGUr5VTp
	XQOHEKlrRUqh5GhaDfMCIsUOdbwbEv3xXyztGCCc9xvwGXwpQeqGRvgk9DzheHKaHsf4vIf+sxN
	QmRG5wIyr+yTq7YOo0bSbYbaUxy3ofumy6VOrRG7IEamn3P1bEcWxtwv70iVwamXHXQ=
X-Received: by 2002:a17:907:3e10:b0:acb:23fc:d766 with SMTP id a640c23a62f3a-ad1eb220effmr394475866b.28.1746632239358;
        Wed, 07 May 2025 08:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGDfHN4YXKsHalMKITw8b9LdZdamAx7Tp0LP7mnnYECPy56ZQWZHnn2y5WeYlqgoF2dlOh8Q==
X-Received: by 2002:a17:907:3e10:b0:acb:23fc:d766 with SMTP id a640c23a62f3a-ad1eb220effmr394472766b.28.1746632238982;
        Wed, 07 May 2025 08:37:18 -0700 (PDT)
Received: from ?IPV6:2001:861:3280:410:2ef0:5dff:fe60:6274? ([2001:861:3280:410:2ef0:5dff:fe60:6274])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895410b2sm912485666b.181.2025.05.07.08.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 08:37:18 -0700 (PDT)
Message-ID: <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
Date: Wed, 7 May 2025 17:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net,
 kees@kernel.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com>
 <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Autocrypt: addr=maxime.belair@canonical.com; keydata=
 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
 yriCIKEAbLqHTyj+RhbroZmv5q3X7iVq
In-Reply-To: <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/7/25 08:26, Song Liu wrote:
> On Tue, May 6, 2025 at 7:40 AM Maxime Bélair
> <maxime.belair@canonical.com> wrote:
>>
>> Add support for the new lsm_manage_policy syscall, providing a unified
>> API for loading and modifying LSM policies without requiring the LSM’s
>> pseudo-filesystem.
>>
>> Benefits:
>>   - Works even if the LSM pseudo-filesystem isn’t mounted or available
>>     (e.g. in containers)
>>   - Offers a logical and unified interface rather than multiple
>>     heterogeneous pseudo-filesystems.
> 
> These two do not feel like real benefits:
> - One syscall cannot fit all use cases well...

This syscall is not intended to cover every case, nor to replace existing kernel
interfaces.

Each LSM can decide which operations it wants to support (if any). For example, when
loading policies, an LSM may choose to allow only policies that further restrict
privileges.

> - Not working in containers is often not an issue, but a feature.

Indeed, using this syscall requires appropriate capabilities and will not permit
unprivileged containers to manage policies arbitrarily.

With this syscall, capability checks remain the responsibility of each LSM.

For instance, in the AppArmor patch, a profile can be loaded only if
aa_policy_admin_capable() succeeds (which requires CAP_MAC_ADMIN). Moreover, by design,
policies can be loaded only in the current namespace.

I see this syscall as a middle point between exposing the entire sysfs, creating a large
attack surface, and blocking everything.

Landlock’s existing syscalls already improve security by allowing processes to further
restrict their ambient rights while adding only a modest attack surface.

This syscall is a further step in that direction: it lets LSMs add restrictive policies 
without requiring exposing every other interface.

Again, each module decides which operations to expose through this syscall. In many cases
the operation will still require CAP_SYS_ADMIN or a similar capability, so environments
that choose this interface remain secure while gaining its advantages.

>>   - Avoids overhead of other kernel interfaces for better efficiency
> 
> .. and it is is probably less efficient, because everything need to
> fit in the same API.

As shown below, the syscall can significantly improve the performance of policy management.
A more detailed benchmark is available in [1].

The following table presents the time required to load an AppArmor profile.

For every cell, the first value is the total time taken by aa-load, and the value in
parentheses is the time spent to load the policy in the kernel only (total - dry‑run).

Results are in microseconds and are averaged over 10 000 runs to reduce variance. 


| t (µs)    | syscall     | pseudofs    | Speedup       |
|-----------|-------------|-------------|---------------|
| 1password | 4257 (1127) | 3333 (192)  | x1.28 (x5.86) |
| Xorg      | 6099 (2961) | 5167 (2020) | x1.18 (x1.47) |

If an LSM wants to allow several operations for a single LSM_POLICY_XXX it can multiplex a sub‑opcode in flags, and select the appropriate handler, this incurs negligible overhead.

Thanks,

Maxime

[1] https://gitlab.com/-/snippets/4840792


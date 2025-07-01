Return-Path: <linux-api+bounces-4077-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AD1AEF301
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513CB4A4453
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA926E6E4;
	Tue,  1 Jul 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GhhbAmmq"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32A26A0EB
	for <linux-api@vger.kernel.org>; Tue,  1 Jul 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361399; cv=none; b=mY4Z9lFjiHC7D9+x64HyodGXxhSWYuDobTqLhplnslYGuMSkuJVEZpwliJPBbFEbjKY8mbSJVPMEccBpmO7JztUXWuJriRdmHUMWk4DrghahDrXCWyzBRs/pIbMzV7XDB3ic57TAR1lSEs55V3/CSLEEvC+Fb+YWszIJBCc87Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361399; c=relaxed/simple;
	bh=cnZfAXC7sGnFz3wmUcDfLnou2Wmc4swTjyswjZmiaWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyt+KAyaIG61U/TK4FupXbWWhtsKM7eYY9en9ekYOnTYovxyE2SzxQJgs3ON/7a/NBZl7cgXsZcsmEJuIgkildesWd59mLWj50SOMF80qoNz/5R6yWVQOr0UAn3nIISGFsY5I3Isa65ghpSikSRSgBKwYQkYGWljl65MRIiz4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GhhbAmmq; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AE593F69A
	for <linux-api@vger.kernel.org>; Tue,  1 Jul 2025 09:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751361392;
	bh=dVcX/aApl1bOZ7xau++gCdWkwO+zwwT+04d8AsO394Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=GhhbAmmqPcmqJX0DnkcMKvIeYWqwQP8HhnVCsxdjzNATfzZc+t1MY1isRCPlWK/O9
	 0reU/Kle64jlp3+QlNmt+Es6NVUEQMFHH4JIKDP7f6+lbIKXE21r4aVuTcSY6OvX39
	 lHkG4SZchb6QQCNJ+HdaqqGzdBEguapBveONvNP1mg03M4ImJbnyKbPCSKHrCwBl4b
	 iPv9nMWj1CuJ5dLn4tySgTjW76zk/AFDY6H69ULzatMZSNbukPjTOLl2A96hpLAuPy
	 ek+sbKWCxvEdhoI+1V6LCBpzw5XaBAqfzNdP67Ji9umWPzUi6VLhKrMYczDKLdd64f
	 0s/D5zl9ZgcuA==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so25195345e9.3
        for <linux-api@vger.kernel.org>; Tue, 01 Jul 2025 02:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361392; x=1751966192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVcX/aApl1bOZ7xau++gCdWkwO+zwwT+04d8AsO394Y=;
        b=Qekp8tQ00VO51GwxtqQScHn1GKSCds/UlvDuZbq/Afw3grgrQAI2FTR66eJxkJJVmO
         OG71zAhsMYkkvleyuLUNjDTaEokedLmY/lZ++WZW5bcdnMA6lTnBY47byq3XeBsLoBcQ
         gV6Y6j0JaXvKSfIFEf9HNL/kTbi3U9InryF0T8i2jVu9E46BcHnpF2wxtwRGYPeLPxFR
         pEf3KBm78MR7c5LDvtLMF2TexZeW7ccEk2/F6dPxrTjLHDRIz7hNg6taTrz0FPJ9o3Dl
         kPOOM67LB9beMKFQt3I7UDDIoW3xCzgArcG8QYYX5TjOwXxJlR7sSERDXk9crrLCrEGs
         aKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9m1PHwMCR89W/iTMiVvvMEpH/QDYAnKfzvzLN6TiNaSF8edMScqrYIcoPZcwnTT3dKcCk+YfTEcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6x7U3k6Li0bo6zrxiUlpOHgPyuRI7ZyJ85kCtvRkY9PU9Mfct
	dRrYm35kUQB3zlv/gBRffKAljq7cXblIuyGQH3iO6BP3QZSZK5F5ZNHfBojUsSwXyBHGSOnjxf9
	VotiARuL1wvzkNRdbiXPU9u496THhNeco10nJ3EVwlcaeZdt+1ZhkLXYRaQ1VnfDAsaAoKXhyVZ
	2zWA==
X-Gm-Gg: ASbGncsXNWX4M8N3sI1gdVCqiu9qkYcYgIxZN5lTGevA0TFujm8Dlzci8IfhN+CCNoe
	VUagex6k0cUCzv34FJ9R9AAU2EuMwly54BN+J4Y69nQCfEp6f05uoYM1Zf/LgMhNoI2THNIlzMw
	8Gi2cZ1PNXlIIO+GvV0F9vB5AyjlaRBfbkGdbyeRxGceLBHwqFhqiiL1evv1UH5nrwcUDaF4PD+
	KqxnTWuKP7KEurumeUPCDoC+QaeRD+fyuun42x0MVvG+I+PgTYtjMVFI+j9gy4O6mH3ejTI1R0V
	5Md2N+d8r4IdtossEHScw2HCUN0Bb9T66FZOXbus/mX6BkMA/SoOA88Z8UAJAxm23mmYEK1ODHa
	11g==
X-Received: by 2002:a05:600c:1caa:b0:453:6150:de41 with SMTP id 5b1f17b1804b1-453936a4bcbmr162957715e9.17.1751361391804;
        Tue, 01 Jul 2025 02:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOOqyJLr4ZGrfOkvegHE3h2BS+hNoKU0ZEkODM/DAdkz3AR7uaEpoRcficw8Y2fcSj2XPNjA==
X-Received: by 2002:a05:600c:1caa:b0:453:6150:de41 with SMTP id 5b1f17b1804b1-453936a4bcbmr162957165e9.17.1751361391309;
        Tue, 01 Jul 2025 02:16:31 -0700 (PDT)
Received: from ?IPV6:2001:861:3280:410:2ef0:5dff:fe60:6274? ([2001:861:3280:410:2ef0:5dff:fe60:6274])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52c99sm12500699f8f.49.2025.07.01.02.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:16:30 -0700 (PDT)
Message-ID: <6cd857e8-8f96-4ea1-81f6-e1895c208c20@canonical.com>
Date: Tue, 1 Jul 2025 11:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org
References: <20250624143211.436045-1-maxime.belair@canonical.com>
 <20250624143211.436045-3-maxime.belair@canonical.com>
 <945bf443-32b4-4432-8702-41ff7b15e420@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Autocrypt: addr=maxime.belair@canonical.com; keydata=
 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
 yriCIKEAbLqHTyj+RhbroZmv5q3X7iVq
In-Reply-To: <945bf443-32b4-4432-8702-41ff7b15e420@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/25/25 03:08, Tetsuo Handa wrote:
> On 2025/06/24 23:30, Maxime Bélair wrote:
>> +config LSM_CONFIG_SELF_POLICY_MAX_BUFFER_SIZE
>> +	int "Maximum buffer size for lsm_config_self_policy"
>> +	range 16384 1073741824
>> +	depends on SECURITY
>> +	default 4194304
>> +	help
>> +	  The maximum size of the buffer argument of lsm_config_self_policy.
>> +
>> +	  The default value of 4194304 (4MiB) is reasonable and should be large
>> +	  enough to fit policies in for most cases.
>> +
> 
> Do we want to define LSM_CONFIG_{SELF,SYSTEM}_POLICY_MAX_BUFFER_SIZE as Kconfig?
> 
> If security_lsm_config_{self,system}_policy() are meant to be used by multiple
> LSM modules, the upper limit each LSM module wants to impose would vary. Also,
> 1073741824 is larger than KMALLOC_MAX_SIZE; kmalloc()-based memory copying
> functions will hit WARN_ON_ONCE_GFP() at __alloc_frozen_pages_noprof().
> 
> Since some of LSM modules might use vmalloc()-based memory copying functions from
> security_lsm_config_{self,system}_policy(), the upper limit should be imposed by
> individual LSM module which provides security_lsm_config_{self,system}_policy().
> 
That makes sense. I removed this global Kconfig and the maximum buffer
size is now defined per module.


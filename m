Return-Path: <linux-api+bounces-4076-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E8BAEF2C6
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9AA1BC02F9
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92E248F42;
	Tue,  1 Jul 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CWWtgoQr"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAE1D07BA
	for <linux-api@vger.kernel.org>; Tue,  1 Jul 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361044; cv=none; b=pbMThbAr0xpXhXLGtH/htrpmVcpQ/ETh5PYkFmSBjUI+6tnSD/9SxwQJEXgSjkdE9LS5VhpVerFmvItmjk7iL76HMzl3mox6xAPhgVrA83T5go8YdEktH+68QLxry3CQuCsRNhRRWlUNhxP3rFwAaCHg7EWi0NF3oNVD5StRuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361044; c=relaxed/simple;
	bh=FzQqF0J/ul9TxEtjjmA9x9umVEbue93hGArsOir7XgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHXyWPguiAl9R428TUaX3udDzDelIEXrnOnAeWOxi5CR1xcEjfqpNyxymYVoCykps3mrs0SThtgttfHV13ngF1lGpZVwra11M3dDj1ertkwl6NQwBUL39oE3pe80cky5BVQp13x1k53VuhY/W0w9tObLOWcYHxJ7nx0ndo8Qcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CWWtgoQr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 215B53F212
	for <linux-api@vger.kernel.org>; Tue,  1 Jul 2025 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751361039;
	bh=FzQqF0J/ul9TxEtjjmA9x9umVEbue93hGArsOir7XgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=CWWtgoQr8nzttZD1ai/13LZXdr30lNK7COrLkwzvTcRcciuXQc/59n6DDlJlYCdSm
	 A+i4gU1pTC9A6VBx3ACPIXsEgg1/q8ZmYCW28rfH+sdP5Bd0zdA3FpW7SKUgCWhisr
	 YFRnDqHp0ElLsP237yLHQ/GNninfvxaRtILyfIcG6oVs0gMgSyhP19fmCYLgqacxIP
	 jJxv2TPckDYnpaHNJkoPtGwzW52t4q1PayS3yWF4sb15vBghpl0AB+xY4NXvvwNhUM
	 GBf+w1QzEz15FzmHHB7QYnyMKJN2LSXAGNow1WrN/PHb89W1Gl31BjIZBJEGrPyl8r
	 gysk/xHrGIOaw==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so2443463f8f.0
        for <linux-api@vger.kernel.org>; Tue, 01 Jul 2025 02:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361038; x=1751965838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzQqF0J/ul9TxEtjjmA9x9umVEbue93hGArsOir7XgI=;
        b=YiOmUP9gEdrd45Uj0NuecchlfWF2eHmbqiAT//x5Vf0KcrLJ1KWLE2dfMVAzsFpVLl
         +GhnIE4hS/9Tli7Gsc1HUanhei6zgcS0vBim9EUmUR5wu749hYt6qr0/dCfgLTfOW2Nw
         PFTu+YKLeIn7jG5BkdUKgYo9mOERMW3ZIE0XZcQjDrfSBZmD8WjK4Riuq9n8P8cHEtVe
         3rEbBSaDmnl12mRu5M0hFBMQBrUMQhmyFm4iiy7gzuf1si9VjMqCJlhe5oCTY7Jb8fAU
         7lHH1l3hOtJKuE4gefZVgn4PEj6fVYKW8AdPgA/8AY41vk8YDnTYuPEAkmpMQabtVOjt
         FJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCV0tPLT6SmngFi5QVPLS9mJJDnH3Sog/yUKgLyuUfw4jNGOD0sflLaUea+xbkhyLj3hFfVyhU+G8LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSJ6S42hpUATC9kJK1OXjRv1EBe/UJuCOmzzSjQDfRtHPtbCg
	Mq9dhSlRjp0I9cO3mBsGdXOlqtHQmleiwp1DCBGJLX8gLs8aRE1CjgFyCn1ZM1ateM6OGtnfP6G
	gAl5F8laGG0gjz2ZKyCUn9IP5tCZdTRLjvN+K/byhvVf00CcYu4A75Ko2iVVE3TLWezxNId9Lii
	CySg==
X-Gm-Gg: ASbGncvpU8rbri9D7NJ2wqlRGkE6l8J4oadraVkpOirD+2KqSSs0NoxogSvrDT9FIXF
	VkZBvIn06XBP++qeJdco4MJaKvqTEOu45WzOdoomXMdKaBkwQTPP/b5V8bzgbhg9s8u3nESPK4R
	Qh3Nmr7sb2Ecdw1Af+GmrJ5r45qvmOFo7iihdvvjtKx9Jxq1yioFuQ5US71QZi8LqtEoSfIw7GJ
	ZrRRHrnrxeUejlgv9D1vMd1ylWxLFbU7uFnUcciaJEaj7id6AupC/8jBrquXDQGVMejmtE4waAJ
	QgdOvUEpPxNRc3+XOxfXT70UUWelq9XipHB9TL3qwuSgbapn8x5kKqpjLMP9kORpi5Lc8aKGUc2
	6WQ==
X-Received: by 2002:a05:6000:65a:b0:3a5:8d9d:27fa with SMTP id ffacd0b85a97d-3a8fdb2ae51mr14169012f8f.3.1751361038384;
        Tue, 01 Jul 2025 02:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Wa9pcB2UUm59Z4GOCv082ua6JPrrZMxVXb+S8tPsIyn/l8uZo0KZb8KgbdGHQMaVoSmCBg==
X-Received: by 2002:a05:6000:65a:b0:3a5:8d9d:27fa with SMTP id ffacd0b85a97d-3a8fdb2ae51mr14168505f8f.3.1751361037764;
        Tue, 01 Jul 2025 02:10:37 -0700 (PDT)
Received: from ?IPV6:2001:861:3280:410:2ef0:5dff:fe60:6274? ([2001:861:3280:410:2ef0:5dff:fe60:6274])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e7481sm12850160f8f.14.2025.07.01.02.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:10:37 -0700 (PDT)
Message-ID: <36d50ab2-ef5a-4440-b6c5-ec324afa9260@canonical.com>
Date: Tue, 1 Jul 2025 11:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, mic@digikod.net, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, song@kernel.org, rdunlap@infradead.org,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org
References: <20250624143211.436045-1-maxime.belair@canonical.com>
 <20250624143211.436045-4-maxime.belair@canonical.com>
 <5313b937-304a-4f2a-8563-3ad1ea194cb9@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Autocrypt: addr=maxime.belair@canonical.com; keydata=
 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
 yriCIKEAbLqHTyj+RhbroZmv5q3X7iVq
In-Reply-To: <5313b937-304a-4f2a-8563-3ad1ea194cb9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/25 03:21, Tetsuo Handa wrote:
> Huge memory leak.
> Here too. :-)
Nice catch, this is fixed in the next iteration.


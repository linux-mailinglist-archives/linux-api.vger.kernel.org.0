Return-Path: <linux-api+bounces-3726-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8201AAFAB5
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A34C9E21EC
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BA21ABAE;
	Thu,  8 May 2025 12:56:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036E219319;
	Thu,  8 May 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709018; cv=none; b=lpEUa03uM5eqRgVr++HNILchneOnFCs4s38OY/1VFR5bIqXB3CaVgdha6bUxkn9Yz9/3QTq7XVQ+qv7nC2Ze/oYb+wDiJfB/guVgLJc7f7OAZJQb9iu7tOvJuVmnQq2974PDxz3+ZCWWWBCgpODFFts3rf1l9kitiWgptD0mlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709018; c=relaxed/simple;
	bh=VnYy99ctH9dGOn0PvoJ8+o42P5BdUgrrCJD+hHpOR5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpzH/hE8jv8ydHc1Be98kc9bYsOJTCUFD9hh0EA/ZnNI4/M3+WEPjLMQCyoxIQuflwRcXD2TGp6amru0OY85UI1Q613Il2Yyj6d8nvAepvUpYKudVEO9Or+bja5YcufPx5netf1Hei8K9SD33dE6XGt5TC69ueAW96JUrPsHk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 548CtjHW039304;
	Thu, 8 May 2025 21:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 548Ctjkt039300
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 May 2025 21:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <75c0385c-b649-46b0-907f-903e2217f460@I-love.SAKURA.ne.jp>
Date: Thu, 8 May 2025 21:55:45 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: John Johansen <john.johansen@canonical.com>,
        =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net,
        kees@kernel.org, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, takedakn@nttdata.co.jp,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <6d785712-6d8e-491c-86d4-1cbe5895778f@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6d785712-6d8e-491c-86d4-1cbe5895778f@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

On 2025/05/08 17:25, John Johansen wrote:
> That is fine. But curious I am curious what the interface would look like to fit TOMOYO's
> needs.

Stream (like "FILE *") with restart from the beginning (like rewind(fp)) support.
That is, the caller can read/write at least one byte at a time, and written data
is processed upon encountering '\n'.



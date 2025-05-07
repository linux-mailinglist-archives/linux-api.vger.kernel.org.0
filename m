Return-Path: <linux-api+bounces-3718-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B42AAEE74
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 00:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651B01BC7D33
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFB5290D91;
	Wed,  7 May 2025 22:05:37 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB424469B;
	Wed,  7 May 2025 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655537; cv=none; b=MRP9JVMNyzJ0WFEElWBKTegUf4U/NhNd44B7GG24wSLhOOEmjmdzbjwUs5zXvzChwEZmUOxHLNpuCuN98JvQsA78NzMeyr6xf6hC0bp9vDEpXRCmPwTYgEif7gK5864sbp6xwxoUS8mbQumLpRwAdpFucwR+KUuW0FOU0ppvIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655537; c=relaxed/simple;
	bh=9nNef3XERP856vyAgJ5hUWqmqVl1tSG9gYUQaJ2yHWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuqW8QJf/Z0Gn/40V00FtIrfwGkYxDrlAmaIg8V6hVfokcSRVxm76MzZsVNy9HTZkTY7+/rPUOUGTmwLfDF8jRPNX7NX81pjSuuhB8URmHGUoUo2Jvbl0CfhG6O5P62HZA7fIGcQOB+M1G7JoHF7S0sHz97UePd/qdcd+ZmUQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 547M4na7045537;
	Thu, 8 May 2025 07:04:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 547M4nL6045534
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 May 2025 07:04:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <470689f0-223e-4d26-a919-8d48f383883b@I-love.SAKURA.ne.jp>
Date: Thu, 8 May 2025 07:04:46 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, takedakn@nttdata.co.jp,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com>
 <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
 <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/05/08 0:37, Maxime Bélair wrote:
> Again, each module decides which operations to expose through this syscall. In many cases
> the operation will still require CAP_SYS_ADMIN or a similar capability, so environments
> that choose this interface remain secure while gaining its advantages.

If the interpretation of "flags" argument varies across LSMs, it sounds like ioctl()'s
"cmd" argument. Also, there is prctl() which can already carry string-ish parameters
without involving open(). Why can't we use prctl() instead of lsm_manage_policy() ?



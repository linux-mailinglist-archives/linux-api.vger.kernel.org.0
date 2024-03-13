Return-Path: <linux-api+bounces-1132-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DC87B28D
	for <lists+linux-api@lfdr.de>; Wed, 13 Mar 2024 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2881F274F8
	for <lists+linux-api@lfdr.de>; Wed, 13 Mar 2024 20:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0244CDE0;
	Wed, 13 Mar 2024 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aJGTGZ23"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD184CB38
	for <linux-api@vger.kernel.org>; Wed, 13 Mar 2024 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360424; cv=none; b=KKYg6ClGA9Pcp9pUTiOtduZtuUt7YBukLmf6aOR5J9rslUaAhCTggVjI434EDNzxWJglIx4oiQKe9CZA9+QBZx9oSuXyRM46/4JCl/hanuzaHtDomsLpnmEmUZnPQSCBfoiDSv3eEAhuxFmsKfDKrLkWrh09+cQT3khlIP/t2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360424; c=relaxed/simple;
	bh=WdJn/2bJPlVRWf/dOWnZCyI2Kvpf9aHz47q/erB5dCg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ot5vTMflVH1Tzz1Yeg8poJP9gxDE7ADy2GqYnjTfohuaeXVgGsbdHLm3gCGUQ3LfuWZT0F7YTlP2hcTyIWfpw36+bp6Bo+3/yXYsRZ0FLVJK9qqr4oRFE1kOnkdMKThI5h6D4Yz8U0mvhz1w0dgkx1FTZ/9nCB9WsaxVNc7HHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aJGTGZ23; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42f37657e91so895431cf.2
        for <linux-api@vger.kernel.org>; Wed, 13 Mar 2024 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710360421; x=1710965221; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TaOWCQYhiM9DJgHYIEv5GJLKXhKlFmkTvf/eVZF5clo=;
        b=aJGTGZ23b/wsfN4YvfvuCU86YOU83NuTbqW8r9WQtbDC13lB80JvrxrGtuYpJE6/oW
         DalDuUnJDX8IcMQtis9h/25kCj9YlhfZlY8KU+Wml63rYp1JbsO8qwD2JYzvuPpW2HF9
         qw0xdXSmjh7RZynQfmfQiyrdWwARnFgalOenb3qYz8siDo07+vStincu0DjxrYaJ57IX
         s+UKaPEV6VtzWgl+RwnPI9tqlD6mw9g90NzGMhwsbNXqTzLSuAiz1/keSKrF3GllvY6b
         fdNmV2Ahpw80GeCN9MfLXwxBJJsc6eWb+jP7JY1EM/1El9KMtq+iYBwReC86PwYc/N86
         4FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360421; x=1710965221;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaOWCQYhiM9DJgHYIEv5GJLKXhKlFmkTvf/eVZF5clo=;
        b=Sc7S1rr2hD0i1M6u7aClCh+FEopQZB2zDnLM1171sJ1AZyLM7io9PgQ091NJOyHh50
         Vhi0VeWBPy3zHNqWtzpbdzHLcFsCcVCFje+x8hAX0T+GmyeaE5+nQUPHVhh+1xJG4gNX
         43PVbn/zAakgZShMRpuXRmd+MIion6wmILfNceGbHOFlGGP6b9KT0XMM67dhlg2MUOna
         4XTHCinBOpm+Nbx+/rQV/eJEr/WhdQyJcOATaRYi+tbMryCd5MHFXUvwcIyd1y8l10iE
         pkYwlzIipc++uknlooQAbW2aSBqxNqvJlFUR9xcf80sgYt63CU5wLfW4GN6N86Q4EmKi
         A1RA==
X-Forwarded-Encrypted: i=1; AJvYcCUQSN3MxIvpnLDzkg+SSsA4avW5WDfJ18HhX+oN4E3vSRP5WJdkYaiW8O/fBlH0vohJPToLeLA8jJIZeC91/UoEWOiveHX2dr92
X-Gm-Message-State: AOJu0Yz6kc3+R7oeUgYlUu12JGYreVs/9hZTF2jq6hsRW0iH8E9JXP9Y
	HGRqG3DuHVu9tvL5etWf6ysDFSr/khME33xzll0UqMAFFz/clI9Yz4CXP4aZdg==
X-Google-Smtp-Source: AGHT+IFxmVIZmlHkW7ctMZiLN7tCNdso6UsKbHz3xwPt7MplNKbQy1ronk5TK63/kW8nTuSGVRemjg==
X-Received: by 2002:ac8:7d82:0:b0:42e:f47e:43d8 with SMTP id c2-20020ac87d82000000b0042ef47e43d8mr17793281qtd.43.1710360421643;
        Wed, 13 Mar 2024 13:07:01 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e17-20020ac85991000000b0042f53f9f8b0sm2357995qte.26.2024.03.13.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:07:01 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:07:00 -0400
Message-ID: <ef972e0088964722adffc596d38b0463@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, "Dmitry V. Levin" <ldv@strace.io>, LSM List <linux-security-module@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
In-Reply-To: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>

On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> LSM: use 32 bit compatible data types in LSM syscalls.
> 
> Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
> and lsm_get_self_attr() from size_t to u32. This avoids the need to
> have different interfaces for 32 and 64 bit systems.
> 
> Cc: stable@vger.kernel.org
> Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
> Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> ---
>  include/linux/lsm_hook_defs.h                        |  4 ++--
>  include/linux/security.h                             |  8 ++++----
>  security/apparmor/lsm.c                              |  4 ++--
>  security/lsm_syscalls.c                              | 10 +++++-----
>  security/security.c                                  | 12 ++++++------
>  security/selinux/hooks.c                             |  4 ++--
>  security/smack/smack_lsm.c                           |  4 ++--
>  tools/testing/selftests/lsm/common.h                 |  6 +++---
>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
>  11 files changed, 38 insertions(+), 38 deletions(-)

Okay, this looks better, I'm going to merge this into lsm/stable-6.9
and put it through the usual automated testing as well as a kselftest
run to make sure everything there is still okay.  Assuming all goes
well and no one raises any objections, I'll likely send this up to
Linus tomorrow.

Thanks everyone!

--
paul-moore.com


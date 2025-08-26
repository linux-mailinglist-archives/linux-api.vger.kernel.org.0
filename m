Return-Path: <linux-api+bounces-4607-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA04B3676D
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201AF5653C8
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FED35083E;
	Tue, 26 Aug 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OMAzL0Rk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF9350826
	for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216511; cv=none; b=OjpselHI+loi3pNH96cHR9MJ4l5xVbIIzLSwtWuxEVIYNoT82l9K1rUSW6/Na56xEkB+arbopi18LV1ItzcSwSIEkgTFa3c+amBazeB/lKp5Ew2EbHFrRgs0GMSoaBQSSb6R/BDeELec2wQc1kMdf5Kb5szCafzt5zXQHhEtkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216511; c=relaxed/simple;
	bh=UY4PAtYCPhfTFvflgw9McFBL8GDEV1IGg0cYHqj+SP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPtzZ8kZkH4TlUnIsKQ+YbXKkOzSXR0nWYbbRwLpBFEWOWZG8CTPMsNdAkoOzOWPPUr/Y9OrrsFzwaqGy3ZYqN8hd9XzKOCwNurhjOOvdO1Q4VWdGKAT8ElwYvQ7XpdWpOaJsyN3aPDuzi0m875vHSZmcfvwgx9yY2/heTLiSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OMAzL0Rk; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c58e29so107413181cf.3
        for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756216508; x=1756821308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WXrsBqa903YM8Bb/iVPoGxewN+EOL3SzPn1F/Ek/XpU=;
        b=OMAzL0RklIwJFcqgzEc6yGluGUmxfi/KxSKTicurIEIH9poMz8tj1w8ld9oh24Q29b
         ZgILejwmV3r7VTOC5uhGPVa6popGpqQIFb66SOpdZ3tENHivn8HMV7mXO2PVYOWEbnSP
         1fn9TN281vwcIO8qFVAIsIMrvjMd5PIeLt1s3nc9suDmvKeVvco2KFH0jwewM+kb3ZrI
         3ntiOPJ6DQt7Np+Bj5xBShG3e6RYJpWgf87BNsJNc7317EtQ60LjF6dRGyMG54SaRH0D
         DLCZ4uHNm9WyjVB27zZuaiWwc139BRIbI7DgW8PgEr+q5iCe2g1XQZuteFydZoc+CUvY
         LD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216508; x=1756821308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXrsBqa903YM8Bb/iVPoGxewN+EOL3SzPn1F/Ek/XpU=;
        b=wu5G9F8BzYkCUOyujlEBn4WnlUtL8I8XtnAFDA1ZI8m5SCt7tAUBmAMM76QuGN71ON
         Xe9ihP6KMRyfuucgfAVlgepfvP9Eo94Ryc89AODpifdl6lKVSwJafYsujN5Y2qOxvPZh
         rlXdkPGvf+yPXS6uovvVRPzd33cPzvg8VI11Wa/4cQ+b23gdLMzaLftPz5Th8FaqF1hQ
         GrvmMcKvfMqe5Nu+J1qrKk/ntPtAAzeMfF5XDQq1uIKigDpxNeNcuONzCK3WkKKGSakQ
         FgtrmT2Ry4ybwi3QW5NBPnszTqJ+Ur0/uSIOpXac+i6WtlDkAJf9gL/bJwU8fO/wpfnX
         5NWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOGcLW2M87HQnST5C4gjsG2yu9pH5bMZXMgHZcLkfr3LFD/wa8Yf/fmSXZhmMlvcMOS40Th4PJC1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WPYwb3HmFaGm7CDeDXBDdKF9TZ1qrJZA1uw88l1Qmruhr1nt
	LXg8cl8B+q/hUbne0zSczhz2ORQDLr/+YFPBKkyCY6VOUvou9weNb2t4zCcSe1CSRSkuiq+iQdl
	4MTTHsaFI/0BdB58dnP86jNYB0vgRqWZbslggtLRwSw==
X-Gm-Gg: ASbGncvFcN7bBaCD4d6cyok2on154I7tIEMWQlJG5ntdh2e/QI/flsSOAJyC2LbBSmj
	Nv5VDP/mO7nY4BGjsFbRgksixuXeQIXkHCGlT7bWkHeYAEOZ+1ltpeYm8anAk2cTW2cef9TQd7O
	Te3eZ1LBcR7JDGtLlUFNDs3QX8BAgSlkcStMhgvVZ5jRU0guj0FCfLzz7HFIxIZ8MYv6j4ZXPsS
	bn6
X-Google-Smtp-Source: AGHT+IGcGuep7n1ZMQbOLWojaFaiFK2h2fVsewAul/Hz9Pfb7IpF4bpoR5o0QPDcbUbeNlPIwhAjeljdyRG6U6RmHSA=
X-Received: by 2002:a05:622a:4083:b0:4b0:851c:538a with SMTP id
 d75a77b69052e-4b2aaa81e96mr162452241cf.8.1756216507983; Tue, 26 Aug 2025
 06:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com> <mafs0ms7mxly1.fsf@kernel.org>
In-Reply-To: <mafs0ms7mxly1.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 13:54:31 +0000
X-Gm-Features: Ac12FXyb-9ofKcB5jLMNzC24BIRSCWuL4lKgd8Qnfh0hAm4ydgvkrr7-UIknHkA
Message-ID: <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> >
> > Changelog from v2:
> > - Addressed comments from Mike Rapoport and Jason Gunthorpe
> > - Only one user agent (LiveupdateD) can open /dev/liveupdate
> > - With the above changes, sessions are not needed, and should be
> >   maintained by the user-agent itself, so removed support for
> >   sessions.
>
> If all the FDs are restored in the agent's context, this assigns all the
> resources to the agent. For example, if the agent restores a memfd, all
> the memory gets charged to the agent's cgroup, and the client gets none
> of it. This makes it impossible to do any kind of resource limits.
>
> This was one of the advantages of being able to pass around sessions
> instead of FDs. The agent can pass on the right session to the right
> client, and then the client does the restore, getting all the resources
> charged to it.
>
> If we don't allow this, I think we will make LUO/LiveupdateD unsuitable
> for many kinds of workloads. Do you have any ideas on how to do proper
> resource attribution with the current patches? If not, then perhaps we
> should reconsider this change?

Hi Pratyush,

That's an excellent point, and you're right that we must have a
solution for correct resource charging.

I'd prefer to keep the session logic in the userspace agent (luod
https://tinyurl.com/luoddesign).

For the charging problem, I believe there's a clear path forward with
the current ioctl-based API. The design of the ioctl commands (with a
size field in each struct) is intentionally extensible. In a follow-up
patch, we can extend the liveupdate_ioctl_fd_restore struct to include
a target pid field. The luod agent, would then be able to restore an
FD on behalf of a client and instruct the kernel to charge the
associated resources to that client's PID.

This keeps the responsibilities clean: luod manages sessions and
authorization, while the kernel provides the specific mechanism for
resource attribution. I agree this is a must-have feature, but I think
it can be cleanly added on top of the current foundation.

Pasha

>
> [...]
>
> --
> Regards,
> Pratyush Yadav


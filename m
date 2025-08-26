Return-Path: <linux-api+bounces-4617-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80808B370ED
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987351BA26FF
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A62E3360;
	Tue, 26 Aug 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i6WEPL0p"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E031C4609
	for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227880; cv=none; b=cy5vAWHvIEJekeit9Ur7yNpVu573hku2jB6v6U2GKtdvUP8XIl5phFv7bfLjYP6zUkjzCxBTdY55IEzhKqdgC7PV8ApROfMNyRrzKO8zwSSfAiFrRye/HdHLarSKW5ROe0FAo4jZIHtTy7GMt2vwTkYtD0fSwV0slikGeR/Kws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227880; c=relaxed/simple;
	bh=4hli9x6NgPwP094pbyA0wxiR+cPcCetA3Wp28EfePcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI893p03WJvv71i8uIX58Fm+elI5OysI+R5lhH17MKQPe5Bbho+pvZ0/FPGfDS3/JPONYSqdn+E4zndb1jvmJH38azcjatEOqr2hpCRESFwPMyMQwl0J8hGR2lZvUCrbh8489AQhqk/Sv/KW5Uuqc6kpZvfRp7E33k+DUjiyklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=i6WEPL0p; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b134aa13f5so71283321cf.1
        for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756227877; x=1756832677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjIfaOrofazhAWITCaBIQC/PYR7khvFmaUUyG7Ja/eo=;
        b=i6WEPL0pn88fDPnRYN45hj7gOcVCBERuZ1htsz9l/CTeeHj2yJkQyh/kwjR7I/du2F
         OOmppdVKnOz9UtjGaeC/ek8tlU+qZdGkzvtOXJyrhdNduwzOxIaS0Ag2/4hve/uJ27lh
         6MViq0s1o6dKjb+y/6TEb7+3NZSSELpdY29DxuWprqUoL6MWOaSu2OJql7+Fd/CiYkAK
         0DQfpzi6kdLrwqWyBkowG5vCTf/oYiOX/6bMmo7DR4xISJkGoUn7rSXHEhqbvjSiggq3
         M7ss2/L1eit4r9HSSLDmgtCzbYagzLjZboL0DpoeQe2see7mDltPbZ69hIwMafT2bwbH
         WHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227877; x=1756832677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjIfaOrofazhAWITCaBIQC/PYR7khvFmaUUyG7Ja/eo=;
        b=idU3S+D+z5M1eb0e3UgqoL5WBYlBKzAqf3wJ4O7cA9R4JgRx8h2jgfpGcrLtV9D1Ub
         M+Tgm2G9uJfuLEDfnhVscuyO0dI3RYdlSnxKpHvwwZhG1mQXMnDiVODtHbk6kbJHLTcD
         zTRd9sr/0ZVcl+c8mDuDf4VNtOxQ/0ZmguECUXJ6iPERZqDf8rAlkXRdXwxQYPHDxmjz
         L95KmMf4Q0TUzwHJJGHEIl78axvch6r9VzM1krXq/tDqmnpWZvaxXHzeSU/5acHGRo7n
         /uAVZlIQO8JmKapzTL24ZG1CTClkh5nfMy9Jg6Qd8Vgf9QFQINd5UsDQg0GGIXXK41AL
         OdpA==
X-Forwarded-Encrypted: i=1; AJvYcCU8W3LF1BtuVAi3w5gtwo/oZd67Eot8lhwKK/Kzuu7zRCkzaa+psUN1VgAIdCN6KSnuN3bRwtuYy10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItIMYahLJ7ihbDK2rqUoSepU8u6BpRw+kCI4kYfuCEGPujasO
	U7gaitwTcPU2OmcLwGqN/63W9V0JuRFJZJHlYWsG6P6kqlD15gPqY1wj9QDrp/2Z8QS4Z75/LbV
	WZm8fXmsKvybyK4funubqXKPm5nhCkVW5BWk4Ahe9ew==
X-Gm-Gg: ASbGncu+g/83pNq80h4kgg8YGfM3yT1B4NTsK2Uh6U2PaFAxMwkc8HTPwNt5FTVUHrk
	mYOu6sey3mRjVDfaYYF04q0k4cz+TwNF1P+D1IJgbw2J4Jair06di0wzu/+d97M3Pvuk5rj123N
	4k9z1jKW+5dzb6FoSgUfCLyDDUDnae/ixErejpr/KyYUuJXa4VsiTtwZsCjBcAw3kUnZVx/P7HS
	2iLXp6kZXLW9Ek=
X-Google-Smtp-Source: AGHT+IGhz39NCK5Fxfc9IjxwgHAO3YphwmnNvrOuu/ULmHzST7LVx0PTJH1sOUstAe48pYCpPqjEksP24bvYcCphrNY=
X-Received: by 2002:a05:622a:1213:b0:4b2:edd6:f1a2 with SMTP id
 d75a77b69052e-4b2edd6f516mr4884241cf.63.1756227876536; Tue, 26 Aug 2025
 10:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <mafs0ms7mxly1.fsf@kernel.org> <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
 <20250826142406.GE1970008@nvidia.com> <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
 <20250826151327.GA2130239@nvidia.com> <CA+CK2bAbqMb0ZYvsC9tsf6w5myfUyqo3N4fUP3CwVA_kUDQteg@mail.gmail.com>
 <20250826162203.GE2130239@nvidia.com>
In-Reply-To: <20250826162203.GE2130239@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 17:03:59 +0000
X-Gm-Features: Ac12FXz3lP2hDCkW5MtqBiPoAwifNenh5414D4bEhipE2lcPWQY4sTh__rhBUIU
Message-ID: <CA+CK2bB9r_pMzd0VbLsAGTwh8kvV_o3rFM_W--drutewomr1ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > The existing interface, with the addition of passing a pidfd, provides
> > the necessary flexibility without being invasive. The change would be
> > localized to the new code that performs the FD retrieval and wouldn't
> > involve spoofing current or making widespread changes.
> > For example, to handle cgroup charging for a memfd, the flow inside
> > memfd_luo_retrieve() would look something like this:
> >
> > task = get_pid_task(target_pid, PIDTYPE_PID);
> > mm = get_task_mm(task);
> >     // ...
> >     folio = kho_restore_folio(phys);
> >     // Charge to the target mm, not 'current->mm'
> >     mem_cgroup_charge(folio, mm, ...);
> > mmput(mm);
> > put_task_struct(task);
>
> Execpt it doesn't work like that in all places, iommufd for example
> uses GFP_KERNEL_ACCOUNT which relies on current.

That's a good point. For kernel allocations, I don't see a clean way
to account for a different process.

We should not be doing major allocations during the retrieval process
itself. Ideally, the kernel would restore an FD using only the
preserved folio data (that we can cleanly charge), and then let the
user process perform any subsequent actions that might cause new
kernel memory allocations. However, I can see how that might not be
practical for all handlers.

Perhaps, we should add session extensions to the kernel as follow-up
after this series lands, we would also need to rewrite luod design
accordingly to move some of the sessions logic into the kernel.

Thank you,
Pasha


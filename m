Return-Path: <linux-api+bounces-5046-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B159BCA53D
	for <lists+linux-api@lfdr.de>; Thu, 09 Oct 2025 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD823B2234
	for <lists+linux-api@lfdr.de>; Thu,  9 Oct 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487A238C36;
	Thu,  9 Oct 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bNg0lRi+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3F23817D
	for <linux-api@vger.kernel.org>; Thu,  9 Oct 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029542; cv=none; b=SilgfeKAv6l3qCuEBpsAgIV9e9IbbP2xKUquLiL67ATcDMAbmqoUMp3PO4Dwy8DyP9OX6a0mTQ+w5u0TdEgZeK1ujYASs7Xr0CszfTwaE/A5NYY5mAZBrpI8FqrGncIX1hhSkYsOI3o9/8U/0Yn70MZm1xF0AJCWqJQCiOmddms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029542; c=relaxed/simple;
	bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7OcHCyHiBOHnknZR/qGZMgC9Q+iNwLNOb0BVVXxwvON+TCtqJNxfVXOKHQAdZ6RFtzTEDul4aUedskMx0K3Ofob3rJoXrR038tchuC/p28uCdXsukIXooaiOdM4Z2Ad8jyCMiBPrsi6AmwWfi8OYKpZGftdpmxT6NKxsSuk5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bNg0lRi+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-875d55217a5so127696085a.2
        for <linux-api@vger.kernel.org>; Thu, 09 Oct 2025 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760029536; x=1760634336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
        b=bNg0lRi++rFK10ae92hN4Q+tD9JKalVMgtXOuv5DxPVssEQDJepsowAy+hBIDI1Q3b
         d24YXKnoa9bgNi6emnzdPBZBOj1vfailzHg6agjIpzM3JJyndgZxPINWrJhnqbZ1vHoo
         gxyUdudesuVLETrCGKh8N7SQZnEDE9Fjqoqf5TwzYSV+jg5HRAv5OgbF1Vmfl2urNTiZ
         NAFBJeR7fREu/yildLKrb73j2o2cZA6vZamNc1MA1MdAC5A62yW3Ysh9wW1T9NzoUlK7
         S70a5Kwd5gImEZJvKQVKJgayqIJUTneVBJ9icQs2ulU1PZuMPH/eyMjPDjILTyKSI3TH
         spVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029536; x=1760634336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEwvryL4F3rbj5qgEHR3Bc73043Xk7gnhFlf4AiO1uc=;
        b=t/PxHaBApZQ7T/G6vEnmRnuyuZ2IJ9ehildVhU4zyA4lIUuVcZpb6uA+2FfzrCI4kT
         z1P5oDhnvg+Qx3Na0fujbBpeW+j15PUn1YtAdTTLg8xp5usVdV0paNWDXcfJG0yXQoXJ
         l/qRHp7I+wmbbTbSiXFkwVuPm0avtqGotFIWYWNSGFEv9Qe+jM/E9p1faH/gtpKCxJXJ
         TEiLX25Jneadw5NVuNmWzhzrEVutcvvS60WBAagsAFuvTK287U0jl2aLqA3m+NVW37UI
         Z3CFRhCjHTzM1IHx082vZ4yQeEA3Vcv7z/fjKL6uIyoBBDNqW6nIhCHLLgRM8OFxxztM
         L7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Tm/WT2d42yc/xK3hF7tBK+ijAtmeHZ64AQZqJBMjp0fSfGKx0F8rTXB0+MvdYBmTX7Laodf5hqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7KAjh/GG8wzsJ+X1TZaHQXRbUwrq4nmvWvDlhNPSIXMyv2Ol
	gZ0/AJeZ3lDh3FtoFPUlxwifIej5vcopBA4gpHuE5zLUJcEmmdICgCInchXHOf7fXG9yw6IjVZj
	04jlQ0zDHUo4w3V8bHhaJfoxWYJlafB+3sQcdyUYsVQ==
X-Gm-Gg: ASbGncszsUhCAQNEfTVm14YYueFZt4Diom1ZdccAKuUpMvdK/uclQ5HNDPhRmtU0P0R
	b0gDEmnJHg/QjIAnO03Axkq1TLu6xVfZf4BZZAAfVr6XVJaaPolg0syFy7KiDg5mKzhrluc9MEz
	pnMYsez37+64segBRSCrl9GEz/VnkSaXpWZh7nhqJbYxUKlTMPCbE48fPzQAqROUws4iYp6pW38
	vVfenx+xAnjxlmM4Rk+x8iPd9sVQSDE8PItI6I=
X-Google-Smtp-Source: AGHT+IFE2sAReF4JI9gkbOEBI0GExAG6O+9H49nxZIOW3wiMfCJHnma5AW+apR4GDzx7KvuzWvZY/WusdxfEgE8+CuY=
X-Received: by 2002:a05:620a:2952:b0:870:ab:42f2 with SMTP id
 af79cd13be357-8835384546cmr1185682885a.24.1760029535702; Thu, 09 Oct 2025
 10:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com> <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org> <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
 <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
In-Reply-To: <dc71808c-c6a4-434a-aee9-b97601814c92@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 13:04:57 -0400
X-Gm-Features: AS18NWB7Cr_VpUIKYZatXQYpiNUtQ7J6s9XvqZtMcyHaQrrY3c7p0E8zT1F9p7k
Message-ID: <CA+CK2bBz3NvDmwUjCPiyTPH9yL6YpZ+vX=o2TkC2C7aViXO-pQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 11:35=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
>
> =E5=9C=A8 2025/10/9 5:01, Pasha Tatashin =E5=86=99=E9=81=93:
> >>> Because the window of kernel live update is short, it is difficult to=
 statistics
> >>> how many times the kernel is live updated.
> >>>
> >>> Is it possible to add a variable to statistics the times that the ker=
nel is live
> >>> updated?
> >> The kernel doesn't do the live update on its own. The process is drive=
n
> >> and sequenced by userspace. So if you want to keep statistics, you
> >> should do it from your userspace (luod maybe?). I don't see any need f=
or
> >> this in the kernel.
> >>
> > One use case I can think of is including information in kdump or the
> > backtrace warning/panic messages about how many times this machine has
> > been live-updated. In the past, I've seen bugs (related to memory
> > corruption) that occurred only after several kexecs, not on the first
> > one. With live updates, especially while the code is being stabilized,
> > I imagine we might have a similar situation. For that reason, it could
> > be useful to have a count in the dmesg logs showing how many times
> > this machine has been live-updated. While this information is also
> > available in userspace, it would be simpler for kernel developers
> > triaging these issues if everything were in one place.
> I=E2=80=99m considering this issue from a system security perspective. Af=
ter the
> kernel is automatically updated, user-space applications are usually
> unaware of the change. In one possible scenario, an attacker could
> replace the kernel with a compromised version, while user-space
> applications remain unaware of it =E2=80=94 which poses a potential secur=
ity risk.
>
> To mitigate this, it would be useful to expose the number of kernel
> updates through a sysfs interface, so that we can detect whether the
> kernel has been updated and then collect information about the new
> kernel to check for possible security issues.
>
> Of course, there are other ways to detect kernel updates =E2=80=94 for ex=
ample,
> by using ftrace to monitor functions involved in live kernel updates =E2=
=80=94
> but such approaches tend to have a higher performance overhead. In
> contrast, adding a simple update counter to track live kernel updates
> would provide similar monitoring capability with minimal overhead.

Would a print during boot, i.e. when we print that this kernel is live
updating, we could include the number, work for you? Otherwise, we
could export this number in a debugfs.

Pasha


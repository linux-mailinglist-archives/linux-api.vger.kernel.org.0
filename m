Return-Path: <linux-api+bounces-5395-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B998C75F09
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFEFD34C66F
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB3350D5E;
	Thu, 20 Nov 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjxvRnyP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0826ED3A
	for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663895; cv=none; b=Q6h56MPfjDdecXkSt3Oybv6dXRZmuWTeoxlX54bLKBAFQYbnCrqxJ4SViBoPAPZUEtwzXg4+YkkeOMkEvOVcOnz90h1GtSLSzCtc0gEJwHoGNlDxD2tuw7zBCtDpJXLLV/wIOzWhEHmk0yKDdgukdVHde1i28RQbdoTa6K/xjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663895; c=relaxed/simple;
	bh=pH4aoYl2QfUcnU259m/ftgZ7f8gdGn4cUZTF2MS+DF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0jImw0H9Isn04N7lzUbx6xkAKM3ISSdsAZJ4Gi4+XlcuANk4PaHW7jcEf/KxstTWYD1XbHBNnddtd4hdfPeNMddhq3MJdqLXCDRcn2yodvzFv+sop12DLKRkPg8Ba8Zf22+f5xrw6ymZAc/MGaGKG7CE2sYtxF1RD9sqw9IM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjxvRnyP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59431f57bf6so1257276e87.3
        for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 10:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763663892; x=1764268692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEixO8O0Sgt+Lt6PLSkUIcXQwGzn13P0qmJRoyPv45k=;
        b=JjxvRnyPLzP9KKLdLgJMGGeSFqt1JD41b5tEWSrvRWkrGpiUvDpWOmPg6NuCGPlQb+
         CgzY5ZnACO7PfbmJdUgUy2YpYq2l3SJUB/6tiOzSQUgz7XMpJvX+zwv1EXQvNa/iet93
         Ys9aVeBUKEi0DvJznuvPa0gcKa9PLnbK3CpnXXy+Vc14r4Gr4Vw1jn2dApEpMYo1mWy8
         if42VZUsHww4QNk/Y5SSoZ9Opt8oHjeLzUwGA9SIxNnp1IwxgNibo7iQMNgCN0DzMEvW
         zuPELdHb3teKvQch7cUwT0t1ErRjd3dMz19YFnVNVtOc9INgAZs3sNYqCCc1BZaP0vdJ
         eAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763663892; x=1764268692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEixO8O0Sgt+Lt6PLSkUIcXQwGzn13P0qmJRoyPv45k=;
        b=lKV6SVm6kF4kWhXudyaNmWSblswq+qaiWGVnqVJS6I6Hp0CUu/pw8t0sR/Yh0r4O0f
         dkWSvxCXM7Ayv1WrAVk7F8fcn9SooJZZmR/4JLfWJhhkXz+g7O2oo6E5zcJO1ylFV+4D
         o/PsIr+YUF0NZiQPJVwsg+c/5e72iPyaUIc+gS4JlPfxB+5+/cGFGuSjCMncGwax8uDc
         j7d8EWRdfgPNpHJ1AfMWsQstZLNzhD4FSGhTq6FE/whFcwINgQQAFuQxeKScVT9IY1Lc
         7HTu1akk4dgurZwtvSccAbeWHxiUeaXUUud4RkVCHoGbzdWzXtP8WGJ6xszaFgipCcVq
         PWPw==
X-Forwarded-Encrypted: i=1; AJvYcCWlA/CBwEyjvlkeBEQfW1LPHbEq0j/UPG7C03U/k0VawHOjQnJlTNDUwoQI5viTjfDZ1UmrQzncM20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8newDJ0X0p7nPOg4sabxAqqTTfxdk75e8xlgUNrawLiTOvfl
	1nu1JUz6zZ7zTTY4LCXCiTM8i8u14kP//Za4KLQixZay1/udnbKZSsRKwerbiD4fX/2UzPs2yMW
	VAfVXi0EgNwT4YWyVKgF5baSA8nouHLxr2SiFKMcV
X-Gm-Gg: ASbGncuabwJzEGcuwPAI4x70k/8C/CjanYzCyjqXnAN2fbwqu/1UoO/f4K+5HfaQggn
	OlSH925sGgOxnxSjBpL7xupch4tlN5lpkrXynMUm+tF4gXwk2ZysG71//a3WPW/wIKiQcUhTVou
	2YLfwWkMZkghZOUbHpXjy+yQXVvtBhJnXW9TNxJ+UX0tOxkHCfktLFKzUY4fm+AYmHXrmDtGpqW
	NvIk1DSnq+2+yj1Sbt/izQBVS15gcs3WxlbpKU9Sf1O2xE+kOjSJxMbMUPgn4jpODbsobU=
X-Google-Smtp-Source: AGHT+IFxGlfrzESORJlhJ+sQ1ptMndyIY9+wnuGK/JMRNqNcwAbgDqN1vNXo1wzn0/v3S95tUN0EH3tcgci+Oz3slSE=
X-Received: by 2002:a05:6512:2215:b0:595:7a6c:7dd3 with SMTP id
 2adb3069b0e04-5969e2b50d0mr1513169e87.5.1763663891285; Thu, 20 Nov 2025
 10:38:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com> <20251115233409.768044-6-pasha.tatashin@soleen.com>
In-Reply-To: <20251115233409.768044-6-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 20 Nov 2025 10:37:39 -0800
X-Gm-Features: AWmQ_bm8564IWabRa9o-QUB5L75hdON9Crp276hpUHsnCI8idLYa3aONINMtLrk
Message-ID: <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> The idea is that there is going to be a single userspace agent driving
> the live update, therefore, only a single process can ever hold this
> device opened at a time.
...
> +static int luo_open(struct inode *inodep, struct file *filep)
> +{
> +       struct luo_device_state *ldev =3D container_of(filep->private_dat=
a,
> +                                                    struct luo_device_st=
ate,
> +                                                    miscdev);
> +
> +       if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> +               return -EBUSY;

Can you remind me why the kernel needs to enforce this? What would be
wrong or unsafe from the kernel perspective if there were multiple
userspace agents holding open files for /dev/liveupdate, each with
their own sessions?


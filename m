Return-Path: <linux-api+bounces-5383-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 145DCC713A1
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 23:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B6ED349307
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 22:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C4530C373;
	Wed, 19 Nov 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KEgUB3O2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348428C5B1
	for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590385; cv=none; b=EyeAMFLC7kJV+576Y4aiivM+Vn7j1XXVD41GEsLc1fCB6IVt16dyX9elIVSLCEwb7eysM3WOuPNTniywvSulQIyr3Rvuqkl9i9anLDC4gljKp45KdNvSNd9Uch9SQIqAHVR3YMZVX8SvoD02tQZyK2uZyTNQJyBTI2lfnUfVITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590385; c=relaxed/simple;
	bh=0r7R5FGvy0RXdYfaciazSHP/k6sy56Z0pCJRwQ5fY7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pq7RisLf8d7yKVMj4NY3vkbU8quXtnGKkw6HJ5H67DsU+unrYwr8DwvHF2KsJTBUt/xbp9LdSRqwRO60lXILpLo1X5GWZAc4Ufy3r0I0g8htWBwCoHgO4CnN0Zf6drSwMkuu8GV/Oj0aZOoMbW+NqAr55iYEaTZcQTpGjoNi74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=KEgUB3O2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso2200604a12.1
        for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763590381; x=1764195181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmO/rmQDeDDD4oFLN2kD77+FOiHPR0yrD5sudAmDUFo=;
        b=KEgUB3O2dSddznzLt3eRI11v4CwzDNWE4w1yneEeOt5mCUetXpfjYYiNpZWB6A8gTc
         BmkJdxDJxl0kpnXaBgoPw8js/tyCskcF/G3B8/n+8p+0KS2Wmsrz2BVrIvqK+XYlWlfK
         3mFOnNl/DNTaQY1Ip/wvGW9HKkO45N0jQYPbNPa91glUA7X1m/Grw9xhju0bFxobS8Gt
         cxIdd+5ET3rl1kWzkz6yqEX3sYRI49aAf0WiOnkEUKApG3ICGXrhSJyRnnOzPcYf5hxz
         G5i5/7f7+PAg60jL33nQS46YuZnMEqJLeVwMQA/1HY8xYg6mVVj/Ue1EcjobhdznMPoL
         5JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590382; x=1764195182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmO/rmQDeDDD4oFLN2kD77+FOiHPR0yrD5sudAmDUFo=;
        b=UyAmlaUgMze7BcSGwZpPGZ1l4zQqlneB2OPrcjXU6X/3Kvb5qpFwLBGliKLBhBFZxN
         vZZKp9J7Kko5LCZA5hhBCqz8JgHoco/LZwwxXJrhB4BtkAAWCRk7iVQWtcb28GheKJaa
         SVp/RUhO4zEuY2E1NVpMs62rEjOxpWtbJJ47VhLEhea4qT94IntVdApw9M5M+L3bUSUE
         22QFvKBGEC2z0h5VtxnqrI76SFVpsbMntrywi/DjaMsdP8grfndUVXYzCGKhS+/KOWpi
         fy057625BB6FzCaCEy0hbnQVsvKSIyvfnKaVBISR6fE5DQnM+5vtpBB3vD03LanuPFxF
         iVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxtNpiSzlV54/NNMc5SCMCA19Oitj5sgAs9lICQchcuFfIUpOWQOhPF+IX33kgmpjALXHOBQcZRe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/fvLiNV/gCQeWBKi1a7ldo8Ys+CuR+SuXUGW6+NW+wEYf9Bf
	Xa5HNDYOAa6im5oN4DFI9Vr67mhdRcpRv2XIGOBobIbMrmcw1koG2pZQXTvpz0tq/8WQ6mXP9fb
	L13v8qAmCAXngTXk1hCfLIvBpzC2uS4orya5xGVSP0g==
X-Gm-Gg: ASbGncsx8NqRE2ATYuJAwtwkCg4zfGLpkwBSkIQkhnmkf0H1rP8/vBkMSic6R7qsX/6
	yoQPJh1Y9k51dMiEPbiCy50M/USxiv9gifZZ8ZsZXzCvZRYhU9bcLygBL16PZrs5U4eD4BOQD8A
	m6CnY1oeudNci4PTeVjOFPBYI5Tp8CxdDf5c9pr1tkYS1tX8wjEu4zvPfpAEG44dEb7oY7XtxT/
	i6dy7iGA66SJf6cbBo3ZFs2hZJ8TKvt/eirz0S75tKiYr8qqVog4ZVEklPhx8ilKx/FZRLSYQ09
	gSuNlLhng0ucbg==
X-Google-Smtp-Source: AGHT+IFw6kDorU2RenWoIYJjhBpjj+66hDpPciDjAImJ3B8hxUcjgpzXU/StGuyx3A6WKe/RvhzZdqNdpa9gP61f3nc=
X-Received: by 2002:a05:6402:3492:b0:640:b625:b920 with SMTP id
 4fb4d7f45d1cf-6453966533fmr137250a12.6.1763590381585; Wed, 19 Nov 2025
 14:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com> <aR40oVOxZ-dezpy0@google.com>
In-Reply-To: <aR40oVOxZ-dezpy0@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 19 Nov 2025 17:12:24 -0500
X-Gm-Features: AWmQ_bn2ZiiYRRhjdL5Zxy3O1nTVtrU9qOIx56eMo9t0_SUIdxuoIchWFpNGDbY
Message-ID: <CA+CK2bBoantuwMxqe1=PnRO+RX86Qo0epf89kbmZx5z8i2ivLQ@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
To: David Matlack <dmatlack@google.com>
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

On Wed, Nov 19, 2025 at 4:20=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-11-15 06:34 PM, Pasha Tatashin wrote:
>
> > diff --git a/tools/testing/selftests/liveupdate/do_kexec.sh b/tools/tes=
ting/selftests/liveupdate/do_kexec.sh
> > new file mode 100755
> > index 000000000000..3c7c6cafbef8
> > --- /dev/null
> > +++ b/tools/testing/selftests/liveupdate/do_kexec.sh
> > @@ -0,0 +1,16 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +set -e
> > +
> > +# Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initra=
mfs
>
> It'd be nice to use proper command line options for KERNEL and INITRAMFS
> instead of relying on environment variables.

Now that tests and do_kexec are separate, I do not think we should
complicate do_kexec.sh to support every possible environment. On most
modern distros kexec is managed via systemd, and the load and reboot
commands are going to be handled through systemd. do_kexec.sh is meant
for a very simplistic environment such as with busybox rootfs to
perform selftests.

> e.g.
>
>   ./do_kexec.sh -k <kernel> -i <initramfs>
>
> > +
> > +KERNEL=3D"${KERNEL:-/boot/bzImage}"
> > +set -- -l -s --reuse-cmdline "$KERNEL"
>
> I've observed --reuse-cmdline causing overload of the kernel command
> line when doing repeated kexecs, since it includes the built-in command
> line (CONFIG_CMDLINE) which then also gets added by the next kernel
> during boot.

There is a problem with CONFIG_CMDLINE + KEXEC, ideally, it should be
addressed in the kernel

>
> Should we have something like this instead?
>
> diff --git a/tools/testing/selftests/liveupdate/do_kexec.sh b/tools/testi=
ng/selftests/liveupdate/do_kexec.sh
> index 3c7c6cafbef8..2590a870993d 100755
> --- a/tools/testing/selftests/liveupdate/do_kexec.sh
> +++ b/tools/testing/selftests/liveupdate/do_kexec.sh
> @@ -4,8 +4,16 @@ set -e
>
>  # Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initramf=
s
>
> +# Determine the boot command line we need to pass to the kexec kernel.  =
Note
> +# that the kernel will append to it its builtin command line, so make su=
re we
> +# subtract the builtin command to avoid accumulating kernel parameters a=
nd
> +# eventually overflowing the command line.
> +full_cmdline=3D$(cat /proc/cmdline)
> +builtin_cmdline=3D$(zcat /proc/config.gz|grep CONFIG_CMDLINE=3D|cut -f2 =
-d\")

This also implies we have /proc/config.gz or CONFIG_IKCONFIG_PROC ...

> +cmdline=3D${full_cmdline/$builtin_cmdline /}
> +
>  KERNEL=3D"${KERNEL:-/boot/bzImage}"
> -set -- -l -s --reuse-cmdline "$KERNEL"
> +set -- -l -s --command-line=3D"${cmdline}" "$KERNEL"
>
>  INITRAMFS=3D"${INITRAMFS:-/boot/initramfs}"
>  if [ -f "$INITRAMFS" ]; then
>
> > +
> > +INITRAMFS=3D"${INITRAMFS:-/boot/initramfs}"
> > +if [ -f "$INITRAMFS" ]; then
> > +    set -- "$@" --initrd=3D"$INITRAMFS"
> > +fi
> > +
> > +kexec "$@"
> > +kexec -e
>
> Consider separating the kexec load into its own script, in case systems h=
ave
> their own ways of shutting down for kexec.

I think, if do_kexec.sh does not work (load + reboot), the user should
use whatever the standard way on a distro to do kexec.

>
> e.g. a kexec_load.sh script that does everything that do_kexec.sh does ex=
ecpt
> the `kexec -e`. Then do_kexec.sh just calls kexec_load.sh and kexec -e.


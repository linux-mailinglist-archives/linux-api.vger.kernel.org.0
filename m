Return-Path: <linux-api+bounces-5381-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F5C71230
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 22:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5062A4E294D
	for <lists+linux-api@lfdr.de>; Wed, 19 Nov 2025 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962A2F619A;
	Wed, 19 Nov 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CCrztLZi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FA2EA480
	for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587241; cv=none; b=Wot+clJ7+zvOs7LghxLOZ4zOoFwD7NBO4xxT2uePVSi5F5rmMB21BQR8MN3ZWTYnHsfViCZ9nqFMwp4DRex6RZ95qXvPqYJc8Z9qXYi+nz1iU1p/4msjq4szYpA+3PKQM/+FaQrpaMHccPKC6XzGgWndZmUHJsNi/R6R0SFzWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587241; c=relaxed/simple;
	bh=5FMCYKy+e8kyhNpTIUKcyng1fuKvk1WBXqnTBDSSpjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WslkfCN2eimintSKcwhVaKz/duIWCOvxNkDpDTW1RG/tymW/SvbyTTgdlVdyghoSOu9+2ZdxbQR069iRhn0CqfVkC860LSJKw/2W/bEI8RFZF9rg3qF2tDcd7kuD7RC7wDWkNX59szQ68MN+BTmHy1i90m0o2xEjg7nc5bXhjuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CCrztLZi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298250d7769so1544035ad.0
        for <linux-api@vger.kernel.org>; Wed, 19 Nov 2025 13:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763587239; x=1764192039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flj38gz4L08lc87dayRdAelLk1tJ7Y8JM+kGwy03iE4=;
        b=CCrztLZiIq+KtKjZ2GpSS0mrBf9kSXYu3VjmH8UoOnDjbwblXDLqyf0qkdbQuv1LrO
         xTyJQdlgcNVHSsLQtXoFs+cBI8n/thMqYCsIy7yQsPOPJHOBYJtcMwFHqB4WQYV8u7XO
         D16L7taQvez11c7IFn072fR4tcK9lKyOc5a/22SSwK/tP7Ds0CTRiJruIomf8fB9bn9Q
         2pS+6Akbqo3V/k3YndMwvmH4pc6LZ2nN4J1HkJ7OG7YRvezDG862nkuloyC8VjR8PAwi
         Up5fqzdF5OVydy5poBnXICoUb/Or+klkr2khwOC1kr59+c+zp9neJ/Og3NDC8LkawrXz
         unbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763587239; x=1764192039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flj38gz4L08lc87dayRdAelLk1tJ7Y8JM+kGwy03iE4=;
        b=TYs5U1dv9Nwhs46NRjBMdVaIKjAPYVy09HWRx5iDSWOLxF44D6fgvn5XKfen1aRKqV
         YFi5SqULmWUhn3d7ZcF/Oz7entSDHqdfG34s2TOSFqS0mTX/48LYqvICdxwd+cCfadDl
         5Y+97dwnOGx8mlp15/efPj2zmTcQ/KpJeFPKrSF6d/rdeRZdaAShxzEiRs0w6VEsZbt3
         6QLvdRTaNFbUKzJnKXzYR8HpjJt+udpXrQw1xlrWM3hjkMkUiQHtFaGolA8eeqkEGtEM
         xT+zCeIXTd3g2YuOABRGqVRVYXjGLGd3WuWXOa+dPCFvawC5JvIqunH2+/mu+sltsBE2
         OoCw==
X-Forwarded-Encrypted: i=1; AJvYcCXkjfWSi0Nwztsw5Jes0tkJXHQkFh2FG3n/oUZVSXGC7VRx115/0dy08uN5RtOb3+3Jx5NTbteVfbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/wVxAprksXsrwm88qVnh11P1mzPwse2qIL8b/LQfgl+iMNrW
	RkmyUtLHlgE2L1u8V6WW1fqK9KffNprVBG4rke6sNmrs7A34VHpgogdS7hzmqr+89w==
X-Gm-Gg: ASbGnct9DegFpF5UOnstZHyx+Q/AB1e825eVA+tEIyvMV6bhzdLnCN9um+z2H6L4R22
	YuXZO877hrwSeujV547S4IsUgDhWDkAm75hpt+rb//cSikjWdzUc7teF1vl2+ejuYMAEzZI9glj
	CQ1GhuKpE2A0/2bFoFYz5MWK7JD0/qHXtebfAKWm8Abka2TfoS0tlcKgpckBYJUjdDae+adSYVH
	fXJ7QiVtVUqAs5GQdPpnveuOvtW9ITEqBx9e4SyjgJ+F3Lbo1RU37nvBzqP1cHLuZflgbvZ4lN1
	TiDIDPPPujCERxJMxK1+wFzLW3IXkpLm8hvJqrQgWoQksX08rDWrki5FaE78diINE0LYMoZfVu2
	uZ2F0X1a2EB9YtO4iRaZG0EiQQiuswpQGkLbalU8WGzfzfX4WBckybKnVUmfQMUGCvpjIFFnGcs
	lo1/lzzshVbUvC59KbNI9NeLN+XxZxoCTMnA2SBNXgiyw08t3D2aQEbkPY0L9gCAUtPOKonEHkX
	g==
X-Google-Smtp-Source: AGHT+IFrxTck/ibRPggmaOfoFEHngZ9j3Wi19/Cn4ktJjoxdrVE4GnzBiziuQnyIS9dFi1fhtFrseg==
X-Received: by 2002:a17:903:11c5:b0:294:fc77:f021 with SMTP id d9443c01a7336-29b5b13a8bbmr9665255ad.49.1763587239033;
        Wed, 19 Nov 2025 13:20:39 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13e7e6sm3965405ad.40.2025.11.19.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:20:37 -0800 (PST)
Date: Wed, 19 Nov 2025 21:20:33 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 18/20] selftests/liveupdate: Add kexec-based selftest
 for session lifecycle
Message-ID: <aR40oVOxZ-dezpy0@google.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-19-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-19-pasha.tatashin@soleen.com>

On 2025-11-15 06:34 PM, Pasha Tatashin wrote:

> diff --git a/tools/testing/selftests/liveupdate/do_kexec.sh b/tools/testing/selftests/liveupdate/do_kexec.sh
> new file mode 100755
> index 000000000000..3c7c6cafbef8
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/do_kexec.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +set -e
> +
> +# Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initramfs

It'd be nice to use proper command line options for KERNEL and INITRAMFS
instead of relying on environment variables.

e.g.

  ./do_kexec.sh -k <kernel> -i <initramfs>

> +
> +KERNEL="${KERNEL:-/boot/bzImage}"
> +set -- -l -s --reuse-cmdline "$KERNEL"

I've observed --reuse-cmdline causing overload of the kernel command
line when doing repeated kexecs, since it includes the built-in command
line (CONFIG_CMDLINE) which then also gets added by the next kernel
during boot.

Should we have something like this instead?

diff --git a/tools/testing/selftests/liveupdate/do_kexec.sh b/tools/testing/selftests/liveupdate/do_kexec.sh
index 3c7c6cafbef8..2590a870993d 100755
--- a/tools/testing/selftests/liveupdate/do_kexec.sh
+++ b/tools/testing/selftests/liveupdate/do_kexec.sh
@@ -4,8 +4,16 @@ set -e

 # Use $KERNEL and $INITRAMFS to pass custom Kernel and optional initramfs

+# Determine the boot command line we need to pass to the kexec kernel.  Note
+# that the kernel will append to it its builtin command line, so make sure we
+# subtract the builtin command to avoid accumulating kernel parameters and
+# eventually overflowing the command line.
+full_cmdline=$(cat /proc/cmdline)
+builtin_cmdline=$(zcat /proc/config.gz|grep CONFIG_CMDLINE=|cut -f2 -d\")
+cmdline=${full_cmdline/$builtin_cmdline /}
+
 KERNEL="${KERNEL:-/boot/bzImage}"
-set -- -l -s --reuse-cmdline "$KERNEL"
+set -- -l -s --command-line="${cmdline}" "$KERNEL"

 INITRAMFS="${INITRAMFS:-/boot/initramfs}"
 if [ -f "$INITRAMFS" ]; then

> +
> +INITRAMFS="${INITRAMFS:-/boot/initramfs}"
> +if [ -f "$INITRAMFS" ]; then
> +    set -- "$@" --initrd="$INITRAMFS"
> +fi
> +
> +kexec "$@"
> +kexec -e

Consider separating the kexec load into its own script, in case systems have
their own ways of shutting down for kexec.

e.g. a kexec_load.sh script that does everything that do_kexec.sh does execpt
the `kexec -e`. Then do_kexec.sh just calls kexec_load.sh and kexec -e.


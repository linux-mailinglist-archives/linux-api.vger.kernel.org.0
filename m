Return-Path: <linux-api+bounces-5398-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB697C7611D
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 20:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B20D42C2C3
	for <lists+linux-api@lfdr.de>; Thu, 20 Nov 2025 19:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE893314BC;
	Thu, 20 Nov 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BbMrJwOL"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038430FF03
	for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666612; cv=none; b=gCqD16LelIplER5efkHuZd0L2/NW0q/d/dFojwRJqzhu/cAvC/e7T72q8iDZIQB+1ESgkWtMyuWzss4qmiMy4A0uFkok65aQedTp7E+QGqdtMk/oMj3M8lqslAVHbIvhRIBMvPH8PKtPVD/5aWpPt/6b7Oh0gK6ZhpGxaaDQxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666612; c=relaxed/simple;
	bh=q296xHT139H/nWM6Mg7reqJBxMtKMjHiSyLM9oVB9ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCc9N32aTmmqhyWtSYv75hQ3z2g+1T1jrPPhzn5jj22nDANS5nlBbpuIAoRWkOGY+zZYYPGSLJJETQyhKo+KPtcoUK1ShM7tP9djJFzQoLmuOmn3FE8WcZypOovXAZ45+PKf27f8GvA/fXphr2YCtRbkS1dpl/0HbyhXh2lOfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BbMrJwOL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so1924738a12.3
        for <linux-api@vger.kernel.org>; Thu, 20 Nov 2025 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763666609; x=1764271409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyqJoiBriMQgCPogonFRTQ9rKbbZAaEyFulWYXXm130=;
        b=BbMrJwOLrT3Py4p30cn1WEcybQv43PCIVCm1iXjzIj2p7KNXK6hqeiZBArjEMuE+jX
         Y3Eze+w8xj5wDNzOyI82htIFgBFn0c0tDN46qCmrzH6jZpJbf+F8L3tZR3ob8tA75qW4
         A7vUVtw7aTC1siTO9z8On6ikwjQVYUQLPdno3iaV8cwhMVjgOsns08mU00lcTn0SfT1E
         +m+rHYYxVsxCqPZAcWUSk7BcZFNxg2tgYAusDCG6B/pL//T829mudssUIjiWix6M8I5Y
         Q3Qfj50QZ7sOn6uq0MLQnYBwPmLbIEH1HY91ksC6Y002jFsB7U/oYzCd7wkdtgl9mCiC
         2sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666609; x=1764271409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyqJoiBriMQgCPogonFRTQ9rKbbZAaEyFulWYXXm130=;
        b=i6F5eh2MuY2NSRnSghXJs3sKsiwMqK9+FlH6hTZk0ZZHIaLAovkPFgXiybTe3DaWh8
         XCYHM9Po/vgbC3z+cGzRHyHk1dSElOyQYQjKXhHJDQR9hwv+vk3U3qxhX6ei0DQ6lNnx
         81PysxqH/xj4Sy0X8IgmrPI5UzPg9GnTwO++j3oRw1NpAu8Q52XQsNFLyIE/3NajSHw+
         F6gkEuj4BVu+WqSfntpRIxo6Hzte9t8X4ACycO0KrqB5E8JnPFKq31xd6P78fSMzFb7q
         EZgP6lhbPvvVjWyBHVJdc+5s/Li7//kHRhnEnvNsu7boMdsip8KKer3/LsSKHUrQ9PVV
         PEjw==
X-Forwarded-Encrypted: i=1; AJvYcCUi7DpuxJbKKps/Oh4SzFc4myiOJr+s6k9BH4xYO4CciiKjzIKXbwefVP74O4Zq/SOmph8i95OONYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlQikaS75sGkvY0qrWKdcl4ckaFboOwz1pNdTcZdY6zFuKHWv
	npr44vbtaRxkXp+2Q0Zc4BSMdnyEAnZojakHUJxzC+jZuPPfLAxPnRy4nx04HbfNh6pDidSYVGE
	0s92PrlTU/LNSCpC50nFKTNwqV8x2vXYzbAZl0sCdig==
X-Gm-Gg: ASbGncvNNQJSxMWvQjm88+I2za8sD1HV13dSg5x67Dm6Tv8lBVMJIwP9/qdPCwlmayz
	xnClH8M6zsONxcGmtS/8Ctg/pJNQr1SY//g60br5n860yomihc0CxK8FW9qku6UZTWp6JHaGebh
	1ujkKZMTBQD0oIla78N1COwBuSuWvVPMtrO16Z3n0i4YR7CidqpX5bE4XCUerpSYsyxMDpKmTUZ
	C7fovtos7/27z5cb0/ktVsv2pYLwSQhSIM1bsi8nY+k4S3zNycEwwGnB52HX6NgBYHs
X-Google-Smtp-Source: AGHT+IGJIRbNGCteCBItzQRTIq/UH9PLUTffzANE/lniZXOm3tJP5jtVCSVDjBc5RQYSOrk0+uvnxuTU46FVfmAnAaA=
X-Received: by 2002:a05:6402:34c7:b0:641:4b82:10c9 with SMTP id
 4fb4d7f45d1cf-64536450b6dmr3933635a12.27.1763666608422; Thu, 20 Nov 2025
 11:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-6-pasha.tatashin@soleen.com> <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
In-Reply-To: <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Nov 2025 14:22:50 -0500
X-Gm-Features: AWmQ_bmAzBC36YkUhEhsUvaEIh48LIbtssnzB0dTWcGpqHev3pMUQm9n-Tz4Sts
Message-ID: <CA+CK2bD4Y3CMHcTGKradmv-hAbdtA7zsw2CYeh7-8LNianYMZw@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
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

On Thu, Nov 20, 2025 at 1:38=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> > The idea is that there is going to be a single userspace agent driving
> > the live update, therefore, only a single process can ever hold this
> > device opened at a time.
> ...
> > +static int luo_open(struct inode *inodep, struct file *filep)
> > +{
> > +       struct luo_device_state *ldev =3D container_of(filep->private_d=
ata,
> > +                                                    struct luo_device_=
state,
> > +                                                    miscdev);
> > +
> > +       if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> > +               return -EBUSY;
>
> Can you remind me why the kernel needs to enforce this? What would be
> wrong or unsafe from the kernel perspective if there were multiple
> userspace agents holding open files for /dev/liveupdate, each with
> their own sessions?

By enforcing a singleton, we will ensure a consistent view for tooling
like luoadm (which will track incoming/outgoing sessions, UUIDs, etc.)
and prevent conflicting commands regarding the transition state.

This is not a bottleneck because the vast majority of the work
(preserving devicse/memory) is handled via the individual Session FDs.
Also, since sessions persist even if /dev/liveupdate is closed, we
allow the agent upgrade, or crashing without requiring concurrent
access.

Pasha


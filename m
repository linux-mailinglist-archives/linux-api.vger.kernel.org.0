Return-Path: <linux-api+bounces-4912-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35373B91D31
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 16:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFB8189BA2D
	for <lists+linux-api@lfdr.de>; Mon, 22 Sep 2025 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B52D6E60;
	Mon, 22 Sep 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZukVEC2T"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F472D63FC
	for <linux-api@vger.kernel.org>; Mon, 22 Sep 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553099; cv=none; b=k/VkHmYt4CfgJqMqPuc5zVKS8W34TCoxM0aCOgVnNse82omHIZuLbMoW4F6bKGxeTzQhANgqN+Ri0FouvG536XH4z/eRm8oZljelS8a4NvI56MpwQ2vKC17TjESRLTT83XSnL3l+xHHoLhko+Fz/6LXQx0OaY/ZO3gbbsetRXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553099; c=relaxed/simple;
	bh=bk/uSOBhjlLpezuJ67nR7iyn8eOOajtcOPPkD+iN/3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuvZLlojGJSsuXsGC/Ss/IwCzbo67g9T7ZwgYanIGw8Syp2haDhwG8skEYir8n3zksPPfz9IdGmidetAaljPG0ax29LwCdHIVV9PsE1IPvw3G5ZBtES1O7M5LT3+iFk0e8i5K7yMu4SQ1RXRS4xetN/R+KHhu1H9fPXIgwL2nHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ZukVEC2T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b548745253so76198921cf.0
        for <linux-api@vger.kernel.org>; Mon, 22 Sep 2025 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758553097; x=1759157897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFVWZlAioBD8f+qAHkBJ/aidH/GZeFQvA+qClIUvAWI=;
        b=ZukVEC2TBHAzXAq1pJ57A+FQBf77prwd0uZpcCm7CiP1eyDs3Vm3KRA1I9PFOqLsH2
         2wPq27j3F3bQuCq5fUt9llx7sjeF0BMZUBWAY8ZQEmyf/liW3pqzv1IOYnT9I2ZBoEPX
         pswDF/EeI1DbHR/d3UeGJ2PgS1punXOeZhNwsrLv47atcgf9gqpDOTzDmtehGDYkw2O6
         20nmty0XcDB2YOvGe5MubykrS2Z4b+3MQBtcpKezm3apfn5w0CtFyp8/Pgnr3vWniMoD
         3szXovJtaP+6UTxvOsxqJmuft80jXG7XKzWwC/W5XaiDnCL1Ah13iLj6JoyKmexoszIY
         dDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758553097; x=1759157897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFVWZlAioBD8f+qAHkBJ/aidH/GZeFQvA+qClIUvAWI=;
        b=lzKIeTJ9N+AXwpU5ufd0btt7BkGN6UX3Qf/GJLPmoOerurAuHcS6sa7goiktODgk+B
         YmIvGRqfdaY/VAyWgilC7Hyers/p3/2sIiFboCQ/etDCLMDYzNOHa99cXsNYcd76KXlh
         GzO7FuR8d2QmDpfp/PHECJXCmvdypcqoh8V3KxoCPW0A97lmtnMs78qu8FKZP/3zRIQ+
         8Xoyo2CqD8n8cES2py+YF2tFIg3TRhpipT7sLegckrCCXbavIEnCTyHnvxepN4nNSu7W
         Mniv97bocJDUWsTDXULdpYUq6PHsRFaf3eaGZTiRQGdF8cXBjez4mcwih1C4DztVZib/
         64IA==
X-Forwarded-Encrypted: i=1; AJvYcCV/wbBlfq8LMcMQ8VPTnTnxbZNsgNWJnJYm/ld63vy2tQOusE2q5Yxvdb8GGLn1PR12o7eGNE74LYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQBXnDzEDVK74kZGuj3kwW/AqkLaBQdGwamKiYqxjhVGyhmRV
	+RQ9UYsuFr3QG79EKVQG9hegDNbP+oHk5vKAC+oSS7Ll7mgCOWhMVDIJDBbdkwnvU++JThk5xGL
	vDkokJgTIMFAqa8OhWXMlTuWotwg01vDzj7PsXlpeLA==
X-Gm-Gg: ASbGncsh04nWrhlO7jedv9Q4KhZdNImap0TeAykJNv+nMIvsK/IuEMOIj1tDIc7Ty2K
	7TVnyyZmdASbqbNk9u+fidwLmIjlplB3HRtvdkl3gS/zFT3/gTJAhJOqZgoFGom3NRQDn3ZP97D
	L8pnTiGAGjM3jhwrUb5Po2HWbFPLTOkGOUHk7+JtqRxqdF3gh8Ua0/SbfcLTDPPIkA0G1Fsz6K8
	STr
X-Google-Smtp-Source: AGHT+IFB/CQ+Stx8wqmihXNU+u019GIyHx6IROg0+AJtIcKFDHMuxhnTyNrT+0blnUsLunK7sMerRGUSSQ0zeNBJCw8=
X-Received: by 2002:a05:622a:1aa0:b0:4b5:d70a:2245 with SMTP id
 d75a77b69052e-4c073ab0d34mr174036401cf.77.1758553096737; Mon, 22 Sep 2025
 07:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-9-pasha.tatashin@soleen.com> <20250814133009.GC802098@nvidia.com>
In-Reply-To: <20250814133009.GC802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 10:57:39 -0400
X-Gm-Features: AS18NWDigaezp8KdbFsh6YfrVI9s8S_j72gr5tDnCBaGxghJTTvfOltyGvHBbhQ
Message-ID: <CA+CK2bDDo7xVxFd=-vkkXuUyStj9ShmURmGNPkMyJvi96KrV7Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/30] kho: don't unpreserve memory during abort
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:30=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Aug 07, 2025 at 01:44:14AM +0000, Pasha Tatashin wrote:
> >  static int __kho_abort(void)
> >  {
> > -     int err =3D 0;
> > -     unsigned long order;
> > -     struct kho_mem_phys *physxa;
> > -
> > -     xa_for_each(&kho_out.track.orders, order, physxa) {
> > -             struct kho_mem_phys_bits *bits;
> > -             unsigned long phys;
> > -
> > -             xa_for_each(&physxa->phys_bits, phys, bits)
> > -                     kfree(bits);
> > -
> > -             xa_destroy(&physxa->phys_bits);
> > -             kfree(physxa);
> > -     }
> > -     xa_destroy(&kho_out.track.orders);
>
> Now nothing ever cleans this up :\

It is solved with stateless KHO. The current implementation is broken,
dropping everything in abort should never happen for stuff that was
independently preserved.

> Are you sure the issue isn't in the caller that it shouldn't be
> calling kho abort until all the other stuff is cleaned up first?
>
> I feel like this is another case of absuing globals gives an unclear
> lifecycle model.

Yes. But, we have a fix for that.

Pasha


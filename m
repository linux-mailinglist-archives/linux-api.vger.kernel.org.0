Return-Path: <linux-api+bounces-4192-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39877B0F493
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA188E746
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B52E88AB;
	Wed, 23 Jul 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="dM9JXVnv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EF272E5A
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278830; cv=none; b=gxiFB5pPsmKqr30ZgAZ/uLe6O3GtFKjL5uahnkHN8qYp9Tpc111hb1l7RHZn8Mls+SEnrBieMNUg/amCYNrMDbDaEN3VjSR2uBJE68vytrOjiA+5cislnCwPBQ5r26b9PukENwFQCiJ2OVUOM8n6WTrIeFl9nFjcYG7lZ4L11bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278830; c=relaxed/simple;
	bh=hByHGrth5zdeb5TgCiwXXXAzfAWK6MDyTN/grdnGXO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDRMaOHKQOFB7wWTbDKPLbDDtwwsvULsDAZa8Z2dUiAfjTqncw1mnlM0Hdq78zytdhpgtBjaD/5QX/8oCOYlDefk3s7/XoINVlQSohn6Ew8dZNjCvXYEuqr6BR/PE3b5xKBGv/MDghoA/8ufJkdUMY/679B1FRfPvXmTpvu/XiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=dM9JXVnv; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4abac5b1f28so61461751cf.0
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753278828; x=1753883628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nYQ1nxWVgdB6FCVcfOrCHIYHLuEY3Xl4xttYXGmsTA=;
        b=dM9JXVnvI/nED2XsNyy7A/f4HrA0tPyaQWK54CCTUytezJATSD6jxh2KlV6Erdcdf6
         TJLt2q1PQTwIjLBM5FjszQVQfWVLLk5I4kuZfb0NGqo0iMJAXDUu698AP9/7qTyXc+He
         RYAOPoTtLIS8gtEYVbkuUqMod4uQ9Mlt6THbDftUBGg+Dy9W6jV71ffVYS0893Pitou7
         QG6dk3K49tNEelJAPHlJBl52bF1/YdlU+FUHqX6tPoaV1PbU6RLnR71alJHyzsX70qM5
         Jz10MNP6qWIl6ZPL1WMdExBJjvoMk5kdnRu/iFgh/zSJgfUv3YEUuD295CXtOAlEAPPP
         D2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278828; x=1753883628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nYQ1nxWVgdB6FCVcfOrCHIYHLuEY3Xl4xttYXGmsTA=;
        b=GI+Ju1jIDlc/FCnBGaAb1SvbPPUjN82soaJAA6zdvS/qAVMFKorGMj+7XsGp4Cfk++
         LCcDFWedTHuRROneswY8M+s/8E895JpQ8ccBLHWoANC99hnTJo3UbZ6wM/5devnZpMGZ
         ylAYRvMauBvCc21boZE/bJeQmik16WgiWIzCOQa2SjEIGPmXy2OsGbRKja7lNN1IKk+9
         vSm8L83tyer1iJBWDJ0Cp8NXT1AtKRgH2V2KcmqtrIQg5BqvPR0tDU+PsPfNUSyhfx5D
         kN+RgbpVAHlg7TTR2mqMRrxVs1WvcqxGlbdv10SzvzGeP3nEhRTY2OUXFaRDnF8+hHEH
         my2A==
X-Forwarded-Encrypted: i=1; AJvYcCXmQFg7okXNq859o19CFILHYkJqExkI2+j4PptpG99ewOF6KgC2rsNz0jnfdudFblaSVupNGb0ymQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4zdq+bWUPsJa95mp2ag8s0Ih4f2Uc06325B/tu+DhecI8zY6
	bOERrk7Cku9qSlthUBYQh00FdU6MdC6iuZOmF6V5bJezJkrpnxOq+BD1b/e2yyyBcyQ+BSxU03I
	DYrjrhNORnw2hwlAB7tQu0LigUwCXoM/YTz2AguD1UA==
X-Gm-Gg: ASbGncv1GdpcgvBMJM7GdNtO3NpetPuc2eyflH8jy4HtSNRqk1APFjj+hNLm01KVxf/
	5rVCxCPIfXf2Okc2VycEXt0OkuZl/k+7QQf/JjMERDeDU57F3wNswqjVQdDkO6A26hKTpCENbDg
	EPeMmfAZl6RF0hBO/QlO9yKNWwcA9omHJy23c1CHN01Zlvsq0yoaQVDMDDP1EjVV/n9Elxjby2e
	ntu
X-Google-Smtp-Source: AGHT+IHnUuhdrD9l7/UqXUCaUGkjpnut9RPkUhkRsYy8dMo95ULrH9zUrOnS3/mgiyGB2gnOI0df5GH4vloe3EzyqoM=
X-Received: by 2002:a05:622a:13:b0:4ab:65c3:37d5 with SMTP id
 d75a77b69052e-4ae6e009e59mr39018621cf.27.1753278827759; Wed, 23 Jul 2025
 06:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-18-pasha.tatashin@soleen.com> <d6e44430-ec9c-4d77-a00b-15e97ab9beab@infradead.org>
In-Reply-To: <d6e44430-ec9c-4d77-a00b-15e97ab9beab@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 13:53:11 +0000
X-Gm-Features: Ac12FXycG_A7VpBGI0ZPxdi4OoC_3NChOWXSX3JfSNxhPZyJt2s_1oWRajx-S3I
Message-ID: <CA+CK2bCpY3xnPeEyWCRYVpRcs3maKMqZnApQtm5upkwmM80a3g@mail.gmail.com>
Subject: Re: [PATCH v1 17/32] liveupdate: luo_sysfs: add sysfs state monitoring
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:29=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
>
> On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-liveupdate b/Docume=
ntation/ABI/testing/sysfs-kernel-liveupdate
> > new file mode 100644
> > index 000000000000..4cd4a4fe2f93
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-liveupdate
> > @@ -0,0 +1,51 @@
> > +What:                /sys/kernel/liveupdate/
> > +Date:                May 2025
> > +KernelVersion:       6.16.0
> > +Contact:     pasha.tatashin@soleen.com
> > +Description: Directory containing interfaces to query the live
> > +             update orchestrator. Live update is the ability to reboot=
 the
> > +             host kernel (e.g., via kexec, without a full power cycle)=
 while
> > +             keeping specifically designated devices operational ("ali=
ve")
> > +             across the transition. After the new kernel boots, these =
devices
> > +             can be re-attached to their original workloads (e.g., vir=
tual
> > +             machines) with their state preserved. This is particularl=
y
> > +             useful, for example, for quick hypervisor updates without
> > +             terminating running virtual machines.
> > +
> > +
> > +What:                /sys/kernel/liveupdate/state
> > +Date:                May 2025
> > +KernelVersion:       6.16.0
> > +Contact:     pasha.tatashin@soleen.com
> > +Description: Read-only file that displays the current state of the liv=
e
> > +             update orchestrator as a string. Possible values are:
> > +
> > +             "normal":       No live update operation is in progress. =
This is
> > +                             the default operational state.
>
> Just an opinion, but the ':'s after each possible value aren't needed
> and just add noise.

Removed columns, thanks.

Pasha


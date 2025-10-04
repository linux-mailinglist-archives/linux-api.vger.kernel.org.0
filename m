Return-Path: <linux-api+bounces-4991-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2258BB8845
	for <lists+linux-api@lfdr.de>; Sat, 04 Oct 2025 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB319C770B
	for <lists+linux-api@lfdr.de>; Sat,  4 Oct 2025 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897C27FB21;
	Sat,  4 Oct 2025 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UVBohL8c"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676991DF979
	for <linux-api@vger.kernel.org>; Sat,  4 Oct 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543728; cv=none; b=eXgL9dYc5E6OjWbRa1+z8IQBtaIKK/wVe3W6lH/6OS9i3YsXdBcNNgsWjcf3FI38ykUm7K11EO3WviHqu+twzv6p92sI5z7//iJ/+VN32a+w/9KXNamsfkCIlcUjW77aVrEbxsb0BbqFCMZpuBbNzAE7s8rnCB4MTlF40+JXx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543728; c=relaxed/simple;
	bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjkiB0qZaKg0IDBd4U3tKNk3Vxuy13ixjLm9yIVXXDVpSH2/Ro1nIv2fvKT/oGt/DUa28DiW2VvAEr6mTC0SBKCzy29arEu1wuSA6hSpFhn9nR3b0L3fChs9L5bEkBKIez0/Y6DC43KK4ssYd8VqzIMKJRTDEiSgtZ3Jd+6xR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UVBohL8c; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4de659d5a06so16837031cf.3
        for <linux-api@vger.kernel.org>; Fri, 03 Oct 2025 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759543725; x=1760148525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
        b=UVBohL8cU+t8AHNXNBFMhP3Q1+ncT7/G64axJBW6tt6F87RkpDFR51Fn6SnQuXE1sW
         zMlqgn85RiMJx+APlHTL8Mupunuf3Mto4vwrClsFZwF3iZu2ccU9dJ6JRlRyzPECC5DX
         +M+8OuzvGRyJ3scu3u4q1CRCWAVaTDN/SL2ohwmfAUp/ZIDkfJWAqRidOCH6iJ3qUG71
         R4MVttxjbYVr0YOEpK0kBQD+5W2+BJo49b+lmv91vUqvuVTBcXKwlv+u/1pgjruKvZsq
         k9OApD4/bcxXXIN5TVARF+5M/3dM9Gfnj5jkiDnFxHRwZZQCkr6/X7O9MYejnitZ4oOt
         D5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543725; x=1760148525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
        b=ALp2oczxTvgm3JWWzDF+J6EYlB1yYCMypCBI72iVeZQoqxxFnM7p28vSRPsvKdsB+b
         82zdPP+pbNTCXx4mzbtI00ZaXdv9NFEa+EvllWmGhqGIZOEO1UoFnx0LDq73cM0otm79
         GHu1zkOPtIT4bhfc5u9QMU1AGqpH1ixCNjxQd7WCg+v531EcubIq1PzWM7yOLReF+eN6
         n6wfTrestTOciUm79UEJ+Im+Oo4SHRdTD7aeGyQHI8s3I2y7xLNJKLhFl5zcW3b5qjti
         t2sZQqdcCsFLgruhXXH1EUmuKrlUFaCKljyQilSSmeZi5Jl8ReLpnxsxnaucjCOs8G16
         IAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLoKxa5xphkG3/cYgvnoJSqdenjc0clZEXuicMavzI7By/vLM+uZsvIKC+ZV4mXGjm0z6PerH0qAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmRGwZF5SuSeWxb3ULdI9cz+NHBt37Sr/6ZxvfECVQAGSsVNQ
	zwEZ1+JQr8X2csyj9dKiseLVE6pLEbKtkREhfn+e1RHTjEI6wYucjWQ+VieD1OVDTzntc64Y0/l
	telsTlqx+jR+fo31PjYQLaYhwsfpoo9pxB513FFOncA==
X-Gm-Gg: ASbGncuOprZUCJ7zHnjtKdNk2fbGGj3A50aLgc5aoWoVnLC88zNymz7//9AnlYRJ07J
	RPvCChSmV9aeZnIgaB0t/2fHYLBIbsIRl7mHl5FHRFaNIQ9uGCLcNWLLSqK2HT0NlFhuOdTpUq4
	I+ThSa9AV8xjV7GaankO+9DWCrbas4KRiJ8dvm37us4KxUSROsJw6a3lypwmBb38GgzKh3P5SgX
	UOIz2JmGgndMqrgQ1IlGoZxpssf
X-Google-Smtp-Source: AGHT+IHbUzSApGmCRxnFWZElbyxsoU4/P0TZBLF0BzTvLsCV+miCnogbHJNniWq337bBkZeh/jjC8xT2gDd4cs+U3JI=
X-Received: by 2002:a05:622a:5c98:b0:4d6:173a:8729 with SMTP id
 d75a77b69052e-4e576a44213mr72478001cf.10.1759543725080; Fri, 03 Oct 2025
 19:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-19-pasha.tatashin@soleen.com> <20251003231712.GA2144931.vipinsh@google.com>
In-Reply-To: <20251003231712.GA2144931.vipinsh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 22:08:08 -0400
X-Gm-Features: AS18NWCqgXSjTPwyDSbb0KSJXp4c4gz9L9NTQCHF71G2zcSqEq0ghlLm9Q7hBiI
Message-ID: <CA+CK2bD+gG41LA5=kfuWh=zsYm5L9Dq+M8Bhg9-2sn05YvNfaw@mail.gmail.com>
Subject: Re: [PATCH v4 18/30] selftests/liveupdate: add subsystem/state tests
To: Vipin Sharma <vipinsh@google.com>
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
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:17=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> On 2025-09-29 01:03:09, Pasha Tatashin wrote:
> > diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/=
selftests/liveupdate/config
> > new file mode 100644
> > index 000000000000..382c85b89570
> > --- /dev/null
> > +++ b/tools/testing/selftests/liveupdate/config
> > @@ -0,0 +1,6 @@
> > +CONFIG_KEXEC_FILE=3Dy
> > +CONFIG_KEXEC_HANDOVER=3Dy
> > +CONFIG_KEXEC_HANDOVER_DEBUG=3Dy
> > +CONFIG_LIVEUPDATE=3Dy
> > +CONFIG_LIVEUPDATE_SYSFS_API=3Dy
>
> Where is this one?

I removed the v4 SYSFS interface, and this line is a leftover, I will fix i=
t.

Thanks,
Pasha

>


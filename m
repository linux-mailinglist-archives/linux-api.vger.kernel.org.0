Return-Path: <linux-api+bounces-5039-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE0BC8EF2
	for <lists+linux-api@lfdr.de>; Thu, 09 Oct 2025 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305B619E7B10
	for <lists+linux-api@lfdr.de>; Thu,  9 Oct 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A952C3274;
	Thu,  9 Oct 2025 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b+zMQNGz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DF264A86
	for <linux-api@vger.kernel.org>; Thu,  9 Oct 2025 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011318; cv=none; b=s1J1yetIwWBoEKnHi2XZOs4jjr2qR0htL8MUuuddDyG/ZXxiMBBBaYvhZIsbDsRGUKQyEkTtWcuQivo7jfRF1IOLwo/FOvFXVctSsrfGW8pZOVLheByB4cG7AvEE2QZsG5Rn9hrseOmtMiwO/TyaBBkGlOgTRgTBq6DWsA/89gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011318; c=relaxed/simple;
	bh=GM7HHu3HbolbVRGEPyllWwUcu2/FcpmuCKiQlqwBpNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx7g7P8pqFjy+Gu9GE38TrH6KvMgGI2kjuf7SJMwfJx0onLSnlyRUw/fB2vWIeMyb5fP6cOHoX2trY0+XRMmgLE0DaZb9SVJfZBqR2lSQShVjLnRpUfLJgIBG9YTIyhEPrYSN1JYtMsJV8N1Dw041JQfneyWM4Dhju7PwRVZUu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b+zMQNGz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4d9f38478e0so9405521cf.1
        for <linux-api@vger.kernel.org>; Thu, 09 Oct 2025 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760011316; x=1760616116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GM7HHu3HbolbVRGEPyllWwUcu2/FcpmuCKiQlqwBpNU=;
        b=b+zMQNGzBJd1OaeJknxqIgA61IUUVrXkv8oIP3xZ2A0MdE1kUkFPP/N/0/QuUD4AJV
         N2naFEJj3vuVNfiVA9tpl7OH4gGf5eVN5FROd5V9mKU1OWYCFcuFVssSdauYOi6AUD/6
         WnMaklKCI1d7IS+RjHFdIpL6cgsbVVuZYf0mekI2EgeAPnUFh0kuUfSy61tIOE+4pa3i
         MV1oHs6F/pMl5Y8IkkBfyQXR0GRc6waWiZeDGSFpVeE8gLkKgYRBF6vgZfFF8SHims18
         DJzf5+VMrn7FWtL36gms+zIvDJUV4PXpXGcBx+ITMjtadkuovdUz3uFKpgyR33rvFcGv
         fCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760011316; x=1760616116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM7HHu3HbolbVRGEPyllWwUcu2/FcpmuCKiQlqwBpNU=;
        b=fiVvNVRw7SHNzxvWa7jvFnhzb/ZEWsPOl3979r9bqGvdqsWWbBCjaGFs2UBVGiarWv
         aGCV78yLD8lQTUEXcZ086sdW2+Vgd87H6jD8e8y9oSOX1hJlUmtPa7a5Tpr7NIgYa8qv
         CAn6rWqgtegxodjZBPx+6xgNx99dSeqTHNKJkIANldO4G9RtJZJ+uNy8skY8GunOyFV3
         5de3gdOuWJt7VRtfucQxrAxEJ/J+P9In5I0o1KtRDw0MCrLEOySFnWTWEDEiXKorTl1y
         snurIg383fTECKvF+LvSRjMPNgkF4jj8+1c/c0erQwh9KaI0TSTST/oOda2n57G3mJE+
         dTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMH1gqZow6pEL/Ls5BpxkWNemKI0lZ8GjnT2Dic+hEYwcPFIBZIPZtED/HbqEco05cWxALmnGmy60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmuztlMDBGusCqpJCrjo63Yrs86ibIYC5314aqGSrsT+hDOb1
	UFUnabsOTFH6Iv3/2bdfv7yVVs04phGaVo6VuReFBsuEzWIBGTMpd1KENDsB+WjRC/tVboVukyA
	aKFUxaf2eFJuyPuvsYzmDgFrtqeXNixvclvoKBWY0tw==
X-Gm-Gg: ASbGncv88P3rpk8HwD08H2UT5jZVLErX1ep78MMZN1wpMd865CVXe0o0mmUJwC9gPVo
	i2Yp4L7t/i+viJ2qJRrkST3M8bLSXmpR/jUQ/q3ATGi71oh1URw2gYZoWRW29Duivbxn1m4HylC
	gJbIpxZPnxzsGbMNR0UKp7+u8X0xo8GSHRxGq8DgmR8thNgbXWyQ1jUtx46IAK+bV5T9/QZYkWq
	ttOW3JuzHLxqQxJJewdbncILXHm
X-Google-Smtp-Source: AGHT+IE9zb3wwXEpUh5P+ZmZZJCDFFOKUQIOo3/6KsN55Cs1OSGbV39rZ1DIVG9kDY7HFP8FPvwlsRPNuhjvFarm0hU=
X-Received: by 2002:ac8:5d4d:0:b0:4d2:ba6f:28fa with SMTP id
 d75a77b69052e-4e6de8b5d39mr171303161cf.34.1760011310206; Thu, 09 Oct 2025
 05:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-20-pasha.tatashin@soleen.com> <a27f9f8f-dc03-441b-8aa7-7daeff6c82ae@linux.dev>
 <mafs0qzvcmje2.fsf@kernel.org>
In-Reply-To: <mafs0qzvcmje2.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 08:01:13 -0400
X-Gm-Features: AS18NWB0gqbxGnAmt0TyUGPWI9yXOeOjTQwVBIB2xaJy4b4dnuqgnZXYRRh26fc
Message-ID: <CA+CK2bCx=kTVORq9dRE2h3Z4QQ-ggxanY2tDPRy13_ARhc+TqA@mail.gmail.com>
Subject: Re: [PATCH v3 19/30] liveupdate: luo_sysfs: add sysfs state monitoring
To: Pratyush Yadav <pratyush@kernel.org>
Cc: "yanjun.zhu" <yanjun.zhu@linux.dev>, jasonmiu@google.com, graf@amazon.com, 
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

> > Because the window of kernel live update is short, it is difficult to statistics
> > how many times the kernel is live updated.
> >
> > Is it possible to add a variable to statistics the times that the kernel is live
> > updated?
>
> The kernel doesn't do the live update on its own. The process is driven
> and sequenced by userspace. So if you want to keep statistics, you
> should do it from your userspace (luod maybe?). I don't see any need for
> this in the kernel.
>

One use case I can think of is including information in kdump or the
backtrace warning/panic messages about how many times this machine has
been live-updated. In the past, I've seen bugs (related to memory
corruption) that occurred only after several kexecs, not on the first
one. With live updates, especially while the code is being stabilized,
I imagine we might have a similar situation. For that reason, it could
be useful to have a count in the dmesg logs showing how many times
this machine has been live-updated. While this information is also
available in userspace, it would be simpler for kernel developers
triaging these issues if everything were in one place.

Pasha


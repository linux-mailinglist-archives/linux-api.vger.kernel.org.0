Return-Path: <linux-api+bounces-4291-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E1FB1AB29
	for <lists+linux-api@lfdr.de>; Tue,  5 Aug 2025 01:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94709174096
	for <lists+linux-api@lfdr.de>; Mon,  4 Aug 2025 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFD328C5C1;
	Mon,  4 Aug 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AYlBj9Vi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAF221FA0
	for <linux-api@vger.kernel.org>; Mon,  4 Aug 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348480; cv=none; b=l501ExEsSF/bflDlB9LMVIFp+m65dRCfLl6saTV90a1sX+b7a8pDSVHJK7pyy9SMcBpIm7yIwX5PEYEdOnz3fJe//zaLfZ+8Ouz0JNUz0S/NFk+ZPqPodckZICDU3JGjdaRIvLQQmEi73Xec+bJG7idwoJ+K8xwZKHWpCY5uQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348480; c=relaxed/simple;
	bh=kh1Iqz0Yf5ok/S6yiGGNzHKbyS1kwiJn5rDTHcZSof0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOUfh6cCLANYKQiI9jzvnT3OYIlzlldMiQfUglxOKO/VCsAtczxkby115lfulgVNYaqAWjLfGWmXEjYewhr314LgroFqit7nTt+PV+ZktPdmWtDcWq1s34L9bVrE3Oq1d2H91W5j7M+dM2D14wYdSl/PXWhoXCgXaciyXlf7BB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AYlBj9Vi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4aeb2edce3dso33847841cf.2
        for <linux-api@vger.kernel.org>; Mon, 04 Aug 2025 16:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754348477; x=1754953277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gU7gICCtCiiOkKgytm+DZgh/C6t4tnk/oqWk65I1YqY=;
        b=AYlBj9Vi9oeeUhhAv7M5QYtp7yD49AbI2V4og/j1+jWMDyNGJYo7lda1IPfzY3cD90
         rTMlqqfgz3jszmO0x9rvF5ik6kwMO3NH5Pv93491kLWzzGoEw/KBqgysLIqgEXrMxUqT
         Ltm8yhBliuMaNAly/2dHYSjAGQjCJJvHwpW050fX3whlw1CEP05vA1b2nddYjrXK4aAr
         OWh49iDlEufQ3wSfa6dN4iu+DmtG/8ZOrXkwPCwXXVQzRoJWzi32+MO9NQXeJkEpKy4L
         +d+Ym6jGTy1WYAZTvJU3So0Uz+XA1JdFPaw8LuZ15O2bBax0WmrLBPcUG/JfBn6Ittl8
         AUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348477; x=1754953277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gU7gICCtCiiOkKgytm+DZgh/C6t4tnk/oqWk65I1YqY=;
        b=kbnrwwT0NOzD+NBt2kq7Ac/fa2knTrgwMNHcgCxn6qmugE6o9sBktIo4rnARhTjHAj
         zVyH4B0KJWlT7eHfmxGGpZAxG1IoN6waZyg3t0s2J/4c8OWOP3uiQFwJSJW5zJ6SWQUL
         qtenZ8JrxLzhjfMCY5ig/BKdePuWDvrdzPrns0r5ssBCCEsmaCPg1aDFMTW87bJXfBEB
         INLzoWDEnDQT1lRb3T2cncV4dQhhgYi1tENJmLPjKGePaiCv/W4KcLrwJGm4S1fR2IkE
         JPHtPKxBU9+L8Y0dqlTMvuYjCtd63GwPUL4ifPjqfVu9AgOMkB/ez1pGPYLazcVdXdV7
         gyEg==
X-Forwarded-Encrypted: i=1; AJvYcCXT6CD7kEmlQpDvsGVUnSO22/Ei0bSByxQD8z6KSR2TYlbTSs0bEAERn6AFWU97rWTwrehA9pi7QR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGx4jJ2ZsESSB6tVyT4PZH4btNzuxtzGPQtfA3yfE0m+LWIf8W
	XLir0z1Ah/t7YMkgc+FQFzEwvIIjVx50bANa1MGplWRyoDx5T79bsZF00MJQ5Gm89QLV7j/rxBW
	LtIZIXQ5e6X+hhmLVtWct6Pw3KIHeAOOr0fzWekeQKQ==
X-Gm-Gg: ASbGnctXRf1N3ZvfyCR2wQXE/DtYIzCyWkrNVO/2tz5k2V9EFCTa+2y1fVnUATg/3SM
	lcVa0KqYoBDxudzytszDDSXUqyrNw97Fyb4ZPNvxVoKD/E6k1gHZG40BdPmDOkdB7xBiCFnn0jL
	UxHqr50j70Qe4N2azw+PjWJe8+zPP5nCHCnroiYKdgLGvk2pILG0wmrDZ9agMjbN7DiwDZQAvT4
	u8C
X-Google-Smtp-Source: AGHT+IHe63ELG7HHSW4Jr0p22ejEnswLaJpBTfGBY8KrlhhHwCd1xtHK5nLfdWJ/GzdTJH5a222X5rXcjnstQZeQWOo=
X-Received: by 2002:ac8:57cf:0:b0:4af:c21:41b1 with SMTP id
 d75a77b69052e-4af10ad5bdbmr146282341cf.55.1754348476999; Mon, 04 Aug 2025
 16:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-15-pasha.tatashin@soleen.com> <20250729173318.GQ36037@nvidia.com>
In-Reply-To: <20250729173318.GQ36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 4 Aug 2025 23:00:39 +0000
X-Gm-Features: Ac12FXy6p3_gSOnGWR1VjKZIJjskzeugSY4VSrqKY12UE9gHpXQr70kL51Ej-YY
Message-ID: <CA+CK2bBEX6C6v63DrK-Fx2sE7fvLTZM=HX0y_j4aVDYcfrCXOg@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] liveupdate: luo_files: add infrastructure for FDs
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

> > +struct liveupdate_file_ops {
> > +     int (*prepare)(struct file *file, void *arg, u64 *data);
> > +     int (*freeze)(struct file *file, void *arg, u64 *data);
> > +     void (*cancel)(struct file *file, void *arg, u64 data);
> > +     void (*finish)(struct file *file, void *arg, u64 data, bool reclaimed);
> > +     int (*retrieve)(void *arg, u64 data, struct file **file);
> > +     bool (*can_preserve)(struct file *file, void *arg);
> > +};
>
> ops structures often have an owner = THIS_MODULE

Added here, and to subsystems.

>
> It wouldn't hurt to add it here too, and some appropriate module_get's
> though I didn't try to figure what happens if userspace races a module
> unload with other luo operations.

I added try_module_get()/module_put() to register/unregister functions.

> > +
> > +/**
> > + * struct liveupdate_file_handler - Represents a handler for a live-updatable
> > + * file type.
> > + * @ops:           Callback functions
> > + * @compatible:    The compatibility string (e.g., "memfd-v1", "vfiofd-v1")
> > + *                 that uniquely identifies the file type this handler supports.
> > + *                 This is matched against the compatible string associated with
> > + *                 individual &struct liveupdate_file instances.
> > + * @arg:           An opaque pointer to implementation-specific context data
> > + *                 associated with this file handler registration.
>
> Why? This is not the normal way, if you want context data then
> allocate a struct driver_liveupdate_file_handler and embed a normal
> struct liveupdate_file_handler inside it, then use container_of.

Good point. I removed arg, and added handler as an argument to the
callback functions.

> > +     fdt_for_each_subnode(file_node_offset, luo_file_fdt_in, 0) {
> > +             bool handler_found = false;
> > +             u64 token;
> > +
> > +             node_name = fdt_get_name(luo_file_fdt_in, file_node_offset,
> > +                                      NULL);
> > +             if (!node_name) {
> > +                     panic("FDT subnode at offset %d: Cannot get name\n",
> > +                           file_node_offset);
>
> I think this approach will raise lots of questions..
>
> I'd introduce a new function "luo_deserialize_failure" that does panic
> internally.
>
> Only called by places that are parsing the FDT & related but run into
> trouble that cannot be savely recovered from.

Agreed. I added a new macro in luo_internal.h:

 11 /*
 12  * Handles a deserialization failure: devices and memory is in
unpredictable
 13  * state.
 14  *
 15  * Continuing the boot process after a failure is dangerous
because it could
 16  * lead to leaks of private data.
 17  */
 18 #define luo_restore_fail(__fmt, ...) panic(__fmt, ##__VA_ARGS__)

And use it in places where we panic during deserialization.

Pasha


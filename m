Return-Path: <linux-api+bounces-5332-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F445C65B8C
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FA054E4E24
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C530C377;
	Mon, 17 Nov 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XQBhjdNm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87412E03EC
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404228; cv=none; b=d/yLebhfiS85PuTYWbx/bjiYAC8840042e4kFio6pIHBuaTeLJsxJoZbLzyrSnL/2LgyuCUM6rpORwRCXVtNRuJ0LXVbLNjURShL2WYKTNh95bOOM310Cb+CE+jR6OiH1rPAFFOayg112fKohBaf0LV+MNAq8o/89uGsQtJpVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404228; c=relaxed/simple;
	bh=XmGPnc3Nhnm1pE/IxNN2voQ/65Pq6bmkez9grZd7nic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfHxARf1+BMWfGDjZJao6JMf1Nz4NcD8hBK97CX8Sp/lbmGiXIt02a7GoY4rhStzOmFo5Xo+DTh+6obK3Kb+qSvugyzYisPvWfNerDzYj9BK2uV4539tymaapeVh4A1e/wjIUItl0Z2YpCgaJ/cDJlU5lxtjCUPlAkaupHQNUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XQBhjdNm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so7010145a12.0
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 10:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763404225; x=1764009025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo7Fpew4SCWgreWKkBa60zvQOZX9oGrQ6m1RkCiDUC0=;
        b=XQBhjdNm8mbkVN0tkxf1aaX9kmALdiA2V4APUS7DHQrvHclx6lcc8m7Et9wUGYcoKI
         7xvcriNTjyK4SOHajOKl9I+rQFutvt3f38qj9jcxe9wkcxmh1MwH6usB4A8ZCu9FaXFf
         /+Zu+vfKRIww2iioDFPLi8AlNVJ0JWKunRiUYUC8+EI4kS+jDsIoWeWs2MX8lo2sNlju
         c1GdqeCARWjYXtfoYmd+OkrBGdr30CcmwSSwKjbznkJnnG3d6FRRDvQuS6zh9z2Cpx0G
         o3hpo9e0hmPQK3Ah1hqPEbeFbLzfNPv1WxfNmD/E2lksTn31QuycufYZ/rhB7Cu1qzg+
         Sggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404225; x=1764009025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mo7Fpew4SCWgreWKkBa60zvQOZX9oGrQ6m1RkCiDUC0=;
        b=fbMnM7bgIEcEJgruGufNfklnDlM3Aa0Jtybpj2YO8EvysDo8qizbv5EcJiVKbg3vxm
         wO4FDtmB7D4lwcP8jV0LmXrIBBnxAXz30BzhI9SjYanxzRlGX3JI34eX9aMCwIJV74Ms
         gwsbV4AxWTJYtwA0//bA/EUZvmebJg7jZyI7gfxUsJQtSGff85m+2/2HW82bvlLW4MM2
         6s3IcGjRWmj9b11qmfhOSA4sQX+AfBfAahXvlr9Olnje//vLH2cD5shso+T/VFDl+LNs
         ZJ3mlrghdBAu1QkPMZ3XlFQpMNvlMmqU6EikW7GDdeqCwcm2Bh3nVWy5HLAc2cVlVcb3
         /MJw==
X-Forwarded-Encrypted: i=1; AJvYcCUcWq0ZtSIG53UPPoadj9UzJaqPyydEKQBcP9TH4DP7/uNNIVtSQqyuSQ6LmnULkJscoxHFkeTdK9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3XVDPCpysWBpw4etZUYOsk+PUtporVkSrMt26AJ4aSKO3HxU
	wmU9xZcBTCH/obXAvLCvB27UA1b4NYOGWa+SoG8c+6yLMg756gCQ+sCwRnwnTcaTY/DwS4CejTT
	AImty/srP14c/hfup6SCQ4PjBpUvQgKeoMk/DcxtHvQ==
X-Gm-Gg: ASbGnctqnp6WcyJdg8hTxQ/pjla2XtSKQcOkotH6lVp9Q19nviyjYytGRBwlcA0o6Mp
	vM/jz4YaWMvuWzMIUZL+iM9eLcIkLu5kt9HJMH2PT5VLM18cwf2bdML2btJOlKzWiHAKsxuvSfp
	C5mbysAoU91SZNcdqVvWxYaAbQBmad64aL+D21YBL48fg2KXCgnybbJEokZNJ6Rr9/+WliFQbyt
	ZPiFbecKr2x7G2R4eAvu3MjEsdVyITbiCWVQruyfu4947OSzcsb8crp3P1z+4Z19PsY
X-Google-Smtp-Source: AGHT+IGbft8Z+rAKPet8Z4NE8LDyUX4MgwKnPbmIzDODsbkkevdfT0+fNvskHAAOPS9NtBXhUCGNpo/Yz/tzbQHQBNw=
X-Received: by 2002:a05:6402:27c8:b0:641:8b4d:cc6f with SMTP id
 4fb4d7f45d1cf-64350e899b0mr11672843a12.23.1763404225103; Mon, 17 Nov 2025
 10:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-3-pasha.tatashin@soleen.com> <aRnG8wDSSAtkEI_z@kernel.org>
 <CA+CK2bDu2FdzyotSwBpGwQtiisv=3f6gC7DzOpebPCxmmpwMYw@mail.gmail.com> <aRoi-Pb8jnjaZp0X@kernel.org>
In-Reply-To: <aRoi-Pb8jnjaZp0X@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:29:47 -0500
X-Gm-Features: AWmQ_bmhhbDUMBKFxNnFMOPCeOApSAwekkwuL9HuN6ynW1cSRitKeGbWllXoez0
Message-ID: <CA+CK2bBEs2nr0TmsaV18S-xJTULkobYgv0sU9=RCdReiS0CbPQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
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
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 2:16=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sun, Nov 16, 2025 at 09:55:30AM -0500, Pasha Tatashin wrote:
> > On Sun, Nov 16, 2025 at 7:43=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > > +static int __init liveupdate_early_init(void)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     err =3D luo_early_startup();
> > > > +     if (err) {
> > > > +             pr_err("The incoming tree failed to initialize proper=
ly [%pe], disabling live update\n",
> > > > +                    ERR_PTR(err));
> > >
> > > How do we report this to the userspace?
> > > I think the decision what to do in this case belongs there. Even if i=
t's
> > > down to choosing between plain kexec and full reboot, it's still a po=
licy
> > > that should be implemented in userspace.
> >
> > I agree that policy belongs in userspace, and that is how we designed
> > it. In this specific failure case (ABI mismatch or corrupt FDT), the
> > preserved state is unrecoverable by the kernel. We cannot parse the
> > incoming data, so we cannot offer it to userspace.
> >
> > We report this state by not registering the /dev/liveupdate device.
> > When the userspace agent attempts to initialize, it receives ENOENT.
> > At that point, the agent exercises its policy:
> >
> > - Check dmesg for the specific error and report the failure to the
> > fleet control plane.
>
> Hmm, this is not nice. I think we still should register /dev/liveupdate a=
nd
> let userspace discover this error via /dev/liveupdate ABIs.

Not registering the device is the correct approach here for two reasons:

1. This follows the standard Linux driver pattern. If a driver fails
to initialize its underlying resources (hardware, firmware, or in this
case, the incoming FDT), it does not register a character device.
2. Registering a "zombie" device that exists solely to return errors
adds significant complexity. We would need to introduce a specific
"broken" state to the state machine and add checks to IOCTLs to reject
commands with a specific error code.

Pasha


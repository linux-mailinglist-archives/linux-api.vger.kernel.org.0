Return-Path: <linux-api+bounces-5331-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB1C65B47
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16FAA346F53
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584430AD00;
	Mon, 17 Nov 2025 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JeQjlk53"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD899277007
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403946; cv=none; b=Fmb7/xBqtzFuHWuYP4yb8xFfNNKDRbsGwHZVH7XIoxO1js8FSerGT1JEOsdoJR1fY+hdaLhZzULj+kVhh71INjlLHvUW48CMmLH37BMErz7B8Z22W0aw/ml7++eN8Q5oQ5kRY/UfHPFsKAhRyYmRfJse63LZp03WyZOh7o9mKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403946; c=relaxed/simple;
	bh=dMycsWk6alcimZ9cye+sIiGHVio6V3dIKHH3BxJbFzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7+nFxKo1jpDKig/fig8JPITXYDILQVauhuaAMGLXho9meB4VGXTXvb8BmXHPUlFR3XzleVwJKs7CWwg9O8qoFvgIsJ1BOsR+jsBp0PpMS414k+WiNSlunaXfg3EKNFD3AgP/Fjtuu4xJCQFnas3ecEOIRrESTZW+HwVVqsywNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=JeQjlk53; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so8009013a12.1
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763403943; x=1764008743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMycsWk6alcimZ9cye+sIiGHVio6V3dIKHH3BxJbFzo=;
        b=JeQjlk53pq2zJjWMlm1xSgj7kGKmc5aUKot2CX4cKkELU/EEVPJhKR2EBqlXCae62H
         Q5OQMucd7llOJItyTh7wjKn0xn8Tv2/pdb29l8JqeniatA7lqmQnlsy+9Lz9fJefWIZj
         ohRtOO6qC3C4yDxmZhxEe08vq72Nn6/XiuXWrA0kn4yLxeDr3n9rTyJIk1cA/293oWSR
         rHO/wdIcRZmkbETgJN9MFNeqyPNL1R14An0FPBEMK+Y9mltcU+XiExEGWiYZ+SoWYSE8
         cNWVCvJ+3bZmtZe8hl+3lvFp1IdqEBr2BY2Jbg4K5jwzT+ESwa1Luzu0v4eyPLDOvHZi
         v4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403943; x=1764008743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMycsWk6alcimZ9cye+sIiGHVio6V3dIKHH3BxJbFzo=;
        b=UYVb8yXi+PfIfcdfRet+8aAvOqCWdwiBsZzdqrYs7KF79mmMxZD8F4qRe6M1dIP5Pt
         pub/5jvL9MtC4v03DGrAKN3uq2BWneWBLgCYOlFX3U/4aEn6NeLd8NiSYAD5bxnOp8MO
         3aOe6aUXG2QbrYpDT7C/PIdJFIvzh6UVCGrB04sKFdQ0NGlJe8QL/q1Li7lLti1/TgK7
         9w5Lwp+FDgNCaLeCnFSPfTTHU2HSAjBqmwU3u6wRcZVZ2Qy/xXdZm0Pear7GgVQUeuP0
         V4H9Tg4lmRaVfdH8n7eVgqo3VIVmDDcatFIHqnb7s+dUT2wo+qvsSbpHxs18w4ywaM12
         +rcw==
X-Forwarded-Encrypted: i=1; AJvYcCVy6ZFMqBZsESy1IcWBtemhzfLWdfyjXaRTNm0HSg7j/cX3QuguGBo+1oTn/g58K/FF4mOsufbyQ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XQc/V8igg72CA0mVYHU/G8b4pUTMZq0upppHnBFrTEdUj17i
	vwFQhZCippWA9XSLjTG9C/SeL5McAxFfuYrKlrag7UZ+Dl1ORLTHuNBT0QpUbVtuN4m32pQ64DD
	T74LiGII1kTTvfNqgyCiTovANQf8SLIQY5tthsujvug==
X-Gm-Gg: ASbGncvF3Q5hqp+EiaU2QBmrUmUHJ5B89jgPXGg5AvAGJI1DPeZ5Kn0OwU3qvRu7XTl
	oOzxyxBys0hAMMOHt2xByVCuxjmTWM/dK8R8F74j5UbYkyyNJWd8WpynQZePbH+LtMgQM+pZAFl
	HeIH8KIMNjbTk/nfiSxzpVrZ7JVEtjrnOWgWKCuJo5NUQHwa91++lyOdcTF6cF8iQf9G+uIzC5M
	QnbanKJv5iDp49/RaGaGXclk7fZ4M88yrKVRE9viA7pgfH2/aPGd6qZsAAqiQwU7ge6YMYe0mrn
	mJw=
X-Google-Smtp-Source: AGHT+IFhDEducLN7T5Jy1DwFvPprFdHcnJ42WfejgEYNti2gLXiHYmpyBjQ/4t56trSFuAgRCxac7v4hY1mMU4Ka3uY=
X-Received: by 2002:a05:6402:23cc:b0:640:b497:bf77 with SMTP id
 4fb4d7f45d1cf-64350e9eb61mr11509176a12.35.1763403943114; Mon, 17 Nov 2025
 10:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-12-pasha.tatashin@soleen.com> <aRrvaHh-cP8jygAF@kernel.org>
In-Reply-To: <aRrvaHh-cP8jygAF@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:25:05 -0500
X-Gm-Features: AWmQ_blTQifSbVFjHBESf3b3IYzXXqzrvc6uwjRPXvt2KinsJtxmdBdOtqW5SFc
Message-ID: <CA+CK2bD_a=C0h-y4HDWPYV1VOWjM7V4gcocwekA6M9h5WbiqSg@mail.gmail.com>
Subject: Re: [PATCH v6 11/20] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
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

On Mon, Nov 17, 2025 at 4:48=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:57PM -0500, Pasha Tatashin wrote:
> > From: Pratyush Yadav <ptyadav@amazon.de>
> >
> > shmem_inode_info::flags can have the VM flags VM_NORESERVE and
> > VM_LOCKED. These are used to suppress pre-accounting or to lock the
> > pages in the inode respectively. Using the VM flags directly makes it
> > difficult to add shmem-specific flags that are unrelated to VM behavior
> > since one would need to find a VM flag not used by shmem and re-purpose
> > it.
> >
> > Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
> > information, but their bits are independent of the VM flags. Callers ca=
n
> > still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed t=
o
> > the shmem-specific flag internally.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you.

Pasha


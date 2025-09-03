Return-Path: <linux-api+bounces-4696-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD3B41E7B
	for <lists+linux-api@lfdr.de>; Wed,  3 Sep 2025 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6655E16AC56
	for <lists+linux-api@lfdr.de>; Wed,  3 Sep 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC88284896;
	Wed,  3 Sep 2025 12:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBJeWvHs"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181527FD49
	for <linux-api@vger.kernel.org>; Wed,  3 Sep 2025 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901402; cv=none; b=tx0Fl2HmVMgsuq10MeRhm8NKPhCkOMv0lOwXMHhf2qh0cUyl2e+0BAZxIt7ExygDQaU5dU7Tfh3th9I3Q+WzYMW3pq3FHK97bVk9Xr8/BOTr9paDu5gv8Cc5quXYgSJ4wbPtqqjYGkOd+LSps23ZzOQ6tuDqdBl1qvPQQX7wEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901402; c=relaxed/simple;
	bh=iwrjIC284r+BvpqNgaW4aGVZ0TU6ehHshdglAmcMta4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIIaIcnjrc6nqBLCxb1wbd2N5BdLeoLGkiFneBIT2PENhV7oH4UCmngXrAmCFhRYgVbf/AiMYBSqk5uvgwnBBoeD1Df5IauGsTPH7tpJvgYgKDZaQWvqyWHiiALK3ulkhibWODX4uWnCz23K3D6AitKjus5+lBsxjssXqPV5q9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBJeWvHs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756901399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DMEP0xOMWgNdu9dERfEeNH9Yxp8yE6lRyF3eTYROdsQ=;
	b=eBJeWvHs08HHYmYCtFLnFXRGynYwtfXNQ7BoOpg07tU2BsL8Jf4VGNWCYhZOpVanSM8quj
	2Bc1oxGJ80PaW3/OMXwyJ2R2yjnHakMpugeGcFQwtfF4xVjWLcctZ92geOPxxCfukosH5d
	sojcDcfhNbAjjJjLVflgkNxBWYAnzV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-eH2Obmb3Pm6Smyu7mx3FsQ-1; Wed, 03 Sep 2025 08:09:58 -0400
X-MC-Unique: eH2Obmb3Pm6Smyu7mx3FsQ-1
X-Mimecast-MFC-AGG-ID: eH2Obmb3Pm6Smyu7mx3FsQ_1756901397
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9c1b74e1so9232365e9.1
        for <linux-api@vger.kernel.org>; Wed, 03 Sep 2025 05:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901397; x=1757506197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMEP0xOMWgNdu9dERfEeNH9Yxp8yE6lRyF3eTYROdsQ=;
        b=KA9W78tmWiUvTqi373QIoW8pmOj/TlFkDeIrGmsrVSLp1DtU2i7tqrgoS1mEpGqRwG
         I61BEIhFl8GyFxS8LRRxBMpCmYftxQoBlPQ7ALExPXpxvnCUzkMcoxRK7mLJL8YKSFKi
         2btfmUlowQnUQJOpqyxAMCp0DsWRy7oaB6UEIG1SaTeLz11+Q03ToNHh25MXsz+oslFH
         F+l80xWvmAd0X19c+mXT+fqc5TimyY2hgcvPxAHhneCAA2QE3ZoyUMzALRxIDRHujiWd
         5Z5n9w36iL9sSZ/jdJs1HoKcyX/0hEnbEb1iXYeQrwEhfoqLUxHsFj/CjgUmwXv18ool
         iWlg==
X-Forwarded-Encrypted: i=1; AJvYcCV598dpEDPHlK5YNCOKmiTS/VKxBaYx6g6X4KuVp6VxGW0ldf7XPQzfMDDiMglPX+qV51Pyoqo+ruQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqPS1a5KOsyG2yyPUOH8Uya0+ILbjXlSDACEAqSt6bch9YDGi
	qWy3cVCZvlDa5jbvJwfnQq6iz1B1a/2DY3AsEoYqZ9SurNJeHib0AAthjNG+MPG94Um+90m7DQ3
	7XP2/WxX9rsMTN/5Rr2qqwPKORN+bW+xAavFuN0juHRdMU6I2KbYSHkwM9guajKLjzgiAj4K5d4
	yza6Ri9osAmB0TNSSz4hNDoi3uN6lycrAgBxK2
X-Gm-Gg: ASbGnct9DtbwOkvbz3ISz8nvDfAABT7vZPklxr7k/659RVWGMNd13CkbjBzsF4DPTgL
	s5f/XYwjashVzSfMFSYZvauo7ClGlITvSfF//MxyYqQjiXWD7qvTr5C9iHqiCeESURynDzd/5TA
	NN3U2gbj8KLpK8vaxm/j+2zA==
X-Received: by 2002:a05:6000:1884:b0:3d8:7c6e:8ad4 with SMTP id ffacd0b85a97d-3d87c6e9003mr7827057f8f.10.1756901397267;
        Wed, 03 Sep 2025 05:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7eol6V4DQSyhx5O1kwyFs5bBKV9xnd8AnWXLRZYC/lRdauVniCV+d4Ut9AnzQLHv7Q3b6Plpn3szdRzQ6GHg=
X-Received: by 2002:a05:6000:1884:b0:3d8:7c6e:8ad4 with SMTP id
 ffacd0b85a97d-3d87c6e9003mr7827039f8f.10.1756901396892; Wed, 03 Sep 2025
 05:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org> <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu> <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu> <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu> <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu> <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu> <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
 <CAJgzZooK+w7NTjsFV_0c=SmPSnsSMiWXFgnvcw=w3msj7NBY9A@mail.gmail.com>
In-Reply-To: <CAJgzZooK+w7NTjsFV_0c=SmPSnsSMiWXFgnvcw=w3msj7NBY9A@mail.gmail.com>
From: Arjun Shankar <arjun@redhat.com>
Date: Wed, 3 Sep 2025 14:09:45 +0200
X-Gm-Features: Ac12FXy-BTAZHXYHAnfo48HkVW6NRx3Q2A9Aae38LsVDhTLR5jG7SobAROuAdhw
Message-ID: <CAG_osabF4nynNNFc=CP_ZFqZ_iJr47VXTJpsN75CzX+Pi+CgEQ@mail.gmail.com>
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: enh <enh@google.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, Aleksa Sarai <cyphar@cyphar.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

> > Earlier on in this thread, Aleksa mentioned sched_setattr as
> > establishing precedent for the kernel modifying non-const objects. It
> > looks like glibc actually does provide a sched_setattr wrapper since
> > 2.41. The relevant argument hasn't been marked as const and the kernel
> > does modify the contents, and glibc's syscall wrapper simply passes it
> > through. So we already do this.
>
> given that
>
> SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>                                unsigned int, flags)
>
> calls sched_setattr(), which is defined thus:
>
> int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
> {
>         return __sched_setscheduler(p, attr, true, true);
> }
>
> i think that's just a copy & paste mistake in the kernel -- carefully
> preserved in glibc and bionic -- no?
>
> (i only see the kernel updating its own _copy_ of the passed-in struct.)

Based on my understanding, it all happens before the call to the const
marked sched_setattr. Starting from line 986 (as of today) on the same
syscalls.c file [1]:

        retval = sched_copy_attr(uattr, &attr);
        if (retval)
                return retval;

Which inside sched_copy_attr does:

        ret = copy_struct_from_user(attr, sizeof(*attr), uattr, size);
        if (ret) {
                if (ret == -E2BIG)
                        goto err_size;

And that leads to:

err_size:
        put_user(sizeof(*attr), &uattr->size);
        return -E2BIG;

Which writes to userspace.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/syscalls.c?id=e6b9dce0aeeb91dfc0974ab87f02454e24566182#n986

-- 
Arjun Shankar
he/him/his



Return-Path: <linux-api+bounces-4668-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1388B3F27D
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 04:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304EE189E5DF
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D432DECB4;
	Tue,  2 Sep 2025 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuZZbosD"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B72DECA7
	for <linux-api@vger.kernel.org>; Tue,  2 Sep 2025 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780910; cv=none; b=Mk/igwNRBI9b21aVAToJN0efIDyFJ57uAhoWPuNsGFcmyN5V3Llmmswxn6lutmY0u/ed5jdflS/XftOv2c9RSe18bgtA8AEa9nhungt1cy0F8q9JRJTRd8YX69AmWFrcxvGrGaXd+WVKmO/crDM6Okbe6mLwW+0szNssx1ByuVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780910; c=relaxed/simple;
	bh=JaHhtfzc7rg7wnZRlgZklrE06wWmQLrXQh+byJOtdco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REAT0XD4/vU3IuHPHfMo5My+d6ZuHOFFSgWFPASXnreCIK+El7kSZQ88QU9IcYdcgRLvEaHr8kPtN8AwpYxdD5DwnA+ZuC4WpGwWFRPdFBt+r1V0gG4mCQRCS/RMJNNDcWgrOwxqMOP1vX1PF0Eauh/aSuSSG1ynnZdq6asfWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuZZbosD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756780907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JaHhtfzc7rg7wnZRlgZklrE06wWmQLrXQh+byJOtdco=;
	b=cuZZbosDxEzRpiFERmx41Zmg//Lg68E565K5l2f1g77kgi1I91rvA3KwY2EG7/fChip8ZJ
	+EVZku1Oz/gtpQoZCOaiCp6L3wjNXYrxGwmq4q+O30HZnluqG0WZe6o+JO90CNEK8M0WB6
	T4q7VBUVk6EKOeCw55f+loqpnYNJqjU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-9z5QBMtmOvm4PsXcESo-PA-1; Mon, 01 Sep 2025 22:41:45 -0400
X-MC-Unique: 9z5QBMtmOvm4PsXcESo-PA-1
X-Mimecast-MFC-AGG-ID: 9z5QBMtmOvm4PsXcESo-PA_1756780904
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3d17731acb6so2545398f8f.3
        for <linux-api@vger.kernel.org>; Mon, 01 Sep 2025 19:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780904; x=1757385704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaHhtfzc7rg7wnZRlgZklrE06wWmQLrXQh+byJOtdco=;
        b=TPEnWU7Imj2ENAh6d/hx0easazczHOiHF3rlu8u8suyTvbxX338v/RXjA0Pkes179J
         +OBoV08IC9sadqr9SjMuxH/xU4JPiNENC5wOnHtBgaKn+US+k5zBGBatSm1QPQdJFkCC
         mMwnXkFkSAIo60X/uDO633j56aBdGyvtH6WIZKf3xTBRGk6yiiRW+Dm/8KfhvqqhU+ob
         ZfDlnxWI76BnREgYHIl/wfU3CI5PQW3Axix63VAhKltqrCF2faJ7k/u0WaXGahA4XWfJ
         8MZM8d/eKmDuf/uuOOPiIlNw+bjmn7YjbS7g5NKQKA3ishpb5eSzSC2P9jzdcdX7bCut
         hR2A==
X-Forwarded-Encrypted: i=1; AJvYcCWg/Pn1O++MeFiBPhhePYX8wReY0sBIT4LJ49xF6xso8/A5BrEfliJsIJkVCcfRiQRhELI8fH1YKsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoTdN+lUZWCE2u9yOWee+c8z09crTd17+zpFvZy6FesPU0wcp
	w4VB6ncivb2W4omNRwj5doHi0wO6Dg9uOUdTbdGEHQDeDnj6ztBS/jZ66iZvRGdgdSDlx4a27mm
	XPXuf9qOGRHmgMmjj4+FTHJbgGDR1+O0iyuWG8npoxYHeyCt7tFrR+ajZsPb0AFvyr47Xhox6jr
	W1u0D2SKeqMbGE1GE2JardXHjbKRWGYxPwuJ/C
X-Gm-Gg: ASbGncv+A6krje/0Ld5zz9B7eLjwmef3whOXtDxAP6hVVmZfLf01ouzcI0ad0RIfMSr
	0y7eFZuvduGPAG7vzWP1dGuRUW1BX16uX6/nEhrvsHWhuT8IGF8EsVeJqyzZLJ0Bbs7ZYx+goU/
	NZ0bHgNm18CesrdHjyDNZ7zA==
X-Received: by 2002:a05:6000:2908:b0:3ce:d43c:673c with SMTP id ffacd0b85a97d-3d1e03bffc3mr8091262f8f.46.1756780904132;
        Mon, 01 Sep 2025 19:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENb1kY2XQ8mBQa0J7/ig1nVAt9yukczIBflFZuDPJFDw7c0uMbgFvrppwdCgeyTJdaek0AJ8R6vYgcDz4/HpU=
X-Received: by 2002:a05:6000:2908:b0:3ce:d43c:673c with SMTP id
 ffacd0b85a97d-3d1e03bffc3mr8091255f8f.46.1756780903778; Mon, 01 Sep 2025
 19:41:43 -0700 (PDT)
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
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
In-Reply-To: <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
From: Arjun Shankar <arjun@redhat.com>
Date: Tue, 2 Sep 2025 04:41:32 +0200
X-Gm-Features: Ac12FXzLaThOFh0KE6jFNHb2EeCxt5uCy8iEP5YlTDaLumDdcuqUnP4aPaTeQjI
Message-ID: <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

> On 2025-08-28 01:42, Aleksa Sarai wrote:
> >> I still fail to understand how a hypothetical "give me the supported flags"
> >> openat2 flag would be useful enough to justify complicating the openat2 API
> >> today.
> > My only concern is that it would break recompiles if/when we change it
> > back.
>
> OK, but from what I can see there's no identified possibility that
> openat2 will modify the objects its arguments point to, just as there's
> no identified possibility that plain openat will do so (in a
> hypothetical extension to remove unnecessary slashes from its filename
> argument, say).

While it is true that openat cannot be extended in this way, for
openat2 (whether or not it eventually materializes in Linux) there
already is the RFC patch series proposing CHECK_FIELDS that Aleksa
referred to earlier. And it's not just that: it has been mentioned as
a potential future direction even when the openat2 syscall was
implemented [1]. I think we should interpret this to mean that there
is indeed a possibility for openat2.

> In that case it's pretty clear that glibc should mark the open_how
> argument as pointer-to-const, just as glibc already marks the filename
> argument.

Unless the kernel marks open_how as const, glibc marking it as const
can lead to additional maintenance complications down the line: in the
future if the kernel starts modifying open_how, glibc's openat2
wrapper will no longer align with the kernel's behavior. At that
point, glibc will either need to discard the const (which will cause
any existing users of the wrapper to fail to recompile), or glibc will
need to handle the kernel's new behavior in the wrapper (which will
lead to further divergence from the behavior of the syscall that we
would claim to wrap). Neither of these seems problem-free. On the
other hand, following the kernel's declaration will mean that should
the kernel choose to mark it const, we can easily follow suit in glibc
without breaking recompiles.

Earlier on in this thread, Aleksa mentioned sched_setattr as
establishing precedent for the kernel modifying non-const objects. It
looks like glibc actually does provide a sched_setattr wrapper since
2.41. The relevant argument hasn't been marked as const and the kernel
does modify the contents, and glibc's syscall wrapper simply passes it
through. So we already do this.

Based on all this, I feel that leaving open_how as-is is the easier
and more maintenance-friendly choice for the syscall wrapper.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fddb5d430ad9fa91b49b1d34d0202ffe2fa0e179

--
Arjun Shankar
he/him/his



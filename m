Return-Path: <linux-api+bounces-5326-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF6BC64A4F
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70F874E4952
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14954334698;
	Mon, 17 Nov 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gH3qohYX"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D1334363
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389719; cv=none; b=byToH+5DQfsOPeResGjn4jITOL4ZtcEoxlofxzrkvdtyoPO2TMkfGx4SBnlBSJUYPB9panMzHuHnlJ8ax8XBqbaLc3GEhotfKNzVCRDHyjcwCz3A80pdalkXA0XnanCP/2Q72YNTSgzqmF8t62be5Tr5BYPM1YHTZ+Uq6+hMAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389719; c=relaxed/simple;
	bh=AMc2ILHILGpbxf7Iwmbtxzu0IeHwgu3vwmxmrbvehR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+5U/D2i70/UTISiRt44k2596KfsFkiJ9uQ0pEc/EhZgxqtF5TLABWsN7fx+xuZYnDGHPV9iv9hKJpBCAUgZVgjpDmrSrz4ZllcGcAuWdPlCikts3gAn0xK82kJFtQB+dAhTWjZP6I0zPTXeYBbcmsJVuwekdulMANzcFkk7lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gH3qohYX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735b7326e5so607671466b.0
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 06:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763389715; x=1763994515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQVCE/CnnGowlKqCGL6JwWMjWGkEt4E9DF7myhq90M4=;
        b=gH3qohYXE4nIIduaKocyNkDSMBKDGdCkktTQvcw+xHdSUGksf9O7S6XGkyMEf//xAB
         LkPUhK/ky2QYWCafHzVuZLZYaon1B8+4IU1W9seqiT7X7R464Zi4DvgOPG3ecY32FOsi
         w3gRvFA/PckwXM9JpIcfbqczID4xkFKuqcof3B+AhvL+C26n3/7QoyAGES38XpC7v7Kv
         gbGll5xibpqLtE2Zl+AesQ5CvBkeV0O4QYLuopFE5ubp1eB4K4e4Lh6xs1b1v7w52nms
         4PJKoa64UiLvDSBLCYwqLMG6Z0uje3G/3gGLfJv7V4PaexZcTo5WxKmgVreCecrFc1EK
         /Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389715; x=1763994515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQVCE/CnnGowlKqCGL6JwWMjWGkEt4E9DF7myhq90M4=;
        b=rrEpRQFRctTdQ31LY3HdhoPvr4G41Co2Sxnw6bF/8hj+wTrP16zobmS1t43Rg+19sS
         52FC5v/c+k4wgOwkW+LswWOUIc8vyWL0I1GcH5PwVLzriOoaW1RjjVR30VhJdSCDQ3PF
         GwFe3O7vahdFLmU4UB0cITORGULmznZ/HOTna5C2rhgiPMZLcowyQ9juSnAfDh0zOmD4
         sFqnn13eTiTvgLz6pFhUvYZpGwm+7Vfwxdig6CRNh9yVdlD/34J1CmFB5VNODT3oJ9Sd
         G1BxTeK2nGHjnucgUlZWtWyGhRZN+B8o0lOLGJLR9iiESRfWXa3wYSbgkv1LQU/N9DBj
         TSMg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgEIMjAZxifPx/9wIukmgdunobiCKgL+khQfo4RJGQ6fo9f9rumZfrPEXyO91awdbNp4s30XXhW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eGq21GcjjcxmFgnPxPkIv2pEO9VWoqYZxGH9ZMDCzRPtUxMR
	yjVnWKm4W2omF+HWhHSfI5gtd8aA2p3zFm1d9MEx2bo0l5ylL3Ft+n89amxbypxmXBRduBxtoR7
	G9FgPz4UE4sNZ1EptP+nw97TU7b24lxJ3CXDlnRm7pA==
X-Gm-Gg: ASbGnctgOVh+FCIbDLKb3QgXe2nzB/092wGr7BaNUV1jo/Uma/SDIrRvv+5/8CuC14I
	XsHlDEuhoMSCDQe6N/BMGOVFGtDbmupDxLKuj05EKSNzfbKnTdNnQ0aA7Vs6f+XpgFxloVJ1W6E
	CZ0kycE8e0xHFSK1MhJRVrky57mYPqDVXTpETfzpYX66ijZJ6oAOfghqqKziQcncEWTmr9/+jo5
	0VyKRTzxhO6L5ugI48JcuWa/m0Hcs4Qu5SMJOY06QcbViubnPFO3ZdeJg==
X-Google-Smtp-Source: AGHT+IHFe/sTuuiJ+53/94QiMySpnxf4UN/E970XTSsHg+BmNQprmENpJq+u5KG4abgGaMQyqcrDGuE+yfqH+ShvDHg=
X-Received: by 2002:a17:906:fe4d:b0:b72:7e7c:e848 with SMTP id
 a640c23a62f3a-b7348570745mr849235566b.17.1763389715484; Mon, 17 Nov 2025
 06:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-2-pasha.tatashin@soleen.com> <20251116185406.0fb85a3c52c16c91af1a0c80@linux-foundation.org>
In-Reply-To: <20251116185406.0fb85a3c52c16c91af1a0c80@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 09:27:58 -0500
X-Gm-Features: AWmQ_blpOVxmRUODWBmJWtPPz2QzcGqIJZJTFHJU9AtpYTtzUk5ADMkO-uE2GJ4
Message-ID: <CA+CK2bAKm_Mb0Tp3Q5X=B0ngYrrfiT_pQ5P+c0=YVCXymxkqXw@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
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

On Sun, Nov 16, 2025 at 9:54=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 15 Nov 2025 18:33:47 -0500 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > Introduce LUO, a mechanism intended to facilitate kernel updates while
> > keeping designated devices operational across the transition (e.g., via
> > kexec).
>
> Thanks, I updated mm.git's mm-unstable branch to this version.  I
> expect at least one more version as a result of feedback for this v6.

Thank you Andrew! I plan to address all comments and send a v7 in
about a week. The comments/changes so far are minor, so I hope to land
this during the next merging window

>
> I wasn't able to reproduce Stephen's build error
> (https://lkml.kernel.org/r/20251117093614.1490d048@canb.auug.org.au)
> with this series.

That build error was fixed with the KHO fix-up patch back on Friday.

>


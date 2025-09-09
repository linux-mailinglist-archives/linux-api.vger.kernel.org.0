Return-Path: <linux-api+bounces-4737-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931FB50289
	for <lists+linux-api@lfdr.de>; Tue,  9 Sep 2025 18:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF6B7A4B57
	for <lists+linux-api@lfdr.de>; Tue,  9 Sep 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D20352FE1;
	Tue,  9 Sep 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BdLdyYHA"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307D350D52
	for <linux-api@vger.kernel.org>; Tue,  9 Sep 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435185; cv=none; b=Dl60HULT6OVn/7UzmEkCk4zKfJmhN1UspzJ+GG6NdHYZ+RFN8H98Fe4LSCZHuP8PY2QWzeISFzBjf8+2uesZIa0c5CgG5Y3jYkeGbTZKb1y6sLz9WvQki6+W431G++k1iRl3VcqDtEZKTNRcN6dq1XlJv0TwWHFlYpHsAJLS0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435185; c=relaxed/simple;
	bh=h2KtKkiK1ZCeC0eEimsTpCD94S5mFdW9SnYokRVzfec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=symeOgamNeowORFHM24Nbrlpx3OOkXTCNgz5DivQWSkrX0wfb1dbjklofDXf3uhdltNeMQ5S/Nf6YHaGkCPIWodf+/Am85hSZC/bR5hzSCE71U+NThOt+EyyZfH7vQa0KxDZvhLYRTfyQZUFCpN513PhLu69OLWjI6dsYuwE3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BdLdyYHA; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5f6ae99c3so33715431cf.1
        for <linux-api@vger.kernel.org>; Tue, 09 Sep 2025 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1757435183; x=1758039983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h2KtKkiK1ZCeC0eEimsTpCD94S5mFdW9SnYokRVzfec=;
        b=BdLdyYHADmRJ2+AK2JUSjb2Yncx+jUlUGLk/7BrWoD84OlSePTFdOprSrm7rFMPKs7
         QiGbjoQYkmeFFKZwuSQLkh/QBUMLX6I8JHop51Ma/Ok+BuzEuNBymtniRbgpvzDnu7Zf
         wPu308SN7o/UoQvs/5lMfjDjphAlQuLrlq7R4M+nC2Z/mGD1XUtuM+pSWQPOQZley0Cq
         UJFf9Au4KQuzM/TX+4SQQ8UklnMsvXByMLq5W+LlKuA293rQwc5crJFFuwZoRt4c78Mi
         4YcdCQWCEZhN3Ocu224USX1CzVyznNI/iBwq6u2sBGNhCf460ANfh8uFV1FfkTyCcUlF
         tqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435183; x=1758039983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2KtKkiK1ZCeC0eEimsTpCD94S5mFdW9SnYokRVzfec=;
        b=fh6KG1907DeDn3JgUwLvtPTH4j4JUpeCP6WDC8CWCdMrTtmrMHUZR6Us3L2iBrWcjJ
         /Qu2AabdVug0FdEOCX3FE4JaC/DdgelQntJCzxalaVWa9vPC8G77Y461RVi2e+r9iOQg
         SkjR5hCw9I9mCTH0ReYvC8VOzmLCjLYldPsa7OkmchjqoIuZMdYu/cWHqUGh4pmEKbQK
         eUpl2LNT8oUXwIXoQvUZdQh3lKLj+DnVbSjLubA+ZAZ8DjD0qUwh2z8E4LISbLSmsQJg
         XU1GLmsar5eYzG+TQXD19lXhjP4ZYvccjS/bwH6k3VI5dTqnc00xOujacBX/A0p1ZCuR
         FZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnDjaHxeh3dcNavnUndbS0b111QO0kWCXf75iQ2MNAuv5fO+QXTCplvlqFGDehLnv2EnDDQUlyjis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymj6ouSle1tBqIggWNXbkC0DzyeXvbl01h5Rp5Z2lxdxEX7dI7
	MzJfFMiBi+gIr+h1oEHZ0xjP3QLXc6qOwoJ9/6M8wP3iJBin0sqQEUC/LQPv8j0mWluVgRWa9G3
	rPyCEepcbbKnVU4z4Crfh3CAUukoxAy3AQwxsc5g8Ww==
X-Gm-Gg: ASbGncsymGYfTOQqqVMkM4Ujh+8gKdlIwGkiNFNRajSmMBLt17i7maAViNFI4lfNkH5
	opM7t9YyNJfgyZ1i2wcSoCQrisc6As+ZQJ2hqpDpZzk6eJdSJpGKHq6Q+jQQRZQlW7WE9goHSO9
	UfIx21NBjXj7GIs2BbYeEDeOGiYC+Hki5KDqf8mwwBqdgZFAomssY1F0o73xAN9G2A1ZFARSwNZ
	roBWsoD/NBR0p4=
X-Google-Smtp-Source: AGHT+IFbO0LQXpb4o5AfjDjgaLCI09lbX8MmFHBChHx28mbb47+GctVRETBu/lxFgwTGAONEXXUbu26j2npwF4yJSjI=
X-Received: by 2002:a05:622a:2d3:b0:4b4:8f9f:746c with SMTP id
 d75a77b69052e-4b5f8398f6amr130559411cf.23.1757435182490; Tue, 09 Sep 2025
 09:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com> <20250826162019.GD2130239@nvidia.com>
 <mafs0bjo0yffo.fsf@kernel.org> <20250828124320.GB7333@nvidia.com>
 <mafs0h5xmw12a.fsf@kernel.org> <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org> <20250903150157.GH470103@nvidia.com>
 <mafs0a53av0hs.fsf@kernel.org> <20250904144240.GO470103@nvidia.com>
 <mafs0cy7zllsn.fsf@yadavpratyush.com> <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
 <mafs0h5xbk4ap.fsf@yadavpratyush.com>
In-Reply-To: <mafs0h5xbk4ap.fsf@yadavpratyush.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 9 Sep 2025 12:25:44 -0400
X-Gm-Features: Ac12FXx6epo0S67QSojcQ_-q7eHBI3YWc1_bazn-CLdcZQ8RS6cUC5rSpC48xWE
Message-ID: <CA+CK2bD0FGsqKS70bCgiD_1T2S092-UDy3saW9p5KNZCzzYjPA@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Pratyush Yadav <me@yadavpratyush.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
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
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> I think it would help with making a wider range of roll back and forward
> options available. For example, if your current kernel can speak version
> A and B, and you are rolling back to a kernel that only speaks A, this
> information can be used to choose the right serialization formats.

At least for upstream, we discussed not to support rolling back (this
can be revised in the future), but for now rollback is something that
would need to be taken care of downstream.

Pasha


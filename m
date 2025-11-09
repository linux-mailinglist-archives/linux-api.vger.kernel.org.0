Return-Path: <linux-api+bounces-5183-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51498C4373B
	for <lists+linux-api@lfdr.de>; Sun, 09 Nov 2025 03:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507BC4E1B88
	for <lists+linux-api@lfdr.de>; Sun,  9 Nov 2025 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77DE1A23B6;
	Sun,  9 Nov 2025 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="b0I93vTv"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83161B6D08
	for <linux-api@vger.kernel.org>; Sun,  9 Nov 2025 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655553; cv=none; b=svppR9GTmRjB1JkMqoPVCi6xqC79MWQpsmfdVlkYe0mEXyqXgcHPMMVii+zbwAUbDLQsgp3OKPcwAfPhER9rJDt/sa1sjulUvQQbQyem3emf5kLbT0te9LPc8p9E93sq4REMubVUeNNMK9kSIJnQCNYRGa4Nt6+SZWf/1c+Y98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655553; c=relaxed/simple;
	bh=8wnVlEDqMdtcwfKI+Tx4kOKYiIjjZzPcvCAbnijyJz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8JgjfUAcbcpgN7qfq/7/dBjl6s0bX0YwsjeA/UNb8Lk+vEk4GqxMYA6bOJVPDnAxLgRS4Cy7Y9yKg+ByHZy9GHfueWvswh2UiRqnJbNuNxMLOBUimzgCsiWZ7pw1jRXkJEVVwEoyNmmeLRIS1HseRaSAyVV06JaWu3FxvdQKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=b0I93vTv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso2216382a12.3
        for <linux-api@vger.kernel.org>; Sat, 08 Nov 2025 18:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762655550; x=1763260350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3sUd4yemanGWTyJ8Beqz7xtQVHp5hlUsPWyPSJXOUQ=;
        b=b0I93vTv/1CuhJD5S9t5VkO3h82xRN8BBhw5WUK8w76QXPFlkbgft6ZQR0PLu/Aqa5
         5gLIyxnZuICXZU2aJeuALxwBjPKEy7PU7hqcasm1LaJfnudYo9gopK00XDh24b6NC83k
         dcOlrLF25ySQoUknCtiI7fVaw0GDH7vRoYU2pXWw3cezIaAhahKeE5UywCH1aLqT/x1H
         enZuZLBusJR/gHzgxfr+1bnuYD9jk7v4/acUR1WwdBcESAhfc7nu52n+fXSXZXH9THqI
         3CIRn7vQSn59yCRx1e7RYlpwQvGbl20RChs97VbMYvycR78jPeNeP4+S37aI1BEcMcQc
         3eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762655550; x=1763260350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3sUd4yemanGWTyJ8Beqz7xtQVHp5hlUsPWyPSJXOUQ=;
        b=bIW6uCW+2WX0CWWmmsuVjgnXtUeld9Bt9CHccKBU0ihDFiFDNhS/0kwCeAGJIqnEWZ
         qzuwk0il8QiMnyHlmC+MmLJcGw2VTDjvC2Cj5O527A1Kk1IPKuQDlkNlfe9Di6t5iTYh
         a1oofctVdg08yXM4izVHwB83dTLWB2T8q0FWS2emad6RgEW6yqnayKY4ByYGPDt1WZNf
         BcrOJ/TpWgAsa4+XSydchzlgcHcmWpVhRXSo5piHhnnBVj0ElAk9Wb5gqbrTfDfRjCZV
         x2FNfvsb9kcLSA6W1kwPwpnkrm9qFK64TDmp5GGMbYRjtohWo+rwhxIyCBj/4RAO37iu
         j3KA==
X-Forwarded-Encrypted: i=1; AJvYcCWv0yXMnAm9kNYCLhQUz5cY6ryIf/W/lLc+icm7JZpuL4eDxOfW1fw93czcQ/+bmdIEsYiw6ONmecc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDGB+XxiM2ugu0Gd29o9jNqgTOTJ4t3gqfFS7SltcChQJSMDOk
	F8gtIfdpRZFi7M4IpysXQPqj8YO4/SPf9VSVTUBoPNadX0fyRE14vj8gsz77isViedLBAiMw+0K
	f3sXuh7ImL/pUdf0iP3QAKsRyRT3GorIYPygve+RqLA==
X-Gm-Gg: ASbGnct1KxDnKBlkRANDuGp8heKnNEiSsSPwbmnQe556GjabW9gl8dWYeXFK1g6ybzs
	A5p6PKXPwPy16XM3FtT1keQylDiL6vXeu5S7/WcVvtv+MYFLL1LsAMa9PMQ5fxgUqvRWRR7edv/
	5L5gNxZL1mYFikSMJxUcEoXprzizA3F3Ly3ZyoBl4D0Ktp6xoH8HpP1uc9kIpxRyRcYhXIYsoEI
	IqXLDf1/GRIxoOqmw6aLhszJZXO6C6xo1hwem2UODlK86r8TjNvrfyXFw==
X-Google-Smtp-Source: AGHT+IGkPxaoskiODxv8UFWCdDvkCCatOQpLUt4UqpyBbWyWH0iYYiRs5ogfnHqSYP0nAMnRxIXTeT8EwyG6LMTSdO4=
X-Received: by 2002:a05:6402:270f:b0:640:b7f1:1cc8 with SMTP id
 4fb4d7f45d1cf-6415e822f52mr2906725a12.18.1762655550218; Sat, 08 Nov 2025
 18:32:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107143310.8b03e72c8f9998ff4c02a0d0@linux-foundation.org>
 <CA+CK2bCakoNEHk-fgjpnHpo5jtBoXvnzdeJHQOOBBFM8yo-4zQ@mail.gmail.com> <20251108103655.1c89f05222ba06e24ddc3cc3@linux-foundation.org>
In-Reply-To: <20251108103655.1c89f05222ba06e24ddc3cc3@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 8 Nov 2025 21:31:54 -0500
X-Gm-Features: AWmQ_bkVcbxT0gV7fpmnxd0SCIbpS_2m6TSXTf-t_TBkr04sjlFMoWl4do6gJ2w
Message-ID: <CA+CK2bAcQZM76dO2pHP0M1wAUeq6m7kKijSxoWDv7fvyreMJ1g@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] Live Update Orchestrator
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
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> No prob.
>
> It's unfortunate that one has to take unexpected steps (disable
> CONFIG_DEFERRED_STRUCT_PAGE_INIT) just to compile test this.
>
> It's a general thing.  I'm increasingly unhappy about how poor
> allmodconfig coverage is, so I'm starting to maintain a custom .config
> to give improved coverage.

That's an interesting point. The depends on !DEFERRED_STRUCT_PAGE_INIT
reduces build and potentially other automatic test coverage for
LUO/KHO.

We should prioritize relaxing this constraint. There are a few
possible short- and long-term solutions, which I will discuss with
Mike and Pratyush at our next sync.

Thanks,
Pasha


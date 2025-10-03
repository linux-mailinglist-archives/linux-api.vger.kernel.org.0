Return-Path: <linux-api+bounces-4989-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F6BB85F5
	for <lists+linux-api@lfdr.de>; Sat, 04 Oct 2025 01:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338014C1B4A
	for <lists+linux-api@lfdr.de>; Fri,  3 Oct 2025 23:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250C91C84A6;
	Fri,  3 Oct 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XetpY5Pj"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7822032D
	for <linux-api@vger.kernel.org>; Fri,  3 Oct 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533440; cv=none; b=QddCK81yny9ot4uNFjbrRnaoZK2q42Ug3tg66fbWtB45SUZSd/vgXFLN3Zum1SRsz1uKa4owFijl8C3N8tgnYv7gT09pGzCZEuE7DoMQ2uO99iAMnclktpcrAEopXHZWQ6f8yNxz5j3zl7F60ka12EsYTY0kTSS8AX6stw6sx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533440; c=relaxed/simple;
	bh=BqNIw1YGmI341uZYGrCWK9ZhHORfzlcwYubDz9DWoW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha5QnWNDXGxcVCFFueTwJLvPzL4DBFoMejTBz+RwfL8ULQGcuumDK3EFZv823yXe5iR8zC9ez9cOIJqoypJPfiUC6FcsCd1+bdH93LrC9rx4LCqPc1C2+fvF0qTgrQO6xsuvqH16OzR2ukshhcPC4nUM23NqkaHb4YSRv+S/H88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XetpY5Pj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2731ff54949so31315ad.1
        for <linux-api@vger.kernel.org>; Fri, 03 Oct 2025 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533438; x=1760138238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqNIw1YGmI341uZYGrCWK9ZhHORfzlcwYubDz9DWoW4=;
        b=XetpY5PjAMWK0IOYd8nDy+TbjJdaLXTajVqcGgpmrobza4UXAfEs8clIz+0LzEhGwq
         6yP+sUOS40Ce+2HfMF1nav03d5xZtI9sevUpmXbmsPG9Kz7KYH9jvi5NM28Wb635YpiU
         A1z21d6hjlkPcfTp+PL19oRaA4wgCpvyngI6zQmsZAhGbL88KAXvNCZCGoQSHR1EB6fz
         P7eT08ZIa2/dKA7CYXM0eL0t8d3vWA9BdmWQnjHhaEI0aajaI7AWc3EAGvyGprBJT6sK
         IGMnG6b542ZNyA2DsNfEDvmtWIfShzS1VEtBwSzK3PB7+wfXPc+hJ9MJvKIj/sbcb9Xb
         fzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533438; x=1760138238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqNIw1YGmI341uZYGrCWK9ZhHORfzlcwYubDz9DWoW4=;
        b=bnaF4ex9dbSWCmCRn7U/NVxOJSl8SieYoewnoydQode5UHBtK7Gv9fgiwLZ1dhlcNK
         4Ve4CGU4onQdv35eNJ2yq0P5rJ1poMDi82K8Tqvyl7QOiTXWU47I0xcXmdo8Tj8GdO88
         PD/I+TVlqD1ulp2JvYjGfiCcZJLH2nZFqJKctEBXT12Qbw5TcthuODYQ+0dkXajnT7q8
         BBeloaiHkhMKA7GZZ9m6HHmxXEHWsYBtQ9VbVQ+zSSFHNIpj7ZCGeraOoW1Zks7q47F/
         ptB+Pz/8ptLmgf8p9XnwYVfQL32f/MzAnYmQzWtGo9RA/6AzkrNV5CcRylldnGnDVy+I
         S1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUm5cr9HX/gNn6ffxW6R0ZTrnSo8w5dbM6iqbxbr9VLFWOqnXIRVQxj1LcogeAIiOONFDVWWSexli4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVvPqPCbs0fjLbg5Ndm/FmU7YhFHIMB32k2LFchWZNSBry7wi
	7ii3f6Ed7nwvgvm1OJgavpuhNJIV726Wn2ooPSa2EqIXjiHnEUR4na/VA4JQpz2/tQ==
X-Gm-Gg: ASbGncuASe8ncoMsXDhOI2YE0xWyW6CWzZzDaXidOmY0Gur9kuZwOE5vljU1BviZmqZ
	O7tCrAeAWtL+cyXUKKhABb3Z4b6ilsZ9V5/m6ykkqHMc3UPUBEvg/klST8stdjWCM8xwOqU38P3
	WpyhT5gWVlO6gy628/iE/20ae09u3Lx1N0qWyP7h10xyVv+tsZa0MV4eBiCbvPl9aV6301tKg3H
	7MbaziiGJTci2oOmOZvwhMrHZtse2eRZruAcXwaY2gOddK13U9yei6kLw1H44TiQTuq8MEKPUzJ
	kmNNOsrLZH6RbXebpKv7POh8kmS9EK2ZD3ANng9pxrTbUkWLr2M+CDizI0yqkK0jK5o8sNPeLQ8
	CGBPKGKZ3Co4UxeYqC52ZJkLa0c2nSv7iqzwJEz3miMVaK8eEYo7vt+9OxgELqUcOpxq84OjmaS
	EpFVqs/J1ogSA=
X-Google-Smtp-Source: AGHT+IH2PZQKML2R5n+BBFPUW8xCHC5Y8Kow9Od4wnT5GRTXGwVXHZ46Mp0pjYj0WarzaHWz91nJyA==
X-Received: by 2002:a17:902:f68b:b0:265:e66:6c10 with SMTP id d9443c01a7336-28ea7ebef98mr1733985ad.4.1759533437467;
        Fri, 03 Oct 2025 16:17:17 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d91sm60950595ad.5.2025.10.03.16.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:17:16 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:17:12 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org, steven.sistare@oracle.com
Subject: Re: [PATCH v4 18/30] selftests/liveupdate: add subsystem/state tests
Message-ID: <20251003231712.GA2144931.vipinsh@google.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-19-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929010321.3462457-19-pasha.tatashin@soleen.com>

On 2025-09-29 01:03:09, Pasha Tatashin wrote:
> diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/selftests/liveupdate/config
> new file mode 100644
> index 000000000000..382c85b89570
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/config
> @@ -0,0 +1,6 @@
> +CONFIG_KEXEC_FILE=y
> +CONFIG_KEXEC_HANDOVER=y
> +CONFIG_KEXEC_HANDOVER_DEBUG=y
> +CONFIG_LIVEUPDATE=y
> +CONFIG_LIVEUPDATE_SYSFS_API=y

Where is this one?



Return-Path: <linux-api+bounces-5367-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E21C6B084
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D44A4E5DB9
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0533C1BD;
	Tue, 18 Nov 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFGecU9H"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374629BD8E
	for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487524; cv=none; b=UZ6xTLFsGaIq/s/ca7sg4TeDE9XSSb8KFyq0p1C1OcsAE88YK4PHJVnR1khguowcnJyuBaVtv1HOPqEGzSx1L0KNc9li5sxuGLkqd8UVAmR2rp3vHIdGY3F6bwFNYsMez4FiuDJQnKZBnXx4dHU/Gw3kLpTFWy2a3gxaU8McllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487524; c=relaxed/simple;
	bh=0R9nNh+fcxIvM+QvxY30LzRC0hI4TwT1hpwj1bidwn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9WnO6kdeeJvUiz4DNlDyRctEE4DlPCuCjexjdlcr/JFSLZR8yZMOFYGV3Gk/zDaoggSVy1W/FIj9GhXKcL3iEyvhEps9CTTCGZCtm3gDLoWQ26yFP7aKyF2faogjZ8ydlYZ+zrhcy52r479Idoo8aUCafTQ9vwpq5BItyjRmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFGecU9H; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so6436747b3a.2
        for <linux-api@vger.kernel.org>; Tue, 18 Nov 2025 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763487522; x=1764092322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KOpYFcon0iDNFMIs3t+r9Ea1btmn7c7oPi7Nmj2oec=;
        b=zFGecU9Hi+7IGywYRFjuy/UyYCOwT7m2Psq0CRVAHdKpKQ8X00QXCaPNs2ndTQotyv
         BCswsOxVw4gW5EJx+uDvIv113R641UBvb/cjb90QEOWRZ+KLNGYcD/4dmSYN8iq20VfH
         zD7S3wpdmFldzMnthMWqUybuJbxDad8mdTKi9UUzZ2V5zTfgs2ScxYH0RumXplH0hmFk
         hCjyMNMoqdYbYO3C9Kqu0vlpF71u/WVX40Eh+2UsZOel6VDh/g5hjE/tu9t2VA9E+0Zr
         mwf4FofvcXjL72aXiYvTNckIcT3X+U9lXVEq7Bpidk9JPPbEB4Pd9elNmMccEgTNGxSC
         TmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487522; x=1764092322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KOpYFcon0iDNFMIs3t+r9Ea1btmn7c7oPi7Nmj2oec=;
        b=hLtzLp7NFO1P4vfQk2aNebYUYPyP80aZM3LKLE1dzn7YCU2lKjp7q07Hx9mJ9REPA0
         O0SpBPJDgi7Dvmm8f8rPxeyqEXYYzUyVuxY1hMUZ5mj1HOoqnsTQDl6JZImtaLdp8oRD
         /aYOguCmGqAz9hl392v5CgioISKJ4I0OoyhqBv1EKZ49fdf/8lGQFvhgh0Q/PQynC4TD
         3Fb2kKxRaDvGBOHgyFlt3/fpsM3fDVP6JteBJPS+MThPErWzXmo4ICgs2WSwQYUPiVRY
         D82kjd5hdHQNvR5GWpYhoSlHLiBv02JD/s2EENm6dW0lFvTHZMgAAzk5vD5Pj6s9Yd2z
         Jv4g==
X-Forwarded-Encrypted: i=1; AJvYcCVzZ9Xv1UpUd+7ZvhTR+UMzR/SEYnwAHk+PI3IHdAmVK6cfcBtDRjzXYTHf0+C2rRD13DmHsO40GDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmYjlUvPbXNPn63WIFKz4qqwCO/IUYfLLybEXIToMfSOTRL91
	vSLyYWJBl9ssVu08uHoewpIRiBlJdtNQvWR5VeDyiEWm98ZDgoa2Lj8OmgERZMBxCQ==
X-Gm-Gg: ASbGncvTHRrDph3J0g7xaPe9bZ74rQTyl2XBr12SG5r5qCHYOgnrkWD+Oox6lS3KIsX
	YmIexRYtojidSIBZz8/DXdsBh4YPw3QdvUOy1KMN+2+h6iUoqvbdGvO/E/Os3pdMjitNbRCnjnZ
	5VhDw13HLPEw06FZua4cKlamHvFRVj/nrWDmqflkf4/h9utFKM+0Fs0EUrDaLjbhUR/iJ4mM6zY
	Bx2qNDhaZhZ7LrmTTWUSlYoxbVa227a9FkBfaS0+NyDYz3NRRYSBJK0RhI9Bs8HAXCYh4L544CU
	BXpCUa9QPfHx2wlMctty2MEAwpwlpVqPpYtV0DtIoabsqb2rxGHK5MgVxFaIULq+Rj06P5VJIwM
	LKal6NhyceGeVA9qbpKqo3FQWAR0XC+GvpICIClmISp2Ij88Quge6i3NYeapi9uCrLKk3vu8bEV
	jUEcGMJLw+3ZnOvfp26OnQTx0sHbeMxZ3JC1OuLSbH5qQCotNUlifo
X-Google-Smtp-Source: AGHT+IFHhg72xm2TGOlgC80Jpbc+gsGTnmY9bbV9Ns7ch2lY+9eWvW41JSseHQ0nLr5q5q73zE6FJQ==
X-Received: by 2002:a05:6a00:9aa:b0:7aa:93d5:822c with SMTP id d2e1a72fcca58-7ba3c27267emr14948626b3a.23.1763487521172;
        Tue, 18 Nov 2025 09:38:41 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92782d390sm17124484b3a.60.2025.11.18.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:38:39 -0800 (PST)
Date: Tue, 18 Nov 2025 17:38:35 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	rppt@kernel.org, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
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
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
Message-ID: <aRyvG308oNRVzuN7@google.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115233409.768044-7-pasha.tatashin@soleen.com>

On 2025-11-15 06:33 PM, Pasha Tatashin wrote:
> This patch implements the core mechanism for managing preserved
> files throughout the live update lifecycle. It provides the logic to
> invoke the file handler callbacks (preserve, unpreserve, freeze,
> unfreeze, retrieve, and finish) at the appropriate stages.
> 
> During the reboot phase, luo_file_freeze() serializes the final
> metadata for each file (handler compatible string, token, and data
> handle) into a memory region preserved by KHO. In the new kernel,
> luo_file_deserialize() reconstructs the in-memory file list from this
> data, preparing the session for retrieval.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

> +int liveupdate_register_file_handler(struct liveupdate_file_handler *h);

Should there be a way to unregister a file handler?

If VFIO is built as module then I think it  would need to be able to
unregister its file handler when the module is unloaded to avoid leaking
pointers to its text in LUO.


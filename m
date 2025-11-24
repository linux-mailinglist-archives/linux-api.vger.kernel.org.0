Return-Path: <linux-api+bounces-5490-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C709CC82702
	for <lists+linux-api@lfdr.de>; Mon, 24 Nov 2025 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79C194E335B
	for <lists+linux-api@lfdr.de>; Mon, 24 Nov 2025 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7622E7F20;
	Mon, 24 Nov 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="g8iktMVW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C22E091B
	for <linux-api@vger.kernel.org>; Mon, 24 Nov 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764017056; cv=none; b=akDY4DauZmwknRzGX00H9MZMuQAOs8tdmXLbc7u7kbCPqbhie9zb4HGU46Fhpcabb/A5bVVelJ3Ri7VEaDzGxAiMEme4u+kx1moEuCZ7HxtSU8lJ07jnmtD3q/O6N2VcXbDvAfFyElYxoQHhdqIHGp54PzPujD/OUkujja4X+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764017056; c=relaxed/simple;
	bh=BBE6LeQp/9dxs9+8oqbQWSo19CZnncAHHP/erXGXDYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICjPUQn86oE4RTOk3+AvRWbHOynAD6ohlkB71z9kCgOy5Q304LRXbUw5ZU2EAmP2Kg6PrBTlw9A+YH8Quab6PnmRwrZpS2ASQ2l23gHejk95a6KuszssXKQNVAw5Swrht52wCaRuXkzdKMxXJGsRcB9Li077ElYQWLooK0r7aTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=g8iktMVW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so7083507a12.0
        for <linux-api@vger.kernel.org>; Mon, 24 Nov 2025 12:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764017052; x=1764621852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBE6LeQp/9dxs9+8oqbQWSo19CZnncAHHP/erXGXDYE=;
        b=g8iktMVWcI/LuhUgIvV4WSpMbjXgytvx4V51oSQ+pjqWLbfgytyU/K3V7DMh9pdsI7
         Vr9D+wtwK7v3vQeer3Fx3k6I1pZ9PaR0cO6sDCpXxn7AlUC0gDq6b8guo4Guce67IJCN
         55Pt7JRAZpI5vW3IqAu7wMbflGWFJE9P5QiMO/1jhsyM2ozz0U0RmSCj/w4entfSzV6L
         QJEN1M7HB3At0fWH7JxrJ4Be9BvzoMkzKgWfnSZXoxv3IraS0egse41BT1QNk9L1wGQJ
         WHi0CBEw11KQ2NZsgWBlfsj+C3V59QBoY2yQkhcnxYhTbVZMqJF8PQq5ex27MQrgwYCJ
         kJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764017052; x=1764621852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBE6LeQp/9dxs9+8oqbQWSo19CZnncAHHP/erXGXDYE=;
        b=mW6ny7n6zmekwb/0kNygiPDP3Mf3b5H5DQiX+lHhGEOvkP8xT1bxfqvi19EqJe+2A3
         4o+PlBkqwIZzhp4WciLuH9kiudaLHCGcPPTAM2TASnlxRO4vyivy4d3wF6utaBO6ufxN
         coaEU/j7g6HYUM80ve4JjNVmzHucGuek2jV7uWwWTkwiYzPw0Y34qleJSGx81ogX5C0p
         MUWb3Mg6uyUCneuAA3+QHiHDqEEo9Qq6FtdK/ABeUzDYHikE6TLzh2W2Zs6bk6rTC14U
         vUhwwOZsu/vrFKH/UxP4y+mtZOchLosFMQM5yWgTIOYbNXNRHYPuSnGw/0f2PUI7eXZz
         OYOg==
X-Forwarded-Encrypted: i=1; AJvYcCX3N4SKjZOPntZmktt97pXknCS7DZt80eJT7lu07e1TcjiGOntNJpehC6vPuvjSbzlqN1LsDY4rm3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+W9TLK2Y080sIsjVbVMPKiMwpQF78z1Rd7Ix4ZnDU1GYwuvvg
	qqcLzGSnOJx1SFP6werQC5FJIHPgq+0lCBv44ZxPJU4ddZXRtv4zRYFblgty0gUzurapeha5alM
	tTGNFw1OMFq0OntmJrcrojaSlG2h9vr5wgUfmthJHaQ==
X-Gm-Gg: ASbGnctrLMfN5p22NX/cGAanPM7sqCIn7igDHfPcbuL6GZkypQrr5qKl0ZvxxVeTuzl
	Z9UHytzBCJNT2bdNUP2Jq1FHyXE1nCwpnYF0k/+wGfUt1JK6Trz2lvtrrKfFB/LJHwNmyIVYpvr
	TW0ZWZSMSxhNTXQau3oue5i/8aa14y/OUKmHyReKal/IVY6fP2Bt7hNZNM7RjzVo9d5r/bgPHy8
	bronv6gYZNdU4YE3e7gZkrRXY0+Ba1y1OhUrc7SIbjfOgO6+bLRcRDzbfopXCnkUhKz8qDDG04O
	1H0=
X-Google-Smtp-Source: AGHT+IGhvW1zbxphQtXzCMtZtUK6gJJpF4SpaRUxkwNlXNg4phdSf38kNJPBHFGIc5NhOi7Yie2O+dbmmBf+QzpJ1eA=
X-Received: by 2002:a05:6402:35d0:b0:640:6653:65c1 with SMTP id
 4fb4d7f45d1cf-64554322775mr12262864a12.5.1764017051792; Mon, 24 Nov 2025
 12:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-2-pasha.tatashin@soleen.com> <aSLsCxLhrnyUlcy4@kernel.org>
 <CA+CK2bCN7x=eMwfTXF-2+vR=Gn3=41z6Xxx6wM1m7i-rxzug9w@mail.gmail.com> <aSPoIw2keoueM2q8@kernel.org>
In-Reply-To: <aSPoIw2keoueM2q8@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 24 Nov 2025 15:43:34 -0500
X-Gm-Features: AWmQ_bl-mLHs5xZHjLqaNQo3tDZr-xY0sDzlZu79iSrnbtwX9ynUfgq6sBNqNvg
Message-ID: <CA+CK2bDqaVV9=gQUQr81euOJCN2d2vJGH+9fZw-Vcymuff3KdA@mail.gmail.com>
Subject: Re: [PATCH v7 01/22] liveupdate: luo_core: Live Update Orchestrator
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

> > Sure, or I can remove all of them from Kconfig, whatever you prefer :-)
>
> Quick grepping shows that the vast majority of Kconfigs does not have
> copyright, let's just drop it.

Done


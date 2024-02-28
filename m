Return-Path: <linux-api+bounces-1083-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304AA86B7AE
	for <lists+linux-api@lfdr.de>; Wed, 28 Feb 2024 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F451C25F54
	for <lists+linux-api@lfdr.de>; Wed, 28 Feb 2024 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112D71ED1;
	Wed, 28 Feb 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jz8yh18x"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6271EC2
	for <linux-api@vger.kernel.org>; Wed, 28 Feb 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146246; cv=none; b=nZNE2QzXXT5ob3hDGyFaz/MAhGqWMfvO3q2737d5096R4qtlE4fhP1+RppZwMwpbrsw05AexJ5hZtU+b3SoWb7O5fjGNnTs+QIB3QYU2SK45ixNTX8KHYn7S1QXJE7UQQ4o2PMLYpV4+rTvnBeYgCDB73Q0gAisBSOqcs5vsEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146246; c=relaxed/simple;
	bh=uCNk9xZssjz88SO3HgKmg/6pNPAs4j9cZ22qRa/0FUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iClSr5lfn2Jv2g0Pkd2cwxaB9rsbVKmLB8iRsPpkJaRGg1UDuyIoCw2NBOLig2vA7U+b0WP2S07v9CiA2//BqaqWgN0FBu57X7tlXiNgT5685rwdCVoVp5Z4QLZbDiqzu+709ge8pAcOI1tRwCK2DqHNH6m1q16OOh+M/a+zArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jz8yh18x; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412b493ed27so462965e9.2
        for <linux-api@vger.kernel.org>; Wed, 28 Feb 2024 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709146243; x=1709751043; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzx4HJfLML4JQaG7fROeK+a0qZNaeaLXumU4hcnOH5U=;
        b=Jz8yh18xpafJEnQQlffADR/JWLGW90uMfpbJK/V8qPEbJflGfIZ8msGjAds/C4hFOZ
         hu6ikyWwAojPdrBeIjOhh4i2zzH3AQz8QXm36XuNgKBQ+P432WmD2Rf2DV9NyoxSidun
         vaNUfc9ElXoq92QN5dQzELXifRLmvt6zoDSFLNbSAmOVJKHHZ4S6sRGAFutDRiDDHoXV
         DW2Zq24Q+IfvGra77G9IDtsqHL84elno7uuxeoVc80LeynNO/Fzzo9SKCQUrETulwEN7
         vwpxgWGTrq5yoNBIq5sxL/RXKAIRVbZb9YUEFBJOBCYPuoIz43jnL7FxY5zmjcC44LdF
         5wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146243; x=1709751043;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzx4HJfLML4JQaG7fROeK+a0qZNaeaLXumU4hcnOH5U=;
        b=gkI5sV5yFzS2+wdMcb/pvHk3Gi3TgOpWoDJTeEGxNecfJ9WimE1Ef5+UvQDqjdPpga
         AQvTwPqcApBwihy4gw1xnxhZ7yPiqUspjTFVTojO+FrRnHuE6EtSW3A8BbR901BR+Cej
         55hjHfGkMV3WmxgZLNQraqPYSxJDuePWgHIn55P9xoN7c4/5g/QbYE/gY0Dmi5WeHzBj
         VJ2nCGp7hH9dQIJqAHMRx3ocy2Ry/C+7W7U9CEJYyMbppISufhkISu/Yfa0yIZh+MTmI
         dPiwqAYonLK+V10S0x79w778vibMhdlms3SVRqPVv7d8TIzrWzejRAHyIrQEkI/7kBMU
         4zhg==
X-Forwarded-Encrypted: i=1; AJvYcCWYeBNoPKdyRIPeE4je+YaANIYWiSic/cFgoTEsZHGRAHDe67Rkel7Reqc6HfUrIYIFfseZ89WYRolSU+6n9eXkrCSPe7Et8io5
X-Gm-Message-State: AOJu0Ywb0l/BPQYXbLnRsm94qzbZ7ahB3mEeSPiMzgJG5lILDoY4sdhF
	HkwMuNH3Ur3cS2MIcwmW/N+wUq1LQTj4Lr8d87vqhFUFHdvOZldLJ/CbxrwDZg==
X-Google-Smtp-Source: AGHT+IG2H+YrKQ5fSobiXEyDPQnan1RYKk8JYEWcjEAIGT6HGiPQq/QjDtUbrthdPJ6TZz1M9/GBOQ==
X-Received: by 2002:a05:600c:468c:b0:410:85ab:67f3 with SMTP id p12-20020a05600c468c00b0041085ab67f3mr81884wmo.21.1709146242594;
        Wed, 28 Feb 2024 10:50:42 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:e9d0:d027:ced7:cf52])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b00412aff7874esm2890521wms.48.2024.02.28.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:50:41 -0800 (PST)
Date: Wed, 28 Feb 2024 19:50:36 +0100
From: Marco Elver <elver@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
	carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Chris Kennelly <ckennelly@google.com>, dvyukov@google.com
Subject: Re: [PATCH 00/30] RSEQ node id and mm concurrency id extensions
Message-ID: <Zd-AfDcQ-r04CMXk@elver.google.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Mathieu, all,

On Tue, Nov 22, 2022 at 03:39PM -0500, Mathieu Desnoyers wrote:
> Extend the rseq ABI to expose NUMA node ID, mm_cid, and mm_numa_cid
> fields.
> 
> The NUMA node ID field allows implementing a faster getcpu(2) in libc.
> 
> The per-memory-map concurrency id (mm_cid) [1] allows ideal scaling
> (down or up) of user-space per-cpu data structures. The concurrency ids
> allocated within a memory map are tracked by the scheduler, which takes
> into account the number of concurrently running threads, thus implicitly
> considering the number of threads, the cpu affinity, the cpusets
> applying to those threads, and the number of logical cores on the
> system.
> 
> The NUMA-aware concurrency id (mm_numa_cid) is similar to the mm_cid,
> except that it keeps track of the NUMA node ids with which each cid has
> been associated. On NUMA systems, when a NUMA-aware concurrency ID is
> observed by user-space to be associated with a NUMA node, it is
> guaranteed to never change NUMA node unless a kernel-level NUMA
> configuration change happens. This is useful for NUMA-aware per-cpu data
> structures running in environments where a process or a set of processes
> belonging to cpuset are pinned to a set of cores which belong to a
> subset of the system's NUMA nodes.
[...]

Just out of curiosity: is anyone aware of any libraries that have
started using CIDs? It looks like the cost of CID assignment is always
paid (even though it should be small), I'm trying to understand if after
1.5 years there are common libraries that have started using it and what
their exact usecase is.

I'm aware that TCMalloc was the inspiration for vCPUs [1], then renamed to
CIDs, but am wondering if other users are out there.

Thanks,
-- Marco

[1] https://lore.kernel.org/lkml/20220218210633.23345-10-mathieu.desnoyers@efficios.com/


Return-Path: <linux-api+bounces-2260-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A4E96707A
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4460E1C21849
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7616E89B;
	Sat, 31 Aug 2024 09:36:35 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from port70.net (port70.net [81.7.13.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F814D449;
	Sat, 31 Aug 2024 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.7.13.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725096995; cv=none; b=OREgMsu1cyrSnG4vHtIuyZRUKN554yFryE3X1GvDQbP8D5OwBMRWEuZizBn8p3EbaVMgEhyjYFe6YxKK5uWurjHWe6XvM+V7ohOMuPbP6yt1LQ/gcNDzOsd8HooBRtXfEcEaKwk+77QvfGn9z/Ri1ME8maEV+sAWSR6l7t1IHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725096995; c=relaxed/simple;
	bh=y8MuaaMlSx7uER0YHN6g/ghPc2e5pvKdz8U7N5S8BxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgzLsErXUHlNEcg3Ms0noi8I25GkVsauWcglfZwi6FqD16J3BI32nywKSEh3FqYv1FbBc/RzJRCBLdNMWxLVeQmfAYBXQYmMpjS3Bh65Gr4prN8RxJ0amulDsuQmyVUvjoi6enyInu5fnZz/OHNktc5v8bGgemybmNcuVp9B130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=port70.net; spf=pass smtp.mailfrom=port70.net; arc=none smtp.client-ip=81.7.13.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=port70.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=port70.net
Received: by port70.net (Postfix, from userid 1002)
	id BF3A2ABEC0C7; Sat, 31 Aug 2024 11:29:02 +0200 (CEST)
Date: Sat, 31 Aug 2024 11:29:02 +0200
From: Szabolcs Nagy <nsz@port70.net>
To: Rich Felker <dalias@libc.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: Re: [musl] AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
Message-ID: <20240831092902.GA2724612@port70.net>
Mail-Followup-To: Rich Felker <dalias@libc.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com
References: <20240829205436.GA14562@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829205436.GA14562@brightrain.aerifal.cx>

* Rich Felker <dalias@libc.org> [2024-08-29 16:54:38 -0400]:
> As I understand it, the AT_MINSIGSTKSZ auxv value is supposed to be a
> suitable runtime value for MINSIGSTKSZ (sysconf(_SC_MINSIGSTKSZ)),
> such that it's safe to pass as a size to sigaltstack. However, this is
> not how the kernel actually implements it. At least on x86 and
> powerpc, the kernel fills it via get_sigframe_size, which computes the
> size of the sigcontext/siginfo/etc to be pushed and uses that
> directly, without allowing any space for actual execution, and without
> ensuring the value is at least as large as the legacy constant
> MINSIGSTKSZ. This leads to two problems:
> 
> 1. If userspace uses the value without clamping it not-below
>    MINSIGSTKSZ, sigaltstack will fail with ENOMEM.
> 
> 2. If the kernel needs more space than MINSIGSTKSZ just for the signal
>    frame structures, userspace that trusts AT_MINSIGSTKSZ will only
>    allocate enough for the frame, and the program will immediately
>    crash/stack-overflow once execution passes to userspace.
> 
> Since existing kernels in the wild can't be fixed, and since it looks
> like the problem is just that the kernel chose a poor definition of
> AT_MINSIGSTKSZ, I think userspace (glibc, musl, etc.) need to work
> around the problem, adding a per-arch correction term to
> AT_MINSIGSTKSZ that's basically equal to:
> 
>     legacy_MINSIGSTKSZ - AT_MINSIGSTKSZ as returned on legacy hw
> 
> such that adding the correction term would reproduce the expected
> value MINSIGSTKSZ.
> 
> The only question is whether the kernel will commit to keeping this
> behavior, or whether it would be "fixed" to include all the needed
> working space when they eventually decide they want bigger stacks for
> some new register file bloat. I think keeping the current behavior, so
> we can just add a fixed offset, is probably the best thing to do.

i think it makes sense that the kernel sets AT_MINSIGSTKSZ
according to what the kernel needs (signal frame size)
anything beyond that is up to userspace requirements (e.g.
the kernel cannot know if the libc wraps signal handlers)

it's up to the libc to adjust sysconf(_SC_MINSIGSTKSZ)
according to posix or backward compat requirements.


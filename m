Return-Path: <linux-api+bounces-2258-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A64965186
	for <lists+linux-api@lfdr.de>; Thu, 29 Aug 2024 23:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B254EB22216
	for <lists+linux-api@lfdr.de>; Thu, 29 Aug 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7318C01F;
	Thu, 29 Aug 2024 21:09:55 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86018C013
	for <linux-api@vger.kernel.org>; Thu, 29 Aug 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965795; cv=none; b=a+oYfj6mdXWj5GmXYXkR2kJ2XqQIou/2mZAAOaXa1pBAF1C8RtO50hNP6UdUzgmz0VTWE3O/pR8tpjGSyK4HldADnGozSNLdvLpDTQuInF2xvUiJE6G1kexeLE+fbrg4Ua4wRJV59zZYSLM+I+4rAtLm+HPGmpewg9THs4eE9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965795; c=relaxed/simple;
	bh=S3YBKg7lXNOxz5AOfofnf/s0noWCjPueQqE5fBwJHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dqF+ZdUrQkcZ2A2KgG9VLOTrXP2Zc+a44HB+B2vvkF1jkAwA5aWOMAxr+Z2fYEgcga07s+s4TH3MiS/mG5/j5Nj8DHK60+SUWWQsfTo9H6d83oes7OFTWdqNJLoFZDIyIZopaK3BUEcjoCzJs+03Qq89pyySI2uf24yhTbZBa6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Thu, 29 Aug 2024 16:54:38 -0400
From: Rich Felker <dalias@libc.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-api@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
Message-ID: <20240829205436.GA14562@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)

As I understand it, the AT_MINSIGSTKSZ auxv value is supposed to be a
suitable runtime value for MINSIGSTKSZ (sysconf(_SC_MINSIGSTKSZ)),
such that it's safe to pass as a size to sigaltstack. However, this is
not how the kernel actually implements it. At least on x86 and
powerpc, the kernel fills it via get_sigframe_size, which computes the
size of the sigcontext/siginfo/etc to be pushed and uses that
directly, without allowing any space for actual execution, and without
ensuring the value is at least as large as the legacy constant
MINSIGSTKSZ. This leads to two problems:

1. If userspace uses the value without clamping it not-below
   MINSIGSTKSZ, sigaltstack will fail with ENOMEM.

2. If the kernel needs more space than MINSIGSTKSZ just for the signal
   frame structures, userspace that trusts AT_MINSIGSTKSZ will only
   allocate enough for the frame, and the program will immediately
   crash/stack-overflow once execution passes to userspace.

Since existing kernels in the wild can't be fixed, and since it looks
like the problem is just that the kernel chose a poor definition of
AT_MINSIGSTKSZ, I think userspace (glibc, musl, etc.) need to work
around the problem, adding a per-arch correction term to
AT_MINSIGSTKSZ that's basically equal to:

    legacy_MINSIGSTKSZ - AT_MINSIGSTKSZ as returned on legacy hw

such that adding the correction term would reproduce the expected
value MINSIGSTKSZ.

The only question is whether the kernel will commit to keeping this
behavior, or whether it would be "fixed" to include all the needed
working space when they eventually decide they want bigger stacks for
some new register file bloat. I think keeping the current behavior, so
we can just add a fixed offset, is probably the best thing to do.

Rich


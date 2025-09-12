Return-Path: <linux-api+bounces-4746-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28856B540BA
	for <lists+linux-api@lfdr.de>; Fri, 12 Sep 2025 04:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8C2175143
	for <lists+linux-api@lfdr.de>; Fri, 12 Sep 2025 02:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC4221299;
	Fri, 12 Sep 2025 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LbF7o2s8"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56192CCC5
	for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645883; cv=none; b=rP7f0AUN/0LJu7FXambZ3mGHjlgsh+vjkRIpQBXYf3vnC8RGOKoRq3bLhwVzXquIEUy9B6aLMmPMAa8qVZC5Fh4OF/t5b/Ca6GqCamhN6bGpWP9SlKOOZbgLfh7DERTljTOAYKjTyjTgezzFd2hxXdXNgryinE9BiaKF/0nu6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645883; c=relaxed/simple;
	bh=NKzV8JR7UqZc/ELm898thRwxaHqJOWu3m49en4Oeu6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfVxRDSya4+nkshwMlkqyEN5jAw9v8FpT+PKhbOOOYKxsinq6ClCqoYYxUP0L69/Pvo/2Jj86hDf4wudAFe2vp/VY83B2chqL9uDKhqReKOkhDumIAzMu5cNMrJtHFlZNDo9z3/oLOdtvaq9mpf2HrCXSt+4C072ri7CDOMfcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LbF7o2s8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-47.bstnma.fios.verizon.net [173.48.111.47])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58C2vq9m017381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 22:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1757645874; bh=qZ4wRsiYgIdJWsLZwhp7675lYDcgsKjkqJ1skEDYHoc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LbF7o2s8bdjp0Fm0mghSWBjEZRngWR3cH3HYMyWr6ctJhv4I6H8t1Pgdn8pM5Jjsj
	 /Grf04/bq3dTI5XkKrsDwQjtMNyWDX52fhMIuzjxxBqGt0zpWUWklieQDVqr6Ef+7v
	 gtzZFLGRHwkpuk64CoxR0TE05vudtSNMrvFzcLaYHZ7SnUmyForDkJHHm3c0cA0v5H
	 kcuygIchVoe2AimqclE2+uLyE8RGHWOwiHMmd42pDoYFepFdU80ZfzMF3FTBoxBzOa
	 yD5I02PJeCr+ynW17XJnZtGLGmlow/f1Z1cq3O8h38n8qtpjc3ixIrGqq8iPAI5j1l
	 XHwIcvz0pCSgQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7B40A2E00D9; Thu, 11 Sep 2025 22:57:52 -0400 (EDT)
Date: Thu, 11 Sep 2025 22:57:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>, G@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/3] ext4: add support for 32-bit default reserved uid
 and gid values
Message-ID: <20250912025752.GC3703006@mit.edu>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
 <20250908-tune2fs-v1-2-e3a6929f3355@mit.edu>
 <20250911223121.GD8084@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911223121.GD8084@frogsfrogsfrogs>

On Thu, Sep 11, 2025 at 03:31:21PM -0700, Darrick J. Wong wrote:
> 
> Is there a risk that some garbage written to s_reserved (and not caught
> by either the kernel or e2fsck) will now appear as a "legitimate" resuid
> value?

The superblock is checksumed, so the risk would be that some
impleentation modifies the superblock and updates s_reserved for some
reason.  But they could do that to any superblock field, or to the low
16 bits of s_resuid/s_resgid today, and that's something that neither
the kernel or e2fsck could check.

The mke2fs program zeroes all of the unused/reserved portions of the
superblock, so the risk is some random non-Linux implementation (e.g.,
GNU Hurd or BSD) had hijacked some reserved field without coordinating
with upstream ext4.  I thought about using some kind of compat feature
flag, but it probably wouldn't help since the other implementation
would likely not bother to use their own feature flag since that would
prevent the file system to be mounted with Linux.

Currently, someone tried to run "tune2fs -u 146878 /tmp/foo.img" we'll
silently drop the high 16 bits:

% tune2fs -u 146878 /tmp/foo.img 
tune2fs 1.47.3-rc2 (12-Jun-2025)
Setting reserved blocks uid to 146878
% dumpe2fs -h /tmp/foo.img | grep uid
dumpe2fs 1.47.3-rc2 (12-Jun-2025)
Reserved blocks uid:      15806 (user tytso)

And if we have implementations that support 32-bit reserved
uid's/gid's, and the file system is mounted on an older kernel, it
will simply use a different reserved uid (e.g., 15806 instead of
146878).  But we're kind of confused today, and in practice most of
the time people will be using low reserved uid's/gid's (e.g., 1 for
daemon, etc.).

						- Ted


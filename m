Return-Path: <linux-api+bounces-5585-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FEACF7D59
	for <lists+linux-api@lfdr.de>; Tue, 06 Jan 2026 11:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2733110C1B
	for <lists+linux-api@lfdr.de>; Tue,  6 Jan 2026 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C42E344025;
	Tue,  6 Jan 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGg/ap0R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2qYNiajn"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FA3195EF;
	Tue,  6 Jan 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695592; cv=none; b=mu10YcyRAlzuYYtnN8YPKlU4ml+OgClEtMVIKifWkUUEGKvl8YQdXNs/DO/jQq+xZ0upb+lQqCjqw7L+KA2OdtJRTy42q4gQ9P3/jIARWvMsQh/ks0e0W1ZcRacIz9LGhd6prSfyvhrazDcjurSLu9f9ZeP2Iv8KF0w3oYZ+MMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695592; c=relaxed/simple;
	bh=H8/17NULFy8CplKH1nS0Kom0Evptl///XzL5Gln2hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL2lgnnMUa+Eg8tQC5uTh90kVakjZmt4F9gSuHi6JB5swg3S8fHWLQQ8XtAZKyKR5gD7I22jp809qvGeHjlfKANkvxW3gCJa8HQ/hzZRwno9q6TuFPPODW6Jlk6GZ8jwwtoycYvaLDHjhMvCE+/15nJFdy0ho8BiWOlXuC2p7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGg/ap0R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2qYNiajn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 6 Jan 2026 11:32:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767695578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/r76hoBo6xwYcVTj09hRbJ+2p05uWHpUI4bIIlSY4Q=;
	b=dGg/ap0RA1MNR6hNwMj4nxF55pEzJV+i4uUruVW1FIiNecYgMjVSS+XPWwekM98/jdDYbb
	O22FNIsnYLTS28qNJzLWJZDgsi9im9pNNFkPjfiqSseUVGysQAvHViRswTkG8VV68XtwBn
	P8MDop5c7lB4uFRWfHWCdlHH6xrRv1YzWrTaFTeEkTBSXLXRkE5peyNBEqt5KGmIit/84L
	HSV0yz7LHU9+cwlU58NhSwdrhqJ1d0+Nhn7PuruGlzwHH7WFj9TvAgGy754TqvYCIJGZ8P
	CLmlBbOD5xjK/NPG25rGnNB3dmtHYNsJjxU/BlpGwtgUG6MfXfM1Eo2benRDkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767695578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/r76hoBo6xwYcVTj09hRbJ+2p05uWHpUI4bIIlSY4Q=;
	b=2qYNiajn5JqKxHCUD2M59p+xgpngjaPwIdExDH7bEynsMz/lnIjIY7bFoBpficKnMlMCC/
	9gIqD2lUyHixhRBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Message-ID: <20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <20260105095713.0b312b26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105095713.0b312b26@kernel.org>

Hi Jakub,

On Mon, Jan 05, 2026 at 09:57:13AM -0800, Jakub Kicinski wrote:
> On Mon, 05 Jan 2026 09:25:55 +0100 Thomas Weißschuh wrote:
> > Various UAPI headers reference 'struct sockaddr'. Currently the
> > definition of this struct is pulled in from the libc header
> > sys/socket.h. This is problematic as it introduces a dependency
> > on a full userspace toolchain.
> > 
> > Instead expose a custom but compatible definition of 'struct sockaddr'
> > in the UAPI headers. It is guarded by the libc compatibility
> > infrastructure to avoid potential conflicts.
> > 
> > The compatibility symbol won't be supported by glibc right away,
> > but right now __UAPI_DEF_IF_IFNAMSIZ is not supported either,
> > so including the libc headers before the UAPI headers is broken anyways.
> 
> I did not look too closely but this seems to break build of selftests
> in netdev and BPF CI (netdev on AWS Linux, not sure what base BPF uses)

Thanks for the report.

I found the reported CI failures in BPF CI and will work on those.

As for the failure in netdev CI however I am not so sure.
Looking at net-next-2026-01-05--12-00, the only failures triggered by my
change are also the ones from the bpf-ci. Are these the ones you meant,
or am I missing some others?


Thomas


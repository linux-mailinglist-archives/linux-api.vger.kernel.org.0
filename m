Return-Path: <linux-api+bounces-5620-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E7D12D3E
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CE7D30021FE
	for <lists+linux-api@lfdr.de>; Mon, 12 Jan 2026 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD92D47E3;
	Mon, 12 Jan 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KYQdp0nD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PqZ2/STn"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05A27E07A;
	Mon, 12 Jan 2026 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224825; cv=none; b=XP1Vxf7GwlMqdkzuzDUv5I4DsG4RhWC/8V1uAze2w+OFZrz8TF0lvoZ8yQgIcpWE1trlWC9SbafNXm4pLnQsaNqVs7GG6b4qF89hH8J7pOCVva80VyJYj8Mm1EpnPV6bP6qPu4iPMie6iFf5PHojWnijSSDSMB7kf+moDHw1IQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224825; c=relaxed/simple;
	bh=EYL6qPvUJNB85ib1joVC7jyA9C3txlDMBBMZAbT+6eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpYBFVhqyAKG3lbrLRgqbqAjX1NNynRsQ2viW4gmhaTwnhtd/0M0Nfc+aoAA68nia2UueVaIuvffctwG70aqasknFzSnpx6GaeEy4obXva8MCiKPmThsltn48K7cBaf8z0CEUz7pXbaF026FXpE8K698CMkOcvpdR4NowSaEb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KYQdp0nD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PqZ2/STn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 14:33:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768224821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWj4H2Lgq+WhqUr9o6eZinAp459hvArUl+5f/ZqyT2k=;
	b=KYQdp0nDiI90EXdJkoIOi3C2UwZe5hY0UxJtySajl+TmkR9u5p/91NT4ihNdKxuCS0uhr1
	63n+WT/0FbnSc4MQog88JJqgockJZBGurJFgngg+edfeHTVuP2oYKUizksKYJvnrD+i2u8
	vXX0j3en1zIKt8YwNUgBVxVGManZM1vJMrny6o5ha59uaqeXBAIf8888HOYnXafPkP/x7W
	wrQL+mwVuUY1ktJhNuecKsD4L2OH3+DVt0pMPUgB6yDLXun0SB760gfrfrXSKGlfxrJDpC
	zPDvFcpX7XGpmPQBBTxrMijN9KzA+PNxab+4TCnwTm1Jme2LV745CQYVvw2HgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768224821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWj4H2Lgq+WhqUr9o6eZinAp459hvArUl+5f/ZqyT2k=;
	b=PqZ2/STn7G+lEHLlQVIIXDb3DYQhyKIMPjO8HDgx2dsjxMNawG+2VKJ3dkRwZspGS8y2uH
	oz1kuz7zjdP3k2Ag==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Message-ID: <20260112143158-efc74534-0283-4db1-812f-402794eb8844@linutronix.de>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <20260105095713.0b312b26@kernel.org>
 <20260106112714-d47c16e0-0020-4851-9c2a-f8849c9a0677@linutronix.de>
 <20260106151313.1f8bd508@kernel.org>
 <06cf1396-c100-45ba-8b46-edb4ed4feb62@app.fastmail.com>
 <lhu7btnkqg6.fsf@oldenburg.str.redhat.com>
 <20260112124604-dbf7f68d-2182-438f-9495-2931cac02a81@linutronix.de>
 <lhutswrj73u.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lhutswrj73u.fsf@oldenburg.str.redhat.com>

On Mon, Jan 12, 2026 at 02:25:25PM +0100, Florian Weimer wrote:
> * Thomas Weißschuh:
> 
> >> If you call the data member sa_data just like glibc, it will only fail
> >> in C++, not C.  GCC considers the two definitions sufficiently
> >> equivalent (even though glibc adds a may_alias attribute to meet POSIX
> >> requirements), and duplicate definitions are permitted in C.
> >
> > clang is not so lenient and will error out.
> 
> It seems it accepts it if you switch to C23 mode.

The currently supported baseline for UAPI headers is C90.
We can't really force userspace to switch here.


Thomas


Return-Path: <linux-api+bounces-6331-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANmJM6/7BmrtqQIAu9opvQ
	(envelope-from <linux-api+bounces-6331-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 12:55:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1354DD4B
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 12:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D8C831F5C75
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2026 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90063D1AB0;
	Fri, 15 May 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="BrKZCENd"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A73CF04C
	for <linux-api@vger.kernel.org>; Fri, 15 May 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840920; cv=none; b=X6jPvLNMzWcYMirZCD5lIXdCr4mwP6wAoXl1lNVPDnz7hH1IInwuyTQXwls4TtWiAvs235WT0bhAoI+VmJiAq99anew1tjzlUCLs4MAEx/y0q7UBxeV7ylnf8snNgkEXRWBoyeYAbnVwyCQjDn/thFRlTraQyokcROjNjefj07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840920; c=relaxed/simple;
	bh=c1fZt+EhMaze7Xfv6jg9YLHTIZyZz3e+ZzgOB76j/zg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NTxEGjlzv1G1gfXPfubxfIdnkYzpJiNFOBR+tedTLKH8DxnvNFyDTVi93xnwUXPeMumit2Z6cIdaLqSIfWEca5yyu+Y8TtYnem8evzITE5oWVyYSUvycjhBrFynZpA9onmX9JAD9ZTbi+tQrTGQoNBFd38PrlW1xQrbpflrfL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=BrKZCENd; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: ac30a75c-5048-11f1-8ff5-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ac30a75c-5048-11f1-8ff5-005056999439;
	Fri, 15 May 2026 12:27:28 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id ac2d0699-5048-11f1-83d9-00505699891e;
	Fri, 15 May 2026 12:27:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=o+g3oIspZbQxd4700CmXmbRknUGWU2/T9rWbT6maPsU=;
	b=BrKZCENdur7yuFODlIfAa8ogi0Hi1f20puRaGYymT8J/K7cHTgJH0tJG4FBH4o0AA6yWHjfhdqzuH
	 6tNdJCWnwpIfHHG+5drLbA2fp8F7kTMFmrRDTUn7qiwIRIxYyg3qBaRu5meZgMhA9OiSG0lCdC7bwl
	 xfZBbJiWVtPkgJfTY+es2asORWKmDiMS1zUHcYccxClnvWsYqOeFgqxRgMYCI/EAbfNq20uLfAGcqK
	 sCE4t1vrD1Y+5jDdZXTB+4bdpyTAdO/p5ZsDr5u/8vH4yRUsbczHWh2QCBCmqk87uLrf4s2G/sI1RM
	 KkXcJRuQ/mKEWxTkruV7XP5Niyvg+AA==
X-KPN-MID: 33|n7vdFBOu3qaOaFYpGwBVO23jTXHQGyzA2ld9/dY8vyt+nZ0VZlhfMH50V1m/wgv
 p/zkXPO9528LxOx9CJHxJ4J010gYAOgZ27KYuIh57s34=
X-CMASSUN: 33|9Yh2PtNWWkBqhq1nMV5YM2PHOEAM+WUkKvQkhhqaMqRaz2jZNBD11g0Y3PDgFJ5
 iZeCGLx6fDeudO0tuJZ3XyQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id ac24601a-5048-11f1-94b1-00505699eff2;
	Fri, 15 May 2026 12:27:28 +0200 (CEST)
Date: Fri, 15 May 2026 12:27:28 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Weißschuh <thomas.weissschuh@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	cmirabil@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Message-ID: <1107708899.1358192.1778840848108@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <20260427-umlegen-aufbau-ee3a97f1528a@brauner>
 <1600596489.77018.1777916475931@kpc.webmail.kpnmail.nl>
 <20260511-hochdekoriert-neoliberale-f7a2922bc57c@brauner>
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns
 an O_DIRECTORY fd
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: 32E1354DD4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6331-lists,linux-api=lfdr.de];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


> Op 11-05-2026 14:00 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> mkdirat2() is objectively the worse api. It forces userspace to use a
> separate system call without any reason whatsoever. If you can to
> O_CREAT you should also be able to to O_DIRECTORY in the same system
> call. If we support O_DIRECTORY | O_CREAT we get all the lookup
> restriction niceties RESOLVE_* for free. Plus, it is supportable both in
> openat() and openat2() because I made that combo return an errno.

I don't disagree. I know that some of the UAPI feature requests are not fully
flashed out, but at least it gives a basis to get the discussion going.

In fact I already have a O_DIRECTORY | O_CREAT patch that at least passes
some initial tests. However, I need to sit on it a little bit to think whether
I am not leaving something out. Also, I understand why vfs_create() wasn't used
in the O_CREAT path, for instance because you cannot just make use of may_create_dentry()
there. But now that we are going

> 
> UAPI design often is a nasty mix of performance (context switches),
> separation of concerns and privileges, tastefulness, and compromises you
> never thought or wanted to make.
> 
> I think here it is pretty clear that O_DIRECTORY | O_CREAT is the right
> thing to do. Instead of restructuring a bunch of codepaths so it can be
> plumbed through to the filesystems we just reuse the existing codepaths
> that give us the right context for free.
> 
> And during LSFMM the VFS maintains all agreed to proceed with
> O_DIRECTORY | O_CREAT.


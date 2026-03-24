Return-Path: <linux-api+bounces-6033-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCVtM/tMwmnvbAQAu9opvQ
	(envelope-from <linux-api+bounces-6033-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 09:36:11 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB41304BA7
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 09:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4836C30075D2
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 08:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7136D51B;
	Tue, 24 Mar 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVnjhA/S"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A52315793;
	Tue, 24 Mar 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340424; cv=none; b=Z6co55xkIGbECr1psVpbJnPY8mjcaoIZT5VN+lBQZtKCFdQLkxNkRRGZ3o75ibxj/JoeCfEDvgDxsfQj1BM7Lzlo7JL+v6eJKqoiKvEj7+n1IiJUcd6himwvros9MKpRJjWKbdCrj1WypBC3AQ1RbqdoB1E7bx7f77iNLHmlZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340424; c=relaxed/simple;
	bh=B3kyXlmEq13caqQrNaU86Hb/JRfeTL9rcrJV9xcXokw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJwaWyVqZC672tvCH3uemDPcM87mzbxavSfeuYNAPqq6mjNvmF/4PwincQyvp1KNuOoGBqrZXmPVHKSkyISPrFQWa42CwpHwPg86d6LAWKVW47RsHH6mRONlLmy5M5cQZf1wJtGF/hFaarzGRAnxbItE2A9b+XdRjwtKNtvc6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SVnjhA/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A48AC19424;
	Tue, 24 Mar 2026 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774340423;
	bh=B3kyXlmEq13caqQrNaU86Hb/JRfeTL9rcrJV9xcXokw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SVnjhA/S24RkfOLk24Js6bYFNLDZ/CMgcY5Xu5WUp5rIEAjvRgyhnm7NmM0nX41Ey
	 +CyJoTys0eXf7tVjeN9Ef8dqfiUb1eN26U5K5zj8OeEF1lghIsu/GtZtn0h2CnCLS1
	 5YADBioRSmBZTvTjzz5f6tqRT1mgHix4a6QZLveM=
Date: Tue, 24 Mar 2026 09:20:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/9] kernel/api: add debugfs interface for kernel API
 specifications
Message-ID: <2026032411-paramount-lapdog-41e6@gregkh>
References: <20260322121026.869758-1-sashal@kernel.org>
 <20260322121026.869758-4-sashal@kernel.org>
 <2026032309-jargon-stalling-28c2@gregkh>
 <acHTupVGxJR3gmFT@laps>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acHTupVGxJR3gmFT@laps>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6033-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,linuxfoundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4FB41304BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 07:58:50PM -0400, Sasha Levin wrote:
> > But this only works if the kabi stuff is built into the kernel image,
> > right?  This doesn't work if any of these abi sections are in a module
> > or am I missing that logic here?
> 
> That is correct, for now.
> 
> I'm only trying to tackle syscalls to begin with, and since no syscalls live in
> modules, we have no need for module support.

We used to support syscalls in modules, but thankfully that is now gone.
But, how will this work for stuff like usbfs ioctls?  That is a module,
and our uapi is, by far, in drivers through ioctl "hell" and that would
be great to be able to document through all of this.  Will that just not
be in the debugfs api?

thanks,

greg k-h


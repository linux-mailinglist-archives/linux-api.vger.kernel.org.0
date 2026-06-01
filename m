Return-Path: <linux-api+bounces-6488-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EzecJAnkHWo0fwkAu9opvQ
	(envelope-from <linux-api+bounces-6488-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 21:56:57 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD9D624CF6
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 21:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF97C302BB82
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 19:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD6385D67;
	Mon,  1 Jun 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQajPwgU"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE537DAB3;
	Mon,  1 Jun 2026 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343738; cv=none; b=CScj5SsNyuusvmcPA8x78oNwtxLe9avqburXjRSbDHyLgUh608XNVJ689fOMwW+7YjapdZkxGljrrRouVZ1yJJjp1VjlfTPlmtxf2L9CUztihcDbEo9dS+p0Z72ebFIRSm0IRUTc6VAxw2zonFVzVhEmOjDhHrpRnwaeTVACPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343738; c=relaxed/simple;
	bh=uW8BgLcKXeWCr1hOUHfg6YdmNr/u6dKf80Ywx087aaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5mM77AhBhSBOr3TwU+Eq27QxClXQgqyJ2Jb16KNw4VHumKbNFBmNNLgd1XjZDo+Nxxk2AR3bSU3HrNgXNNZPNeV2BLdR9NdQq44JBYnCYFJ3fiNG5xjzwrlwNMoMfR0sgn8Ylzf2qOUCO8e8vOYdh02KUz+2v+yoW27pfQi4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQajPwgU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF631F00893;
	Mon,  1 Jun 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780343737;
	bh=rzAAcVnBObtsD4DzRUXCCaUoF+wigWmV5eP+yceRm6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BQajPwgUvU6B9J4ZcgsDDOzuz5NUEl/Cdbm63kkJ0ppoFFiVpz33fqC9Y8FYW5m/v
	 sCvvIFMmJSPZOVTLFtboEUk83KdJrNEUJcjHRKVjN4dnmtzuGuIWumxncjlnvLj98X
	 0jY4mrC+QiTFrLox+sg2+t4sGY7v0rqV9IUDTsPQdrUwT84MHvC4nYTEDNrEya9RSo
	 Zon9PWYBjXAG2Ho2RqQhIwfgg1R76bU7JIPRbgXbHNdUT79zoAXielIIVMN/CHDCp4
	 GMUL7nWdvoDesnKGStsEmO+VWgqoA9uqJhT10xS1OvogwOVOvo9DFhhBo1U6FzIYCe
	 M9+J9tkesQeMQ==
Date: Mon, 1 Jun 2026 12:55:37 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Li Chen <me@linux.beauty>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
Message-ID: <202606011254.5FCBD65@keescook>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6488-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EBD9D624CF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 01:02:53PM +0200, Christian Brauner wrote:
> On Thu, May 28, 2026 at 05:52:21PM +0800, Li Chen wrote:
> > Hi,
> > 
> > This is an early RFC for an idea that is probably still rough in both the
> > UAPI and implementation details. Sorry for the rough edges; I am sending
> > it now to check whether this direction is worth pursuing and to get
> > feedback on the kernel/userspace boundary.
> 
> The idea of having a builder api for exec isn't all that crazy. But it
> should simply be built on top of pidfds and thus pidfs itself instead.
> It has all the basic infrastructure in place already. Any implementation
> should also allow userspace to implement posix_spawn() on top of it.
> 
> fd = pidfd_open(0, PIDFD_EMPTY /* or better name */)
> 
> pidfd_config(fd, ...) // modeled similar to fsconfig()

FWIW, I agree this should be modelled after fsconfig and built on pidfs.
Doing so will avoid a bunch of design issues, etc.

-Kees

-- 
Kees Cook


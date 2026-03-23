Return-Path: <linux-api+bounces-6031-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKnOBoRgwWmaSgQAu9opvQ
	(envelope-from <linux-api+bounces-6031-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 16:47:16 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BE2F6E77
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE0B5308E4E1
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC33C9ED1;
	Mon, 23 Mar 2026 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJ5hRoCK"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58A3B2FEF;
	Mon, 23 Mar 2026 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279129; cv=none; b=rne/jwOse9HAPD/4Q7ZEzh/GIUdAN7Z9DmAfgpUcOEO2WmSyd90K4kW0vV+6rR3Y6yEstCzfySu3/AUQ8LvVnfcyWyKRRdenuh+tb+32Ak1SpoSvTFWQjlqg1TKqRstFRqlyS49cWDFOpPQJD9Mxbxy4oJ0Cs+rxATIov4vPiQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279129; c=relaxed/simple;
	bh=pbXYxhzMz1CXELl5GAMQGqn3VS0cXr+c3mpboLxq4hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmSXXN8c2WtH3wQQynNMPQ/4OJ1Uiby0h0yibazGqP0nyC08VKPKrqEkc2mYo/CrLemmjYefUxJhEgk+j+9xtLRyyydgJDuY1dBsKpzwQVR5QpZnJ8ozea5zTzisYi+u0qHwyFw4HtTHUCBw2oZbBuStV0Gh2a7JNJHtZkfRpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJ5hRoCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CCBC4CEF7;
	Mon, 23 Mar 2026 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279129;
	bh=pbXYxhzMz1CXELl5GAMQGqn3VS0cXr+c3mpboLxq4hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJ5hRoCKajUHc8KKiBAP2gYu1mVfUOfWRR6xc1nDC/KmFM8FTX4OS4y9Nfd8vhfAi
	 J23Pc2XVcANhfXnjGTAo+urvXkyrzow5gFm2OspORm1S/DdOvkBQZXlQYlKUBUvn28
	 tpGOuXncYvNz+HkAvROWP9p1b6eqV6ah8hy5xkd8=
Date: Mon, 23 Mar 2026 14:52:58 +0100
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
Message-ID: <2026032309-jargon-stalling-28c2@gregkh>
References: <20260322121026.869758-1-sashal@kernel.org>
 <20260322121026.869758-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322121026.869758-4-sashal@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6031-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BC5BE2F6E77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 08:10:17AM -0400, Sasha Levin wrote:
> Add a debugfs interface to expose kernel API specifications at runtime.
> This allows tools and users to query the complete API specifications
> through the debugfs filesystem.
> 
> The interface provides:
> - /sys/kernel/debug/kapi/list - lists all available API specifications
> - /sys/kernel/debug/kapi/specs/<name> - detailed info for each API
> 
> Each specification file includes:
> - Function name, version, and descriptions
> - Execution context requirements and flags
> - Parameter details with types, flags, and constraints
> - Return value specifications and success conditions
> - Error codes with descriptions and conditions
> - Locking requirements and constraints
> - Signal handling specifications
> - Examples, notes, and deprecation status
> 
> This enables runtime introspection of kernel APIs for documentation
> tools, static analyzers, and debugging purposes.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Debugfs logic looks sane, nice.

But this only works if the kabi stuff is built into the kernel image,
right?  This doesn't work if any of these abi sections are in a module
or am I missing that logic here?

thanks,

greg k-h


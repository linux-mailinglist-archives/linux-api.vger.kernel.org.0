Return-Path: <linux-api+bounces-6010-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIDBKJC+umkGbgIAu9opvQ
	(envelope-from <linux-api+bounces-6010-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 16:02:40 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0AC2BDC3C
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 16:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DA433094F9D
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D343DD51B;
	Wed, 18 Mar 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMbtNwkb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08A3DA7F9;
	Wed, 18 Mar 2026 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845596; cv=none; b=T4PezzOunG4LsgIp8xGtPoUKYj0ar/qLddB54FP5SeLPzbDlpQ1BxGFITTcRzfAsqiS36g+qTQaL/VD2VHVwJ0EmcMS622Xacu7bvNOqw5D74vod/slgHBDlK67Wou9V1MplpJbPk/+JgdpFDXJ3lpkxanDqsKC2zIxODLvekPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845596; c=relaxed/simple;
	bh=P3RmEfeVl5rB1RolpuEMWoYT1Rcb+L0pzJIV0hoByz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnR3tHnxcWIsvMci8/ZA7sqxZ8MMELKGvexir3hypxvEGl2biWlvDr/X4ztPK+2x2YpAf1zNh2J7hnqs7EEtbW4dYU5QTtOUQImp5h8GoIAzMT56QCo+gc19JaL0Mh8W/E5XsqwvcLjFIks55CR+RmVszHjG9XCE3xzPvQFRT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMbtNwkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D76BC2BC87;
	Wed, 18 Mar 2026 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845596;
	bh=P3RmEfeVl5rB1RolpuEMWoYT1Rcb+L0pzJIV0hoByz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMbtNwkbW+OUuU+yZQ/XPWW5ssKtSEb4Ak7q/TSWFTi1wWOwPNs4+4ISaQx6iagfz
	 SkjanjkVNtPWbP0meWOJ7lP8DKAX82gAY7qP/HO0qgwANKwBEaLX+UKQbaJw+D6C4l
	 cR7MNfb7Ps3FMv0WCCEcuE7F6ICzla5fkKL5ZwacsE/BHx5ZsfODCGaESSn5M/1m9Y
	 Iy0rqm72AtdPHXAKQKIj3JK0t2PTMahvgBoriZKu9XfHjus3xtxWEYsxtM+bB8/69G
	 TbFSJHr6guXlhZ+mNEfKjW7nIs0+yBRKs+UvYe7qkKW6lSP3VJp0HT+Jq8r1Bu3hme
	 l/qsqdQKh8ryg==
Date: Wed, 18 Mar 2026 10:53:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 1/9] kernel/api: introduce kernel API specification
 framework
Message-ID: <abq8W0jDtwgSsUdT@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-2-sashal@kernel.org>
 <87h5qe9wig.fsf@trenco.lwn.net>
 <20260318070055.39f1af80@foz.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260318070055.39f1af80@foz.lan>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6010-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,vger.kernel.org,kernel.org,linuxfoundation.org,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:email]
X-Rspamd-Queue-Id: 1D0AC2BDC3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 07:00:55AM +0100, Mauro Carvalho Chehab wrote:
>On Tue, 17 Mar 2026 11:49:27 -0600
>Jonathan Corbet <corbet@lwn.net> wrote:
>> So the reason for two completely separate mechanisms is not entirely
>> clear to me.  The kerneldoc variant is essentially documentation, while
>> the macro stuff is to be built into the executable?  What if you want
>> both?
>
>You can easily add support at kernel-doc to output such macros.
>
>All you need is to create a new class derived from OutputFormat and
>make it produce any different output format, including:
>
>    #include <linux/kernel_api_spec.h>
>
>    DEFINE_KERNEL_API_SPEC(sys_open)
>    KAPI_DESCRIPTION("Open or create a file")
>    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
>    /* ... parameter, error, constraint definitions ... */
>    KAPI_END_SPEC
>
>I'd say that converting from such output to `.kapi_specs`` ELF section
>itself and/or to sysfs/debugfs - e.g. something that would require to
>compile or be linked with Kernel's compiled binaries should be done by a
>separate tool, but we should aim to have a singe tool to process
>kernel documentation markups.
>
>It is hard enough to maintain just one tool - and to have people actually
>writing documentation. Having a second one to handle it, with a different
>format will likely increase a lot the documentation burden.

So this is exactly what happens under the hood :) kerneldoc outputs these
macros and they get compiled ito the binary.

I exposed the macros as an option since they're there anyway, but I'm happy to
hide them as internal plumbing too.

-- 
Thanks,
Sasha


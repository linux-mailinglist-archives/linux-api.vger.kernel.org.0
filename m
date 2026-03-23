Return-Path: <linux-api+bounces-6032-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKehDVHVwWmgXAQAu9opvQ
	(envelope-from <linux-api+bounces-6032-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 01:05:37 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA592FF3EC
	for <lists+linux-api@lfdr.de>; Tue, 24 Mar 2026 01:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2D53105719
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2026 23:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FED38A700;
	Mon, 23 Mar 2026 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X09WVTvq"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA3389DED;
	Mon, 23 Mar 2026 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310333; cv=none; b=UvlVG1xKCQAx5X7qSqkOW1+a+z7nFyFSwnZOaWAhLsg301cXu0KOq2K3PTt+zE20/mJ+AgTm/c7pO3WeIUbBSIBNbEPpL3uu8QVqBIHuPVgXWbon9SZ5ghd/seOunP2rujNPa5ZE1w0juI2jb+TbPXZskikBYlkfV22w/1769U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310333; c=relaxed/simple;
	bh=09tSdPc4KE+Wrg/3IyzHyq6uHIuy+tsDuWBUHfhcgjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVvAaeK6PImMCYzCpn70eTuhyy+4LLqYHIFnIXXxz9M676Q1QTChxyGf4wQEHhKX7j5g+q7lM0puPh4iNeZBy1Gxx96jP8pdTtSV9vEL343NhE+7hOu9fjuP2Y6BXz0hrJMeNGoT52U1B6HWLUv1G0v7LJE0u05DjqPiWM5qG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X09WVTvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0ABC4AF0D;
	Mon, 23 Mar 2026 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310332;
	bh=09tSdPc4KE+Wrg/3IyzHyq6uHIuy+tsDuWBUHfhcgjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X09WVTvqUzVe6286hdc2QsmRNSrbRb/vw8cWztfvWQ/PsFia8VsgYRjUvi7fytYj+
	 g77WCldW1KRYfVbqbGvEI953LKcCNiEpqhig+r7z9IXJDtjpbYODlu/5zeqtRPqTGl
	 WGFYbpUlPhvB4Y75BfaWj+EOwtbx6eoAbzTVsqSmc+la018UkNZJRWX2ZIKWR59p4/
	 dEHJmDDGskDJimUR5GDykm4AHl27pHnJCuPITXKXDVOD1RFmz/XTClYe9AUIzQX61T
	 LFm1pUBIv7zc90cEmkak7xQ5+RDcJVj8E2QhFGQqd9DX4R+o5OgtdCSZKMirZgEL8o
	 3doxRZ3Z7A/XA==
Date: Mon, 23 Mar 2026 19:58:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <acHTupVGxJR3gmFT@laps>
References: <20260322121026.869758-1-sashal@kernel.org>
 <20260322121026.869758-4-sashal@kernel.org>
 <2026032309-jargon-stalling-28c2@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026032309-jargon-stalling-28c2@gregkh>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6032-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,linuxfoundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCA592FF3EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:52:58PM +0100, Greg Kroah-Hartman wrote:
>On Sun, Mar 22, 2026 at 08:10:17AM -0400, Sasha Levin wrote:
>> Add a debugfs interface to expose kernel API specifications at runtime.
>> This allows tools and users to query the complete API specifications
>> through the debugfs filesystem.
>>
>> The interface provides:
>> - /sys/kernel/debug/kapi/list - lists all available API specifications
>> - /sys/kernel/debug/kapi/specs/<name> - detailed info for each API
>>
>> Each specification file includes:
>> - Function name, version, and descriptions
>> - Execution context requirements and flags
>> - Parameter details with types, flags, and constraints
>> - Return value specifications and success conditions
>> - Error codes with descriptions and conditions
>> - Locking requirements and constraints
>> - Signal handling specifications
>> - Examples, notes, and deprecation status
>>
>> This enables runtime introspection of kernel APIs for documentation
>> tools, static analyzers, and debugging purposes.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Debugfs logic looks sane, nice.

Thanks!

>But this only works if the kabi stuff is built into the kernel image,
>right?  This doesn't work if any of these abi sections are in a module
>or am I missing that logic here?

That is correct, for now.

I'm only trying to tackle syscalls to begin with, and since no syscalls live in
modules, we have no need for module support.

-- 
Thanks,
Sasha


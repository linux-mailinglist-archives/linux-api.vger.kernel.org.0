Return-Path: <linux-api+bounces-5957-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAc5ENUztGn4igAAu9opvQ
	(envelope-from <linux-api+bounces-5957-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:57:09 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFD286739
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BDA73065706
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA035F613;
	Fri, 13 Mar 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqOmm3A0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972235E94B;
	Fri, 13 Mar 2026 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417155; cv=none; b=u7NHl7NVuGNHFkWufwo3U8eA4qW7f8LcgFgfrLI52jsw8JAQfxHuCXbL8QJOEh1nY/pFPaeQJ72d36rfi8Z/A65DO0bfAkQLA1tORSMczy6RdE9yG/9qrLHTkx7Z99VP3MT0kNC+D80x828l9Y1RbCR12wNSxgj7mvNPH892WuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417155; c=relaxed/simple;
	bh=cLD4UeOXJEUjkMvUeEZ9aUKn0n85Sd7Thbn1qGBM0uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4iGlZLhYkIV7tjDL2IRxRJRh++h7GciVJqF9W/ZXX/CDPuCleA2RpqKPptCYSAJePVtKwcZ08IoD6U18bcuH/JnK3xC09U/llpZEYOmZwhciD01+Q1zqGUOtIBl6DYZxvUAZh470Mi/vzwdIvAdgzG8t1wQd9PQAPRnb9ZUxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqOmm3A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA18C19425;
	Fri, 13 Mar 2026 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773417155;
	bh=cLD4UeOXJEUjkMvUeEZ9aUKn0n85Sd7Thbn1qGBM0uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqOmm3A0UZs9o+49rm7NCPNLl6y2BgofzBQ/MVdHloql3+txX9ZVv6nIClHxFk7D0
	 NxcnY6lKcEMxCqba0hVKiM+eb5ldNI4tGaTnjM5MliA8h9J3pZ6UQkctN7+z79HObz
	 E3+AUjS96c53npC+NNUFW0NFVEnBwWvYXdq7mx7I=
Date: Fri, 13 Mar 2026 16:52:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH 6/9] kernel/api: add API specification for sys_close
Message-ID: <2026031321-steadfast-fang-ba42@gregkh>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313150928.2637368-7-sashal@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5957-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,linuxfoundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FBFD286739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 11:09:16AM -0400, Sasha Levin wrote:
> + * notes: This syscall has subtle non-POSIX semantics: the fd is ALWAYS closed
> + *   regardless of the return value. POSIX specifies that on EINTR, the state
> + *   of the fd is unspecified, but Linux always closes it. HP-UX requires
> + *   retrying close() on EINTR, but doing so on Linux may close an unrelated
> + *   fd that was reassigned by another thread. For portable code, the safest
> + *   approach is to check for errors but never retry close().

We don't care about HP-UX :)

> + *   Error codes from the flush callback (EIO, ENOSPC, EDQUOT) indicate that
> + *   previously written data may have been lost. These errors are particularly
> + *   common on NFS where write errors are often deferred to close time.

What flush callback?


> + *
> + *   The driver's release() callback errors are explicitly ignored by the
> + *   kernel, so device driver cleanup errors are not propagated to userspace.

What "The driver" here?  release() callbacks aren't really relevant
here.

thanks,

greg k-h


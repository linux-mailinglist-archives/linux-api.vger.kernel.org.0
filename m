Return-Path: <linux-api+bounces-5987-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPp2GsdVtmlQAgEAu9opvQ
	(envelope-from <linux-api+bounces-5987-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 07:46:31 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26B29017B
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 07:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9163305C3E6
	for <lists+linux-api@lfdr.de>; Sun, 15 Mar 2026 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75591DE8AE;
	Sun, 15 Mar 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4sTG/4E"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136417B50F;
	Sun, 15 Mar 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773557186; cv=none; b=Eo7dsggxidqCW0S+rgPYE5uMqNqHlW7RqpVPR7yekSqNkuee6Q2M/WojHwOX+4/bjhsGONEk9YuGC841wsvSpnM9lBSDQr7gdX1y5W9WmSp6bg8lAMfcuBQNHVyBHTGz4ia1rpb8glI4H0RCqgIzG33DUS/J7EaCUQD8H84ilaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773557186; c=relaxed/simple;
	bh=IpUTDcZ1Uu4Z1bfflk4CngBLm8hUBNUIhtC4bYm5ODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqkSKKnY17k9HaBeX9eWjSJn1jXckSjh6Zum4IKjCCyfCJ+q7JK9+9aSaTmVE97QwXDcH26LUsY81Oh29LUdKOldq7znSJfEVArP3BFBZdlM4HfWgeTGxEgEjJg8fs1qOkO5KzJ/dNqjZpZxIxy3YcdRMo8LlKE3zsV1MdZIBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4sTG/4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B7DC4CEF7;
	Sun, 15 Mar 2026 06:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773557186;
	bh=IpUTDcZ1Uu4Z1bfflk4CngBLm8hUBNUIhtC4bYm5ODw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4sTG/4E6mbg52QlUCguplRl3s+AbHo/83S7cwIrGRmYk7p6ogy+RDg5b5gNufUzM
	 XWlobTcH2/a8HyZR0gU2s0+avyy0Fza9PGIpBMLulzkWL6QjsUWBNKDiqTMw6nTODm
	 NXPXNVnC8Vr5cvZN598o/xc8pjrkX7Ya0b9boOwsgWg8rRcnQB4dTATj5TMKV81o3y
	 KqpoQB6xnb2BuzgFny89j5tSBGOXe3SBzu4jGmOrQqK/ZH+Aa/8d0zdoIKVq1PWIsP
	 EsFrwGyjyj2BkZ9IP7N0DqY4AZ8A7l3Ye6N1a6aiAUFLCLFUwBQw9Y3AbCaTirhNSN
	 wD0KzKDOK75nQ==
Date: Sun, 15 Mar 2026 02:46:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>, Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
Message-ID: <abZVwFwKSsxvwCw3@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260314111822.63a2ba4a@kernel.org>
 <20260314224435.35465615@pumpkin>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260314224435.35465615@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5987-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0E26B29017B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 10:44:35PM +0000, David Laight wrote:
>On Sat, 14 Mar 2026 11:18:22 -0700
>Jakub Kicinski <kuba@kernel.org> wrote:
>
>> On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
>> > This enables static analysis tools to verify userspace API usage at compile
>> > time, test generation based on formal specifications, consistent error handling
>> > validation, automated documentation generation, and formal verification of
>> > kernel interfaces.
>>
>> Could you give some examples? We have machine readable descriptions for
>> Netlink interfaces, we approached syzbot folks and they did not really
>> seem to care for those.
>
>The whole thing reminds me of doxygen comment blocks.
>They tend to make it hard to read the source files, hard to search
>the source files (due to all the extra matches) and are pretty much
>always out of date.
>
>The kerndoc comment blocks for trivial helper functions are hard enough
>to keep up to date.
>
>The only way even parameter descriptions are going to stay correct is if the
>compiler is using the definition and only the comment part is extra.
>For error returns you'll need the documentation to be at the return site.

When CONFIG_KAPI_RUNTIME_CHECKS is enabled, the specs are enforced at
the syscall boundary. The SYSCALL_DEFINEx macro grows a wrapper that
calls kapi_validate_syscall_params() before the real implementation and
kapi_validate_syscall_return() after it. Parameter constraints (ranges,
valid flag masks, alignment) are checked on every syscall entry, and
return values are validated against the documented success/error ranges
on every exit.

If a spec goes stale, it has runtime consequences. A new flag bit added
without updating the spec's valid_mask means callers using that flag get
EINVAL, which any test exercising that path catches immediately. An
implementation returning an undocumented error code triggers a warning
from the return validation.

The selftest in the series (tools/testing/selftests/kapi/test_kapi.c)
exercises this with real syscalls, both valid and invalid inputs,
verifying the validation layer catches violations.

-- 
Thanks,
Sasha


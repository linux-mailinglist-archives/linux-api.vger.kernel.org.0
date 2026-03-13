Return-Path: <linux-api+bounces-5961-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JX6Az5EtGk4kAAAu9opvQ
	(envelope-from <linux-api+bounces-5961-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 18:07:10 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E3B287D03
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 18:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A81C532764F8
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB543CB2F8;
	Fri, 13 Mar 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyKdwyFg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692F3CB2E5;
	Fri, 13 Mar 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420922; cv=none; b=SPHT9lAvr3gn/x22fbGN/pqmVURW6C1oP3ZMdn092rNsgFnUn72Tj/8NHElVtIyFFgL0P1DIUrWCr6RJ9rOn0EP6bK+0FTEGZLKdxjW1OJKpWaQBlS878lW0cnf79ax/1fLlQ8KlfML0My9dhyZw+kWwu1yqCotwQxXAN+yYtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420922; c=relaxed/simple;
	bh=baiNm/cmPS4XXblwmiJyoB/1uw5qigLq+GeTLGJPF7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtAeb0qyOqUUFKMoc1Sv9n3tyBczgloq5Y0aZRL/UhgaK7yaewgdk0diJmajr10vbhBBuJcENlsolC+U2IB89qpyWnNMrQRoduwVm+eJIBnXxcyhIurgHc6WCaJJsChY0P/Subv29bkqGS5tDQGYs4jUp299lcAsTeFl0cJxrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyKdwyFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1494BC4AF09;
	Fri, 13 Mar 2026 16:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420922;
	bh=baiNm/cmPS4XXblwmiJyoB/1uw5qigLq+GeTLGJPF7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyKdwyFgZEkFhnwl3H84TQ4TiHRtNBGHnSUJpL+bbrRRWnxxGT/cpfpx+rsVvWHnh
	 ZJGDMxgAiyTJCuaTfVvPPdAVuamT2rutLRxRFI5VjwTyEJ2daklBGS2TLbfeUb2kPD
	 pp0VuJ3NZ1vSBWpHfuCNBRtvljh0T+i5av/c/wa+VTgOcQsDvkyyqRLmVcuSiOr+pa
	 nZbLuBH5yY8g4nhVcHZtDHYxhDb90Ou0/9vdx5fbcAl61v0k3nyon+xHtYJx8Ag51n
	 rxBDa4kvpAzMj9C5LjILB2EAczgYxXc9CdvtJ5NrJmKatW3/9v6GITgI44Fc/RQt4f
	 uos80lV7v5jrw==
Date: Fri, 13 Mar 2026 12:55:20 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <abRBeBI4Nh251wZi@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-7-sashal@kernel.org>
 <2026031321-steadfast-fang-ba42@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026031321-steadfast-fang-ba42@gregkh>
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
	TAGGED_FROM(0.00)[bounces-5961-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 60E3B287D03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:52:30PM +0100, Greg Kroah-Hartman wrote:
>On Fri, Mar 13, 2026 at 11:09:16AM -0400, Sasha Levin wrote:
>> + * notes: This syscall has subtle non-POSIX semantics: the fd is ALWAYS closed
>> + *   regardless of the return value. POSIX specifies that on EINTR, the state
>> + *   of the fd is unspecified, but Linux always closes it. HP-UX requires
>> + *   retrying close() on EINTR, but doing so on Linux may close an unrelated
>> + *   fd that was reassigned by another thread. For portable code, the safest
>> + *   approach is to check for errors but never retry close().
>
>We don't care about HP-UX :)

Fair :) The original text was contrasting Linux's "always closed" behavior
with HP-UX. I'll just drop that reference.

>> + *   Error codes from the flush callback (EIO, ENOSPC, EDQUOT) indicate that
>> + *   previously written data may have been lost. These errors are particularly
>> + *   common on NFS where write errors are often deferred to close time.
>
>What flush callback?

This was referring to f_op->flush, which filp_flush() calls during close.

But you're right, that's internal plumbing. I'll reworded to describe the
behavior without referencing internal callbacks:

   Error codes like EIO, ENOSPC, and EDQUOT indicate that previously
   buffered writes may have failed to reach storage.

>> + *
>> + *   The driver's release() callback errors are explicitly ignored by the
>> + *   kernel, so device driver cleanup errors are not propagated to userspace.
>
>What "The driver" here?  release() callbacks aren't really relevant
>here.

The original text was noting that __fput() ignores the return value of
f_op->release(), so even if a driver's cleanup fails, userspace never
sees it via close(). But agreed, that's an internal implementation detail
not relevant to the syscall specification. Removed.

Thanks for the review!

-- 
Thanks,
Sasha


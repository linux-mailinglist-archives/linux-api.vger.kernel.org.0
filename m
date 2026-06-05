Return-Path: <linux-api+bounces-6565-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NcfyAO0kI2qejQEAu9opvQ
	(envelope-from <linux-api+bounces-6565-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 21:35:09 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9D64AFA3
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 21:35:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=g5KmIlkS;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6565-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6565-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ECDF301913C
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2EE43E9C3;
	Fri,  5 Jun 2026 19:35:06 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C93CF1EE
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 19:35:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688106; cv=none; b=lQeCVVi5nQRftnXKRvQ8WSHCUuASVKnG2IE6pQ7YAWGAyVXOzVLChjpbd7jc9Od69rpH2/UhVR9QLLFoTEdpE3mFuCh20cEsjdq1gRhfRKCWZQ7dcfrqHbcoIT9MBAeA3NOwjGvgD01RiIu355FVMw2d46bANgVAlKVrUKgIHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688106; c=relaxed/simple;
	bh=cEHdvvSNdwEceaJjjNLPDHJB5qJnAkNGBAr1AdGqYtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8Ep1Q/cBiQ4GpzpMmrZMTZoBGQMgoIodOfWd7U6yA51yOIVi4bGlTDTJHLn3v6uepoDZeSSbdCKqAzG49Sl/K8mFikynQZWy5HSe3AmCtcpORP+ivSV38d2AuvLNT16RzOTZGezgf0rEFXfcTNRyS5Wo1vz8f0mJNUfTAXqVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5KmIlkS; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780688104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e20VlXH0aqUbMsSjeiYD1F+rMEEZP2T5xYCNs93/16g=;
	b=g5KmIlkSQqW8BLg1BgmU1XSaEaF0f9DF6jZVToXyos/PzYlXeKO2QTGb27BvTfODJPcBWS
	b3JjLmf3NVinTGE1wuPm46SK23jGhPVXs83bUpsl/qD1WPCe84txwcH0zup1EIb8YbB05n
	Fp4SUNkAEwFCl4Sh715BhnltxydWXbA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-4gD2I__oOQOhPKUCQMI3Cw-1; Fri,
 05 Jun 2026 15:35:00 -0400
X-MC-Unique: 4gD2I__oOQOhPKUCQMI3Cw-1
X-Mimecast-MFC-AGG-ID: 4gD2I__oOQOhPKUCQMI3Cw_1780688097
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44A29195608B;
	Fri,  5 Jun 2026 19:34:56 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.48.51])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9FCE765;
	Fri,  5 Jun 2026 19:34:50 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Richard Patel <ripatel@wii.dev>
Cc: x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 David Laight <david.laight.linux@gmail.com>,
 Andy Lutomirski <luto@kernel.org>,  Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>,  linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
 linux-api@vger.kernel.org, Arjun Shankar <ashankar@redhat.com>
Subject: Re: [PATCH v2 0/5] Usermode Indirect Branch Tracking
In-Reply-To: <20260605184715.3383415-2-ripatel@wii.dev> (Richard Patel's
	message of "Fri, 5 Jun 2026 18:47:11 +0000")
References: <20260605184715.3383415-2-ripatel@wii.dev>
Date: Fri, 05 Jun 2026 21:34:46 +0200
Message-ID: <lhu1pek4w89.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-6565-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,infradead.org,intel.com,linux.intel.com,redhat.com,alien8.de,gmail.com,vger.kernel.org,sourceware.org];
	FORGED_RECIPIENTS(0.00)[m:ripatel@wii.dev,m:x86@kernel.org,m:hpa@zytor.com,m:peterz@infradead.org,m:rick.p.edgecombe@intel.com,m:yu-cheng.yu@intel.com,m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:david.laight.linux@gmail.com,m:luto@kernel.org,m:kees@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:libc-alpha@sourceware.org,m:linux-api@vger.kernel.org,m:ashankar@redhat.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oldenburg.str.redhat.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80A9D64AFA3

* Richard Patel:

> Adds basic support for x86 userspace IBT.
>
> IBT is part of Intel CET. It requires indirect call and jump targets
> to start with an endbr{32,64} instruction, otherwise throwing #CP.
>
> In summary, this patch does 3 things:
> - Config wiring ensuring supervisor XSAVE contains IBT state
> - Allow userspace to enable IBT via prctl(PR_CFI_*) for an entire thread
> - Enable IBT support (ENDBR instructions) in VDSO
>
> Unlike the arm64 BTI API:
> - does not support mixed usermode (all or nothing)
> - does not touch page table code
> - not enabled automatically (no ELF GNU note parsing)
> - temporarily disables IBT enforcement when handling signals
> These can all be cleanly added later.

Adding the ELF GNU note parsing can be added later, but perhaps not
cleanly.  I'm still a bit worried we might have to rev the markup
because too many binaries are in circulation that claim compatibility,
have never been tested, and are actually broken.  If the kernel does not
look at the ELF bits, things a slightly simpler.

How do you detect that handling a signal is complete and IBT can be
re-enabled?  Or is it re-enabled before entering the userspace signal
handler?

> The main question is whether glibc is happy with this prctl syscall API.

As far as I can tell, the prctl works for glibc.  Re-use of an
arch_prctl constant might have been problematic, but the series is not
doing that.

> There is one notable gap in this patch series, to do with signals:
>
>   000a: mov rax, 0x100a
>   000f: jmp rax
>   *** signal occurs ***
>   *** signal handler runs, does sigreturn ***
>   100a: nop
>
> The above sequence does not crash.
>
> With IBT, it should crash at the nop (because an endr64 is expected there).
> The IBT state (WAIT_FOR_ENDBR in IA32_U_CET MSR) is not backed up to the
> signal frame though.  So, when userland does a sigreturn, the CPU has
> forgotten that it was doing an indirect branch before the signal.
> (This specifically only occurs with signal handlers that sigreturn.)
>
> This is because IA32_U_CET is part of XSAVE 'supervisor' state, so
> regular XSAVE/XRSTOR can't access it.  Doing a manual backup is tricky.

That's a bit annoying.  Is this restricted to signal handlers, or does
it apply to page faults, too?

> A related problem is that the signal handler routine is not checked for
> endbr preamble.

That's not necessarily a problem because its address cannot be directly
overwritten in userspace.  Not all indirect branches need to be checked,
only those that have tweakable targets.  In fact, fewer ENDBR64 markers
are better (although we wouldn't drop the marker from a signal handler
specifically, of course).

Thanks,
Florian



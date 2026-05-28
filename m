Return-Path: <linux-api+bounces-6448-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBmeBEqJGGpnkwgAu9opvQ
	(envelope-from <linux-api+bounces-6448-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 20:28:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F295F646D
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10893300FB7B
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E86409612;
	Thu, 28 May 2026 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njOE3EuG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B6408032
	for <linux-api@vger.kernel.org>; Thu, 28 May 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992837; cv=none; b=ZTBr0IfdOQ6JwzxBBoLnX9f1i9wM+V0I5Xj6DFaNwu+ICHGFe5BWkVgSbM4ivtPFlNmh+9cuMTCyrlSJJwB9GjxEozQ+ytNVKmY8qO8MRlYXM4qAWjHdSOL20++SHASCbGtdX6M3RC4KBmBwJpiAOVcALy7zcDUI1e7n8dgMSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992837; c=relaxed/simple;
	bh=Bi/Ekqnmt+zfvrHKtNJFwE8S0+0gM1iROurgHj5oaVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMaIeih1bh5e+ApGhc2PfqZ/ajDbL5s59KE8FO00QSzMWKZzwx3mZ6Whsy5E8BIjAz4dP7EtX+bKL+18nQ/18EQCq+gd60vcj8ndevp0+kwqivNYX1VJp5Ez6UK3JvB/Sc6aegKC81EcKIr2wwNIENhz71voX+UvPAyNMQKwB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njOE3EuG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3201F01562
	for <linux-api@vger.kernel.org>; Thu, 28 May 2026 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992835;
	bh=uNFRPkLBDJywU48J/noDObDM2rNQtdyFBCATGMJKuNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=njOE3EuG3YaY1aqLR1PQz66Ex1f3r4CiGknKOWDez1lc1exX52GKvaY34ZhZBQpI6
	 w6fDDonhOwqCaYBRrsJaX1UOdElyDQTgs0C6qBKDH3YWDntCuxPKTPgKZhhpuUCu8r
	 Cz+DqZOZmMkd4SP+HcVdtVNTJHO0Q8r7OMedsTNiWlrkaGv5NOg6EawmBbGaa5oUzf
	 6kbKiuxwfxWYIbPxp97vEMg78BXlDBvLilLxB05WVYWSAyf7+BqAVvVOtTTeOCufO7
	 L70y2sLMwZ3XpPVa2AtA2Kj+TWYv/FqY/3Gw+5I16BB6azMBZ7GL+U8CxVMU4z7mUt
	 JX2GvXvpfvKLw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8891febd2so17247873e87.1
        for <linux-api@vger.kernel.org>; Thu, 28 May 2026 11:27:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9MSuWADfnHFbluZTOj1q4eSRAOtGqnxA3F4M/2t0zt5KwTARU0WI/z23q7z+gVhw0ScPsVCRJh7FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvlk5i0FU6uwNmhMycxmtbtit5jk2yh+BSv9I+B7sK+0Pg6Gy
	xkk2IJ/HZ9wtvnL4JOmObXs3zfwoiD3ZlykRbFNtAHroh6CBO1ZGOgEI50yc7orNa3Ycm4IsHMU
	rURkGd8H5a2eV2CFcWYP6KrLtZN3jNvtkpfxq9aWE
X-Received: by 2002:a05:6512:4017:b0:5a8:87fc:2b34 with SMTP id
 2adb3069b0e04-5aa57e2c285mr81991e87.32.1779992833237; Thu, 28 May 2026
 11:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty>
In-Reply-To: <20260528095235.2491226-1-me@linux.beauty>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 28 May 2026 11:27:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXqWcqn_79sMKnkyKOSAjg4AmcSHsuyH83oW8zJFoV6Dw@mail.gmail.com>
X-Gm-Features: AVHnY4IbWwLdSkNuWrooNBUAlyUyrWFavzF9Z8DQApcFhZZC4EFwzAXsIa5vxFY
Message-ID: <CALCETrXqWcqn_79sMKnkyKOSAjg4AmcSHsuyH83oW8zJFoV6Dw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Li Chen <me@linux.beauty>
Cc: Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6448-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.beauty:email]
X-Rspamd-Queue-Id: 77F295F646D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 2:55=E2=80=AFAM Li Chen <me@linux.beauty> wrote:
>

>
> The template pins the executable and denies writes to that file while the
> template fd is alive,

Please don't.  *Maybe* detect when it gets modified and clear your cache.

Or develop a generic way to open a new fd that's an immutable view
into an existing file such that the fd retains its contents even if
the file changes.  (Think a reflink that's not persistent and has no
name -- you'll need some way to avoid resource exhaustion.)

>
> Workload     Calls  subprocess  spawn_template  time_s       Delta
> (workers)    calls  calls/s     calls/s         seconds
> 1x16         6144      411.04          420.32   14.95/14.62  +2.26%
> 2x8          6144      666.78          690.08    9.21/8.90   +3.49%
> 4x4          6144      955.61         1003.25    6.43/6.12   +4.99%
> 8x2          6144     1048.25         1069.18    5.86/5.75   +2.00%

This is a lot of complexity in the kernel for a teeny tiny gain.

I'm with Christian -- a better spawn API would be great (and much
faster than fork/vfork + exec), but that's a different patch.


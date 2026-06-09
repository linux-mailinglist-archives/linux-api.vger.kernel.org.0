Return-Path: <linux-api+bounces-6585-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TXr7NsBYJ2oRvAIAu9opvQ
	(envelope-from <linux-api+bounces-6585-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 02:05:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA9965B43B
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 02:05:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eXuaGwnb;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6585-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6585-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE0943028F2D
	for <lists+linux-api@lfdr.de>; Tue,  9 Jun 2026 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5617557E;
	Tue,  9 Jun 2026 00:02:12 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF735975
	for <linux-api@vger.kernel.org>; Tue,  9 Jun 2026 00:02:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963332; cv=none; b=BAmR1zC5b1hHWvvQvAVa2FlYZLDhcvHVj0ZhAUv4JnIVguqFeHyC81NivVu2j5QqWX0Ngrt1+Qyc2q1BrD3GVYuZsTsVgE2kPyJIc8zxt/zDge17hvMeCxmeuRVbtNPAlfaaWm7VhLIjc+p+N1b1zFYmINNwowFcqgnBQm8NlSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963332; c=relaxed/simple;
	bh=ehhVnUUSPM5W6rCzz2GnQ6HvZZhXRe18DnMeQ/BamFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPLWMDz42zkaxYlDYuof/iQH2gr4uYXpO2BPFZp8hgCFGBRXm1tEWa68cOkWoj9DnaVXwq/jUREZEY5Gxn2TPzNfePXPgZVJ9Pyl2v5+osAjBzUG4+GpgpurL9mhzR1Jf6Bn1wXht+nP4sci7panXjVawA6MxsMDQ9wPM7nPDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXuaGwnb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7361F00899
	for <linux-api@vger.kernel.org>; Tue,  9 Jun 2026 00:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780963331;
	bh=woImH2BFt1btrxe26vw/Ytjm9bjqS1jpO9bbmq+ghwc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eXuaGwnbfl8E6wWfryKLt6weIAT4Z75+aTG0aA09Z+6+P+DvnOGzlfBa7qcSo+qls
	 CnpTVwlPYgMZb/84L+cL0zl/yqRgJgpiQNZNj3tyKzuJCDEXeuCmBvrTA9Twy/cyVv
	 13dmIrffNPg2+LY5j4c+OoGNTYA3oTB0OFQtwlO1BU7G5BkI/iPIk/xtxxFdXKpn2f
	 BYv2cBLQmh3UN/irun0I9IcmsMPa68yUN9BZELLHlZnykCZRfz486h56QvGFPkyGEV
	 Ks3lNGBKxpBu3lNX5505W24I53sadF6CTOf1KL2Lh9PVyzbofFtHL3rVYiFYyaOfNp
	 S+kOHw3mOgtxA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so4398841e87.2
        for <linux-api@vger.kernel.org>; Mon, 08 Jun 2026 17:02:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++CK5WF9Kd5WWFV2Pvrhdtm24JE0nu94zp7hNqT+Vi2mpMtHkeW9HuzgEH1FA8br9uVdytQbKSkao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWLjAIq/4V2Zo7rgqKmSeSDAjY5HJao21e09+iiDEHZbyE2S7
	XM94Aa0TpD5p41nWLDyL/YxJRvmQVHj3D4JuqQqvj/Klx9N7lbELzo81kZhW/8pbEGIMFLSVYpJ
	QtpgwF6QTRZB/GQJw86LFHuNJk6aUA4sgaRwfw71S
X-Received: by 2002:a05:6512:401f:b0:5aa:73e6:b6f8 with SMTP id
 2adb3069b0e04-5aa87c3b216mr4211255e87.35.1780963330006; Mon, 08 Jun 2026
 17:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
In-Reply-To: <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 8 Jun 2026 17:01:57 -0700
X-Gmail-Original-Message-ID: <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
X-Gm-Features: AVVi8Ce5fjaYqJFvbRl5NO-VXKi7ykDdQPBWcGcRNHTyLfWlxfmRoC6MkWLNyng
Message-ID: <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Christian Brauner <brauner@kernel.org>
Cc: Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6585-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:me@linux.beauty,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CA9965B43B

On Thu, May 28, 2026 at 4:05=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, May 28, 2026 at 05:52:21PM +0800, Li Chen wrote:
> > Hi,
> >
> > This is an early RFC for an idea that is probably still rough in both t=
he
> > UAPI and implementation details. Sorry for the rough edges; I am sendin=
g
> > it now to check whether this direction is worth pursuing and to get
> > feedback on the kernel/userspace boundary.
>
> The idea of having a builder api for exec isn't all that crazy. But it
> should simply be built on top of pidfds and thus pidfs itself instead.
> It has all the basic infrastructure in place already. Any implementation
> should also allow userspace to implement posix_spawn() on top of it.
>
> fd =3D pidfd_open(0, PIDFD_EMPTY /* or better name */)
>
> pidfd_config(fd, ...) // modeled similar to fsconfig()
>

After contemplating this for a bit... why pidfd?  Doesn't a pidfd
refer to an actual process that is, or at least was, running?  This
new thing is a process that we are contemplating spawning.  I can
imagine that basically all pidfd APIs would be a bit confused by the
nonexistence of the process in question.


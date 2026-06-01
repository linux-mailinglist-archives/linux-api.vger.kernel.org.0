Return-Path: <linux-api+bounces-6477-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG/DINDyHGq1UQkAu9opvQ
	(envelope-from <linux-api+bounces-6477-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 04:47:44 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ED1618E1A
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 04:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF203014BC5
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 02:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB91F1537;
	Mon,  1 Jun 2026 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="i4uWgPWD"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323A18B0A;
	Mon,  1 Jun 2026 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780282058; cv=pass; b=qWXDoZ1TeDC1hgTj8qFAG/jPDDnijm2I+0l/gxHR9UMHJMkOkWEPKyAY7XOCXDUfTtQWCMRBtXEObrmwTaJYAGoIWuTfCTIiBEXKSrIopsWh5M5TXLOVuKxCRcQO1gUM0N28IUPQWlIDOhd2fvzc9/0F5XoUwjDmfgzhc+yuZvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780282058; c=relaxed/simple;
	bh=+cvRLTMfGFbpnFcw0p+gJeOVuz5qvmXtedBnn0RfWWg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TlZXSo6YenwDM3/8ozDN5KS45uUnsR/Z/Jlq5EllS/4Wsi+vOZHtNrgOYpSzpQkiyivQwP5ZyH2s7nsw1AgJf9cIuzrzWXw6y7eGhTCj5jMqPVQcVg6WEGVYb0yeH9x3iaSvd54p6sMCynsrywCye4LnbMzuSLt0h3fx2WjraZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=i4uWgPWD; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1780282022; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VhevDLX+jcvxZX+UlQ+Wxz0FCFg+LjBiWzNfXWyC6bp6Q9wQBLfvAwEx84FhSc/2nYZEKzb5DRlJDZSC+u9RX6eI3lcoTwaTP+bngDtffMdxgy0dHAfNBeTwuHnvSQlf8j9fVwRw11AyP6yxXw5XpOCkIiIvlEkwtWG/5/Z4d9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780282022; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0j5y4eHjA2s58keIUCJbqELrbC/VcqvqjEm+eO/tp38=; 
	b=lSbIdqfNnvt2r8wfFWL9TJ+mSRjbsNaoUAeAFJg3rV8UeQlrUH8z8wrM2DJBd7PlbInrPAjQ4JwEphoQnD7v2eRO2MXq2PDbzWRcJaeXyF4L0qVs4Bqqb8Svz7eFAY2K5Y3KGnaH4I4H5pxLkHOCyGl6Q85F+yD/E/pRtJko0Ok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780282022;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0j5y4eHjA2s58keIUCJbqELrbC/VcqvqjEm+eO/tp38=;
	b=i4uWgPWDiFQiBL7nZhR4Fm2f/IlUPCFd62QikIjgStAEislo+YBK6vlj5POZsB6L
	SDFxCJQfURcxOAO4XbXQQHGZW6alw1m02iJZzYSa4l2UMWxuMeb+PCHrQ/VfjKbqJsW
	AK8cifPY6TEdUz6yVwpoT7hbCaJbJ8wLp6um5Q8k=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 178028202051664.08529719843057; Sun, 31 May 2026 19:47:00 -0700 (PDT)
Date: Mon, 01 Jun 2026 10:47:00 +0800
From: Li Chen <me@linux.beauty>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-mm" <linux-mm@kvack.org>,
	"linux-arch" <linux-arch@vger.kernel.org>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"x86" <x86@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
	"Andy Lutomirski" <luto@kernel.org>,
	"Thomas Gleixner" <tglx@kernel.org>,
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>
Message-ID: <19e8113d290.893abab26142069.5024234139508454104@linux.beauty>
In-Reply-To: <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
References: <20260528095235.2491226-1-me@linux.beauty> <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6477-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.beauty:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D2ED1618E1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Christian,

Thanks a lot for your great review!

 ---- On Thu, 28 May 2026 19:02:53 +0800  Christian Brauner <brauner@kernel=
.org> wrote ---=20
 > On Thu, May 28, 2026 at 05:52:21PM +0800, Li Chen wrote:
 > > Hi,
 > >=20
 > > This is an early RFC for an idea that is probably still rough in both =
the
 > > UAPI and implementation details. Sorry for the rough edges; I am sendi=
ng
 > > it now to check whether this direction is worth pursuing and to get
 > > feedback on the kernel/userspace boundary.
 >=20
 > The idea of having a builder api for exec isn't all that crazy. But it
 > should simply be built on top of pidfds and thus pidfs itself instead.
 > It has all the basic infrastructure in place already.

Yes, that makes a lot more sense. I was staring too hard at the "hot
executable" part and made the cache/template the API, which was probably
the wrong thing to expose. Sorry about that.

 > Any implementation
 > should also allow userspace to implement posix_spawn() on top of it.

That's so cool, and this is a really useful point. I had not thought about =
this as
something that could sit under posix_spawn(), but that makes the target
much clearer. It should be a generic exec/spawn builder first, and the
agent use case should just be one user of it.

 > fd =3D pidfd_open(0, PIDFD_EMPTY /* or better name */)
 >=20
 > pidfd_config(fd, ...) // modeled similar to fsconfig()

Reusing pidfd_open() with an empty target is nice because it keeps the API =
close
to pidfds, but I wonder if a separate entry point such as
pidfd_spawn_open() or pidfd_create() would make the "new process
builder" case a bit more explicit? Either way, the configuration side
being fsconfig-like makes sense to me.

Thanks again for pointing me in this direction. It helps a lot.

Regards,
Li=E2=80=8B



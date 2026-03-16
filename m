Return-Path: <linux-api+bounces-5999-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFbxKPmKuGmJfgEAu9opvQ
	(envelope-from <linux-api+bounces-5999-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 23:58:01 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FE2A1C54
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 23:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF05C300A631
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2453377EA5;
	Mon, 16 Mar 2026 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYytfHIU"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8FA35028C;
	Mon, 16 Mar 2026 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701878; cv=none; b=AjUNFH2jvGq8l3EzeX4JN+2Ffh2gMxrj46EKp7Il2z8ZAhMFG+EIh4S0p3DORtu7+hMh0rrU5P8qij1c51JyYO/7CRTCYzXuCeBkcKduO36LoIlqroT2voapv7XoStZaLu2/Qwj86FkXnGsbBQgDisUYX2j+OgvbPYbGkONb1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701878; c=relaxed/simple;
	bh=mEnlDtD+uMXBaY3t2IfkmLKFopSN2YDt1ilz6+WKW4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vu7xdIW5UxGQMMrJ5XOdy27SluBTkn49II5s8nY7NNTlOJ8Dru7UVX0sPPy9La+DlsEEHByA6rCZtAzGsRMn697SSIRvM8q2zxtN/MLCAXgEBHXlN7K8T7JhT7HkMIBWGk3hdINK/E3XNteVgHo2bhQjenwT9ssO2qxooowO2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYytfHIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B5CC19421;
	Mon, 16 Mar 2026 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773701878;
	bh=mEnlDtD+uMXBaY3t2IfkmLKFopSN2YDt1ilz6+WKW4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dYytfHIUOzat5FH4iDWFKQ+0LqEBB/CopaYZWcxqPfMn6TDVJ5aH2m7e7b6i2uI+G
	 njfJqsJHJEfJczHdFp+9mf+HI3bQ1IsCULV7Za2wDaYAEj9Fo0kh8Pi7OuDertqPRS
	 Rl0/jJqSngDaNVj6stP+jWC41xXtSehkjltX63SMWOlUwrzAnPwCmSA2iV+L1CjHhA
	 LnNsPapvzaV6qITwziVvpn7+IND6I895QjO8R0ZPpEt5pxkemP75Fgna1R/Tbpw178
	 fu0AaoYy8JiT2wSC0G1wnhYdgF9IahedQfdKYUX95VoEM5I5nt2m650V/+QJ3gT5aZ
	 kaEqPojDY5xFA==
Date: Mon, 16 Mar 2026 15:57:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sashal@kernel.org>,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org, Thomas
 Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis
 <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge <jake@lwn.net>,
 David Laight <david.laight.linux@gmail.com>, Askar Safin
 <safinaskar@zohomail.com>, Gabriele Paoloni <gpaoloni@redhat.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
Message-ID: <20260316155756.25b985f5@kernel.org>
In-Reply-To: <CACT4Y+arWePyxnV3hWk5RanWZpoc7=ALQ6DV_2MCuQkNoTtJUw@mail.gmail.com>
References: <20260313150928.2637368-1-sashal@kernel.org>
	<20260314111822.63a2ba4a@kernel.org>
	<CACT4Y+arWePyxnV3hWk5RanWZpoc7=ALQ6DV_2MCuQkNoTtJUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5999-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[googlegroups.com,kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,raw.githubusercontent.com:url]
X-Rspamd-Queue-Id: 0C4FE2A1C54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 08:05:53 +0100 Dmitry Vyukov wrote:
> On Sat, 14 Mar 2026 at 19:18, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:  
> > > This enables static analysis tools to verify userspace API usage at compile
> > > time, test generation based on formal specifications, consistent error handling
> > > validation, automated documentation generation, and formal verification of
> > > kernel interfaces.  
> >
> > Could you give some examples? We have machine readable descriptions for
> > Netlink interfaces, we approached syzbot folks and they did not really
> > seem to care for those.  
> 
> I think our reasoning wrt syzkaller was that not all interfaces in all
> relevant kernels are described with netlink yml descriptions, so we
> need to continue using the extraction of interfaces from the source
> code. And if we have that code, then using yml as an additional data
> source only adds code/complexity. Additionally, we may extract some
> extra constraints/info from code that are not present in yml.
> 
> Realistically system call descriptions may have the same problem for
> us at this point, since we extract lots of info from the source code
> already:
> https://raw.githubusercontent.com/google/syzkaller/refs/heads/master/sys/linux/auto.txt

yup! we haven't tried to make the yml spec super useful to syzbot 
to be fair. I'm just flagging that example because in our case we
quickly went from "this will obviously be useful to syzbot" to
"although we could, it may not be super practical"

> (and LLMs obviously can allow us to extract more)

Didn't even think of that. LLMs should make short work of this sort of
extraction of information from source code..


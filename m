Return-Path: <linux-api+bounces-6267-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8INWIXWg+WmQ+QIAu9opvQ
	(envelope-from <linux-api+bounces-6267-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 05 May 2026 09:47:01 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3713B4C8341
	for <lists+linux-api@lfdr.de>; Tue, 05 May 2026 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EED8303AF1F
	for <lists+linux-api@lfdr.de>; Tue,  5 May 2026 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98253E9595;
	Tue,  5 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYENH4ut"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA6290DBB;
	Tue,  5 May 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967176; cv=none; b=NfEpI5VPibF/OE/1n/66WMDfo7fkmnCu/0prxEKkFPF8gLt0BqdzOaW5R4mz9zKLQX2Wo9Dz8KvZUUiSxawERQWxWO6H/AWpZP9ynpUqKJqBWKmkB0XQJhCL1C0+hZMPMxICr5r5XsLzfSrX12b8WJORpib9jRbioRiCQguaEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967176; c=relaxed/simple;
	bh=PuRAhq5SiXiqc76UbhOEtTuhVUy+QUHdrAQ6+om8jQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=aAgkKhke+gpqFtZ82Zb6LJKVP2Cl9cKl5979YvEC3yURxZNPH81BSgawzAJYcUeiWTfvEHgtyxSQwXa97oWdwhhGUbxftTg7a33LufSVB5AbV2kEQj/oCPOL+cvaCKMjI7g4cVYcL8yGqSoH1HIUXhkYWNW4tSNv9abHNw0t6JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYENH4ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35AC2BCC7;
	Tue,  5 May 2026 07:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777967175;
	bh=PuRAhq5SiXiqc76UbhOEtTuhVUy+QUHdrAQ6+om8jQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYENH4utBGU9HCP3WrpxkAdRRWjG5Exc2YJm6RQVhGs0R5MiJXHwlkQrzT+/yGDgS
	 JJ/Ihea9J/vhNqPRgPeEZVAf9hTbuA+ymECadkAqfgKn+ZqYGea9P39NPPTzktJrkK
	 mssSOCcO88HHObwUwWk7+26kETY7HcZmdzIyPJ/Wk7ZyFS/OKg5S37l7BOewB8r97G
	 CSFtRh4JJvZgpmPQJQOA+Ix/6kLzD/6KLrrP/pwZpq0H4T34OEpDZV5bjVLklO62Lh
	 zy4mNXODfCV39N/qwUs5MwUCAvHt1DkDZhaK7CyhYNUecFDSQnq0Xlrvh/UTjo+J8h
	 U8LUzTAzNxkGw==
From: Sasha Levin <sashal@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
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
	Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/9] kernel/api: introduce kernel API specification framework
Date: Tue,  5 May 2026 03:45:41 -0400
Message-ID: <20260505074545.430334-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <afIykLLPj7m0fcsX@levanger>
References: <20260424165130.2306833-1-sashal@kernel.org> <20260424165130.2306833-2-sashal@kernel.org> <177726106581.2478607.12645653803520391071.b4-review@b4> <afIykLLPj7m0fcsX@levanger>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3713B4C8341
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6267-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 06:32:16PM +0200, Nicolas Schier wrote:
> On Sun, Apr 26, 2026 at 11:37:45PM -0400, Nathan Chancellor wrote:
> > On Fri, 24 Apr 2026 12:51:21 -0400, Sasha Levin <sashal@kernel.org> wrote:
> > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > [...]
> > > +obj-$(CONFIG_KAPI_SPEC) += api/
> > > +# Ensure api/ is always cleaned even when CONFIG_KAPI_SPEC is not set
> > > +obj- += api/
> >
> > If $(CONFIG_KAPI_SPEC) is not set, shouldn't
> >
> >   obj-$(CONFIG_KAPI_SPEC) += api/
> >
> > evaluate to
> >
> >   obj- += api/
> >
> > anyways? Why the duplication? This is the only place in the kernel where
> > this would be needed?
>
> yes, this is definitely not needed, as obj- is always evaluated during
> 'make clean', cp. scripts/Makefile.clean [1].
>
> Kind regards
> Nicolas
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.clean?h=v7.1-rc1#n30

Thanks for the pointer!

The redundant "obj- += api/" and the accompanying comment are dropped in v4.

--
Thanks,
Sasha


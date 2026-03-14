Return-Path: <linux-api+bounces-5966-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMQRA3amtWkh3AAAu9opvQ
	(envelope-from <linux-api+bounces-5966-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 19:18:30 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FF628E638
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 19:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC240300D0F5
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701B326938;
	Sat, 14 Mar 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljmQoDo6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A72F851;
	Sat, 14 Mar 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512304; cv=none; b=GwULPmlR3pl6Y4vCIHYxY0eMr8hzMmlwb+wXn2DMyAWcd5uDPWb8VighXw1QARQYZNFoTGPWbCB5E6Rkw902ZWKHDfBomDCplJ8wqVEwXQykr+ME8cYqkjLHvTY2UsKdPTlNwBhsROVH5CHl0LQjhoC8pXZ+JxxPkVHX2Xn5Ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512304; c=relaxed/simple;
	bh=68Bjyoi3gtdErelVO/sN0br35R51BTPCrE2rCbJxO44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1L36lQA72nGGy59SXGouwXW1OguRaAIcZaplBGYWLrYzhw53qGv6b7AnS7vKmR6loksuSnw1XVxDGq/2nHjbMTlFINOubTZAGNobFEZnaMFFidr1pCKWvjkUAuH+Quj/cjRybjzFhxM/PmOZT4Jo5NIAJa29QZEIQIUs2SmpI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljmQoDo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00466C116C6;
	Sat, 14 Mar 2026 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773512304;
	bh=68Bjyoi3gtdErelVO/sN0br35R51BTPCrE2rCbJxO44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljmQoDo6+8N5qariNMP+lxBxK9JyF7T0M+fUn2PH5u1KxLF9wwqV4xeYeOD9teSUI
	 0vRosx7dOI9CiCAb440Az7+OWWQgJXPXB9o73UyHwNLk7jTd7Kvb44zSI5Yg+eqMih
	 Z4tqWM39rhUqviuVVfoBB7EyeE0f3aG67KuYz81hK+3HV3pD1sKJ9fHwr2ySEXA8Dt
	 YZd9LQ+Y+G938tznqGltVQiP8SgiEHeMISaghcdU4Wy2FDoHlP0RKyN7bgzEngnDGT
	 XqYkaEvqCd3epEpoGm0D8oEqQJV/9aal++4UMS4E34uFBDZgv/yPrLkytWT8aFAwbH
	 iemdxGuEO1zJQ==
Date: Sat, 14 Mar 2026 11:18:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org, Thomas
 Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Dmitry Vyukov <dvyukov@google.com>, Randy Dunlap
 <rdunlap@infradead.org>, Cyril Hrubis <chrubis@suse.cz>, Kees Cook
 <kees@kernel.org>, Jake Edge <jake@lwn.net>, David Laight
 <david.laight.linux@gmail.com>, Askar Safin <safinaskar@zohomail.com>,
 Gabriele Paoloni <gpaoloni@redhat.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Christian Brauner <brauner@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
Message-ID: <20260314111822.63a2ba4a@kernel.org>
In-Reply-To: <20260313150928.2637368-1-sashal@kernel.org>
References: <20260313150928.2637368-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5966-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55FF628E638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
> This enables static analysis tools to verify userspace API usage at compile
> time, test generation based on formal specifications, consistent error handling
> validation, automated documentation generation, and formal verification of
> kernel interfaces.

Could you give some examples? We have machine readable descriptions for
Netlink interfaces, we approached syzbot folks and they did not really
seem to care for those.


Return-Path: <linux-api+bounces-6658-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O6z4HWFkPGqtnggAu9opvQ
	(envelope-from <linux-api+bounces-6658-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:12:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47F6C1DF3
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:12:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=M92HitiV;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6658-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6658-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C523008D2E
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C183B4432;
	Wed, 24 Jun 2026 23:12:27 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265823C4FF;
	Wed, 24 Jun 2026 23:12:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342747; cv=none; b=U5aiJyks/qLI9fnoZe6d32LnMvAfW4bG1u7qivkOrF19twOklj1h8YVi0u7z8eSddZ6BgQU1vFE3+mOakhKI+jysT1N3/QYG+tvdz7cy8TW1M7Ij86XWgA4em5oSspidybSM3lInXtZohkGNmlH4vgnlJd8Tl4y4w7hLJiS2t5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342747; c=relaxed/simple;
	bh=jxafdzeDQQj+b3Z/xYBssuCs0wa6+9Wk8H/YWO9YvgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvqRnHQX7hI1/9pAEU/dKHmiOtgpas2GYHE7GWaPNGa0vDBqxdtvsWQRi9KiacZCcetTwk6P2cYxTJH2ZNN0NEYYXfIss/zUxvYWubMT+DmDcELtfciksoFwrufBhN9aiDsFqpY2PAxN9r09jAacRw4dLZCiqYsrVIoS7JgEtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=M92HitiV; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=beOvvVn0+AejXo29fd8CNsSGWNMgqTX5RDnFJbYLSpQ=; b=M92HitiVOHC2b3xmlqSSUz7btr
	+5wkyjQtPor8VgLu7kfScVvaoXEml8uIMhgdn86RYe/rCJmavsPIYE37/cP9PZE6c6YydZAqnxjyq
	pUDn9ahlFr1ZldblX5YAvqzRVyIFQUTDJGzofpLSSQi3UC+PSQBbOl3Sna6ippTzQ2rGIMcbjOVrc
	wJdXpQatdEAPX4T8ed+5UcT7ROQVDPzNEUnNUQNps3cxJhNa7BcUelLhf6X64PiNFs4Sag1hcknA1
	PSqyDQBtVop1QcCBulxcSY6Tb/frG2eFzu5WbI6iU0awQsd2rxf6EI4caJ20JJGSpFXJYY0k3vhul
	kupeaGVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wcWlX-0000000C2pX-0Rxc;
	Wed, 24 Jun 2026 23:12:19 +0000
Date: Thu, 25 Jun 2026 00:12:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>,
	Christian Brauner <brauner@kernel.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260624231219.GL2636677@ZenIV>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-6658-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ZenIV:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,zeniv.linux.org.uk:from_mime,linux.org.uk:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B47F6C1DF3

On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:

> #### Null mount namespace
> 
> - requires:
> 
>   - null root file system: absolute paths don't work.
> 
>   - null current working directory: relative paths with traditional,
>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work.
> 
> - All operations relating to the "ambient" mount tree don't work.
> 
> - `*at` operations with a file descriptor do work.

Huh?  The last bit looks contradicts the previous one - if you have
an opened directory in a mount from some namespace, those `*at` operations
with that descriptor *will* be seeing the mount tree of that namespace,
whatever the hell is "ambient" supposed to mean.  Either that, or you
will be exposing whatever's overmounted in that mount, which is a huge
can of worms.

